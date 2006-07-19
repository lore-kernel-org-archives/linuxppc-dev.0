Return-Path: <mgreer@mvista.com>
Date: Wed, 19 Jul 2006 16:00:14 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/6] bootwrapper: arch/powerpc/boot code reorg
Message-ID: <20060719230014.GB3887@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Abstract the operations used in the bootwrapper.  The operations
have been divided up into platform ops (platform_ops), firware ops
(fw_ops), device tree ops (dt_ops), and console ops (console_ops).

The proper operations will be hooked up at runtime to provide the
functionality that you need.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

 main.c  |  219 +++++++++++++++++++++++++++++-----------------------------------
 ops.h   |  117 ++++++++++++++++++++++++++++++++++
 stdio.c |    4 -
 types.h |   29 ++++++++
 4 files changed, 248 insertions(+), 121 deletions(-)
--

diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index b66634c..0e49f58 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -14,17 +14,11 @@ #include "elf.h"
 #include "page.h"
 #include "string.h"
 #include "stdio.h"
-#include "prom.h"
 #include "zlib.h"
+#include "ops.h"
 
 extern void flush_cache(void *, unsigned long);
 
-
-/* Value picked to match that used by yaboot */
-#define PROG_START	0x01400000	/* only used on 64-bit systems */
-#define RAM_END		(512<<20)	/* Fixme: use OF */
-#define	ONE_MB		0x100000
-
 extern char _start[];
 extern char __bss_start[];
 extern char _end[];
@@ -33,14 +27,6 @@ extern char _vmlinux_end[];
 extern char _initrd_start[];
 extern char _initrd_end[];
 
-/* A buffer that may be edited by tools operating on a zImage binary so as to
- * edit the command line passed to vmlinux (by setting /chosen/bootargs).
- * The buffer is put in it's own section so that tools may locate it easier.
- */
-static char builtin_cmdline[512]
-	__attribute__((section("__builtin_cmdline")));
-
-
 struct addr_range {
 	unsigned long addr;
 	unsigned long size;
@@ -55,17 +41,8 @@ static unsigned long elfoffset;
 static char scratch[46912];	/* scratch space for gunzip, from zlib_inflate_workspacesize() */
 static char elfheader[256];
 
-
-typedef void (*kernel_entry_t)( unsigned long,
-                                unsigned long,
-                                void *,
-				void *);
-
-
 #undef DEBUG
 
-static unsigned long claim_base;
-
 #define HEAD_CRC	2
 #define EXTRA_FIELD	4
 #define ORIG_NAME	8
@@ -123,24 +100,6 @@ static void gunzip(void *dst, int dstlen
 	zlib_inflateEnd(&s);
 }
 
-static unsigned long try_claim(unsigned long size)
-{
-	unsigned long addr = 0;
-
-	for(; claim_base < RAM_END; claim_base += ONE_MB) {
-#ifdef DEBUG
-		printf("    trying: 0x%08lx\n\r", claim_base);
-#endif
-		addr = (unsigned long)claim(claim_base, size, 0);
-		if ((void *)addr != (void *)-1)
-			break;
-	}
-	if (addr == 0)
-		return 0;
-	claim_base = PAGE_ALIGN(claim_base + size);
-	return addr;
-}
-
 static int is_elf64(void *hdr)
 {
 	Elf64_Ehdr *elf64 = hdr;
@@ -169,16 +128,6 @@ static int is_elf64(void *hdr)
 	vmlinux.size = (unsigned long)elf64ph->p_filesz + elfoffset;
 	vmlinux.memsize = (unsigned long)elf64ph->p_memsz + elfoffset;
 
-#if defined(PROG_START)
-	/*
-	 * Maintain a "magic" minimum address. This keeps some older
-	 * firmware platforms running.
-	 */
-
-	if (claim_base < PROG_START)
-		claim_base = PROG_START;
-#endif
-
 	return 1;
 }
 
@@ -212,47 +161,11 @@ static int is_elf32(void *hdr)
 	return 1;
 }
 
-void export_cmdline(void* chosen_handle)
-{
-        int len;
-        char cmdline[2] = { 0, 0 };
-
-	if (builtin_cmdline[0] == 0)
-		return;
-
-        len = getprop(chosen_handle, "bootargs", cmdline, sizeof(cmdline));
-        if (len > 0 && cmdline[0] != 0)
-		return;
-
-	setprop(chosen_handle, "bootargs", builtin_cmdline,
-		strlen(builtin_cmdline) + 1);
-}
-
-
-void start(unsigned long a1, unsigned long a2, void *promptr, void *sp)
+static void prep_kernel(unsigned long *a1, unsigned long *a2, void *sp)
 {
 	int len;
-	kernel_entry_t kernel_entry;
-
-	memset(__bss_start, 0, _end - __bss_start);
-
-	prom = (int (*)(void *)) promptr;
-	chosen_handle = finddevice("/chosen");
-	if (chosen_handle == (void *) -1)
-		exit();
-	if (getprop(chosen_handle, "stdout", &stdout, sizeof(stdout)) != 4)
-		exit();
-
-	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r", _start, sp);
-
-	/*
-	 * The first available claim_base must be above the end of the
-	 * the loaded kernel wrapper file (_start to _end includes the
-	 * initrd image if it is present) and rounded up to a nice
-	 * 1 MB boundary for good measure.
-	 */
 
-	claim_base = _ALIGN_UP((unsigned long)_end, ONE_MB);
+	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r", _start,sp);
 
 	vmlinuz.addr = (unsigned long)_vmlinux_start;
 	vmlinuz.size = (unsigned long)(_vmlinux_end - _vmlinux_start);
@@ -263,43 +176,46 @@ void start(unsigned long a1, unsigned lo
 		gunzip(elfheader, sizeof(elfheader),
 				(unsigned char *)vmlinuz.addr, &len);
 	} else
-		memcpy(elfheader, (const void *)vmlinuz.addr, sizeof(elfheader));
+		memcpy(elfheader, (const void *)vmlinuz.addr,sizeof(elfheader));
 
 	if (!is_elf64(elfheader) && !is_elf32(elfheader)) {
 		printf("Error: not a valid PPC32 or PPC64 ELF file!\n\r");
 		exit();
 	}
 
-	/* We need to claim the memsize plus the file offset since gzip
+	/* We need to alloc the memsize plus the file offset since gzip
 	 * will expand the header (file offset), then the kernel, then
 	 * possible rubbish we don't care about. But the kernel bss must
 	 * be claimed (it will be zero'd by the kernel itself)
 	 */
 	printf("Allocating 0x%lx bytes for kernel ...\n\r", vmlinux.memsize);
-	vmlinux.addr = try_claim(vmlinux.memsize);
+	vmlinux.addr = (unsigned long)malloc(vmlinux.memsize);
 	if (vmlinux.addr == 0) {
 		printf("Can't allocate memory for kernel image !\n\r");
 		exit();
 	}
 
 	/*
-	 * Now we try to claim memory for the initrd (and copy it there)
+	 * Now we try to alloc memory for the initrd (and copy it there)
 	 */
 	initrd.size = (unsigned long)(_initrd_end - _initrd_start);
 	initrd.memsize = initrd.size;
 	if ( initrd.size > 0 ) {
-		printf("Allocating 0x%lx bytes for initrd ...\n\r", initrd.size);
-		initrd.addr = try_claim(initrd.size);
+		printf("Allocating 0x%lx bytes for initrd ...\n\r",initrd.size);
+		initrd.addr = (unsigned long)malloc((u32)initrd.size);
 		if (initrd.addr == 0) {
-			printf("Can't allocate memory for initial ramdisk !\n\r");
+			printf("Can't allocate memory for initial "
+					"ramdisk !\n\r");
 			exit();
 		}
-		a1 = initrd.addr;
-		a2 = initrd.size;
-		printf("initial ramdisk moving 0x%lx <- 0x%lx (0x%lx bytes)\n\r",
-		       initrd.addr, (unsigned long)_initrd_start, initrd.size);
-		memmove((void *)initrd.addr, (void *)_initrd_start, initrd.size);
-		printf("initrd head: 0x%lx\n\r", *((unsigned long *)initrd.addr));
+		*a1 = initrd.addr;
+		*a2 = initrd.size;
+		printf("initial ramdisk moving 0x%lx <- 0x%lx "
+			"(0x%lx bytes)\n\r", initrd.addr,
+			(unsigned long)_initrd_start, initrd.size);
+		memmove((void *)initrd.addr, (void *)_initrd_start,initrd.size);
+		printf("initrd head: 0x%lx\n\r",
+				*((unsigned long *)initrd.addr));
 	}
 
 	/* Eventually gunzip the kernel */
@@ -314,8 +230,6 @@ void start(unsigned long a1, unsigned lo
 		memmove((void *)vmlinux.addr,(void *)vmlinuz.addr,vmlinuz.size);
 	}
 
-	export_cmdline(chosen_handle);
-
 	/* Skip over the ELF header */
 #ifdef DEBUG
 	printf("... skipping 0x%lx bytes of ELF header\n\r",
@@ -324,23 +238,90 @@ #endif
 	vmlinux.addr += elfoffset;
 
 	flush_cache((void *)vmlinux.addr, vmlinux.size);
+}
 
-	kernel_entry = (kernel_entry_t)vmlinux.addr;
-#ifdef DEBUG
-	printf( "kernel:\n\r"
-		"        entry addr = 0x%lx\n\r"
-		"        a1         = 0x%lx,\n\r"
-		"        a2         = 0x%lx,\n\r"
-		"        prom       = 0x%lx,\n\r"
-		"        bi_recs    = 0x%lx,\n\r",
-		(unsigned long)kernel_entry, a1, a2,
-		(unsigned long)prom, NULL);
-#endif
+/* A buffer that may be edited by tools operating on a zImage binary so as to
+ * edit the command line passed to vmlinux (by setting /chosen/bootargs).
+ * The buffer is put in it's own section so that tools may locate it easier.
+ */
+static char builtin_cmdline[COMMAND_LINE_SIZE]
+	__attribute__((__section__("__builtin_cmdline")));
 
-	kernel_entry(a1, a2, prom, NULL);
+static void get_cmdline(char *buf, int size)
+{
+	void *devp;
+	int len = strlen(builtin_cmdline);
 
-	printf("Error: Linux kernel returned to zImage bootloader!\n\r");
+	buf[0] = '\0';
 
-	exit();
+	if (len > 0) { /* builtin_cmdline overrides dt's /chosen/bootargs */
+		len = min(len, size-1);
+		strncpy(buf, builtin_cmdline, len);
+		buf[len] = '\0';
+	}
+	else if ((devp = finddevice("/chosen")))
+		getprop(devp, "bootargs", buf, size);
+}
+
+static void set_cmdline(char *buf)
+{
+	void *devp;
+
+	if ((devp = finddevice("/chosen")))
+		setprop(devp, "bootargs", buf, strlen(buf) + 1);
 }
 
+/* Section where fdt can be tacked on after zImage is built */
+#define	EMPTY_SECTION_STR	"no fdt"
+
+char dt_blob_start[8*1024]
+	__attribute__((__section__("__builtin_fdt"),__aligned__(8)))
+		= EMPTY_SECTION_STR;
+
+struct ops *ops;
+
+void start(unsigned long a1, unsigned long a2, void *promptr, void *sp)
+{
+	char cmdline[COMMAND_LINE_SIZE];
+
+	memset(__bss_start, 0, _end - __bss_start);
+
+	ops = platform_init(promptr);
+
+	/* Override the dt_ops if there was an fdt attached to the zImage */
+	if (strcmp(dt_blob_start, EMPTY_SECTION_STR))
+		ops->dt_ops = fdt_init(dt_blob_start);
+
+	if (!ops || !ops->platform_ops || !ops->fw_ops || !ops->dt_ops
+			|| !ops->console_ops)
+		exit();
+
+	if (ops->console_ops->open && (ops->console_ops->open() < 0))
+		exit();
+	if (ops->platform_ops->fixups)
+		ops->platform_ops->fixups();
+
+	prep_kernel(&a1, &a2, sp);
+
+	/* If cmdline came from zimage wrapper or if we can edit the one
+	 * in the dt, print it out and edit it, if possible.
+	 */
+	if ((strlen(builtin_cmdline) > 0) || ops->console_ops->edit_cmdline) {
+		get_cmdline(cmdline, COMMAND_LINE_SIZE);
+		printf("\n\rLinux/PowerPC load: %s", cmdline);
+		if (ops->console_ops->edit_cmdline)
+			ops->console_ops->edit_cmdline(cmdline,
+					COMMAND_LINE_SIZE);
+		printf("\n\r");
+		set_cmdline(cmdline);
+	}
+
+	if (ops->console_ops->close)
+		ops->console_ops->close();
+
+	ops->dt_ops->call_kernel((void *)vmlinux.addr, a1, a2, promptr, sp);
+
+	/* console closed so printf below may not work */
+	printf("Error: Linux kernel returned to zImage bootloader!\n\r");
+	exit();
+}
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
new file mode 100644
index 0000000..94d97b0
--- /dev/null
+++ b/arch/powerpc/boot/ops.h
@@ -0,0 +1,117 @@
+/*
+ * Global definition of all the bootwrapper operations.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2006 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef _PPC_BOOT_OPS_H_
+#define _PPC_BOOT_OPS_H_
+
+#include "types.h"
+
+/* Platform specific operations */
+struct platform_ops {
+	void	(*fixups)(void);
+	void	(*exit)(void);
+};
+
+/* Firmware specific operations */
+struct fw_ops {
+	void *	(*malloc)(u32 size);
+	void	(*free)(void *ptr, u32 size);
+	void	(*exit)(void);
+};
+
+/* Device Tree operations */
+struct dt_ops {
+	void *	(*finddevice)(const char *name);
+	int	(*getprop)(void *node, const char *name, void *buf, int buflen);
+	int	(*setprop)(void *node, const char *name, void *buf, int buflen);
+	u64	(*translate_addr)(char *path, u32 *in_addr, u32 addr_len);
+	void	(*call_kernel)(void *entry_addr, unsigned long a1,
+			unsigned long a2, void *promptr, void *sp);
+};
+
+/* Serial console operations */
+struct serial_console_data {
+	int		(*open)(void);
+	void		(*putc)(unsigned char c);
+	unsigned char	(*getc)(void);
+	u8		(*tstc)(void);
+	void		(*close)(void);
+	unsigned char	*base;
+	u8		reg_shift;
+};
+
+/* Console operations */
+struct console_ops {
+	int	(*open)(void);
+	void	(*write)(char *buf, int len);
+	void	(*edit_cmdline)(char *buf, int len);
+	void	(*close)(void);
+	void	*data;
+};
+
+struct ops {
+	struct platform_ops	*platform_ops;
+	struct fw_ops		*fw_ops;
+	struct dt_ops		*dt_ops;
+	struct console_ops	*console_ops;
+};
+
+extern struct ops *ops;
+
+extern struct ops *platform_init(void *promptr);
+extern struct fw_ops *dink_init(void);
+extern struct dt_ops *fdt_init(void *dt_blob);
+extern struct console_ops *ns16550_init(void);
+
+extern int serial_open(void);
+extern void serial_write(char *buf, int len);
+extern void serial_edit_cmdline(char *buf, int len);
+extern void serial_close(void);
+
+static inline void *finddevice(const char *name)
+{
+	return (ops->dt_ops->finddevice) ? ops->dt_ops->finddevice(name) : NULL;
+}
+
+static inline int getprop(void *devp, const char *name, void *buf, int buflen)
+{
+	return (ops->dt_ops->getprop) ?
+			ops->dt_ops->getprop(devp, name, buf, buflen) : -1;
+}
+
+static inline int setprop(void *devp, const char *name, void *buf, int buflen)
+{
+	return (ops->dt_ops->setprop) ?
+			ops->dt_ops->setprop(devp, name, buf, buflen) : -1;
+}
+
+static inline void *malloc(u32 size)
+{
+	return (ops->fw_ops->malloc) ? ops->fw_ops->malloc(size) : NULL;
+}
+
+static inline void free(void *ptr, u32 size)
+{
+	if (ops->fw_ops->free)
+		ops->fw_ops->free(ptr, size);
+}
+
+static inline void exit(void)
+{
+	if (ops) {
+		if (ops->platform_ops && ops->platform_ops->exit)
+			ops->platform_ops->exit();
+		if (ops->fw_ops && ops->fw_ops->exit)
+			ops->fw_ops->exit();
+	}
+	for(;;);
+}
+
+#endif /* _PPC_BOOT_OPS_H_ */
diff --git a/arch/powerpc/boot/stdio.c b/arch/powerpc/boot/stdio.c
index b5aa522..7ccc504 100644
--- a/arch/powerpc/boot/stdio.c
+++ b/arch/powerpc/boot/stdio.c
@@ -10,7 +10,7 @@ #include <stdarg.h>
 #include <stddef.h>
 #include "string.h"
 #include "stdio.h"
-#include "prom.h"
+#include "ops.h"
 
 size_t strnlen(const char * s, size_t count)
 {
@@ -320,6 +320,6 @@ printf(const char *fmt, ...)
 	va_start(args, fmt);
 	n = vsprintf(sprint_buf, fmt, args);
 	va_end(args);
-	write(stdout, sprint_buf, n);
+	ops->console_ops->write(sprint_buf, n);
 	return n;
 }
diff --git a/arch/powerpc/boot/types.h b/arch/powerpc/boot/types.h
new file mode 100644
index 0000000..2a2fa2b
--- /dev/null
+++ b/arch/powerpc/boot/types.h
@@ -0,0 +1,29 @@
+#ifndef _TYPES_H_
+#define _TYPES_H_
+
+#define	COMMAND_LINE_SIZE	512
+#define	MAX_PATH_LEN		256
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+typedef unsigned char		u8;
+typedef unsigned short		u16;
+typedef unsigned int		u32;
+#ifdef __powerpc64__
+typedef unsigned long		u64;
+#else
+typedef unsigned long long	u64;
+#endif
+
+#define min(x,y) ({ \
+	typeof(x) _x = (x);	\
+	typeof(y) _y = (y);	\
+	(void) (&_x == &_y);	\
+	_x < _y ? _x : _y; })
+
+#define max(x,y) ({ \
+	typeof(x) _x = (x);	\
+	typeof(y) _y = (y);	\
+	(void) (&_x == &_y);	\
+	_x > _y ? _x : _y; })
+
+#endif /* _TYPES_H_ */
