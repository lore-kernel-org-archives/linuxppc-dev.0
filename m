Return-Path: <sam@ravnborg.org>
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by ozlabs.org (Postfix) with ESMTP id A174EDDE0D
	for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2009 06:05:13 +1000 (EST)
Date: Sun, 3 May 2009 22:07:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: unexpected non-allocatable section
Message-ID: <20090503200701.GA32601@uranus.ravnborg.org>
References: <20090502224126.641c63bf@lappy.seanm.ca>
	<20090503204546.691ec6e7.sfr@canb.auug.org.au>
	<20090503123959.0cc5c967@lappy.seanm.ca>
	<20090503193316.E72BC83420E8@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090503193316.E72BC83420E8@gemini.denx.de>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 03, 2009 at 09:33:16PM +0200, Wolfgang Denk wrote:
> Dear Sean MacLennan,
> 
> In message <20090503123959.0cc5c967@lappy.seanm.ca> you wrote:
> > 
> > > What gcc, binutils versions and config are you using?
> > 
> > gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)
> > GNU assembler version 2.16.1 (powerpc-linux) using BFD version 2.16.1
> > 
> > And this is all running on the Warp with a 440EP.
> 
> Which exact commands did you use to build the kenrel, and how did you
> set (and export?) the CROSS_COMPILE environment variable?
> 
> The thing is, that I cannot reproduce this - I tested it with
> v2.6.30-rc4, both with ELDK 4.1 (as you) and ELDK 4.2.
> 
> Both build the kernel image without any such warnings.

Anders already found the cause of this - it
was a missing endian conversion.
So you need to run this on a little endian target to
see it. And you need to do a full kernel build
so we run modpsot on vmlinux.

I will push the patch in a few minutes.

For reference it is below:

	Sam

From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH] kbuild, modpost: fix unexpected non-allocatable section when cross compiling

The missing TO_NATIVE(sechdrs[i].sh_flags) was causing many
unexpected non-allocatable section warnings when cross-compiling
for an architecture with a different endianness.

Fix endianness of all the fields in the ELF header and
section headers, not just some of them so we are not
hit by this anohter time.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 936b6f8..a5c17db 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -384,11 +384,19 @@ static int parse_elf(struct elf_info *info, const char *filename)
 		return 0;
 	}
 	/* Fix endianness in ELF header */
-	hdr->e_shoff    = TO_NATIVE(hdr->e_shoff);
-	hdr->e_shstrndx = TO_NATIVE(hdr->e_shstrndx);
-	hdr->e_shnum    = TO_NATIVE(hdr->e_shnum);
-	hdr->e_machine  = TO_NATIVE(hdr->e_machine);
-	hdr->e_type     = TO_NATIVE(hdr->e_type);
+	hdr->e_type      = TO_NATIVE(hdr->e_type);
+	hdr->e_machine   = TO_NATIVE(hdr->e_machine);
+	hdr->e_version   = TO_NATIVE(hdr->e_version);
+	hdr->e_entry     = TO_NATIVE(hdr->e_entry);
+	hdr->e_phoff     = TO_NATIVE(hdr->e_phoff);
+	hdr->e_shoff     = TO_NATIVE(hdr->e_shoff);
+	hdr->e_flags     = TO_NATIVE(hdr->e_flags);
+	hdr->e_ehsize    = TO_NATIVE(hdr->e_ehsize);
+	hdr->e_phentsize = TO_NATIVE(hdr->e_phentsize);
+	hdr->e_phnum     = TO_NATIVE(hdr->e_phnum);
+	hdr->e_shentsize = TO_NATIVE(hdr->e_shentsize);
+	hdr->e_shnum     = TO_NATIVE(hdr->e_shnum);
+	hdr->e_shstrndx  = TO_NATIVE(hdr->e_shstrndx);
 	sechdrs = (void *)hdr + hdr->e_shoff;
 	info->sechdrs = sechdrs;
 
@@ -402,13 +410,16 @@ static int parse_elf(struct elf_info *info, const char *filename)
 
 	/* Fix endianness in section headers */
 	for (i = 0; i < hdr->e_shnum; i++) {
-		sechdrs[i].sh_type   = TO_NATIVE(sechdrs[i].sh_type);
-		sechdrs[i].sh_offset = TO_NATIVE(sechdrs[i].sh_offset);
-		sechdrs[i].sh_size   = TO_NATIVE(sechdrs[i].sh_size);
-		sechdrs[i].sh_link   = TO_NATIVE(sechdrs[i].sh_link);
-		sechdrs[i].sh_name   = TO_NATIVE(sechdrs[i].sh_name);
-		sechdrs[i].sh_info   = TO_NATIVE(sechdrs[i].sh_info);
-		sechdrs[i].sh_addr   = TO_NATIVE(sechdrs[i].sh_addr);
+		sechdrs[i].sh_name      = TO_NATIVE(sechdrs[i].sh_name);
+		sechdrs[i].sh_type      = TO_NATIVE(sechdrs[i].sh_type);
+		sechdrs[i].sh_flags     = TO_NATIVE(sechdrs[i].sh_flags);
+		sechdrs[i].sh_addr      = TO_NATIVE(sechdrs[i].sh_addr);
+		sechdrs[i].sh_offset    = TO_NATIVE(sechdrs[i].sh_offset);
+		sechdrs[i].sh_size      = TO_NATIVE(sechdrs[i].sh_size);
+		sechdrs[i].sh_link      = TO_NATIVE(sechdrs[i].sh_link);
+		sechdrs[i].sh_info      = TO_NATIVE(sechdrs[i].sh_info);
+		sechdrs[i].sh_addralign = TO_NATIVE(sechdrs[i].sh_addralign);
+		sechdrs[i].sh_entsize   = TO_NATIVE(sechdrs[i].sh_entsize);
 	}
 	/* Find symbol table. */
 	for (i = 1; i < hdr->e_shnum; i++) {
