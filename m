Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id C22A9DDF8D
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 10:01:30 +1100 (EST)
Date: Wed, 7 Feb 2007 17:01:19 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 03/19] bootwrapper: Remove OF-isms
Message-ID: <20070207230119.GC3849@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove some OF-specific assumptions in generic bootwrapper code in
preparation for an old-U-Boot compatibility target.  Up to five parameter
registers can now be passed to platform_init, and only platform code
should interpret them.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/crt0.S |    2 +-
 arch/powerpc/boot/main.c |   35 +++++++++++++++--------------------
 arch/powerpc/boot/of.c   |    9 +++++++--
 arch/powerpc/boot/ops.h  |   12 +++++++++++-
 4 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
index 70e65b1..fac9d3d 100644
--- a/arch/powerpc/boot/crt0.S
+++ b/arch/powerpc/boot/crt0.S
@@ -59,6 +59,6 @@ _zimage_start:
 	sync
 	isync
 
-	mr	r6,r1
+	mr	r8,r1
 	b	start
 
diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index 6f6b50d..f60d8cf 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -30,14 +30,9 @@ extern char _initrd_end[];
 extern char _dtb_start[];
 extern char _dtb_end[];
 
-struct addr_range {
-	unsigned long addr;
-	unsigned long size;
-	unsigned long memsize;
-};
 static struct addr_range vmlinux;
 static struct addr_range vmlinuz;
-static struct addr_range initrd;
+struct addr_range initrd;
 
 static unsigned long elfoffset;
 static int is_64bit;
@@ -46,7 +41,7 @@ static int is_64bit;
 static char scratch[46912];
 static char elfheader[256];
 
-typedef void (*kernel_entry_t)(unsigned long, unsigned long, void *);
+typedef void (*kernel_entry_t)(unsigned long, unsigned long, unsigned long);
 
 #undef DEBUG
 
@@ -169,7 +164,7 @@ static int is_elf32(void *hdr)
 	return 1;
 }
 
-static void prep_kernel(unsigned long a1, unsigned long a2)
+static void prep_kernel(void)
 {
 	int len;
 
@@ -210,9 +205,10 @@ static void prep_kernel(unsigned long a1
 	 * First see if we have an image attached to us.  If so
 	 * allocate memory for it and copy it there.
 	 */
-	initrd.size = (unsigned long)(_initrd_end - _initrd_start);
-	initrd.memsize = initrd.size;
-	if (initrd.size > 0) {
+	if (_initrd_end != _initrd_start) {
+		initrd.size = (unsigned long)(_initrd_end - _initrd_start);
+		initrd.memsize = initrd.size;
+
 		printf("Allocating 0x%lx bytes for initrd ...\n\r",
 		       initrd.size);
 		initrd.addr = (unsigned long)malloc((u32)initrd.size);
@@ -228,10 +224,8 @@ static void prep_kernel(unsigned long a1
 			initrd.size);
 		printf("initrd head: 0x%lx\n\r",
 				*((unsigned long *)initrd.addr));
-	} else if (a2 != 0) {
+	} else if (initrd.size != 0) {
 		/* Otherwise, see if yaboot or another loader gave us an initrd */
-		initrd.addr = a1;
-		initrd.memsize = initrd.size = a2;
 		printf("Using loader supplied initrd at 0x%lx (0x%lx bytes)\n\r",
 		       initrd.addr, initrd.size);
 	}
@@ -294,7 +288,8 @@ struct platform_ops platform_ops;
 struct dt_ops dt_ops;
 struct console_ops console_ops;
 
-void start(unsigned long a1, unsigned long a2, void *promptr, void *sp)
+void start(unsigned long r3, unsigned long r4, unsigned long r5,
+           unsigned long r6, unsigned long r7, void *sp)
 {
 	kernel_entry_t kentry;
 	char cmdline[COMMAND_LINE_SIZE];
@@ -305,7 +300,7 @@ void start(unsigned long a1, unsigned lo
 	memset(&dt_ops, 0, sizeof(dt_ops));
 	memset(&console_ops, 0, sizeof(console_ops));
 
-	if (platform_init(promptr, _dtb_start, _dtb_end))
+	if (platform_init(r3, r4, r5, r6, r7, _dtb_start, _dtb_end))
 		exit();
 	if (console_ops.open && (console_ops.open() < 0))
 		exit();
@@ -315,7 +310,7 @@ void start(unsigned long a1, unsigned lo
 	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r",
 	       _start, sp);
 
-	prep_kernel(a1, a2);
+	prep_kernel();
 
 	/* If cmdline came from zimage wrapper or if we can edit the one
 	 * in the dt, print it out and edit it, if possible.
@@ -335,17 +330,17 @@ void start(unsigned long a1, unsigned lo
 	if (ft_addr)
 		printf(" flat tree at 0x%lx\n\r", ft_addr);
 	else
-		printf(" using OF tree (promptr=%p)\n\r", promptr);
+		printf(" using OF tree (promptr=%p)\n\r", r5);
 
 	if (console_ops.close)
 		console_ops.close();
 
 	kentry = (kernel_entry_t) vmlinux.addr;
 	if (ft_addr)
-		kentry(ft_addr, 0, NULL);
+		kentry(ft_addr, 0, 0);
 	else
 		/* XXX initrd addr/size should be passed in properties */
-		kentry(initrd.addr, initrd.size, promptr);
+		kentry(initrd.addr, initrd.size, r5);
 
 	/* console closed so printf below may not work */
 	printf("Error: Linux kernel returned to zImage boot wrapper!\n\r");
diff --git a/arch/powerpc/boot/of.c b/arch/powerpc/boot/of.c
index 0182f38..f6a696c 100644
--- a/arch/powerpc/boot/of.c
+++ b/arch/powerpc/boot/of.c
@@ -256,7 +256,9 @@ static void of_console_write(char *buf,
 	call_prom("write", 3, 1, of_stdout_handle, buf, len);
 }
 
-int platform_init(void *promptr, char *dt_blob_start, char *dt_blob_end)
+int platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                  unsigned long r6, unsigned long r7,
+                  char *dt_blob_start, char *dt_blob_end)
 {
 	platform_ops.image_hdr = of_image_hdr;
 	platform_ops.malloc = of_try_claim;
@@ -269,6 +271,9 @@ int platform_init(void *promptr, char *d
 	console_ops.open = of_console_open;
 	console_ops.write = of_console_write;
 
-	prom = (int (*)(void *))promptr;
+	initrd.addr = r3;
+	initrd.memsize = initrd.size = r4;
+
+	prom = (int (*)(void *))r5;
 	return 0;
 }
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 4ac7b02..42c723d 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -59,7 +59,9 @@ struct serial_console_data {
 	void		(*close)(void);
 };
 
-int platform_init(void *promptr, char *dt_blob_start, char *dt_blob_end);
+int platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                  unsigned long r6, unsigned long r7,
+                  char *dt_blob_start, char *dt_blob_end);
 int ft_init(void *dt_blob, unsigned int max_size, unsigned int max_find_device);
 int serial_console_init(void);
 int ns16550_console_init(void *devp, struct serial_console_data *scdp);
@@ -100,4 +102,12 @@ static inline void exit(void)
 	for(;;);
 }
 
+struct addr_range {
+	unsigned long addr;
+	unsigned long size;
+	unsigned long memsize;
+};
+
+extern struct addr_range initrd;
+
 #endif /* _PPC_BOOT_OPS_H_ */
-- 
1.4.4
