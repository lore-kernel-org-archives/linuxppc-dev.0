Return-Path: <mgreer@mvista.com>
Date: Wed, 11 Oct 2006 18:33:46 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/4] powerpc: More bootwrapper reorg
Message-ID: <20061012013346.GB9143@mag.az.mvista.com>
References: <20061012013223.GA9143@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061012013223.GA9143@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

More reorganization of the bootwrapper:
- Add dtb section to zImage
- ft_init now called by platform_init
- Pack a flat dt before calling kernel
- Remove size parameter from free
- printf only calls console_ops.write it its not NULL
- Some cleanup

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 main.c       |   27 ++++++---------------------
 of.c         |    8 +-------
 ops.h        |   25 ++++++++++++++-----------
 stdio.c      |    3 ++-
 wrapper      |    4 ++--
 zImage.lds.S |    5 +++++
 6 files changed, 30 insertions(+), 42 deletions(-)
---

diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index d719bb9..4184974 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -27,6 +27,8 @@ extern char _vmlinux_start[];
 extern char _vmlinux_end[];
 extern char _initrd_start[];
 extern char _initrd_end[];
+extern char _dtb_start[];
+extern char _dtb_end[];
 
 struct addr_range {
 	unsigned long addr;
@@ -250,10 +252,6 @@ #endif
 	flush_cache((void *)vmlinux.addr, vmlinux.size);
 }
 
-void __attribute__ ((weak)) ft_init(void *dt_blob)
-{
-}
-
 /* A buffer that may be edited by tools operating on a zImage binary so as to
  * edit the command line passed to vmlinux (by setting /chosen/bootargs).
  * The buffer is put in it's own section so that tools may locate it easier.
@@ -285,19 +283,12 @@ static void set_cmdline(char *buf)
 		setprop(devp, "bootargs", buf, strlen(buf) + 1);
 }
 
-/* Section where ft can be tacked on after zImage is built */
-union blobspace {
-	struct boot_param_header hdr;
-	char space[8*1024];
-} dt_blob __attribute__((__section__("__builtin_ft")));
-
 struct platform_ops platform_ops;
 struct dt_ops dt_ops;
 struct console_ops console_ops;
 
 void start(unsigned long a1, unsigned long a2, void *promptr, void *sp)
 {
-	int have_dt = 0;
 	kernel_entry_t kentry;
 	char cmdline[COMMAND_LINE_SIZE];
 
@@ -306,15 +297,7 @@ void start(unsigned long a1, unsigned lo
 	memset(&dt_ops, 0, sizeof(dt_ops));
 	memset(&console_ops, 0, sizeof(console_ops));
 
-	/* Override the dt_ops and device tree if there was an flat dev
-	 * tree attached to the zImage.
-	 */
-	if (dt_blob.hdr.magic == OF_DT_HEADER) {
-		have_dt = 1;
-		ft_init(&dt_blob);
-	}
-
-	if (platform_init(promptr))
+	if (platform_init(promptr, _dtb_start, _dtb_end))
 		exit();
 	if (console_ops.open && (console_ops.open() < 0))
 		exit();
@@ -342,8 +325,10 @@ void start(unsigned long a1, unsigned lo
 		console_ops.close();
 
 	kentry = (kernel_entry_t) vmlinux.addr;
-	if (have_dt)
+	if (_dtb_end > _dtb_start) {
+		dt_ops.ft_pack();
 		kentry(dt_ops.ft_addr(), 0, NULL);
+	}
 	else
 		/* XXX initrd addr/size should be passed in properties */
 		kentry(a1, a2, promptr);
diff --git a/arch/powerpc/boot/of.c b/arch/powerpc/boot/of.c
index 3a71845..0182f38 100644
--- a/arch/powerpc/boot/of.c
+++ b/arch/powerpc/boot/of.c
@@ -256,24 +256,18 @@ static void of_console_write(char *buf, 
 	call_prom("write", 3, 1, of_stdout_handle, buf, len);
 }
 
-int platform_init(void *promptr)
+int platform_init(void *promptr, char *dt_blob_start, char *dt_blob_end)
 {
-	platform_ops.fixups = NULL;
 	platform_ops.image_hdr = of_image_hdr;
 	platform_ops.malloc = of_try_claim;
-	platform_ops.free = NULL;
 	platform_ops.exit = of_exit;
 
 	dt_ops.finddevice = of_finddevice;
 	dt_ops.getprop = of_getprop;
 	dt_ops.setprop = of_setprop;
-	dt_ops.translate_addr = NULL;
 
 	console_ops.open = of_console_open;
 	console_ops.write = of_console_write;
-	console_ops.edit_cmdline = NULL;
-	console_ops.close = NULL;
-	console_ops.data = NULL;
 
 	prom = (int (*)(void *))promptr;
 	return 0;
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 135eb4b..59832fb 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -22,7 +22,8 @@ struct platform_ops {
 	void	(*fixups)(void);
 	void	(*image_hdr)(const void *);
 	void *	(*malloc)(u32 size);
-	void	(*free)(void *ptr, u32 size);
+	void	(*free)(void *ptr);
+	void *	(*realloc)(void *ptr, unsigned long size);
 	void	(*exit)(void);
 };
 extern struct platform_ops platform_ops;
@@ -30,12 +31,11 @@ extern struct platform_ops platform_ops;
 /* Device Tree operations */
 struct dt_ops {
 	void *	(*finddevice)(const char *name);
-	int	(*getprop)(const void *node, const char *name, void *buf,
+	int	(*getprop)(const void *phandle, const char *name, void *buf,
 			const int buflen);
-	int	(*setprop)(const void *node, const char *name,
+	int	(*setprop)(const void *phandle, const char *name,
 			const void *buf, const int buflen);
-	u64	(*translate_addr)(const char *path, const u32 *in_addr,
-			const u32 addr_len);
+	void	(*ft_pack)(void);
 	unsigned long (*ft_addr)(void);
 };
 extern struct dt_ops dt_ops;
@@ -59,10 +59,13 @@ struct serial_console_data {
 	void		(*close)(void);
 };
 
-extern int platform_init(void *promptr);
-extern void simple_alloc_init(void);
-extern void ft_init(void *dt_blob);
-extern int serial_console_init(void);
+int platform_init(void *promptr, char *dt_blob_start, char *dt_blob_end);
+int ft_init(void *dt_blob, unsigned int max_size, unsigned int max_find_device);
+int serial_console_init(void);
+int ns16550_console_init(void *devp, struct serial_console_data *scdp);
+void *simple_alloc_init(char *base, u32 heap_size, u32 granularity,
+		u32 max_allocs);
+
 
 static inline void *finddevice(const char *name)
 {
@@ -84,10 +87,10 @@ static inline void *malloc(u32 size)
 	return (platform_ops.malloc) ? platform_ops.malloc(size) : NULL;
 }
 
-static inline void free(void *ptr, u32 size)
+static inline void free(void *ptr)
 {
 	if (platform_ops.free)
-		platform_ops.free(ptr, size);
+		platform_ops.free(ptr);
 }
 
 static inline void exit(void)
diff --git a/arch/powerpc/boot/stdio.c b/arch/powerpc/boot/stdio.c
index 6d5f638..0a9feeb 100644
--- a/arch/powerpc/boot/stdio.c
+++ b/arch/powerpc/boot/stdio.c
@@ -320,6 +320,7 @@ printf(const char *fmt, ...)
 	va_start(args, fmt);
 	n = vsprintf(sprint_buf, fmt, args);
 	va_end(args);
-	console_ops.write(sprint_buf, n);
+	if (console_ops.write)
+		console_ops.write(sprint_buf, n);
 	return n;
 }
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index eab7318..b5fb1fe 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -179,11 +179,11 @@ if [ -z "$cacheit" ]; then
 fi
 
 if [ -n "$initrd" ]; then
-    addsec $tmp "$initrd" initrd
+    addsec $tmp "$initrd" $isection
 fi
 
 if [ -n "$dtb" ]; then
-    addsec $tmp "$dtb" dtb
+    addsec $tmp "$dtb" .kernel:dtb
 fi
 
 if [ "$platform" != "miboot" ]; then
diff --git a/arch/powerpc/boot/zImage.lds.S b/arch/powerpc/boot/zImage.lds.S
index 4b6bb3f..4be3c64 100644
--- a/arch/powerpc/boot/zImage.lds.S
+++ b/arch/powerpc/boot/zImage.lds.S
@@ -21,6 +21,11 @@ SECTIONS
     __got2_end = .;
   }
 
+  . = ALIGN(8);
+  _dtb_start = .;
+  .kernel:dtb : { *(.kernel:dtb) }
+  _dtb_end = .;
+
   . = ALIGN(4096);
   _vmlinux_start =  .;
   .kernel:vmlinux.strip : { *(.kernel:vmlinux.strip) }
