Return-Path: <clg@fr.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9CC42140104
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 17:48:16 +1000 (EST)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Mon, 14 Apr 2014 08:48:12 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 13AB22190046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 08:48:04 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3E7mAkL852350
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 07:48:10 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3E7mANi029392
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 01:48:10 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v2 10/15] powerpc/boot: add 64bit and little endian support to
 addnote
Date: Mon, 14 Apr 2014 09:47:09 +0200
Message-Id: <1397461634-20949-11-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1397461634-20949-1-git-send-email-clg@fr.ibm.com>
References: <1397461634-20949-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1395651884.30488.10.camel@pasglop>
References: <1395651884.30488.10.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It could certainly be improved using Elf macros and byteswapping
routines, but the initial version of the code is organised to be a
single file program with limited dependencies. yaboot is the same.

Please scream if you want a total rewrite.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---

Changes since RFC:

 - fixed the note creation which was done with the wrong endianess 
 - increased 'buf' as ELF structures are larger in 64bit

 arch/powerpc/boot/addnote.c |  128 ++++++++++++++++++++++++++++---------------
 1 file changed, 85 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/boot/addnote.c b/arch/powerpc/boot/addnote.c
index 349b5530d2c4..9d9f6f334d3c 100644
--- a/arch/powerpc/boot/addnote.c
+++ b/arch/powerpc/boot/addnote.c
@@ -6,6 +6,8 @@
  *
  * Copyright 2000 Paul Mackerras.
  *
+ * Adapted for 64 bit little endian images by Andrew Tauferner.
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version
@@ -55,36 +57,61 @@ unsigned int rpanote[N_RPA_DESCR] = {
 
 #define ROUNDUP(len)	(((len) + 3) & ~3)
 
-unsigned char buf[512];
+unsigned char buf[1024];
+#define ELFDATA2LSB     1
+#define ELFDATA2MSB     2
+static int e_data = ELFDATA2MSB;
+#define ELFCLASS32      1
+#define ELFCLASS64      2
+static int e_class = ELFCLASS32;
 
 #define GET_16BE(off)	((buf[off] << 8) + (buf[(off)+1]))
-#define GET_32BE(off)	((GET_16BE(off) << 16) + GET_16BE((off)+2))
-
-#define PUT_16BE(off, v)	(buf[off] = ((v) >> 8) & 0xff, \
-				 buf[(off) + 1] = (v) & 0xff)
-#define PUT_32BE(off, v)	(PUT_16BE((off), (v) >> 16), \
-				 PUT_16BE((off) + 2, (v)))
+#define GET_32BE(off)	((GET_16BE(off) << 16U) + GET_16BE((off)+2U))
+#define GET_64BE(off)	((((unsigned long long)GET_32BE(off)) << 32ULL) + \
+			((unsigned long long)GET_32BE((off)+4ULL)))
+#define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
+			 buf[(off) + 1] = (v) & 0xff)
+#define PUT_32BE(off, v)(PUT_16BE((off), (v) >> 16L), PUT_16BE((off) + 2, (v)))
+#define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
+			  PUT_32BE((off) + 4, (v))))
+
+#define GET_16LE(off)	((buf[off]) + (buf[(off)+1] << 8))
+#define GET_32LE(off)	(GET_16LE(off) + (GET_16LE((off)+2U) << 16U))
+#define GET_64LE(off)	((unsigned long long)GET_32LE(off) + \
+			(((unsigned long long)GET_32LE((off)+4ULL)) << 32ULL))
+#define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
+			  buf[(off) + 1] = ((v) >> 8) & 0xff)
+#define PUT_32LE(off, v) (PUT_16LE((off), (v)), PUT_16LE((off) + 2, (v) >> 16L))
+#define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
+
+#define GET_16(off)	(e_data == ELFDATA2MSB ? GET_16BE(off) : GET_16LE(off))
+#define GET_32(off)	(e_data == ELFDATA2MSB ? GET_32BE(off) : GET_32LE(off))
+#define GET_64(off)	(e_data == ELFDATA2MSB ? GET_64BE(off) : GET_64LE(off))
+#define PUT_16(off, v)	(e_data == ELFDATA2MSB ? PUT_16BE(off, v) : \
+			 PUT_16LE(off, v))
+#define PUT_32(off, v)  (e_data == ELFDATA2MSB ? PUT_32BE(off, v) : \
+			 PUT_32LE(off, v))
+#define PUT_64(off, v)  (e_data == ELFDATA2MSB ? PUT_64BE(off, v) : \
+			 PUT_64LE(off, v))
 
 /* Structure of an ELF file */
 #define E_IDENT		0	/* ELF header */
-#define	E_PHOFF		28
-#define E_PHENTSIZE	42
-#define E_PHNUM		44
-#define E_HSIZE		52	/* size of ELF header */
+#define	E_PHOFF		(e_class == ELFCLASS32 ? 28 : 32)
+#define E_PHENTSIZE	(e_class == ELFCLASS32 ? 42 : 54)
+#define E_PHNUM		(e_class == ELFCLASS32 ? 44 : 56)
+#define E_HSIZE		(e_class == ELFCLASS32 ? 52 : 64)
 
 #define EI_MAGIC	0	/* offsets in E_IDENT area */
 #define EI_CLASS	4
 #define EI_DATA		5
 
 #define PH_TYPE		0	/* ELF program header */
-#define PH_OFFSET	4
-#define PH_FILESZ	16
-#define PH_HSIZE	32	/* size of program header */
+#define PH_OFFSET	(e_class == ELFCLASS32 ? 4 : 8)
+#define PH_FILESZ	(e_class == ELFCLASS32 ? 16 : 32)
+#define PH_HSIZE	(e_class == ELFCLASS32 ? 32 : 56)
 
 #define PT_NOTE		4	/* Program header type = note */
 
-#define ELFCLASS32	1
-#define ELFDATA2MSB	2
 
 unsigned char elf_magic[4] = { 0x7f, 'E', 'L', 'F' };
 
@@ -92,8 +119,8 @@ int
 main(int ac, char **av)
 {
 	int fd, n, i;
-	int ph, ps, np;
-	int nnote, nnote2, ns;
+	unsigned long ph, ps, np;
+	long nnote, nnote2, ns;
 
 	if (ac != 2) {
 		fprintf(stderr, "Usage: %s elf-file\n", av[0]);
@@ -114,26 +141,27 @@ main(int ac, char **av)
 		exit(1);
 	}
 
-	if (n < E_HSIZE || memcmp(&buf[E_IDENT+EI_MAGIC], elf_magic, 4) != 0)
+	if (memcmp(&buf[E_IDENT+EI_MAGIC], elf_magic, 4) != 0)
+		goto notelf;
+	e_class = buf[E_IDENT+EI_CLASS];
+	if (e_class != ELFCLASS32 && e_class != ELFCLASS64)
+		goto notelf;
+	e_data = buf[E_IDENT+EI_DATA];
+	if (e_data != ELFDATA2MSB && e_data != ELFDATA2LSB)
+		goto notelf;
+	if (n < E_HSIZE)
 		goto notelf;
 
-	if (buf[E_IDENT+EI_CLASS] != ELFCLASS32
-	    || buf[E_IDENT+EI_DATA] != ELFDATA2MSB) {
-		fprintf(stderr, "%s is not a big-endian 32-bit ELF image\n",
-			av[1]);
-		exit(1);
-	}
-
-	ph = GET_32BE(E_PHOFF);
-	ps = GET_16BE(E_PHENTSIZE);
-	np = GET_16BE(E_PHNUM);
+	ph = (e_class == ELFCLASS32 ? GET_32(E_PHOFF) : GET_64(E_PHOFF));
+	ps = GET_16(E_PHENTSIZE);
+	np = GET_16(E_PHNUM);
 	if (ph < E_HSIZE || ps < PH_HSIZE || np < 1)
 		goto notelf;
 	if (ph + (np + 2) * ps + nnote + nnote2 > n)
 		goto nospace;
 
 	for (i = 0; i < np; ++i) {
-		if (GET_32BE(ph + PH_TYPE) == PT_NOTE) {
+		if (GET_32(ph + PH_TYPE) == PT_NOTE) {
 			fprintf(stderr, "%s already has a note entry\n",
 				av[1]);
 			exit(0);
@@ -148,15 +176,22 @@ main(int ac, char **av)
 
 	/* fill in the program header entry */
 	ns = ph + 2 * ps;
-	PUT_32BE(ph + PH_TYPE, PT_NOTE);
-	PUT_32BE(ph + PH_OFFSET, ns);
-	PUT_32BE(ph + PH_FILESZ, nnote);
+	PUT_32(ph + PH_TYPE, PT_NOTE);
+	if (e_class == ELFCLASS32)
+		PUT_32(ph + PH_OFFSET, ns);
+	else
+		PUT_64(ph + PH_OFFSET, ns);
+
+	if (e_class == ELFCLASS32)
+		PUT_32(ph + PH_FILESZ, nnote);
+	else
+		PUT_64(ph + PH_FILESZ, nnote);
 
 	/* fill in the note area we point to */
 	/* XXX we should probably make this a proper section */
-	PUT_32BE(ns, strlen(arch) + 1);
-	PUT_32BE(ns + 4, N_DESCR * 4);
-	PUT_32BE(ns + 8, 0x1275);
+	PUT_32(ns, strlen(arch) + 1);
+	PUT_32(ns + 4, N_DESCR * 4);
+	PUT_32(ns + 8, 0x1275);
 	strcpy((char *) &buf[ns + 12], arch);
 	ns += 12 + strlen(arch) + 1;
 	for (i = 0; i < N_DESCR; ++i, ns += 4)
@@ -164,21 +199,28 @@ main(int ac, char **av)
 
 	/* fill in the second program header entry and the RPA note area */
 	ph += ps;
-	PUT_32BE(ph + PH_TYPE, PT_NOTE);
-	PUT_32BE(ph + PH_OFFSET, ns);
-	PUT_32BE(ph + PH_FILESZ, nnote2);
+	PUT_32(ph + PH_TYPE, PT_NOTE);
+	if (e_class == ELFCLASS32)
+		PUT_32(ph + PH_OFFSET, ns);
+	else
+		PUT_64(ph + PH_OFFSET, ns);
+
+	if (e_class == ELFCLASS32)
+		PUT_32(ph + PH_FILESZ, nnote);
+	else
+		PUT_64(ph + PH_FILESZ, nnote2);
 
 	/* fill in the note area we point to */
-	PUT_32BE(ns, strlen(rpaname) + 1);
-	PUT_32BE(ns + 4, sizeof(rpanote));
-	PUT_32BE(ns + 8, 0x12759999);
+	PUT_32(ns, strlen(rpaname) + 1);
+	PUT_32(ns + 4, sizeof(rpanote));
+	PUT_32(ns + 8, 0x12759999);
 	strcpy((char *) &buf[ns + 12], rpaname);
 	ns += 12 + ROUNDUP(strlen(rpaname) + 1);
 	for (i = 0; i < N_RPA_DESCR; ++i, ns += 4)
 		PUT_32BE(ns, rpanote[i]);
 
 	/* Update the number of program headers */
-	PUT_16BE(E_PHNUM, np + 2);
+	PUT_16(E_PHNUM, np + 2);
 
 	/* write back */
 	lseek(fd, (long) 0, SEEK_SET);
-- 
1.7.10.4
