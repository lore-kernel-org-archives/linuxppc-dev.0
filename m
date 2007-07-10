Return-Path: <miltonm@sullivan.realtime.net>
Date: Tue, 10 Jul 2007 17:12:09 -0500 (CDT)
Subject: [PATCH 11/15] bootwrapper: allow vmlinuz to be an external payload
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-6-11.miltonm@bga.com>
In-Reply-To: <boot-6-00.miltonm@bga.com>
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

Allow the boot wrapper to obtain the vmlinux elf from an external
platform supplied location instead of embedding it at link time.

When used with the cpio library, the kernel can be stored as a file
an file in the initramfs, allowing the same (compressed) copy of
the vmlinux elf to be used for both the kernel to execute and any
user space tools such as kexec (for reboot), crash dump, or oprofile.

Another use would be to uncompress directly from a memory mapped
region such as a flash partition.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
Check for no find_vmlinuz method before calling it.

The source and source len varables are passed to the routine only
to allow them to be printed later.

This patch follows the current policy of using linker attached data
in preference to platform supplied data (matching the initrd and
command line).

While the platform could supply archive-start, length, and offset,
in loader data, it would require decompressing the skiped portion
twice when the offset is not known in advance.

The prpmc2800 code shows that this hook to find the kernel and the
the code to uncompress the header may want to be separated from the
vmlinux alloc, decompress, and flush code.  I haven't explored an
actual split.

Index: work.git/arch/powerpc/boot/main.c
===================================================================
--- work.git.orig/arch/powerpc/boot/main.c	2007-07-10 03:44:40.000000000 -0500
+++ work.git/arch/powerpc/boot/main.c	2007-07-10 04:04:02.000000000 -0500
@@ -47,10 +47,19 @@ static struct addr_range prep_kernel(voi
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
 
Index: work.git/arch/powerpc/boot/ops.h
===================================================================
--- work.git.orig/arch/powerpc/boot/ops.h	2007-07-10 04:01:57.000000000 -0500
+++ work.git/arch/powerpc/boot/ops.h	2007-07-10 04:04:02.000000000 -0500
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
 
