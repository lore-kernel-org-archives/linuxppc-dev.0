Return-Path: <mgreer@mvista.com>
Date: Thu, 26 Oct 2006 15:50:45 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [RFC] bootwrapper: prevent fdt from being overwritten by kernel
Message-ID: <20061026225045.GA19839@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

If the fdt that's wrapped in a zImage isn't edited, it will still be
sitting in the zImage when the kernel boots
(i.e., at 0x400000 + <some offset into the zImage>).

That's okay until you get a large enough kernel (e.g., initramfs)
which will overwrite the fdt when the kernel is relocated to 0.

To handle that, I changed the sandpoint.c:platform_init() to base the
simple_alloc heap at the greater of either the end of the zImage or the end
of the kernel once its decompressed & relocated to 0.  It then copies
the dtb to an area allocated by simple_alloc so I know its safe from
being overwritten.

In addition, I moved the vmlinux elf header decompress code from
prep_kernel() to its own routine and called it before platform_init.
I then pass the elf header ptr into platform_init.  That way,
platform_init can figure out where the end of the kernel will
be and put the dtb beyond it.  The OF code can now change
claim_base in platform_init instead of needing the platform_ops.image_hdr
hook.

Here is the patch that I'm talking about with the sandpoint piece there
for your reference.

If you're okay with the approach, let me know and I'll submit a real patch.

Mark
---

 main.c      |   14 +++++++++-----
 of.c        |   29 +++++++++++++----------------
 ops.h       |    4 ++--
 sandpoint.c |   31 ++++++++++++++++++++++++++++---
 4 files changed, 52 insertions(+), 26 deletions(-)
---

diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index 234bb5b..4927c17 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -169,7 +169,7 @@ static int is_elf32(void *hdr)
 	return 1;
 }
 
-static void prep_kernel(unsigned long *a1, unsigned long *a2)
+static void get_elfheader(void)
 {
 	int len;
 
@@ -186,11 +186,13 @@ static void prep_kernel(unsigned long *a
 		       sizeof(elfheader));
 
 	if (!is_elf64(elfheader) && !is_elf32(elfheader)) {
-		printf("Error: not a valid PPC32 or PPC64 ELF file!\n\r");
 		exit();
 	}
-	if (platform_ops.image_hdr)
-		platform_ops.image_hdr(elfheader);
+}
+
+static void prep_kernel(unsigned long *a1, unsigned long *a2)
+{
+	int len;
 
 	/* We need to alloc the memsize plus the file offset since gzip
 	 * will expand the header (file offset), then the kernel, then
@@ -297,7 +299,9 @@ void start(unsigned long a1, unsigned lo
 	memset(&dt_ops, 0, sizeof(dt_ops));
 	memset(&console_ops, 0, sizeof(console_ops));
 
-	if (platform_init(promptr, _dtb_start, _dtb_end))
+	get_elfheader();
+
+	if (platform_init(promptr, elfheader, _dtb_start, _dtb_end))
 		exit();
 	if (console_ops.open && (console_ops.open() < 0))
 		exit();
diff --git a/arch/powerpc/boot/of.c b/arch/powerpc/boot/of.c
index 0182f38..8a81212 100644
--- a/arch/powerpc/boot/of.c
+++ b/arch/powerpc/boot/of.c
@@ -194,20 +194,6 @@ #endif
 	return (void *)addr;
 }
 
-static void of_image_hdr(const void *hdr)
-{
-	const Elf64_Ehdr *elf64 = hdr;
-
-	if (elf64->e_ident[EI_CLASS] == ELFCLASS64) {
-		/*
-		 * Maintain a "magic" minimum address. This keeps some older
-		 * firmware platforms running.
-		 */
-		if (claim_base < PROG_START)
-			claim_base = PROG_START;
-	}
-}
-
 static void of_exit(void)
 {
 	call_prom("exit", 0, 0);
@@ -256,9 +242,11 @@ static void of_console_write(char *buf, 
 	call_prom("write", 3, 1, of_stdout_handle, buf, len);
 }
 
-int platform_init(void *promptr, char *dt_blob_start, char *dt_blob_end)
+int platform_init(void *promptr, const void *elfhdr, char *dt_blob_start,
+		char *dt_blob_end)
 {
-	platform_ops.image_hdr = of_image_hdr;
+	const Elf64_Ehdr *elf64 = elfhdr;
+
 	platform_ops.malloc = of_try_claim;
 	platform_ops.exit = of_exit;
 
@@ -270,5 +258,14 @@ int platform_init(void *promptr, char *d
 	console_ops.write = of_console_write;
 
 	prom = (int (*)(void *))promptr;
+
+	if (elf64->e_ident[EI_CLASS] == ELFCLASS64) {
+		/*
+		 * Maintain a "magic" minimum address. This keeps some older
+		 * firmware platforms running.
+		 */
+		if (claim_base < PROG_START)
+			claim_base = PROG_START;
+	}
 	return 0;
 }
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 59832fb..97ca5d7 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -20,7 +20,6 @@ #define	MAX_PROP_LEN		256 /* What should
 /* Platform specific operations */
 struct platform_ops {
 	void	(*fixups)(void);
-	void	(*image_hdr)(const void *);
 	void *	(*malloc)(u32 size);
 	void	(*free)(void *ptr);
 	void *	(*realloc)(void *ptr, unsigned long size);
@@ -59,7 +58,8 @@ struct serial_console_data {
 	void		(*close)(void);
 };
 
-int platform_init(void *promptr, char *dt_blob_start, char *dt_blob_end);
+int platform_init(void *promptr, const void *elfhdr, char *dt_blob_start,
+		char *dt_blob_end);
 int ft_init(void *dt_blob, unsigned int max_size, unsigned int max_find_device);
 int serial_console_init(void);
 int ns16550_console_init(void *devp, struct serial_console_data *scdp);
diff --git a/arch/powerpc/boot/sandpoint.c b/arch/powerpc/boot/sandpoint.c
index 496cafd..61217c4 100644
--- a/arch/powerpc/boot/sandpoint.c
+++ b/arch/powerpc/boot/sandpoint.c
@@ -12,6 +12,8 @@
 #include <stdarg.h>
 #include <stddef.h>
 #include "types.h"
+#include "elf.h"
+#include "page.h"
 #include "string.h"
 #include "stdio.h"
 #include "io.h"
@@ -139,17 +141,40 @@ static void sandpoint_reset(void)
 
 #define	HEAP_SIZE	(16*MB)
 
-int platform_init(void *promptr, char *dt_blob_start, char *dt_blob_end)
+int platform_init(void *promptr, const void *elfhdr, char *dt_blob_start,
+		char *dt_blob_end)
 {
+	const Elf32_Ehdr *elf32 = elfhdr;
+	Elf32_Phdr *elf32ph = (Elf32_Phdr *)((unsigned long)elf32
+		+ elf32->e_phoff);
+	char *heap_start, *dtb;
 	int dt_size = dt_blob_end - dt_blob_start;
 
 	if (dt_size <= 0) /* No fdt */
 		goto err_out;
 
-	if ((unsigned)simple_alloc_init(_end, HEAP_SIZE, 2*KB, 16) > (32*MB))
+	if (elf32->e_ident[EI_CLASS] != ELFCLASS32)
 		goto err_out;
 
-	if (ft_init(dt_blob_start, dt_size, 16))
+	/* Start heap after end of the zImage or end of the kernel,
+	 * whichever is higher.  That's so things allocated by
+	 * simple_alloc won't overwrite any part of the zImage or
+	 * get overwritten when the early kernel code relocates
+	 * the kernel to 0.
+	 */
+	heap_start = (char *)_ALIGN(elf32ph->p_memsz + elf32ph->p_offset, 4096);
+	heap_start = max(heap_start, (char *)_end);
+
+	if ((unsigned)simple_alloc_init(heap_start, HEAP_SIZE, 2*KB, 16)
+			> (32*MB))
+		goto err_out;
+
+	/* Relocate dtb to safe area past end of zImage & kernel */
+	dtb = malloc(dt_size);
+	if (!dtb)
+		goto err_out;
+	memmove(dtb, dt_blob_start, dt_size);
+	if (ft_init(dtb, dt_size, 16))
 		goto err_out;
 
 	platform_ops.fixups = sandpoint_fixups;
