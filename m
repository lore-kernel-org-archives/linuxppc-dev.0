Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 35C55DDF8F
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2007 18:21:07 +1000 (EST)
Date: Wed, 28 Mar 2007 02:21:03 -0600 (CST)
Subject: [RFC] bootwrapper: allow vmlinuz to be an external payload
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-3-05.miltonm@bga.com>
In-Reply-To: <boot-3-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Milton Miller <miltonm@bga.com>

Allow the bootwrapper to obtain an external platform supplied image.

My work in progress will find a specified file in a initramfs cpio
and advance the gunzip_util stream to the contents.  

Another use would be to uncompress directly from a memory mapped
region such as a flash partition.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
Status: compiles and links, doesn't cause failures.

Passing the source and source len to the routine is just so we can
print it nice and pretty.

While we could take (archive-start, len, skip), we would end up 
doing the decompress processing for skip twice.

Index: kernel/arch/powerpc/boot/main.c
===================================================================
--- kernel.orig/arch/powerpc/boot/main.c	2007-03-28 02:32:24.000000000 -0500
+++ kernel/arch/powerpc/boot/main.c	2007-03-28 02:33:26.000000000 -0500
@@ -115,10 +115,15 @@ static struct addr_range prep_kernel(voi
 	struct elf_info ei;
 	int len;
 
-	/* gunzip the ELF header of the kernel */
-	gunzip_start(&gzstate, vmlinuz_addr, vmlinuz_size);
-	gunzip_exactly(&gzstate, elfheader, sizeof(elfheader));
+	/* Initialze zlib.  Any attached kernel overrides find_vmlinux */
+	if (vmlinuz_size)
+		gunzip_start(&gzstate, vmlinuz_addr, vmlinuz_size);
+	else
+		platform_ops.find_vmlinuz(&gzstate, &vmlinuz_addr,
+				&vmlinuz_size);
 
+	/* gunzip and parse the ELF header of the kernel */
+	gunzip_exactly(&gzstate, elfheader, sizeof(elfheader));
 	if (!parse_elf64(elfheader, &ei) && !parse_elf32(elfheader, &ei))
 		fatal("Error: not a valid PPC32 or PPC64 ELF file!\n\r");
 
Index: kernel/arch/powerpc/boot/ops.h
===================================================================
--- kernel.orig/arch/powerpc/boot/ops.h	2007-03-28 02:32:24.000000000 -0500
+++ kernel/arch/powerpc/boot/ops.h	2007-03-28 02:33:26.000000000 -0500
@@ -19,6 +19,8 @@
 #define	MAX_PATH_LEN		256
 #define	MAX_PROP_LEN		256 /* What should this be? */
 
+struct gunzip_state;
+
 /* Platform specific operations */
 struct platform_ops {
 	void	(*fixups)(void);
@@ -28,6 +30,8 @@ struct platform_ops {
 	void *	(*realloc)(void *ptr, unsigned long size);
 	void	(*exit)(void);
 	void *	(*vmlinux_alloc)(unsigned long size);
+ 	void	(*find_vmlinuz)(struct gunzip_state *, void **srcp,
+ 			unsigned long *lenp);
 };
 extern struct platform_ops platform_ops;
 
