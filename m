Return-Path: <amodra@bigpond.net.au>
Received: from grove.modra.org (CPE-144-136-172-108.sa.bigpond.net.au
	[144.136.172.108]) by ozlabs.org (Postfix) with ESMTP id 231BC679F3
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2006 22:41:52 +1000 (EST)
Date: Mon, 24 Apr 2006 22:11:51 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: modules without a .toc section not loading
Message-ID: <20060424124151.GR27430@bubble.grove.modra.org>
References: <20060420000220.GB22797@curie-int.vc.shawcable.net>
	<20060420002829.GD27430@bubble.grove.modra.org>
	<20060420005445.GA24721@curie-int.vc.shawcable.net>
	<20060420085401.GI27430@bubble.grove.modra.org>
	<20060423035614.GB30578@curie-int.vc.shawcable.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060423035614.GB30578@curie-int.vc.shawcable.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 22, 2006 at 08:56:14PM -0700, Robin H. Johnson wrote:
> On Thu, Apr 20, 2006 at 06:24:01PM +0930, Alan Modra wrote:
> > > I dug at the code, and the R_PPC_REL24 blocks need the contents of the
> > > .toc (via stub_for_addr -> create_stub -> my_r2), and I'm not certain
> > > about it.
> > Yes, the stubs need some reasonable r2 value.
> Using the .stubs values for the .toc seems to work, but I should
> construct a better test case for it, to double check.
> 
> > > The R_PPC64_TOC/R_PPC64_TOC16/R_PPC64_TOC16_DS blocks shouldn't be hit
> > > when there isn't a .toc* from what I figure.
> > Yes, and finding such a reloc should trigger an error.
> Ok, there is a case where R_PPC64_TOC exists and there isn't a .toc, and
> I suspect you're just the right person to ask...

Oops.  R_PPC64_TOC without a toc isn't an error, despite it looking
self-contradictory.

[snip about R_PPC64_TOC in .opd]
> It seems that these R_PPC64_TOC entries are safe to completely ignore -
> is this correct? 

They are the toc pointer value used by functions defined in the module.
Since we are using .stubs+0x8000, that should be the value of these
relocs.  There may be situations where the opd entry escapes out of
the module as a function pointer (eg. via an initialised global function
pointer variable), so we'd better set them to the correct value.

In fact, it probably isn't worth doing error checking of any of the
R_PPC64_TOC* relocs.  If I hadn't tried to be fancy with error checks,
it seems my original patch would have been good.  Oh well, revised patch
follows.

[snip]
> I have searched Google, but not actually found any documentation on what
> the format of the .opd section is supposed to be. LSB-3.1 just says it
> has to exist, without saying what it's format is.

First word is the function entry point, second word is the toc pointer
used by the function, third word is the static chain pointer (unused by
C, but used in languages like Pascal).  Some Redhat compilers omit the
third word entirely, so opd entries may be either 16 bytes or 24 bytes
apart.

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre

--- linux-2.6.16/arch/powerpc/kernel/module_64.c~	2006-01-18 14:17:29.000000000 +1030
+++ linux-2.6.16/arch/powerpc/kernel/module_64.c	2006-04-24 22:01:19.000000000 +0930
@@ -191,11 +191,19 @@ int module_frob_arch_sections(Elf64_Ehdr
 				 (void *)hdr
 				 + sechdrs[sechdrs[i].sh_link].sh_offset);
 	}
-	if (!me->arch.stubs_section || !me->arch.toc_section) {
-		printk("%s: doesn't contain .toc or .stubs.\n", me->name);
+
+	if (!me->arch.stubs_section) {
+		printk("%s: doesn't contain .stubs.\n", me->name);
 		return -ENOEXEC;
 	}
 
+	/* If we don't have a .toc, just use .stubs.  We need to set r2
+	   to some reasonable value in case the module calls out to
+	   other functions via a stub, or if a function pointer escapes
+	   the module by some means.  */
+	if (!me->arch.toc_section)
+		me->arch.toc_section = me->arch.stubs_section;
+
 	/* Override the stubs size */
 	sechdrs[me->arch.stubs_section].sh_size = get_stubs_size(hdr, sechdrs);
 	return 0;
@@ -342,7 +350,7 @@ int apply_relocate_add(Elf64_Shdr *sechd
 			break;
 
 		case R_PPC64_TOC16:
-			/* Subtact TOC pointer */
+			/* Subtract TOC pointer */
 			value -= my_r2(sechdrs, me);
 			if (value + 0x8000 > 0xffff) {
 				printk("%s: bad TOC16 relocation (%lu)\n",
@@ -355,7 +363,7 @@ int apply_relocate_add(Elf64_Shdr *sechd
 			break;
 
 		case R_PPC64_TOC16_DS:
-			/* Subtact TOC pointer */
+			/* Subtract TOC pointer */
 			value -= my_r2(sechdrs, me);
 			if ((value & 3) != 0 || value + 0x8000 > 0xffff) {
 				printk("%s: bad TOC16_DS relocation (%lu)\n",
