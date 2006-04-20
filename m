Return-Path: <amodra@bigpond.net.au>
Received: from grove.modra.org (CPE-144-136-172-108.sa.bigpond.net.au
	[144.136.172.108]) by ozlabs.org (Postfix) with ESMTP id 2104F679E9
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Apr 2006 18:54:02 +1000 (EST)
Date: Thu, 20 Apr 2006 18:24:01 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: modules without a .toc section not loading
Message-ID: <20060420085401.GI27430@bubble.grove.modra.org>
References: <20060420000220.GB22797@curie-int.vc.shawcable.net>
	<20060420002829.GD27430@bubble.grove.modra.org>
	<20060420005445.GA24721@curie-int.vc.shawcable.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060420005445.GA24721@curie-int.vc.shawcable.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 19, 2006 at 05:54:45PM -0700, Robin H. Johnson wrote:
> On Thu, Apr 20, 2006 at 09:58:30AM +0930, Alan Modra wrote:
> > > Ideas for Solutions:
> > > 1. Either the kernel needs to realize that it does not need a .toc
> > > section (I'm uncertain about this, being new to PPC).
> > > 2. GCC is at fault, and it should be generating a .toc.
> > The former.
> Ok, so in module_64.c, under what cases is .toc NOT needed?
> 
> I dug at the code, and the R_PPC_REL24 blocks need the contents of the
> .toc (via stub_for_addr -> create_stub -> my_r2), and I'm not certain
> about it.

Yes, the stubs need some reasonable r2 value.

> The R_PPC64_TOC/R_PPC64_TOC16/R_PPC64_TOC16_DS blocks shouldn't be hit
> when there isn't a .toc* from what I figure.

Yes, and finding such a reloc should trigger an error.

> If the R_PPC_REL24 block won't be hit when there isn't a .toc, the check
> in module_frob_arch_sections, lines 194-197 can just be shortened as a
> fix to the problem.

You could have an R_PPC_REL24 in a module (a function call into another
module or the kernel) without a .toc.  A module without a .toc section
won't itself use r2 for anything, but the any stubs added do need r2.

I'm surprised no one has fixed this.  Here's a totally untested patch
that ought to do the trick (or if it doesn't, should put you on the
right path).

--- linux-2.6.16/arch/powerpc/kernel/module_64.c~	2006-01-18 14:17:29.000000000 +1030
+++ linux-2.6.16/arch/powerpc/kernel/module_64.c	2006-04-20 18:22:42.000000000 +0930
@@ -191,8 +191,15 @@ int module_frob_arch_sections(Elf64_Ehdr
 				 (void *)hdr
 				 + sechdrs[sechdrs[i].sh_link].sh_offset);
 	}
-	if (!me->arch.stubs_section || !me->arch.toc_section) {
-		printk("%s: doesn't contain .toc or .stubs.\n", me->name);
+
+	/* If we don't have a .toc, just use .stubs.  Nothing in the
+	   module itself should use r2, but we need to set r2 in case
+	   the module calls out to other functions. */
+	if (!me->arch.toc_section)
+		me->arch.toc_section = me->arch.stubs_section;
+
+	if (!me->arch.stubs_section) {
+		printk("%s: doesn't contain .stubs.\n", me->name);
 		return -ENOEXEC;
 	}
 
@@ -338,11 +345,21 @@ int apply_relocate_add(Elf64_Shdr *sechd
 			break;
 
 		case R_PPC64_TOC:
+			if (me->arch.toc_section == me->arch.stubs_section) {
+				printk("%s: TOC reloc without .toc\n",
+				       me->name);
+				return -ENOEXEC;
+			}
 			*(unsigned long *)location = my_r2(sechdrs, me);
 			break;
 
 		case R_PPC64_TOC16:
-			/* Subtact TOC pointer */
+			if (me->arch.toc_section == me->arch.stubs_section) {
+				printk("%s: TOC16 reloc without .toc\n",
+				       me->name);
+				return -ENOEXEC;
+			}
+			/* Subtract TOC pointer */
 			value -= my_r2(sechdrs, me);
 			if (value + 0x8000 > 0xffff) {
 				printk("%s: bad TOC16 relocation (%lu)\n",
@@ -355,7 +372,12 @@ int apply_relocate_add(Elf64_Shdr *sechd
 			break;
 
 		case R_PPC64_TOC16_DS:
-			/* Subtact TOC pointer */
+			if (me->arch.toc_section == me->arch.stubs_section) {
+				printk("%s: TOC16_DS reloc without .toc\n",
+				       me->name);
+				return -ENOEXEC;
+			}
+			/* Subtract TOC pointer */
 			value -= my_r2(sechdrs, me);
 			if ((value & 3) != 0 || value + 0x8000 > 0xffff) {
 				printk("%s: bad TOC16_DS relocation (%lu)\n",

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
