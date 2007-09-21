Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 12005DECE7
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 09:06:21 +1000 (EST)
Date: Fri, 21 Sep 2007 18:06:04 -0500 (CDT)
Subject: [PATCH 11/15] bootwrapper: allow vmlinuz to be an external payload
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-8-11.miltonm@bga.com>
In-Reply-To: <boot-8-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>, Rob Landley <rob@landley.net>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Allow the boot wrapper to obtain the vmlinux elf from an external
platform supplied location instead of embedding it at link time.

When used with the cpio library, the kernel can be stored as a file in
the initramfs, allowing the same (compressed) copy of the vmlinux elf
to be used for both the kernel to execute and any user space tools such
as kexec (for reboot), crash dump, or oprofile.

Another use would be to uncompress directly from a memory mapped
region such as a flash partition.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
vs 12178, just fuzz.

The source and source len variables are passed to the routine
only to allow them to be printed later.

The gunzip_state is passed to allow a platform to find the
elf stream in an arbitrary container (cpio, ar, etc) without
decompressing leading data twice.

I also used this hook for qemu, where the "rom" contains the 
wrapper code and device tree blob, but the kernel is loaded
into ram via the -kernel flag (allowing a raw vmlinux elf).

Index: kernel/arch/powerpc/boot/main.c
===================================================================
--- kernel.orig/arch/powerpc/boot/main.c	2007-09-20 17:00:15.000000000 -0500
+++ kernel/arch/powerpc/boot/main.c	2007-09-20 17:49:10.000000000 -0500
@@ -37,10 +37,19 @@ static struct addr_range prep_kernel(voi
 	struct elf_info ei;
 	int len;
 
-	/* gunzip the ELF header of the kernel */
-	gunzip_start(&gzstate, vmlinuz_addr, vmlinuz_size);
-	gunzip_exactly(&gzstate, elfheader, sizeof(elfheader));
+	/* Initialze zlib.  Any attached kernel overrides find_vmlinuz */
+	if (vmlinuz_size)
+		gunzip_start(&gzstate, vmlinuz_addr, vmlinuz_size);
+	else
+		if (platform_ops.find_vmlinuz)
+			platform_ops.find_vmlinuz(&gzstate, &vmlinuz_addr,
+					&vmlinuz_size);
+		else
+			fatal("Can't find a kernel to boot: no attached "
+				"vmlinuz and no find_vmlinuz method\n\r");
 
+	/* gunzip and parse the ELF header of the kernel */
+	gunzip_exactly(&gzstate, elfheader, sizeof(elfheader));
 	if (!parse_elf64(elfheader, &ei) && !parse_elf32(elfheader, &ei))
 		fatal("Error: not a valid PPC32 or PPC64 ELF file!\n\r");
 
Index: kernel/arch/powerpc/boot/ops.h
===================================================================
--- kernel.orig/arch/powerpc/boot/ops.h	2007-09-20 17:49:08.000000000 -0500
+++ kernel/arch/powerpc/boot/ops.h	2007-09-20 17:49:10.000000000 -0500
@@ -24,6 +24,8 @@ typedef void (*kernel_entry_t)(unsigned 
 
 struct boot_param_header;
 
+struct gunzip_state;
+
 /* Platform specific operations */
 struct platform_ops {
 	void	(*fixups)(void);
@@ -33,6 +35,8 @@ struct platform_ops {
 	void *	(*realloc)(void *ptr, unsigned long size);
 	void	(*exit)(void);
 	void *	(*vmlinux_alloc)(unsigned long size);
+ 	void	(*find_vmlinuz)(struct gunzip_state *, void **srcp,
+ 			unsigned long *lenp);
 };
 extern struct platform_ops platform_ops;
 
