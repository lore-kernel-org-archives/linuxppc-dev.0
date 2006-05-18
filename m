Return-Path: <mgreer@mvista.com>
Date: Wed, 17 May 2006 17:21:42 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [HACK] add sandpoint + flattened dt support to arch/powerpc/boot
Message-ID: <20060518002142.GA23182@mag.az.mvista.com>
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

Hi,

This is a patch with some very rough code that adds support for the
sandpoint to arch/powerpc.  I'm posting it now in the hope that it
will spark a deeper discussion on exactly how we're going to support
flattened device tree code in the bootwrapper for non-OF platforms.
I'm also hoping that it will help others that are working on the same
sort of thing so we can help each other.

Again, the code is rough with lots of hacks but it boots and is
something we can point to during this discussion.

So...I am on the right path?

Mark
---

 Kconfig                           |   10 
 boot/Makefile                     |    8 
 boot/dt_utils.c                   |   95 +++
 boot/dts/sandpoint.dts            |  204 +++++++
 boot/io.h                         |  160 +++++
 boot/main.c                       |   42 +
 boot/mpc10x.c                     |   88 +++
 boot/ns16550.c                    |  118 ++++
 boot/prom.h                       |   52 +
 boot/prom_embedded.c              |  112 ++++
 boot/sandpoint.c                  |  110 ++++
 boot/types.h                      |   28 +
 configs/sandpoint_defconfig       | 1017 ++++++++++++++++++++++++++++++++++++++
 kernel/legacy_serial.c            |    2 
 platforms/Makefile                |    1 
 platforms/embedded6xx/Makefile    |    4 
 platforms/embedded6xx/sandpoint.c |  629 +++++++++++++++++++++++
 sysdev/mpic.c                     |    7 
 18 files changed, 2676 insertions(+), 11 deletions(-)
 ---

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6729c98..de09eac 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -323,7 +323,10 @@ config PPC_ISERIES
 
 config EMBEDDED6xx
 	bool "Embedded 6xx/7xx/7xxx-based board"
-	depends on PPC32 && BROKEN
+	depends on PPC32
+	select PPC_UDBG_16550
+	select MPIC
+	select MPIC_SERIAL
 
 config APUS
 	bool "Amiga-APUS"
@@ -411,6 +414,11 @@ config MPIC
 	depends on PPC_PSERIES || PPC_PMAC || PPC_MAPLE || PPC_CHRP
 	bool
 	default y
+
+config MPIC_SERIAL
+	depends on EMBEDDED6xx
+	bool
+	default n
 
 config PPC_RTAS
 	bool
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 840ae59..1995544 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -36,8 +36,14 @@ zliblinuxheader := zlib.h zconf.h zutil.
 $(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheader))
 #$(addprefix $(obj)/,main.o): $(addprefix $(obj)/,zlib.h)
 
-src-boot := crt0.S string.S prom.c stdio.c main.c div64.S
+src-boot := crt0.S string.S stdio.c main.c div64.S
 src-boot += $(zlib)
+ifeq ($(CONFIG_EMBEDDED6xx),y)
+src-boot += prom_embedded.c ns16550.c dts/sandpoint.S \
+	dt_utils.c sandpoint.c mpc10x.c
+else
+src-boot += prom.c
+endif
 src-boot := $(addprefix $(obj)/, $(src-boot))
 obj-boot := $(addsuffix .o, $(basename $(src-boot)))
 
diff --git a/arch/powerpc/boot/dt_utils.c b/arch/powerpc/boot/dt_utils.c
new file mode 100644
index 0000000..c991598
--- /dev/null
+++ b/arch/powerpc/boot/dt_utils.c
@@ -0,0 +1,95 @@
+/*
+ * Simple dtb (binary flattened device tree) search/manipulation routines.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ * 	- The code for strrchr() was copied from lib/string.c and is
+ * 	copyrighted by Linus Torvalds.
+ * 	- The smarts for dt_find_prop_by_name() were copied with the author's
+ * 	permission from u-boot:common/ft_build.c which was written by
+ * 	Pantelis Antoniou <pantelis@embeddedalley.com>.
+ *
+ * 2006 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+/* Supports dtb version 0x10 only */
+
+#include <stdarg.h>
+#include "page.h"
+#include "string.h"
+#include "stdio.h"
+#include "prom.h"
+
+struct boot_param_header *
+dt_get_bph(void *dt_blob)
+{
+	return (struct boot_param_header *)dt_blob;
+}
+
+char *
+strrchr(const char *s, int c)
+{
+	const char *p = s + strlen(s);
+
+	do {
+		if (*p == (char)c)
+			return (char *)p;
+	} while (--p >= s);
+	return NULL;
+}
+
+
+void *
+dt_find_prop_by_name(void *dt_blob, char *full_name, u32 *val_sizep)
+{
+	struct boot_param_header *bph = dt_get_bph(dt_blob);
+	u32 *dp, tag, size;
+	char *s, *str_region;
+	static char path[256], prop[256];
+
+	path[0] = '\0';
+
+	if (bph->magic != OF_DT_HEADER) {
+		printf("dt_find_prop_by_name: bogus magic value: 0x%x\n",
+				bph->magic);
+		return NULL;
+	}
+
+	dp = (u32 *)((u32)dt_blob + bph->off_dt_struct);
+	str_region = (char *)((u32)dt_blob + bph->off_dt_strings);
+
+	while ((tag = *dp++) != OF_DT_END) {
+		switch (tag) {
+		case OF_DT_PROP:
+			size = *dp++;
+			s = str_region + *dp++;
+
+			strcpy(prop, path);
+			strcat(prop, s);
+			if (!strcmp(prop, full_name)) {
+				*val_sizep = size;
+				return dp; /* ptr to prop value */
+			}
+
+			dp = (u32 *)_ALIGN_UP((unsigned long)dp + size, 4);
+			break;
+		case OF_DT_BEGIN_NODE:
+			s = (char *)dp;
+			strcat(path, s);
+			strcat(path, "/");
+			dp = (u32 *)_ALIGN_UP((u32)dp + strlen(s) + 1, 4);
+			break;
+		case OF_DT_END_NODE:
+			path[strlen(path) - 1] = '\0';
+			s = strrchr(path, '/');
+			if (s != NULL)
+				s[1] = '\0';
+			break;
+		default:
+			printf("dt_find_prop_by_name: bugus tag: 0x%x\n", tag);
+		}
+	}
+	return NULL;
+}
diff --git a/arch/powerpc/boot/dts/sandpoint.dts b/arch/powerpc/boot/dts/sandpoint.dts
new file mode 100644
index 0000000..93ecf37
--- /dev/null
+++ b/arch/powerpc/boot/dts/sandpoint.dts
@@ -0,0 +1,204 @@
+/*
+ * Device Tree Souce for Freescale Sandpoint
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2006 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+
+XXXX add flash parts, rtc, ??
+
+build with: "dtc -I dts -O asm -o sandpoint.S -V 16 sandpoint.dts"
+
+
+ */
+
+/ {
+	linux,phandle = <1000>;
+	model = "Sandpoint";
+	compatible = "classic+mpc10x";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		linux,phandle = <2000>;
+		#cpus = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,603e { /* Really 75x, 74xx, 824x */
+			linux,phandle = <2100>;
+			linux,boot-cpu;
+			device_type = "cpu";
+			reg = <0>;
+			clock-frequency = <0>;	/* Fixed by bootwrapper */
+			timebase-frequency = <0>; /* Fixed by bootwrapper */
+			/* Following required by dtc but not used */
+			i-cache-line-size = <0>;
+			d-cache-line-size = <0>;
+			i-cache-size = <0>;
+			d-cache-size = <0>;
+		};
+	};
+
+	memory {
+		linux,phandle = <3000>;
+		device_type = "memory";
+		reg =	<00000000 00000000>;	/* Fixed by bootwrapper */
+	};
+
+	mpc10x { /* AFAICT need to make soc for 8245's uarts to be defined */
+		linux,phandle = <4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "mpc10x-bridge";
+		compatible = "mpc10x-bridge";
+		store-gathering = <0>; /* 0 == off, !0 == on */
+		reg = <fc000000 00100000>;
+		ranges = <80000000 80000000 70000000	/* pci mem space */
+			  fe000000 fe000000 00c00000	/* pci i/o space */
+			  fec00000 fec00000 00300000	/* pci cfg regs */
+			  fef00000 fec00000 00100000>;	/* pci iack */
+
+		dma@1100 {
+			linux,phandle = <4100>;
+			#interrupt-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			device_type = "dma";
+			compatible = "fsl-dma";
+			clock-frequency = <0>;
+			reg = <fc001100 00000024>;
+			interrupts = <33 0>;
+			interrupt-parent = <4400>;
+		};
+
+		dma@1200 {
+			linux,phandle = <4200>;
+			#interrupt-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			device_type = "dma";
+			compatible = "fsl-dma";
+			clock-frequency = <0>;
+			reg = <fc001200 00000024>;
+			interrupts = <34 0>;
+			interrupt-parent = <4400>;
+		};
+
+		i2c {
+			linux,phandle = <4300>;
+			#interrupt-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			clock-frequency = <0>;
+			reg = <fc003000 00001000>;
+			interrupts = <32 0>;
+			interrupt-parent = <4400>;
+		};
+
+		pic {
+			linux,phandle = <4400>;
+			clock-frequency = <0>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			device_type = "open-pic";
+			compatible = "chrp,open-pic";
+			reg = <fc040000 00040000>;
+		};
+
+		pci {
+			linux,phandle = <4500>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			device_type = "pci";
+			compatible = "mpc10x-pci";
+			reg = <fec00000 00400000>;
+			ranges = <01000000 0        0 fe000000 0 00c00000
+				  02000000 0 80000000 80000000 0 70000000>;
+			bus-range = <0 ff>;
+			clock-frequency = <7f28155>;
+			interrupt-parent = <4400>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x11 */
+				8800 0 0 1 4100 18 0
+				8800 0 0 2 4100 18 0
+				8800 0 0 3 4100 18 0
+				8800 0 0 4 4100 18 0
+				/* IDSEL 0x12 */
+				9000 0 0 1 4100 19 0
+				9000 0 0 2 4100 19 0
+				9000 0 0 3 4100 19 0
+				9000 0 0 4 4100 19 0
+				/* IDSEL 0x13 */
+				9800 0 0 1 4100 20 0
+				9800 0 0 2 4100 20 0
+				9800 0 0 3 4100 20 0
+				9800 0 0 4 4100 20 0
+				/* IDSEL 0x14 */
+				a000 0 0 1 4100 21 0
+				a000 0 0 2 4100 21 0
+				a000 0 0 3 4100 21 0
+				a000 0 0 4 4100 21 0
+				/* IDSEL 0x15 */
+				a800 0 0 1 4100 22 0
+				a800 0 0 2 4100 22 0
+				a800 0 0 3 4100 22 0
+				a800 0 0 4 4100 22 0
+				/* IDSEL 0x16 */
+				b000 0 0 1 4100 23 0
+				b000 0 0 2 4100 23 0
+				b000 0 0 3 4100 23 0
+				b000 0 0 4 4100 23 0
+			>;
+
+			isa {
+				linux,phandle = <4510>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				#interrupt-cells = <2>;
+				device_type = "isa";
+				compatible = "isa";
+				ranges = <0 0 01000000 0 0 00800000>;
+
+				serial@3f8 {
+					linux,phandle = <4511>;
+					device_type = "serial";
+					compatible = "ns16550";
+					reg = <0 3f8 8>;
+					clock-frequency = <1c2000>;
+					current-speed = <2580>;
+					interrupts = <4 0>;
+					interrupt-parent = <4400>;
+				};
+
+				serial@2f8 {
+					linux,phandle = <4512>;
+					device_type = "serial";
+					compatible = "ns16550";
+					reg = <0 2f8 8>;
+					clock-frequency = <1c2000>;
+					current-speed = <2580>;
+					interrupts = <3 0>;
+					interrupt-parent = <4400>;
+				};
+			};
+		};
+	};
+
+	chosen {
+		linux,phandle = <5000>;
+		linux,platform = <1>;
+		bootargs = "ip=on";
+		linux,stdout-path = "/mpc8245/pci/isa/serial@3f8";
+		interrupt-controller = <4100>;
+	};
+};
diff --git a/arch/powerpc/boot/io.h b/arch/powerpc/boot/io.h
new file mode 100644
index 0000000..65c1864
--- /dev/null
+++ b/arch/powerpc/boot/io.h
@@ -0,0 +1,160 @@
+#ifndef _IO_H
+#define __IO_H
+
+#include "types.h"
+
+/*
+ * 8, 16 and 32 bit, big and little endian I/O operations, with barrier.
+ * These routines do not perform EEH-related I/O address translation,
+ * and should not be used directly by device drivers.  Use inb/readb
+ * instead.
+ */
+static inline int in_8(const volatile unsigned char *addr)
+{
+	int ret;
+
+	__asm__ __volatile__("lbz%U1%X1 %0,%1; twi 0,%0,0; isync"
+			     : "=r" (ret) : "m" (*addr));
+	return ret;
+}
+
+static inline void out_8(volatile unsigned char *addr, int val)
+{
+	__asm__ __volatile__("stb%U0%X0 %1,%0; sync"
+			     : "=m" (*addr) : "r" (val));
+}
+
+static inline int in_le16(const volatile unsigned short *addr)
+{
+	int ret;
+
+	__asm__ __volatile__("lhbrx %0,0,%1; twi 0,%0,0; isync"
+			     : "=r" (ret) : "r" (addr), "m" (*addr));
+	return ret;
+}
+
+static inline int in_be16(const volatile unsigned short *addr)
+{
+	int ret;
+
+	__asm__ __volatile__("lhz%U1%X1 %0,%1; twi 0,%0,0; isync"
+			     : "=r" (ret) : "m" (*addr));
+	return ret;
+}
+
+static inline void out_le16(volatile unsigned short *addr, int val)
+{
+	__asm__ __volatile__("sthbrx %1,0,%2; sync"
+			     : "=m" (*addr) : "r" (val), "r" (addr));
+}
+
+static inline void out_be16(volatile unsigned short *addr, int val)
+{
+	__asm__ __volatile__("sth%U0%X0 %1,%0; sync"
+			     : "=m" (*addr) : "r" (val));
+}
+
+static inline unsigned in_le32(const volatile unsigned *addr)
+{
+	unsigned ret;
+
+	__asm__ __volatile__("lwbrx %0,0,%1; twi 0,%0,0; isync"
+			     : "=r" (ret) : "r" (addr), "m" (*addr));
+	return ret;
+}
+
+static inline unsigned in_be32(const volatile unsigned *addr)
+{
+	unsigned ret;
+
+	__asm__ __volatile__("lwz%U1%X1 %0,%1; twi 0,%0,0; isync"
+			     : "=r" (ret) : "m" (*addr));
+	return ret;
+}
+
+static inline void out_le32(volatile unsigned *addr, int val)
+{
+	__asm__ __volatile__("stwbrx %1,0,%2; sync" : "=m" (*addr)
+			     : "r" (val), "r" (addr));
+}
+
+static inline void out_be32(volatile unsigned *addr, int val)
+{
+	__asm__ __volatile__("stw%U0%X0 %1,%0; sync"
+			     : "=m" (*addr) : "r" (val));
+}
+
+static inline unsigned long in_le64(const volatile unsigned long *addr)
+{
+	unsigned long tmp, ret;
+
+	__asm__ __volatile__(
+			     "ld %1,0(%2)\n"
+			     "twi 0,%1,0\n"
+			     "isync\n"
+			     "rldimi %0,%1,5*8,1*8\n"
+			     "rldimi %0,%1,3*8,2*8\n"
+			     "rldimi %0,%1,1*8,3*8\n"
+			     "rldimi %0,%1,7*8,4*8\n"
+			     "rldicl %1,%1,32,0\n"
+			     "rlwimi %0,%1,8,8,31\n"
+			     "rlwimi %0,%1,24,16,23\n"
+			     : "=r" (ret) , "=r" (tmp) : "b" (addr) , "m" (*addr));
+	return ret;
+}
+
+static inline unsigned long in_be64(const volatile unsigned long *addr)
+{
+	unsigned long ret;
+
+	__asm__ __volatile__("ld%U1%X1 %0,%1; twi 0,%0,0; isync"
+			     : "=r" (ret) : "m" (*addr));
+	return ret;
+}
+
+static inline void out_le64(volatile unsigned long *addr, unsigned long val)
+{
+	unsigned long tmp;
+
+	__asm__ __volatile__(
+			     "rldimi %0,%1,5*8,1*8\n"
+			     "rldimi %0,%1,3*8,2*8\n"
+			     "rldimi %0,%1,1*8,3*8\n"
+			     "rldimi %0,%1,7*8,4*8\n"
+			     "rldicl %1,%1,32,0\n"
+			     "rlwimi %0,%1,8,8,31\n"
+			     "rlwimi %0,%1,24,16,23\n"
+			     "std %0,0(%3)\n"
+			     "sync"
+			     : "=&r" (tmp) , "=&r" (val) : "1" (val) , "b" (addr) , "m" (*addr));
+}
+
+static inline void out_be64(volatile unsigned long *addr, unsigned long val)
+{
+	__asm__ __volatile__("std%U0%X0 %1,%0; sync" : "=m" (*addr) : "r" (val));
+}
+
+#define	PCI_DEVFN(slot,func)	((((slot) & 0x1f) << 3) | ((func) & 0x07))
+
+/* Indirect PCI config space access routines */
+static inline void
+pci_indirect_read_config_byte(u32 *cfg_addr, u32 *cfg_data, int devfn,
+		int offset, u8 *val)
+{
+	out_be32(cfg_addr,
+		((offset & 0xfc) << 24) | (devfn << 16) | (0 << 8) | 0x80);
+	*val = in_8((u8 *)(cfg_data + (offset & 3)));
+	return;
+}
+
+static inline void
+pci_indirect_read_config_dword(u32 *cfg_addr, u32 *cfg_data, int devfn,
+		int offset, u32 *val)
+{
+	out_be32(cfg_addr,
+		((offset & 0xfc) << 24) | (devfn << 16) | (0 << 8) | 0x80);
+	*val = in_le32(cfg_data + (offset & 3));
+	return;
+}
+
+#endif /* _IO_H */
diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index 816446f..6acdf66 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -48,10 +48,19 @@ static char scratch[46912];	/* scratch s
 static char elfheader[256];
 
 
+#ifdef CONFIG_PPC_OF
 typedef void (*kernel_entry_t)( unsigned long,
                                 unsigned long,
                                 void *,
 				void *);
+#else
+void platform_fixups(void *dt_blob);
+extern void *dt_blob_start;
+extern void *dt_blob_end;
+void edit_cmdline(void *dt_blob_start);
+typedef void (*kernel_entry_t)(void *dtb_addr, void *kernel_entry_paddr,
+		void *must_be_null);
+#endif
 
 
 #undef DEBUG
@@ -218,7 +227,7 @@ void start(unsigned long a1, unsigned lo
 	if (getprop(chosen_handle, "stdout", &stdout, sizeof(stdout)) != 4)
 		exit();
 
-	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r", _start, sp);
+	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r", _start,sp);
 
 	/*
 	 * The first available claim_base must be above the end of the
@@ -238,7 +247,7 @@ void start(unsigned long a1, unsigned lo
 		gunzip(elfheader, sizeof(elfheader),
 				(unsigned char *)vmlinuz.addr, &len);
 	} else
-		memcpy(elfheader, (const void *)vmlinuz.addr, sizeof(elfheader));
+		memcpy(elfheader, (const void *)vmlinuz.addr,sizeof(elfheader));
 
 	if (!is_elf64(elfheader) && !is_elf32(elfheader)) {
 		printf("Error: not a valid PPC32 or PPC64 ELF file!\n\r");
@@ -263,18 +272,21 @@ void start(unsigned long a1, unsigned lo
 	initrd.size = (unsigned long)(_initrd_end - _initrd_start);
 	initrd.memsize = initrd.size;
 	if ( initrd.size > 0 ) {
-		printf("Allocating 0x%lx bytes for initrd ...\n\r", initrd.size);
+		printf("Allocating 0x%lx bytes for initrd ...\n\r",initrd.size);
 		initrd.addr = try_claim(initrd.size);
 		if (initrd.addr == 0) {
-			printf("Can't allocate memory for initial ramdisk !\n\r");
+			printf("Can't allocate memory for initial "
+					"ramdisk !\n\r");
 			exit();
 		}
 		a1 = initrd.addr;
 		a2 = initrd.size;
-		printf("initial ramdisk moving 0x%lx <- 0x%lx (0x%lx bytes)\n\r",
-		       initrd.addr, (unsigned long)_initrd_start, initrd.size);
-		memmove((void *)initrd.addr, (void *)_initrd_start, initrd.size);
-		printf("initrd head: 0x%lx\n\r", *((unsigned long *)initrd.addr));
+		printf("initial ramdisk moving 0x%lx <- 0x%lx "
+			"(0x%lx bytes)\n\r", initrd.addr,
+			(unsigned long)_initrd_start, initrd.size);
+		memmove((void *)initrd.addr, (void *)_initrd_start,initrd.size);
+		printf("initrd head: 0x%lx\n\r",
+				*((unsigned long *)initrd.addr));
 	}
 
 	/* Eventually gunzip the kernel */
@@ -299,6 +311,7 @@ #endif
 	flush_cache((void *)vmlinux.addr, vmlinux.size);
 
 	kernel_entry = (kernel_entry_t)vmlinux.addr;
+#ifdef CONFIG_PPC_OF
 #ifdef DEBUG
 	printf( "kernel:\n\r"
 		"        entry addr = 0x%lx\n\r"
@@ -311,9 +324,20 @@ #ifdef DEBUG
 #endif
 
 	kernel_entry(a1, a2, prom, NULL);
+#else /* !CONFIG_PPC_OF ==> flattened device tree */
+#ifdef DEBUG
+	printf("kernel:\n\r"
+		"        entry addr   = 0x%lx\n\r"
+		"        flattened dt = 0x%lx\n\r",
+		(unsigned long)kernel_entry, &dt_blob_start);
+#endif
+	edit_cmdline(&dt_blob_start);
+	platform_fixups(&dt_blob_start);
 
+	kernel_entry(&dt_blob_start, (void *)vmlinux.addr, NULL);
+#endif
+
 	printf("Error: Linux kernel returned to zImage bootloader!\n\r");
 
 	exit();
 }
-
diff --git a/arch/powerpc/boot/mpc10x.c b/arch/powerpc/boot/mpc10x.c
new file mode 100644
index 0000000..d9c0e0b
--- /dev/null
+++ b/arch/powerpc/boot/mpc10x.c
@@ -0,0 +1,88 @@
+/*
+ * Freescale mpc10[67] & mpc824[015] specific code.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2001 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "string.h"
+#include "stdio.h"
+#include "io.h"
+#include "prom.h"
+
+/* Map B (CHRP Map) Defines */
+#define	MPC10X_MAPB_CNFG_ADDR		0xfec00000
+#define	MPC10X_MAPB_CNFG_DATA		0xfee00000
+
+/* Define offsets for the memory controller registers in the config space */
+#define MPC10X_MCTLR_MEM_START_1	0x80	/* Banks 0-3 */
+#define MPC10X_MCTLR_MEM_START_2	0x84	/* Banks 4-7 */
+#define MPC10X_MCTLR_EXT_MEM_START_1	0x88	/* Banks 0-3 */
+#define MPC10X_MCTLR_EXT_MEM_START_2	0x8c	/* Banks 4-7 */
+
+#define MPC10X_MCTLR_MEM_END_1		0x90	/* Banks 0-3 */
+#define MPC10X_MCTLR_MEM_END_2		0x94	/* Banks 4-7 */
+#define MPC10X_MCTLR_EXT_MEM_END_1	0x98	/* Banks 0-3 */
+#define MPC10X_MCTLR_EXT_MEM_END_2	0x9c	/* Banks 4-7 */
+
+#define MPC10X_MCTLR_MEM_BANK_ENABLES	0xa0
+
+
+/*
+ * Read the memory controller registers to determine the amount of memory in
+ * the system.  This assumes that the firmware has correctly set up the memory
+ * controller registers.
+ * Assume memory map B (CHRP).
+ */
+u32
+mpc10x_get_mem_size(void)
+{
+	u32 *config_addr, *config_data, val;
+	u32 start, end, total, offset, i;
+	u8 bank_enables;
+
+	config_addr = (u32 *)MPC10X_MAPB_CNFG_ADDR;
+	config_data = (u32 *)MPC10X_MAPB_CNFG_DATA;
+
+	pci_indirect_read_config_byte(config_addr, config_data, PCI_DEVFN(0,0),
+			MPC10X_MCTLR_MEM_BANK_ENABLES, &bank_enables);
+
+	total = 0;
+
+	for (i=0; i<8; i++) {
+		if (bank_enables & (1 << i)) {
+			offset = MPC10X_MCTLR_MEM_START_1 + ((i > 3) ? 4 : 0);
+			pci_indirect_read_config_dword(config_addr, config_data,
+					PCI_DEVFN(0,0), offset, &val);
+			start = (val >> ((i & 3) << 3)) & 0xff;
+
+			offset = MPC10X_MCTLR_EXT_MEM_START_1 + ((i>3) ? 4 : 0);
+			pci_indirect_read_config_dword(config_addr, config_data,
+					PCI_DEVFN(0,0), offset, &val);
+			val = (val >> ((i & 3) << 3)) & 0x03;
+			start = (val << 28) | (start << 20);
+
+			offset = MPC10X_MCTLR_MEM_END_1 + ((i > 3) ? 4 : 0);
+			pci_indirect_read_config_dword(config_addr, config_data,
+					PCI_DEVFN(0,0), offset, &val);
+			end = (val >> ((i & 3) << 3)) & 0xff;
+
+			offset = MPC10X_MCTLR_EXT_MEM_END_1 + ((i > 3) ? 4 : 0);
+			pci_indirect_read_config_dword(config_addr, config_data,
+					PCI_DEVFN(0,0), offset, &val);
+			val = (val >> ((i & 3) << 3)) & 0x03;
+			end = (val << 28) | (end << 20) | 0xfffff;
+
+			total += (end - start + 1);
+		}
+	}
+
+	return total;
+}
diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c
new file mode 100644
index 0000000..f92073a
--- /dev/null
+++ b/arch/powerpc/boot/ns16550.c
@@ -0,0 +1,118 @@
+/*
+ * COM1 NS16550 support
+ */
+
+#include "io.h"
+#include "prom.h"
+
+#define UART_FCR	2	/* Out: FIFO Control Register */
+#define UART_LCR	3	/* Out: Line Control Register */
+#define UART_MCR	4	/* Out: Modem Control Register */
+#define UART_LSR	5	/* In:  Line Status Register */
+#define UART_LSR_THRE	0x20 /* Transmit-hold-register empty */
+#define UART_LSR_DR	0x01 /* Receiver data ready */
+#define UART_MSR	6	/* In:  Modem Status Register */
+#define UART_SCR	7	/* I/O: Scratch Register */
+#define UART_DLL	0	/* Out: Divisor Latch Low */
+#define UART_DLM	1	/* Out: Divisor Latch High */
+
+unsigned long	com_port;
+
+/*
+ * Serial defines.
+ */
+#define SERIAL_BAUD			9600
+
+#define SANDPOINT_SERIAL_0		0xfe0003f8
+#define SANDPOINT_SERIAL_1		0xfe0002f8
+
+#define RS_TABLE_SIZE  2
+
+/* Rate for the 1.8432 Mhz clock for the onboard serial chip */
+#define BASE_BAUD			( 1843200 / 16 )
+#define UART_CLK			1843200
+
+/* XXXX Get info from dt instead */
+static struct {
+	int baud_base;
+	unsigned long com_port;
+	u16 iomem_reg_shift;
+} rs_table[RS_TABLE_SIZE] = {
+        { BASE_BAUD, SANDPOINT_SERIAL_0, 0 },
+        { BASE_BAUD, SANDPOINT_SERIAL_1, 0 },
+};
+
+static int shift;
+
+unsigned long
+serial_init(int chan, void *ignored)
+{
+	unsigned long base_baud;
+	unsigned char lcr, dlm;
+
+	com_port = rs_table[chan].com_port;
+
+	/* How far apart the registers are. */
+	shift = rs_table[chan].iomem_reg_shift;
+	/* Base baud.. */
+	base_baud = rs_table[chan].baud_base;
+	
+	/* save the LCR */
+	lcr = in_8((const volatile unsigned char *)com_port
+			+ (UART_LCR << shift));
+	/* Access baud rate */
+	out_8((volatile unsigned char *)com_port + (UART_LCR << shift), 0x80);
+	dlm = in_8((const volatile unsigned char *)com_port
+			+ (UART_DLM << shift));
+	/*
+	 * Test if serial port is unconfigured.
+	 * We assume that no-one uses less than 110 baud or
+	 * less than 7 bits per character these days.
+	 *  -- paulus.
+	 */
+
+	if ((dlm <= 4) && (lcr & 2))
+		/* port is configured, put the old LCR back */
+		out_8((volatile unsigned char *)com_port
+				+ (UART_LCR << shift), lcr);
+	else {
+		/* Input clock. */
+		out_8((volatile unsigned char *)com_port + (UART_DLL << shift),
+			(base_baud / SERIAL_BAUD) & 0xFF);
+		out_8((volatile unsigned char *)com_port + (UART_DLM << shift),
+			(base_baud / SERIAL_BAUD) >> 8);
+		/* 8 data, 1 stop, no parity */
+		out_8((volatile unsigned char *)com_port + (UART_LCR << shift),
+			0x03);
+		/* RTS/DTR */
+		out_8((volatile unsigned char *)com_port + (UART_MCR << shift),
+			0x03);
+	}
+	/* Clear & enable FIFOs */
+	out_8((volatile unsigned char *)com_port + (UART_FCR << shift), 0x07);
+
+	return (com_port);
+}
+
+void
+serial_putc(unsigned long com_port, unsigned char c)
+{
+	while ((in_8((const volatile unsigned char *)com_port
+			+ (UART_LSR << shift)) & UART_LSR_THRE) == 0);
+	out_8((volatile unsigned char *)com_port, c);
+}
+
+unsigned char
+serial_getc(unsigned long com_port)
+{
+	while ((in_8((const volatile unsigned char *)com_port
+			+ (UART_LSR << shift)) & UART_LSR_DR) == 0);
+	return in_8((const volatile unsigned char *)com_port);
+}
+
+int
+serial_tstc(unsigned long com_port)
+{
+	return ((in_8((const volatile unsigned char *)com_port
+			+ (UART_LSR << shift)) & UART_LSR_DR) != 0);
+}
diff --git a/arch/powerpc/boot/prom.h b/arch/powerpc/boot/prom.h
index 3e2ddd4..28394f7 100644
--- a/arch/powerpc/boot/prom.h
+++ b/arch/powerpc/boot/prom.h
@@ -1,6 +1,58 @@
 #ifndef _PPC_BOOT_PROM_H_
 #define _PPC_BOOT_PROM_H_
 
+#include "types.h"
+
+/* #ifndef CONFIG_PPC_OF XXXX */
+
+/* Definitions used by the flattened device tree */
+#define OF_DT_HEADER		0xd00dfeed	/* marker */
+#define OF_DT_BEGIN_NODE	0x1		/* Start of node, full name */
+#define OF_DT_END_NODE		0x2		/* End node */
+#define OF_DT_PROP		0x3		/* Property: name off, size,
+						 * content */
+#define OF_DT_NOP		0x4		/* nop */
+#define OF_DT_END		0x9
+
+#define OF_DT_VERSION		0x10
+
+/*
+ * This is what gets passed to the kernel by prom_init or kexec
+ *
+ * The dt struct contains the device tree structure, full pathes and
+ * property contents. The dt strings contain a separate block with just
+ * the strings for the property names, and is fully page aligned and
+ * self contained in a page, so that it can be kept around by the kernel,
+ * each property name appears only once in this page (cheap compression)
+ *
+ * the mem_rsvmap contains a map of reserved ranges of physical memory,
+ * passing it here instead of in the device-tree itself greatly simplifies
+ * the job of everybody. It's just a list of u64 pairs (base/size) that
+ * ends when size is 0
+ */
+
+struct boot_param_header
+{
+	u32	magic;			/* magic word OF_DT_HEADER */
+	u32	totalsize;		/* total size of DT block */
+	u32	off_dt_struct;		/* offset to structure */
+	u32	off_dt_strings;		/* offset to strings */
+	u32	off_mem_rsvmap;		/* offset to memory reserve map */
+	u32	version;		/* format version */
+	u32	last_comp_version;	/* last compatible version */
+	/* version 2 fields below */
+	u32	boot_cpuid_phys;	/* Physical CPU id we're booting on */
+	/* version 3 fields below */
+	u32	dt_strings_size;	/* size of the DT strings block */
+};
+
+unsigned long serial_init(int chan, void *ignored);
+void serial_putc(unsigned long com_port, unsigned char c);
+unsigned char serial_getc(unsigned long com_port);
+int serial_tstc(unsigned long com_port);
+
+/* #endif XXXX */
+
 typedef void *phandle;
 typedef void *ihandle;
 
diff --git a/arch/powerpc/boot/prom_embedded.c b/arch/powerpc/boot/prom_embedded.c
new file mode 100644
index 0000000..96971df
--- /dev/null
+++ b/arch/powerpc/boot/prom_embedded.c
@@ -0,0 +1,112 @@
+/*
+ * prom.c routines for non-OF/embedded platforms.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2006 (c) MontaVista Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <stdarg.h>
+#include <stddef.h>
+#include "string.h"
+#include "stdio.h"
+#include "prom.h"
+
+int (*prom)(void *);
+phandle chosen_handle;
+ihandle stdout;
+
+int
+service_exit(int nargs, int nret, va_list args)
+{
+	printf("EXIT\n");
+	while (1);
+	/* NOTREACHED */
+}
+
+int
+service_finddevice(int nargs, int nret, va_list args)
+{
+	return 0; /* XXXX */
+}
+
+int
+service_getprop(int nargs, int nret, va_list args)
+{
+	return 4; /* XXXX */
+}
+
+int
+call_prom(const char *service, int nargs, int nret, ...)
+{
+
+	static struct {
+		char	*service;
+		int	((*rtn)(int nargs, int nret, va_list args));
+	} services[] = {
+		{ "exit", service_exit },
+		{ "finddevice", service_finddevice },
+		{ "getprop", service_getprop },
+		/* { "write", service_write }, */
+	};
+	va_list args;
+	int i, rc = 0;
+
+	for (i=0; i<ARRAY_SIZE(services); i++)
+		if (!strcmp(service, services[i].service)) {
+			va_start(args, nret);
+			rc = services[i].rtn(nargs, nret, args);
+			va_end(args);
+		}
+
+	return (nret > 0)? rc : 0;
+}
+
+void
+*claim(unsigned long virt, unsigned long size, unsigned long align)
+{
+	return (void *)virt;
+}
+
+int
+write(void *handle, void *ptr, int nb)
+{
+	char c, *s = (char *)ptr;
+	static char first_time = 1;
+	extern unsigned long com_port;
+
+	if (first_time) {
+		serial_init(0, NULL);
+		first_time = 0;
+	}
+
+	while ((c = *s++) != '\0') {
+	        serial_putc(com_port, c);
+		if (c == '\n')
+			serial_putc(com_port, '\r');
+	}
+
+	return nb;
+}
+
+void
+edit_cmdline(void *dt_blob)
+{
+	u32 i, *v;
+	extern void *dt_find_prop_by_name(void *dt_blob, char *full_name,
+			u32 *val_sizep);
+
+	if ((v = (u32 *)dt_find_prop_by_name(dt_blob,
+			"/chosen/bootargs", &i)) != NULL) {
+		printf("\nLinux/PPC load: %s", (char *)v);
+		/* edit cmdline & put back into dt (realloc may be necessary) */
+	}
+	printf("\n");
+}
+
+void __attribute__ ((weak))
+platform_fixups(void *dt_blob)
+{
+}
diff --git a/arch/powerpc/boot/sandpoint.c b/arch/powerpc/boot/sandpoint.c
new file mode 100644
index 0000000..283bb66
--- /dev/null
+++ b/arch/powerpc/boot/sandpoint.c
@@ -0,0 +1,110 @@
+/*
+ * Sandpoint specific fixups.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2006 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "string.h"
+#include "stdio.h"
+#include "io.h"
+#include "prom.h"
+
+static u32 cpu_824x[32] = {
+	5, 6, 9, 4, 4, 5, 2, 6, 6, 4, 9, 6, 5, 7, 6, 7,
+	4, 5, 4, 6, 7, 8, 8, 4, 6, 5, 8, 6, 6, 5, 7, 0
+};
+static u32 cpu_7xx[16] = { /* 750/755 */
+	0, 15, 14, 2, 4, 13, 20, 9, 6, 11, 8, 10, 16, 12, 7, 0
+};
+static u32 cpu_7457[32] = {
+	23, 34, 15, 30, 14, 36,  2, 40,  4, 42, 13, 26, 17, 48, 19, 18,
+	 6, 21, 11, 22,  8, 20, 10, 24, 16, 28, 12, 32, 27, 56,  0, 25
+};
+
+static struct processor_info {
+	u32	pvr;
+	u32	mask;
+	u32	bus_freq;
+	u32	hid1_shift;
+	u32	hid1_mask;
+	u32	*pll_tbl;
+	u32	max_mem;	/* 7457 flaky with > 64MB of mem */
+} processor_info_tbl[] = { /* From cputable -- MHz are only guesses */
+	/* 824x */
+	{ 0x00810000, 0x7fff0000, 100000000, 27, 0x1f, cpu_824x, 0x80000000 },
+	/* 750 */
+	{ 0x00084202, 0xffffffff, 100000000, 28, 0xf, cpu_7xx, 0x80000000 },
+	/* 745/755 */
+	{ 0x00083000, 0xfffff000, 100000000, 28, 0xf, cpu_7xx, 0x80000000 },
+	/* 7447/7457 Rev 1.0 */
+	{ 0x80020100, 0xffffffff, 100000000, 12, 0x1f, cpu_7457, 0x04000000 },
+	/* 7447/7457 Rev 1.1 */
+	{ 0x80020101, 0xffffffff, 100000000, 12, 0x1f, cpu_7457, 0x04000000 },
+	/* 7447/7457 Rev 1.2 & up*/
+	{ 0x80020000, 0xffff0000, 100000000, 12, 0x1f, cpu_7457, 0x04000000 },
+	/* 7447A */
+	{ 0x80030000, 0xffff0000, 100000000, 12, 0x1f, cpu_7457, 0x80000000 },
+};
+
+struct processor_info *
+get_processor_info(u32 pvr)
+{
+	struct processor_info *pit = processor_info_tbl;
+	u32 i;
+
+	for (i=0; i<ARRAY_SIZE(processor_info_tbl); i++, pit++)
+		if (pit->pvr == (pvr & pit->mask))
+			return pit;
+	return NULL;
+}
+
+#define	__stringify_1(x)	#x
+#define	__stringify(x)		__stringify_1(x)
+
+
+#define SPRN_PVR	0x11F	/* Processor Version Register */
+#define SPRN_HID1	0x3F1	/* Hardware Implementation Register 1 */
+#define mfspr(rn)	({unsigned long rval; \
+			asm volatile("mfspr %0," __stringify(rn) \
+				: "=r" (rval)); rval;})
+
+void
+platform_fixups(void *dt_blob)
+{
+	u32 i, *v, hid1, max_mem = 0xffffffff;
+	struct processor_info *pit;
+	extern void *dt_find_prop_by_name(void *dt_blob, char *full_name,
+			u32 *val_sizep);
+	extern u32 mpc10x_get_mem_size(void);
+
+	if ((pit = get_processor_info(mfspr(SPRN_PVR))) != NULL) {
+		if ((v = (u32 *)dt_find_prop_by_name(dt_blob,
+			"/cpus/PowerPC,603e/clock-frequency", &i)) != NULL) {
+
+			hid1 = (mfspr(SPRN_HID1) >> pit->hid1_shift)
+				& pit->hid1_mask;
+			v[0] = pit->bus_freq * pit->pll_tbl[hid1]/2;
+		}
+
+		if ((v = (u32 *)dt_find_prop_by_name(dt_blob,
+			"/cpus/PowerPC,603e/timebase-frequency", &i)) != NULL)
+			v[0] = pit->bus_freq / 4;
+
+		max_mem = pit->max_mem;
+	}
+
+	/* Get the RAM size from the memory controller */
+	if ((v = (u32 *)dt_find_prop_by_name(dt_blob, "/memory/reg", &i))
+			!= NULL) {
+		i = mpc10x_get_mem_size();
+		v[1] = min(i, max_mem);
+	}
+}
diff --git a/arch/powerpc/boot/types.h b/arch/powerpc/boot/types.h
new file mode 100644
index 0000000..7095b54
--- /dev/null
+++ b/arch/powerpc/boot/types.h
@@ -0,0 +1,28 @@
+#ifndef _TYPES_H_
+#define _TYPES_H_
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+/* XXXX
+#ifdef CONFIG_PPC32
+*/
+typedef unsigned char	u8;
+typedef unsigned short	u16;
+typedef unsigned int	u32;
+/*
+#endif
+*/
+
+#define min(x,y) ({ \
+	typeof(x) _x = (x);	\
+	typeof(y) _y = (y);	\
+	(void) (&_x == &_y);		\
+	_x < _y ? _x : _y; })
+
+#define max(x,y) ({ \
+	typeof(x) _x = (x);	\
+	typeof(y) _y = (y);	\
+	(void) (&_x == &_y);		\
+	_x > _y ? _x : _y; })
+
+#endif /* _TYPES_H_ */
diff --git a/arch/powerpc/configs/sandpoint_defconfig b/arch/powerpc/configs/sandpoint_defconfig
new file mode 100644
index 0000000..3345c8e
--- /dev/null
+++ b/arch/powerpc/configs/sandpoint_defconfig
@@ -0,0 +1,1017 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.17-rc3
+# Wed May 17 16:48:20 2006
+#
+# CONFIG_PPC64 is not set
+CONFIG_PPC32=y
+CONFIG_PPC_MERGE=y
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_PPC=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_PPC_OF=y
+CONFIG_PPC_UDBG_16550=y
+# CONFIG_GENERIC_TBSYNC is not set
+# CONFIG_DEFAULT_UIMAGE is not set
+
+#
+# Processor support
+#
+CONFIG_CLASSIC32=y
+# CONFIG_PPC_52xx is not set
+# CONFIG_PPC_82xx is not set
+# CONFIG_PPC_83xx is not set
+# CONFIG_PPC_85xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_8xx is not set
+# CONFIG_E200 is not set
+CONFIG_6xx=y
+CONFIG_PPC_FPU=y
+CONFIG_ALTIVEC=y
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_SMP is not set
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+# CONFIG_RELAY is not set
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_EMBEDDED=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SHMEM=y
+CONFIG_SLAB=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+# CONFIG_SLOB is not set
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Block layer
+#
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_DEFAULT_AS is not set
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
+
+#
+# Platform support
+#
+# CONFIG_PPC_MULTIPLATFORM is not set
+# CONFIG_PPC_ISERIES is not set
+CONFIG_EMBEDDED6xx=y
+# CONFIG_APUS is not set
+CONFIG_MPIC=y
+CONFIG_MPIC_SERIAL=y
+# CONFIG_PPC_RTAS is not set
+# CONFIG_MMIO_NVRAM is not set
+# CONFIG_PPC_MPC106 is not set
+# CONFIG_PPC_970_NAP is not set
+# CONFIG_CPU_FREQ is not set
+# CONFIG_TAU is not set
+# CONFIG_KATANA is not set
+# CONFIG_WILLOW is not set
+# CONFIG_CPCI690 is not set
+# CONFIG_POWERPMC250 is not set
+# CONFIG_CHESTNUT is not set
+# CONFIG_SPRUCE is not set
+# CONFIG_HDPU is not set
+# CONFIG_EV64260 is not set
+# CONFIG_LOPEC is not set
+# CONFIG_MVME5100 is not set
+# CONFIG_PPLUS is not set
+# CONFIG_PRPMC750 is not set
+# CONFIG_PRPMC800 is not set
+CONFIG_SANDPOINT=y
+# CONFIG_RADSTONE_PPC7D is not set
+# CONFIG_PAL4 is not set
+# CONFIG_GEMINI is not set
+# CONFIG_EST8260 is not set
+# CONFIG_SBC82xx is not set
+# CONFIG_SBS8260 is not set
+# CONFIG_RPX8260 is not set
+# CONFIG_TQM8260 is not set
+# CONFIG_ADS8272 is not set
+# CONFIG_PQ2FADS is not set
+# CONFIG_LITE5200 is not set
+# CONFIG_EV64360 is not set
+CONFIG_PPC_GEN550=y
+CONFIG_EPIC_SERIAL_MODE=y
+CONFIG_MPC10X_BRIDGE=y
+CONFIG_MPC10X_OPENPIC=y
+# CONFIG_MPC10X_STORE_GATHERING is not set
+# CONFIG_SANDPOINT_ENABLE_UART1 is not set
+# CONFIG_WANT_EARLY_SERIAL is not set
+
+#
+# Kernel options
+#
+# CONFIG_HIGHMEM is not set
+CONFIG_HZ_100=y
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=100
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_MISC=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_PM is not set
+# CONFIG_SOFTWARE_SUSPEND is not set
+# CONFIG_SECCOMP is not set
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_GENERIC_ISA_DMA=y
+CONFIG_PPC_I8259=y
+CONFIG_PPC_INDIRECT_PCI=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+# CONFIG_PCI_DEBUG is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+CONFIG_PCCARD=m
+# CONFIG_PCMCIA_DEBUG is not set
+CONFIG_PCMCIA=m
+CONFIG_PCMCIA_LOAD_CIS=y
+CONFIG_PCMCIA_IOCTL=y
+CONFIG_CARDBUS=y
+
+#
+# PC-card bridges
+#
+CONFIG_YENTA=m
+CONFIG_YENTA_O2=y
+CONFIG_YENTA_RICOH=y
+CONFIG_YENTA_TI=y
+CONFIG_YENTA_ENE_TUNE=y
+CONFIG_YENTA_TOSHIBA=y
+# CONFIG_PD6729 is not set
+# CONFIG_I82092 is not set
+CONFIG_PCCARD_NONSTATIC=m
+
+#
+# PCI Hotplug Support
+#
+# CONFIG_HOTPLUG_PCI is not set
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_HIGHMEM_START=0xfe000000
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_TASK_SIZE=0x80000000
+CONFIG_BOOT_LOAD=0x00800000
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+# CONFIG_NETDEBUG is not set
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
+# CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETFILTER is not set
+
+#
+# DCCP Configuration (EXPERIMENTAL)
+#
+CONFIG_IP_DCCP=m
+CONFIG_INET_DCCP_DIAG=m
+CONFIG_IP_DCCP_ACKVEC=y
+
+#
+# DCCP CCIDs Configuration (EXPERIMENTAL)
+#
+CONFIG_IP_DCCP_CCID2=m
+CONFIG_IP_DCCP_CCID3=m
+CONFIG_IP_DCCP_TFRC_LIB=m
+
+#
+# DCCP Kernel Hacking
+#
+# CONFIG_IP_DCCP_DEBUG is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+
+#
+# TIPC Configuration (EXPERIMENTAL)
+#
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_IEEE80211 is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+# CONFIG_STANDALONE is not set
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+# CONFIG_DEBUG_DRIVER is not set
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Macintosh device drivers
+#
+# CONFIG_WINDFARM is not set
+
+#
+# Network device support
+#
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
+# PHY device support
+#
+# CONFIG_PHYLIB is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+CONFIG_NET_TULIP=y
+# CONFIG_DE2104X is not set
+CONFIG_TULIP=y
+# CONFIG_TULIP_MWI is not set
+# CONFIG_TULIP_MMIO is not set
+# CONFIG_TULIP_NAPI is not set
+# CONFIG_DE4X5 is not set
+# CONFIG_WINBOND_840 is not set
+# CONFIG_DM9102 is not set
+# CONFIG_ULI526X is not set
+# CONFIG_PCMCIA_XIRCOM is not set
+# CONFIG_PCMCIA_XIRTULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_NET_PCI=y
+CONFIG_PCNET32=y
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+# CONFIG_DGRS is not set
+# CONFIG_EEPRO100 is not set
+CONFIG_E100=y
+# CONFIG_FEALNX is not set
+# CONFIG_NATSEMI is not set
+# CONFIG_NE2K_PCI is not set
+# CONFIG_8139CP is not set
+CONFIG_8139TOO=y
+CONFIG_8139TOO_PIO=y
+# CONFIG_8139TOO_TUNE_TWISTER is not set
+# CONFIG_8139TOO_8129 is not set
+# CONFIG_8139_OLD_RX_RESET is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+# CONFIG_VIA_RHINE is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_CHELSIO_T1 is not set
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# PCMCIA network device support
+#
+# CONFIG_NET_PCMCIA is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_PCI=y
+# CONFIG_SERIAL_8250_CS is not set
+CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+CONFIG_NVRAM=y
+CONFIG_GEN_RTC=y
+# CONFIG_GEN_RTC_X is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+
+#
+# PCMCIA character devices
+#
+# CONFIG_SYNCLINK_CS is not set
+# CONFIG_CARDMAN_4000 is not set
+# CONFIG_CARDMAN_4040 is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+# CONFIG_TELCLOCK is not set
+
+#
+# I2C support
+#
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+
+#
+# I2C Algorithms
+#
+CONFIG_I2C_ALGOBIT=y
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_I810 is not set
+# CONFIG_I2C_PIIX4 is not set
+CONFIG_I2C_MPC=y
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PROSAVAGE is not set
+# CONFIG_I2C_SAVAGE4 is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+# CONFIG_I2C_VOODOO3 is not set
+# CONFIG_I2C_PCA_ISA is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_SENSORS_DS1337 is not set
+# CONFIG_SENSORS_DS1374 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_M41T00 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+
+#
+# SPI support
+#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Hardware Monitoring support
+#
+# CONFIG_HWMON is not set
+# CONFIG_HWMON_VID is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
+# CONFIG_USB is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# LED devices
+#
+# CONFIG_NEW_LEDS is not set
+
+#
+# LED drivers
+#
+
+#
+# LED Triggers
+#
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
+# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
+#
+
+#
+# Real Time Clock
+#
+# CONFIG_RTC_CLASS is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+CONFIG_FS_POSIX_ACL=y
+# CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_INOTIFY is not set
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+# CONFIG_CONFIGFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_ACL_SUPPORT=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+CONFIG_RPCSEC_GSS_KRB5=y
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+# CONFIG_NLS_CODEPAGE_437 is not set
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+# CONFIG_NLS_ISO8859_1 is not set
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
+
+#
+# Library routines
+#
+CONFIG_CRC_CCITT=y
+CONFIG_CRC16=y
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+
+#
+# Instrumentation Support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+# CONFIG_MAGIC_SYSRQ is not set
+CONFIG_DEBUG_KERNEL=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_DEBUG_VM is not set
+CONFIG_FORCED_INLINING=y
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_DEBUGGER is not set
+CONFIG_BDI_SWITCH=y
+# CONFIG_BOOTX_TEXT is not set
+# CONFIG_SERIAL_TEXT_DEBUG is not set
+# CONFIG_PPC_EARLY_DEBUG_LPAR is not set
+# CONFIG_PPC_EARLY_DEBUG_G5 is not set
+# CONFIG_PPC_EARLY_DEBUG_RTAS is not set
+# CONFIG_PPC_EARLY_DEBUG_MAPLE is not set
+# CONFIG_PPC_EARLY_DEBUG_ISERIES is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+CONFIG_CRYPTO=y
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Hardware crypto devices
+#
diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 6e67b5b..2feca55 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -147,9 +147,11 @@ static int __init add_legacy_isa_port(st
 	if (reg == NULL)
 		return -1;
 
+#if 0 /* XXXX */
 	/* Verify it's an IO port, we don't support anything else */
 	if (!(reg[0] & 0x00000001))
 		return -1;
+#endif
 
 	/* Now look for an "ibm,aix-loc" property that gives us ordering
 	 * if any...
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index c4f6b0d..308fead 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_PPC_PSERIES)	+= pseries/
 obj-$(CONFIG_PPC_ISERIES)	+= iseries/
 obj-$(CONFIG_PPC_MAPLE)		+= maple/
 obj-$(CONFIG_PPC_CELL)		+= cell/
+obj-$(CONFIG_EMBEDDED6xx)	+= embedded6xx/
diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/powerpc/platforms/embedded6xx/Makefile
new file mode 100644
index 0000000..3324426
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/Makefile
@@ -0,0 +1,4 @@
+#
+# Makefile for the PowerPC Embedded Platforms
+#
+obj-$(CONFIG_SANDPOINT)		+= sandpoint.o
diff --git a/arch/powerpc/platforms/embedded6xx/sandpoint.c b/arch/powerpc/platforms/embedded6xx/sandpoint.c
new file mode 100644
index 0000000..9567de8
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/sandpoint.c
@@ -0,0 +1,629 @@
+/*
+ * Board setup routines for the Freescale Sandpoint Test Platform.
+ *
+ * Author: Mark A. Greer
+ *	 mgreer@mvista.com
+ *
+ * 2000-2003 (c) MontaVista Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+/*
+ * This file adds support for the Freescale Sandpoint Test Platform.
+ * These boards have a PPMC slot for the processor so any combination
+ * of cpu and host bridge can be attached.  This port is for an 8240 PPMC
+ * module from Freescale and other closely related cpu/host bridge
+ * combinations (e.g., 750/755/7400 with MPC107 host bridge).
+ * The sandpoint itself has a Windbond 83c553 (PCI-ISA bridge, 2 DMA ctlrs, 2
+ * cascaded 8259 interrupt ctlrs, 8254 Timer/Counter, and an IDE ctlr), a
+ * National 87308 (RTC, 2 UARTs, Keyboard & mouse ctlrs, and a floppy ctlr),
+ * and 4 PCI slots (only 2 of which are usable; the other 2 are keyed for 3.3V
+ * but are really 5V).
+ *
+ * The firmware on the sandpoint is called DINK (not my acronym :).  This port
+ * depends on DINK to do some basic initialization (e.g., initialize the memory
+ * ctlr) and to ensure that the processor is using MAP B (CHRP map).
+ *
+ * The switch settings for the Sandpoint board MUST be as follows:
+ * 	S3: down
+ * 	S4: up
+ * 	S5: up
+ * 	S6: down
+ *
+ * 'down' is in the direction from the PCI slots towards the PPMC slot;
+ * 'up' is in the direction from the PPMC slot towards the PCI slots.
+ * Be careful, the way the sandpoint board is installed in XT chasses will
+ * make the directions reversed.
+ *
+ * Since Freescale listened to our suggestions for improvement, we now have
+ * the Sandpoint X3 board.  All of the PCI slots are available, it uses
+ * the serial interrupt interface (just a hardware thing we need to
+ * configure properly).
+ *
+ * Use the default X3 switch settings.  The interrupts are then:
+ *		EPIC	Source
+ *		  0	SIOINT 		(8259, active low)
+ *		  1	PCI #1
+ *		  2	PCI #2
+ *		  3	PCI #3
+ *		  4	PCI #4
+ *		  7	Winbond INTC	(IDE interrupt)
+ *		  8	Winbond INTD	(IDE interrupt)
+ *
+ *
+ * Freescale has finally released a version of DINK32 that correctly
+ * (seemingly) initalizes the memory controller correctly, regardless
+ * of the amount of memory in the system.  Once a method of determining
+ * what version of DINK initializes the system for us, if applicable, is
+ * found, we can hopefully stop hardcoding 32MB of RAM.
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/major.h>
+#include <linux/initrd.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/ide.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/serial.h>
+#include <linux/tty.h>	/* for linux/serial_core.h */
+#include <linux/serial_core.h>
+#include <linux/serial_8250.h>
+
+#include <asm/system.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/time.h>
+#include <asm/dma.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/smp.h>
+#include <asm/vga.h>
+#include <asm/open_pic.h>
+#include <asm/i8259.h>
+#include <asm/todc.h>
+#include <asm/bootinfo.h>
+#include <asm/mpc10x.h>
+#include <asm/pci-bridge.h>
+/*
+#include <asm/kgdb.h>
+*/
+#include <asm/ppc_sys.h>
+#include <asm/mpic.h>
+
+static void sandpoint_halt(void);
+
+/*
+ * Define all of the IRQ senses and polarities.  Taken from the
+ * Sandpoint X3 User's manual.
+ */
+static u_char sandpoint_openpic_initsenses[] __initdata = {
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 0: SIOINT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 1: XXXX FILL?? */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 2: PCI Slot 1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 3: PCI Slot 2 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 4: PCI Slot 3 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 5: PCI Slot 4 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 6: XXXX FILL?? */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 7: XXXX FILL?? */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 8: IDE (INT C) */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 9: IDE (INT D) */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 10: */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 11: */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 12: */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 13: */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 14: */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 15: */
+};
+
+/*
+ * Interrupt setup and service.  Interrrupts on the Sandpoint come
+ * from the four PCI slots plus the 8259 in the Winbond Super I/O (SIO).
+ * The 8259 is cascaded from EPIC IRQ0, IRQ1-4 map to PCI slots 1-4,
+ * IDE is on EPIC 7 and 8.
+ */
+static void __init
+sandpoint_init_IRQ(void)
+{
+	struct mpic *mpic;
+	phys_addr_t openpic_paddr = 0xfc000000 + /* XXXX */
+		MPC10X_EUMB_EPIC_OFFSET;
+
+	/* This doesn't handle i2c, dma, i2o, or timer intrs right now XXXX */
+	mpic = mpic_alloc(openpic_paddr, MPIC_PRIMARY,
+			16 /* XXXX otherwise num_sources used */ ,
+			NUM_8259_INTERRUPTS,
+			0, /* was 16 */
+			NR_IRQS - 4 /* XXXX */,
+			sandpoint_openpic_initsenses,
+			sizeof(sandpoint_openpic_initsenses), " EPIC     ");
+
+	BUG_ON(mpic == NULL); /* XXXX */
+	mpic_assign_isu(mpic,  0, openpic_paddr + 0x10200);
+	mpic_init(mpic);
+	mpic_setup_cascade(NUM_8259_INTERRUPTS, i8259_irq_cascade, NULL);
+	i8259_init(0xfef00000, 0); /* pci iack addr */
+}
+
+/*
+ * Freescale Sandpoint interrupt routing.
+ */
+static inline int
+x3_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	static char pci_irq_table[][4] =
+	/*
+	 *	PCI IDSEL/INTPIN->INTLINE
+	 * 	   A   B   C   D
+	 */
+	{
+		{ 16,  0,  0,  0 },	/* IDSEL 11 - i8259 on Winbond */
+		{  0,  0,  0,  0 },	/* IDSEL 12 - unused */
+		{ 18, 21, 20, 19 },	/* IDSEL 13 - PCI slot 1 */
+		{ 19, 18, 21, 20 },	/* IDSEL 14 - PCI slot 2 */
+		{ 20, 19, 18, 21 },	/* IDSEL 15 - PCI slot 3 */
+		{ 21, 20, 19, 18 },	/* IDSEL 16 - PCI slot 4 */
+	};
+
+	const long min_idsel = 11, max_idsel = 16, irqs_per_slot = 4;
+	return PCI_IRQ_TABLE_LOOKUP;
+}
+
+static void __init
+sandpoint_setup_winbond_83553(struct pci_controller *hose)
+{
+	int		devfn;
+
+	/*
+	 * Route IDE interrupts directly to the 8259's IRQ 14 & 15.
+	 * We can't route the IDE interrupt to PCI INTC# or INTD# because those
+	 * woule interfere with the PMC's INTC# and INTD# lines.
+	 */
+	/*
+	 * Winbond Fcn 0
+	 */
+	devfn = PCI_DEVFN(11,0);
+
+	early_write_config_byte(hose,
+				0,
+				devfn,
+				0x43, /* IDE Interrupt Routing Control */
+				0xef);
+	early_write_config_word(hose,
+				0,
+				devfn,
+				0x44, /* PCI Interrupt Routing Control */
+				0x0000);
+
+	/* Want ISA memory cycles to be forwarded to PCI bus */
+	early_write_config_byte(hose,
+				0,
+				devfn,
+				0x48, /* ISA-to-PCI Addr Decoder Control */
+				0xf0);
+
+	/* Enable Port 92.  */
+	early_write_config_byte(hose,
+				0,
+				devfn,
+				0x4e,	/* AT System Control Register */
+				0x06);
+	/*
+	 * Winbond Fcn 1
+	 */
+	devfn = PCI_DEVFN(11,1);
+
+	/* Put IDE controller into native mode. */
+	early_write_config_byte(hose,
+				0,
+				devfn,
+				0x09,	/* Programming interface Register */
+				0x8f);
+
+	/* Init IRQ routing, enable both ports, disable fast 16 */
+	early_write_config_dword(hose,
+				0,
+				devfn,
+				0x40,	/* IDE Control/Status Register */
+				0x00ff0011);
+	return;
+}
+
+static int
+x3_exclude_device(u_char bus, u_char devfn)
+{
+	if ((bus == 0) && (PCI_SLOT(devfn) == 0))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	else
+		return PCIBIOS_SUCCESSFUL;
+}
+
+static int __init
+add_bridge(struct device_node *dev)
+{
+	int len;
+	struct pci_controller *hose;
+	int *bus_range;
+
+	printk("Adding PCI host bridge %s\n", dev->full_name);
+
+	bus_range = (int *) get_property(dev, "bus-range", &len);
+	if (bus_range == NULL || len < 2 * sizeof(int))
+		printk(KERN_WARNING "Can't get bus-range for %s, assume"
+				" bus 0\n", dev->full_name);
+
+	hose = pcibios_alloc_controller();
+	if (hose == NULL)
+		return -ENOMEM;
+	hose->first_busno = bus_range ? bus_range[0] : 0;
+	hose->last_busno = bus_range ? bus_range[1] : 0xff;
+	setup_indirect_pci(hose, 0xfec00000, 0xfee00000);
+
+	/* Interpret the "ranges" property */
+	/* This also maps the I/O region and sets isa_io/mem_base */
+	pci_process_bridge_OF_ranges(hose, dev, 1);
+
+	return 0;
+}
+
+u32 mag_dbg = 0;
+
+static void __init
+sandpoint_setup_arch(void)
+{
+	loops_per_jiffy = 100000000 / HZ;
+	isa_io_base = 0xfe000000;
+	isa_mem_base = 0x80000000;
+	pci_dram_offset = 0;
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (initrd_start)
+		ROOT_DEV = Root_RAM0;
+	else
+#endif
+#ifdef	CONFIG_ROOT_NFS
+		ROOT_DEV = Root_NFS;
+#else
+		ROOT_DEV = Root_HDA1;
+#endif
+
+
+#if 1 /* XXXX NEW */
+	{
+		struct device_node *np;
+
+		mag_dbg = 1;
+		for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+			add_bridge(np);
+		mag_dbg = 0;
+
+		ppc_md.pci_swizzle = common_swizzle;
+		ppc_md.pci_map_irq = x3_map_irq;
+		ppc_md.pci_exclude_device = x3_exclude_device; /* XXXX */
+	}
+#endif
+
+#if 0 /* XXXX */
+	if (strncmp (cur_ppc_sys_spec->ppc_sys_name, "8245", 4) == 0)
+	{
+		bd_t *bp = (bd_t *)__res;
+		struct plat_serial8250_port *pdata;
+
+		pdata = (struct plat_serial8250_port *) ppc_sys_get_pdata(MPC10X_UART0);
+		if (pdata)
+		{
+			pdata[0].uartclk = bp->bi_busfreq;
+		}
+
+#ifdef CONFIG_SANDPOINT_ENABLE_UART1
+		pdata = (struct plat_serial8250_port *) ppc_sys_get_pdata(MPC10X_UART1);
+		if (pdata)
+		{
+			pdata[0].uartclk = bp->bi_busfreq;
+		}
+#else
+		ppc_sys_device_remove(MPC10X_UART1);
+#endif
+	}
+#endif
+
+	printk(KERN_INFO "Freescale Sandpoint Test Platform\n");
+	printk(KERN_INFO "Port by MontaVista Software, Inc. (source@mvista.com)\n");
+
+	/* DINK32 12.3 and below do not correctly enable any caches.
+	 * We will do this now with good known values.  Future versions
+	 * of DINK32 are supposed to get this correct.
+	 */
+	if (cpu_has_feature(CPU_FTR_SPEC7450))
+		/* 745x is different.  We only want to pass along enable. */
+		_set_L2CR(L2CR_L2E);
+	else if (cpu_has_feature(CPU_FTR_L2CR))
+		/* All modules have 1MB of L2.  We also assume that an
+		 * L2 divisor of 3 will work.
+		 */
+		_set_L2CR(L2CR_L2E | L2CR_L2SIZ_1MB | L2CR_L2CLK_DIV3
+				| L2CR_L2RAM_PIPE | L2CR_L2OH_1_0 | L2CR_L2DF);
+#if 0
+	/* Untested right now. */
+	if (cpu_has_feature(CPU_FTR_L3CR)) {
+		/* Magic value. */
+		_set_L3CR(0x8f032000);
+	}
+#endif
+}
+
+#if 1 /* XXXX */
+#define	SANDPOINT_87308_CFG_ADDR		0x15c
+#define	SANDPOINT_87308_CFG_DATA		0x15d
+
+#define	SANDPOINT_87308_CFG_INB(addr, byte) {				\
+	outb((addr), SANDPOINT_87308_CFG_ADDR);				\
+	(byte) = inb(SANDPOINT_87308_CFG_DATA);				\
+}
+
+#define	SANDPOINT_87308_CFG_OUTB(addr, byte) {				\
+	outb((addr), SANDPOINT_87308_CFG_ADDR);				\
+	outb((byte), SANDPOINT_87308_CFG_DATA);				\
+}
+
+#define SANDPOINT_87308_SELECT_DEV(dev_num) {				\
+	SANDPOINT_87308_CFG_OUTB(0x07, (dev_num));			\
+}
+
+#define	SANDPOINT_87308_DEV_ENABLE(dev_num) {				\
+	SANDPOINT_87308_SELECT_DEV(dev_num);				\
+	SANDPOINT_87308_CFG_OUTB(0x30, 0x01);				\
+}
+
+/*
+ * Fix IDE interrupts.
+ */
+static int __init
+sandpoint_fix_winbond_83553(void)
+{
+	/* Make some 8259 interrupt level sensitive */
+	outb(0xe0, 0x4d0);
+	outb(0xde, 0x4d1);
+
+	return 0;
+}
+
+arch_initcall(sandpoint_fix_winbond_83553);
+
+/*
+ * Initialize the ISA devices on the Nat'l PC87308VUL SuperIO chip.
+ */
+static int __init
+sandpoint_setup_natl_87308(void)
+{
+	u_char	reg;
+
+	/*
+	 * Enable all the devices on the Super I/O chip.
+	 */
+	SANDPOINT_87308_SELECT_DEV(0x00); /* Select kbd logical device */
+	SANDPOINT_87308_CFG_OUTB(0xf0, 0x00); /* Set KBC clock to 8 Mhz */
+	SANDPOINT_87308_DEV_ENABLE(0x00); /* Enable keyboard */
+	SANDPOINT_87308_DEV_ENABLE(0x01); /* Enable mouse */
+	SANDPOINT_87308_DEV_ENABLE(0x02); /* Enable rtc */
+	SANDPOINT_87308_DEV_ENABLE(0x03); /* Enable fdc (floppy) */
+	SANDPOINT_87308_DEV_ENABLE(0x04); /* Enable parallel */
+	SANDPOINT_87308_DEV_ENABLE(0x05); /* Enable UART 2 */
+	SANDPOINT_87308_CFG_OUTB(0xf0, 0x82); /* Enable bank select regs */
+	SANDPOINT_87308_DEV_ENABLE(0x06); /* Enable UART 1 */
+	SANDPOINT_87308_CFG_OUTB(0xf0, 0x82); /* Enable bank select regs */
+
+	/* Set up floppy in PS/2 mode */
+	outb(0x09, SIO_CONFIG_RA);
+	reg = inb(SIO_CONFIG_RD);
+	reg = (reg & 0x3F) | 0x40;
+	outb(reg, SIO_CONFIG_RD);
+	outb(reg, SIO_CONFIG_RD);	/* Have to write twice to change! */
+
+	return 0;
+}
+
+arch_initcall(sandpoint_setup_natl_87308);
+
+static int __init
+sandpoint_request_io(void)
+{
+	request_region(0x00,0x20,"dma1");
+	request_region(0x20,0x20,"pic1");
+	request_region(0x40,0x20,"timer");
+	request_region(0x80,0x10,"dma page reg");
+	request_region(0xa0,0x20,"pic2");
+	request_region(0xc0,0x20,"dma2");
+
+	return 0;
+}
+
+arch_initcall(sandpoint_request_io);
+#endif
+
+static void __init
+sandpoint_map_io(void)
+{
+	io_block_mapping(0xfe000000, 0xfe000000, 0x02000000, _PAGE_IO);
+}
+
+static void
+sandpoint_restart(char *cmd)
+{
+	local_irq_disable();
+
+	/* Set exception prefix high - to the firmware */
+	_nmask_and_or_msr(0, MSR_IP);
+
+	/* Reset system via Port 92 */
+	outb(0x00, 0x92);
+	outb(0x01, 0x92);
+
+	for(;;);	/* Spin until reset happens */
+}
+
+static void
+sandpoint_power_off(void)
+{
+	local_irq_disable();
+	for(;;);	/* No way to shut power off with software */
+	/* NOTREACHED */
+}
+
+static void
+sandpoint_halt(void)
+{
+	sandpoint_power_off();
+	/* NOTREACHED */
+}
+
+static void
+sandpoint_show_cpuinfo(struct seq_file *m)
+{
+	seq_printf(m, "vendor\t\t: Freescale\n");
+	seq_printf(m, "machine\t\t: Sandpoint\n");
+}
+
+#if 0 /* XXXX */
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
+/*
+ * IDE support.
+ */
+static int		sandpoint_ide_ports_known = 0;
+static unsigned long	sandpoint_ide_regbase[MAX_HWIFS];
+static unsigned long	sandpoint_ide_ctl_regbase[MAX_HWIFS];
+static unsigned long	sandpoint_idedma_regbase;
+
+static void
+sandpoint_ide_probe(void)
+{
+	struct pci_dev *pdev = pci_get_device(PCI_VENDOR_ID_WINBOND,
+			PCI_DEVICE_ID_WINBOND_82C105, NULL);
+
+	if (pdev) {
+		sandpoint_ide_regbase[0]=pdev->resource[0].start;
+		sandpoint_ide_regbase[1]=pdev->resource[2].start;
+		sandpoint_ide_ctl_regbase[0]=pdev->resource[1].start;
+		sandpoint_ide_ctl_regbase[1]=pdev->resource[3].start;
+		sandpoint_idedma_regbase=pdev->resource[4].start;
+		pci_dev_put(pdev);
+	}
+
+	sandpoint_ide_ports_known = 1;
+}
+
+static int
+sandpoint_ide_default_irq(unsigned long base)
+{
+	if (sandpoint_ide_ports_known == 0)
+		sandpoint_ide_probe();
+
+	if (base == sandpoint_ide_regbase[0])
+		return SANDPOINT_IDE_INT0;
+	else if (base == sandpoint_ide_regbase[1])
+		return SANDPOINT_IDE_INT1;
+	else
+		return 0;
+}
+
+static unsigned long
+sandpoint_ide_default_io_base(int index)
+{
+	if (sandpoint_ide_ports_known == 0)
+		sandpoint_ide_probe();
+
+	return sandpoint_ide_regbase[index];
+}
+
+static void __init
+sandpoint_ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
+		unsigned long ctrl_port, int *irq)
+{
+	unsigned long reg = data_port;
+	uint	alt_status_base;
+	int	i;
+
+	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
+		hw->io_ports[i] = reg++;
+	}
+
+	if (data_port == sandpoint_ide_regbase[0]) {
+		alt_status_base = sandpoint_ide_ctl_regbase[0] + 2;
+		hw->irq = 14;
+	}
+	else if (data_port == sandpoint_ide_regbase[1]) {
+		alt_status_base = sandpoint_ide_ctl_regbase[1] + 2;
+		hw->irq = 15;
+	}
+	else {
+		alt_status_base = 0;
+		hw->irq = 0;
+	}
+
+	if (ctrl_port) {
+		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
+	} else {
+		hw->io_ports[IDE_CONTROL_OFFSET] = alt_status_base;
+	}
+
+	if (irq != NULL) {
+		*irq = hw->irq;
+	}
+}
+#endif
+#endif
+
+/*
+ * Set BAT 3 to map 0xf8000000 to end of physical memory space 1-to-1.
+ */
+static __inline__ void
+sandpoint_set_bat(void)
+{
+	unsigned long bat3u, bat3l;
+
+	__asm__ __volatile__(
+			" lis %0,0xf800\n	\
+			ori %1,%0,0x002a\n	\
+			ori %0,%0,0x0ffe\n	\
+			mtspr 0x21e,%0\n	\
+			mtspr 0x21f,%1\n	\
+			isync\n			\
+			sync "
+			: "=r" (bat3u), "=r" (bat3l));
+}
+
+TODC_ALLOC();
+
+static int __init
+sandpoint_probe(void)
+{
+	return 1;
+}
+
+define_machine(sandpoint) {
+	.name			= "Sandpoint",
+	.probe			= sandpoint_probe,
+	.setup_arch		= sandpoint_setup_arch,
+	.setup_io_mappings	= sandpoint_map_io,
+	.init_IRQ		= sandpoint_init_IRQ,
+	.show_cpuinfo		= sandpoint_show_cpuinfo,
+	.get_irq		= mpic_get_irq,
+	.restart		= sandpoint_restart,
+	.power_off		= sandpoint_power_off,
+	.halt			= sandpoint_halt,
+	.calibrate_decr		= generic_calibrate_decr,
+	/*
+	.progress		= udbg_progress,
+	*/
+};
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 7dcdfcb..1badbec 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -629,6 +629,13 @@ #endif /* CONFIG_SMP */
 			mb();
 	}
 
+#ifdef CONFIG_MPIC_SERIAL
+	/* For serial interrupts & set clock ratio */
+	mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1,
+		mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1)
+			| (1<<27) | (0x7<<28));
+#endif
+
 	/* Read feature register, calculate num CPUs and, for non-ISU
 	 * MPICs, num sources as well. On ISU MPICs, sources are counted
 	 * as ISUs are added
