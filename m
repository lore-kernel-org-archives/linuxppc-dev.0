Return-Path: <mgreer@mvista.com>
Date: Tue, 13 Jun 2006 20:37:55 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [HACK] add sandpoint + flattened dt support to arch/powerpc/boot
Message-ID: <20060614033755.GA15224@mag.az.mvista.com>
References: <20060518002142.GA23182@mag.az.mvista.com>
	<1147930376.17679.72.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1147930376.17679.72.camel@localhost.localdomain>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

[The patch below is not a patch submission, its just for comment.]

I reorged the boot stuff a bit to try to make it easier for all the different
worlds to live together.  Basically, there are 4 types of operations,
platform (platform_ops), firmware (fw_ops), device tree (dt_ops), and
console (console_ops).  ops.h defines them all.

I'm sure some ops may need to move and some may need to be added as more
platforms are added into boot dir but its a start.  I also incorporated
Michal Ostrowski's patch that puts the zImage cmdline in a separate section
(although I changed the name to zimage_cmdline to make it clear where
the cmdline came from).  I also changed 'prom.c' to 'of.c' because it
seemed more accurate.

For the sandpoint, I used sandpoint_platform_ops, dink_fw_ops,
fdt_dt_ops (flat dev tree), and ns16550_console_ops (which uses some
more generic serial ops).  The maple only uses the various of_*_ops
which are all in of.c.

Some of the fdt.c code can probably be merged with code that's in
kernel/prom.c or prom_parse.c but I'm not going to worry about that
for now.

The latest powerpc.git tree doesn't seem to build for me (32 bit) so
I haven't tested in that tree but in an older tree, I can build & boot
sandpoint and maple zImages.

I know there was a whole lot more I wanted to say but I'm tired and I
can't think right now.

Anyway, I would appreciate it you and others who care would take a
look and comment.  I would like to get the sandpoint into the powerpc
tree sometime soon so I hope its not too far off.

Thanks,

Mark
--

 arch/powerpc/boot/prom.c              |  165 ----------
 arch/powerpc/boot/prom.h              |   34 --
 b/arch/powerpc/boot/Makefile          |    9 
 b/arch/powerpc/boot/dink.c            |   57 +++
 b/arch/powerpc/boot/dts/sandpoint.dts |  206 +++++++++++++
 b/arch/powerpc/boot/fdt.c             |  525 ++++++++++++++++++++++++++++++++++
 b/arch/powerpc/boot/io.h              |  160 ++++++++++
 b/arch/powerpc/boot/main.c            |  177 +++++------
 b/arch/powerpc/boot/mpc10x.c          |   87 +++++
 b/arch/powerpc/boot/ns16550.c         |  125 ++++++++
 b/arch/powerpc/boot/of.c              |  301 +++++++++++++++++++
 b/arch/powerpc/boot/ops.h             |  117 +++++++
 b/arch/powerpc/boot/sandpoint.c       |  148 +++++++++
 b/arch/powerpc/boot/serial.c          |   90 +++++
 b/arch/powerpc/boot/stdio.c           |    4 
 b/arch/powerpc/boot/types.h           |   29 +
 b/arch/powerpc/boot/util.S            |  101 ++++++
 17 files changed, 2041 insertions(+), 294 deletions(-)

--

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 840ae59..1e67d96 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -36,8 +36,15 @@ zliblinuxheader := zlib.h zconf.h zutil.
 $(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheader))
 #$(addprefix $(obj)/,main.o): $(addprefix $(obj)/,zlib.h)
 
-src-boot := crt0.S string.S prom.c stdio.c main.c div64.S
+src-boot := crt0.S string.S stdio.c main.c div64.S
 src-boot += $(zlib)
+ifneq ($(CONFIG_EMBEDDED6xx),y)
+src-boot += of.c
+endif
+ifeq ($(CONFIG_SANDPOINT),y)
+src-boot += sandpoint.c mpc10x.c dink.c fdt.c serial.c ns16550.c \
+		util.S dts/sandpoint.S
+endif
 src-boot := $(addprefix $(obj)/, $(src-boot))
 obj-boot := $(addsuffix .o, $(basename $(src-boot)))
 
diff --git a/arch/powerpc/boot/dink.c b/arch/powerpc/boot/dink.c
new file mode 100644
index 0000000..b01efbc
--- /dev/null
+++ b/arch/powerpc/boot/dink.c
@@ -0,0 +1,57 @@
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
+#include "page.h"
+#include "io.h"
+#include "ops.h"
+
+#define	MB	(1024*1024)
+
+extern char _end[];
+
+static u32	cur_base;
+static u32	end_of_ram = 32 * MB; /* XXXX get from /memory */
+
+static void *
+dink_malloc(u32 size)
+{
+	void *area = NULL;
+	static u8 first_time = 1;
+
+	if (first_time) {
+		cur_base = _ALIGN_UP((unsigned long)_end, MB);
+		first_time = 0;
+	}
+
+	if ((cur_base + size) < end_of_ram) {
+		area = (void *)cur_base;
+		cur_base += _ALIGN_UP(size, MB);
+	}
+
+	return area;
+}
+
+static struct fw_ops dink_fw_ops;
+
+struct fw_ops *
+dink_init(void)
+{
+	dink_fw_ops.malloc = dink_malloc;
+	dink_fw_ops.free = NULL;
+	dink_fw_ops.exit = NULL;
+
+	return &dink_fw_ops;
+}
diff --git a/arch/powerpc/boot/dts/sandpoint.dts b/arch/powerpc/boot/dts/sandpoint.dts
new file mode 100644
index 0000000..dfd3f7d
--- /dev/null
+++ b/arch/powerpc/boot/dts/sandpoint.dts
@@ -0,0 +1,206 @@
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
+			  fc000000 fc000000 00100000	/* EUMB */
+			  fe000000 fe000000 00c00000	/* pci i/o space */
+			  fec00000 fec00000 00300000	/* pci cfg regs */
+			  fef00000 fef00000 00100000>;	/* pci iack */
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
+			interrupt-pci-iack = <fef00000>; /* New - PCI IACK */
+			interrupt-parent = <4400>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x11 */
+				8800 0 0 1 4400 16 0
+				8800 0 0 2 4400  0 0
+				8800 0 0 3 4400  0 0
+				8800 0 0 4 4400  0 0
+				/* IDSEL 0x12 */
+				9000 0 0 1 4400  0 0
+				9000 0 0 2 4400  0 0
+				9000 0 0 3 4400  0 0
+				9000 0 0 4 4400  0 0
+				/* IDSEL 0x13 */
+				9800 0 0 1 4400 18 0
+				9800 0 0 2 4400 19 0
+				9800 0 0 3 4400 20 0
+				9800 0 0 4 4400 21 0
+				/* IDSEL 0x14 */
+				a000 0 0 1 4400 19 0
+				a000 0 0 2 4400 18 0
+				a000 0 0 3 4400 21 0
+				a000 0 0 4 4400 20 0
+				/* IDSEL 0x15 */
+				a800 0 0 1 4400 20 0
+				a800 0 0 2 4400 19 0
+				a800 0 0 3 4400 18 0
+				a800 0 0 4 4400 21 0
+				/* IDSEL 0x16 */
+				b000 0 0 1 4400 21 0
+				b000 0 0 2 4400 20 0
+				b000 0 0 3 4400 19 0
+				b000 0 0 4 4400 18 0
+			>;
+
+			isa {
+				linux,phandle = <4510>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				#interrupt-cells = <2>;
+				device_type = "isa";
+				compatible = "isa";
+				ranges = <1 0 01000000 0 0 00800000>;
+
+				serial@3f8 {
+					linux,phandle = <4511>;
+					device_type = "serial";
+					compatible = "ns16550";
+					reg = <1 3f8 8>;
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
+					reg = <1 2f8 8>;
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
+		linux,stdout-path = "/mpc10x/pci/isa/serial@3f8";
+		interrupt-controller = <4400>;
+	};
+};
diff --git a/arch/powerpc/boot/fdt.c b/arch/powerpc/boot/fdt.c
new file mode 100644
index 0000000..f8ad8e6
--- /dev/null
+++ b/arch/powerpc/boot/fdt.c
@@ -0,0 +1,525 @@
+/*
+ * Simple dtb (binary flattened device tree) search/manipulation routines.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ * 	- The code for strrchr() was copied from lib/string.c and is
+ * 	copyrighted by Linus Torvalds.
+ * 	- The smarts for fdt_finddevice() were copied with the author's
+ * 	permission from u-boot:common/ft_build.c which was written by
+ * 	Pantelis Antoniou <pantelis@embeddedalley.com>.
+ * 	- Many of the routines related to fdt_translate_addr() came
+ * 	from arch/powerpc/kernel/prom_parse.c which has no author or
+ * 	copyright notice.
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
+#include <stddef.h>
+#include "types.h"
+#include "page.h"
+#include "string.h"
+#include "stdio.h"
+#include "ops.h"
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
+extern void *dt_blob_start;
+extern void *dt_blob_end;
+
+static void *dtb_start;
+static void *dtb_end;
+
+#define MAX_ADDR_CELLS	4
+#define BAD_ADDR	((u64)-1)
+
+struct fdt_bus {
+	u64	(*map)(u32 *addr, u32 *range, int na, int ns, int pna);
+	int	(*translate)(u32 *addr, u64 offset, int na);
+};
+
+static inline struct boot_param_header *
+fdt_get_bph(void *dt_blob)
+{
+	return (struct boot_param_header *)dt_blob;
+}
+
+static char *
+fdt_strrchr(const char *s, int c)
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
+/* 'path' is modified */
+static void
+fdt_parentize(char *path, u8 leave_slash)
+{
+	char *s = &path[strlen(path) - 1];
+
+	if (*s == '/')
+		*s = '\0';
+	s = fdt_strrchr(path, '/');
+	if (s != NULL) {
+		if (leave_slash)
+			s[1] = '\0';
+		else if (s[0] == '/')
+			s[0] = '\0';
+	}
+}
+
+static inline u32 *
+fdt_next(u32 *dp, u32 **tagpp, char **namepp, char **datapp, u32 **sizepp)
+{
+	static char *str_region;
+
+	*namepp = NULL;
+	*datapp = NULL;
+	*sizepp = NULL;
+
+	if (dp == NULL) { /* first time */
+		struct boot_param_header *bph = fdt_get_bph(dtb_start);
+
+		if (bph->magic != OF_DT_HEADER) {
+			*tagpp = NULL;
+			return NULL;
+		}
+		dp = (u32 *)((u32)dtb_start + bph->off_dt_struct);
+		str_region = (char *)((u32)dtb_start + bph->off_dt_strings);
+	}
+
+	*tagpp = dp;
+
+	switch (*dp++) { /* Tag */
+	case OF_DT_PROP:
+		*sizepp = dp++;
+		*namepp = str_region + *dp++;
+		*datapp = (char *)dp;
+		dp = (u32 *)_ALIGN_UP((unsigned long)dp + **sizepp, 4);
+		break;
+	case OF_DT_BEGIN_NODE:
+		*namepp = (char *)dp;
+		dp = (u32 *)_ALIGN_UP((u32)dp + strlen((char *)dp) + 1, 4);
+		break;
+	case OF_DT_END_NODE:
+	case OF_DT_NOP:
+		break;
+	case OF_DT_END:
+	default:
+		dp = NULL;
+		break;
+	}
+
+	return dp;
+}
+
+static void *
+fdt_finddevice(const char *name)
+{
+	u32 *dp, *tagp, *sizep;
+	char *namep, *datap;
+	static char path[MAX_PATH_LEN];
+
+	path[0] = '\0';
+	dp = NULL;
+
+	while ((dp = fdt_next(dp, &tagp, &namep, &datap, &sizep)) != NULL)
+		switch (*tagp) {
+		case OF_DT_BEGIN_NODE:
+			strcat(path, namep);
+			if (!strcmp(path, name))
+				return tagp;
+			strcat(path, "/");
+			break;
+		case OF_DT_END_NODE:
+			fdt_parentize(path, 1);
+			break;
+		}
+	return NULL;
+}
+
+static int
+fdt_getprop(void *node, const char *name, void *buf, int buflen)
+{
+	u32 *dp, *tagp, *sizep, size;
+	char *namep, *datap;
+	int level;
+
+	level = 0;
+	dp = node;
+
+	while ((dp = fdt_next(dp, &tagp, &namep, &datap, &sizep)) != NULL)
+		switch (*tagp) {
+		case OF_DT_PROP:
+			if ((level == 1) && !strcmp(namep, name)) {
+				size = min(*sizep, (u32)buflen);
+				memcpy(buf, datap, size);
+				return size;
+			}
+			break;
+		case OF_DT_BEGIN_NODE:
+			level++;
+			break;
+		case OF_DT_END_NODE:
+			if (--level <= 0)
+				return -1;
+			break;
+		}
+	return -1;
+}
+
+static void
+fdt_modify_prop(u32 *dp, char *datap, u32 *old_prop_sizep, char *buf,
+		int buflen)
+{
+	u32 old_prop_data_len, new_prop_data_len;
+
+	old_prop_data_len = _ALIGN_UP(*old_prop_sizep, 4);
+	new_prop_data_len = _ALIGN_UP(buflen, 4);
+
+	/* Check if new prop data fits in old prop data area */
+	if (new_prop_data_len == old_prop_data_len) {
+		memcpy(datap, buf, buflen);
+		*old_prop_sizep = buflen;
+	}
+	else { /* Need to alloc new area to put larger or smaller fdt */
+		struct boot_param_header *old_bph, *new_bph;
+		u32 *old_tailp, *new_tailp, *new_datap;
+		u32 old_total_size, new_total_size, head_len, tail_len, diff;
+		void *new_dtb_start, *new_dtb_end;
+
+		old_bph = fdt_get_bph(dtb_start),
+		old_total_size = old_bph->totalsize;
+		head_len = (u32)datap - (u32)dtb_start;
+		tail_len = old_total_size - (head_len + old_prop_data_len);
+		old_tailp = (u32 *)((u32)dtb_end - tail_len);
+		new_total_size = head_len + new_prop_data_len + tail_len;
+
+		if (!(new_dtb_start = malloc(new_total_size))) {
+			printf("Can't alloc space for new fdt\n\r");
+			exit();
+		}
+
+		new_dtb_end = (void *)((u32)new_dtb_start + new_total_size);
+		new_datap = (u32 *)((u32)new_dtb_start + head_len);
+		new_tailp = (u32 *)((u32)new_dtb_end - tail_len);
+
+		memcpy(new_dtb_start, dtb_start, head_len);
+		memcpy(new_datap, buf, buflen);
+		memcpy(new_tailp, old_tailp, tail_len);
+		*(new_datap - 2) = buflen;
+
+		new_bph = fdt_get_bph(new_dtb_start),
+		new_bph->totalsize = new_total_size;
+
+		diff = new_prop_data_len - old_prop_data_len;
+
+		/* Adjust offsets of other sections, if necessary */
+		if (new_bph->off_dt_strings > new_bph->off_dt_struct)
+			new_bph->off_dt_strings += diff;
+
+		if (new_bph->off_mem_rsvmap > new_bph->off_dt_struct)
+			new_bph->off_mem_rsvmap += diff;
+
+		free(dtb_start, old_total_size);
+
+		dtb_start = new_dtb_start;
+		dtb_end = new_dtb_end;
+	}
+}
+
+/* Only modifies existing properties */
+static int
+fdt_setprop(void *node, const char *name, void *buf, int buflen)
+{
+	u32 *dp, *tagp, *sizep;
+	char *namep, *datap;
+	int level;
+
+	level = 0;
+	dp = node;
+
+	while ((dp = fdt_next(dp, &tagp, &namep, &datap, &sizep)) != NULL)
+		switch (*tagp) {
+		case OF_DT_PROP:
+			if ((level == 1) && !strcmp(namep, name)) {
+				fdt_modify_prop(tagp, datap, sizep, buf,buflen);
+				return *sizep;
+			}
+			break;
+		case OF_DT_BEGIN_NODE:
+			level++;
+			break;
+		case OF_DT_END_NODE:
+			if (--level <= 0)
+				return -1;
+			break;
+		}
+	return -1;
+}
+
+static u32
+fdt_find_cells(char *path, char *prop)
+{
+	void *devp;
+	u32 num;
+	char p[MAX_PATH_LEN];
+
+	strcpy(p, path);
+	do {
+		if ((devp = finddevice(p))
+				&& (getprop(devp, prop, &num, sizeof(num)) > 0))
+			return num;
+		fdt_parentize(p, 0);
+	} while (strlen(p) > 0);
+	return 1; /* default of 1 */
+}
+
+static u64
+fdt_read_addr(u32 *cell, int size)
+{
+	u64 r = 0;
+	while (size--)
+		r = (r << 32) | *(cell++);
+	return r;
+}
+
+static u64
+fdt_bus_default_map(u32 *addr, u32 *range, int na, int ns, int pna)
+{
+	u64 cp, s, da;
+
+	cp = fdt_read_addr(range, na);
+	s  = fdt_read_addr(range + na + pna, ns);
+	da = fdt_read_addr(addr, na);
+
+	if (da < cp || da >= (cp + s))
+		return BAD_ADDR;
+	return da - cp;
+}
+
+static int
+fdt_bus_default_translate(u32 *addr, u64 offset, int na)
+{
+	u64 a = fdt_read_addr(addr, na);
+	memset(addr, 0, na * 4);
+	a += offset;
+	if (na > 1)
+		addr[na - 2] = a >> 32;
+	addr[na - 1] = a & 0xffffffffu;
+
+	return 0;
+}
+
+static u64
+fdt_bus_pci_map(u32 *addr, u32 *range, int na, int ns, int pna)
+{
+	u64 cp, s, da;
+
+	/* Check address type match */
+	if ((addr[0] ^ range[0]) & 0x03000000)
+		return BAD_ADDR;
+
+	/* Read address values, skipping high cell */
+	cp = fdt_read_addr(range + 1, na - 1);
+	s  = fdt_read_addr(range + na + pna, ns);
+	da = fdt_read_addr(addr + 1, na - 1);
+
+	if (da < cp || da >= (cp + s))
+		return BAD_ADDR;
+	return da - cp;
+}
+
+static int
+fdt_bus_pci_translate(u32 *addr, u64 offset, int na)
+{
+	return fdt_bus_default_translate(addr + 1, offset, na - 1);
+}
+
+static u64
+fdt_bus_isa_map(u32 *addr, u32 *range, int na, int ns, int pna)
+{
+	u64 cp, s, da;
+
+	/* Check address type match */
+	if ((addr[0] ^ range[0]) & 0x00000001)
+		return BAD_ADDR;
+
+	/* Read address values, skipping high cell */
+	cp = fdt_read_addr(range + 1, na - 1);
+	s  = fdt_read_addr(range + na + pna, ns);
+	da = fdt_read_addr(addr + 1, na - 1);
+
+	if (da < cp || da >= (cp + s))
+		return BAD_ADDR;
+	return da - cp;
+}
+
+static int
+fdt_bus_isa_translate(u32 *addr, u64 offset, int na)
+{
+	return fdt_bus_default_translate(addr + 1, offset, na - 1);
+}
+
+static void
+fdt_match_bus(char *path, struct fdt_bus *bus)
+{
+	void *devp;
+	char dtype[128]; /* XXXX */
+
+	if ((devp = finddevice(path)) && (getprop(devp, "device_type", dtype,
+					sizeof(dtype)) > 0)) {
+		if (!strcmp(dtype, "isa")) {
+			bus->map = fdt_bus_isa_map;
+			bus->translate = fdt_bus_isa_translate;
+		} else if (!strcmp(dtype, "pci")) {
+			bus->map = fdt_bus_pci_map;
+			bus->translate = fdt_bus_pci_translate;
+		} else {
+			bus->map = fdt_bus_default_map;
+			bus->translate = fdt_bus_default_translate;
+		}
+	}
+}
+
+static int
+fdt_translate_one(char *path, struct fdt_bus *bus, struct fdt_bus *pbus,
+		u32 *addr, u32 na, u32 ns, u32 pna)
+{
+	void *devp;
+	u32 ranges[10 * (na + pna + ns)]; /* XXXX */
+	u32 *rp;
+	unsigned int rlen;
+	int rone;
+	u64 offset = BAD_ADDR;
+
+	if (!(devp = finddevice(path))
+			|| ((rlen = getprop(devp, "ranges", ranges,
+						sizeof(ranges))) < 0)
+			|| (rlen == 0)) {
+		offset = fdt_read_addr(addr, na);
+		memset(addr, 0, pna * 4);
+		goto finish;
+	}
+
+	rlen /= 4;
+	rone = na + pna + ns;
+	rp = ranges;
+	for (; rlen >= rone; rlen -= rone, rp += rone) {
+		offset = bus->map(addr, rp, na, ns, pna);
+		if (offset != BAD_ADDR)
+			break;
+	}
+	if (offset == BAD_ADDR)
+		return 1;
+	memcpy(addr, rp + na, 4 * pna);
+
+finish:
+	/* Translate it into parent bus space */
+	return pbus->translate(addr, offset, pna);
+}
+
+/* 'addr' is modified */
+static u64
+fdt_translate_addr(char *p, u32 *in_addr, u32 addr_len)
+{
+	struct fdt_bus	bus, pbus;
+	int na, ns, pna, pns;
+	u32 addr[MAX_ADDR_CELLS];
+	char path[MAX_PATH_LEN], ppath[MAX_PATH_LEN];
+
+	strcpy(ppath, p);
+	fdt_parentize(ppath, 0);
+	fdt_match_bus(ppath, &bus);
+	na = fdt_find_cells(ppath, "#address-cells");
+	ns = fdt_find_cells(ppath, "#size-cells");
+	memcpy(addr, in_addr, na * 4);
+
+	for (;;) {
+		strcpy(path, ppath);
+		fdt_parentize(ppath, 0);
+
+		if (strlen(ppath) == 0)
+			return fdt_read_addr(addr, na);
+
+		fdt_match_bus(ppath, &pbus);
+		pna = fdt_find_cells(ppath, "#address-cells");
+		pns = fdt_find_cells(ppath, "#size-cells");
+
+		if (fdt_translate_one(path, &bus, &pbus, addr, na, ns, pna))
+			exit();
+
+		na = pna;
+		ns = pns;
+		memcpy(&bus, &pbus, sizeof(struct fdt_bus));
+	}
+}
+
+static void
+fdt_call_kernel(void *entry_addr, unsigned long a1, unsigned long a2,
+		void *promptr, void *sp)
+{
+	void (*kernel_entry)(void *dt_blob, void *start_addr,
+			void *must_be_null);
+
+#ifdef DEBUG
+	printf("kernel:\n\r"
+		"        entry addr   = 0x%lx\n\r"
+		"        flattened dt = 0x%lx\n\r",
+		(unsigned long)entry_addr, dtb_start);
+#endif
+
+	kernel_entry = entry_addr;
+	kernel_entry(dtb_start, entry_addr, NULL);
+}
+
+static struct dt_ops fdt_dt_ops;
+
+struct dt_ops *
+fdt_init(void)
+{
+	fdt_dt_ops.finddevice = fdt_finddevice;
+	fdt_dt_ops.getprop = fdt_getprop;
+	fdt_dt_ops.setprop = fdt_setprop;
+	fdt_dt_ops.translate_addr = fdt_translate_addr;
+	fdt_dt_ops.call_kernel = fdt_call_kernel;
+
+	dtb_start = &dt_blob_start;
+	dtb_end = &dt_blob_end;
+
+	return &fdt_dt_ops;
+}
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
index 816446f..03e305b 100644
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
@@ -46,17 +40,8 @@ static unsigned long elfoffset;
 
 static char scratch[46912];	/* scratch space for gunzip, from zlib_inflate_workspacesize() */
 static char elfheader[256];
-
-
-typedef void (*kernel_entry_t)( unsigned long,
-                                unsigned long,
-                                void *,
-				void *);
 
-
 #undef DEBUG
-
-static unsigned long claim_base;
 
 #define HEAD_CRC	2
 #define EXTRA_FIELD	4
@@ -113,24 +98,6 @@ static void gunzip(void *dst, int dstlen
 	}
 	*lenp = s.next_out - (unsigned char *) dst;
 	zlib_inflateEnd(&s);
-}
-
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
 }
 
 static int is_elf64(void *hdr)
@@ -161,16 +128,6 @@ static int is_elf64(void *hdr)
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
 
@@ -204,31 +161,12 @@ static int is_elf32(void *hdr)
 	return 1;
 }
 
-void start(unsigned long a1, unsigned long a2, void *promptr, void *sp)
+static void prep_kernel(unsigned long *a1, unsigned long *a2, void *sp)
 {
 	int len;
-	kernel_entry_t kernel_entry;
 
-	memset(__bss_start, 0, _end - __bss_start);
+	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r", _start,sp);
 
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
-
-	claim_base = _ALIGN_UP((unsigned long)_end, ONE_MB);
-
 	vmlinuz.addr = (unsigned long)_vmlinux_start;
 	vmlinuz.size = (unsigned long)(_vmlinux_end - _vmlinux_start);
 
@@ -238,43 +176,46 @@ void start(unsigned long a1, unsigned lo
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
@@ -297,23 +238,75 @@ #endif
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
+static char zimage_cmdline[COMMAND_LINE_SIZE]
+	__attribute__((section("__zimage_cmdline")));
 
-	kernel_entry(a1, a2, prom, NULL);
+static void get_cmdline(char *buf, int size)
+{
+	void *devp;
+	int len = strlen(zimage_cmdline);
 
-	printf("Error: Linux kernel returned to zImage bootloader!\n\r");
+	buf[0] = '\0';
 
-	exit();
+	if (len > 0) { /* zimage_cmdline overrides dt's /chosen/bootargs */
+		len = min(len, size-1);
+		strncpy(buf, zimage_cmdline, len);
+		buf[len] = '\0';
+	}
+	else if ((devp = finddevice("/chosen")))
+		getprop(devp, "bootargs", buf, size);
 }
+
+static void set_cmdline(char *buf)
+{
+	void *devp;
+
+	if ((devp = finddevice("/chosen")))
+		setprop(devp, "bootargs", buf, strlen(buf) + 1);
+}
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
+	if (!ops || !ops->platform_ops || !ops->fw_ops || !ops->dt_ops
+			|| !ops->console_ops)
+		exit();
 
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
+	if ((strlen(zimage_cmdline) > 0) || ops->console_ops->edit_cmdline) {
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
diff --git a/arch/powerpc/boot/mpc10x.c b/arch/powerpc/boot/mpc10x.c
new file mode 100644
index 0000000..2916fdc
--- /dev/null
+++ b/arch/powerpc/boot/mpc10x.c
@@ -0,0 +1,87 @@
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
index 0000000..5a6d91f
--- /dev/null
+++ b/arch/powerpc/boot/ns16550.c
@@ -0,0 +1,125 @@
+/*
+ * 16550 serial console support
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * Much of the code is copied from arch/ppc/boot/common/ns16550.c
+ * which has no Author or Copyright text.
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
+#include "ops.h"
+
+#define UART_DLL	0	/* Out: Divisor Latch Low */
+#define UART_DLM	1	/* Out: Divisor Latch High */
+#define UART_FCR	2	/* Out: FIFO Control Register */
+#define UART_LCR	3	/* Out: Line Control Register */
+#define UART_MCR	4	/* Out: Modem Control Register */
+#define UART_LSR	5	/* In:  Line Status Register */
+#define UART_LSR_THRE	0x20	/* Transmit-hold-register empty */
+#define UART_LSR_DR	0x01	/* Receiver data ready */
+#define UART_MSR	6	/* In:  Modem Status Register */
+#define UART_SCR	7	/* I/O: Scratch Register */
+
+int
+ns16550_get_dt_info(struct serial_console_data *scdp)
+{
+	u64 addr;
+	u32 reg[2], reg_shift;
+	void *devp;
+	char path[MAX_PATH_LEN+1], compat[MAX_PATH_LEN+1];
+
+	scdp->base = NULL;
+	scdp->reg_shift = 0;
+
+	if ((devp = finddevice("/chosen"))
+			&& (getprop(devp, "linux,stdout-path", path,
+					sizeof(path)) > 0)
+			&& (devp = finddevice(path))
+			&& (getprop(devp, "compatible", compat, sizeof(compat))
+				> 0)
+			&& !strcmp(compat, "ns16550")
+			&& (getprop(devp, "reg", reg, sizeof(reg))
+				== sizeof(reg))) {
+
+		addr = ops->dt_ops->translate_addr(path, reg, sizeof(reg));
+		scdp->base = (unsigned char *)((u32)addr & 0xffffffffu);
+
+		if (getprop(devp, "reg_shift", &reg_shift, sizeof(reg_shift))
+				== sizeof(reg_shift))
+			scdp->reg_shift = reg_shift;
+		return 0;
+	}
+	return -1;
+}
+
+static int
+ns16550_open(void)
+{
+	struct serial_console_data *scdp = ops->console_ops->data;
+
+	if (ns16550_get_dt_info(scdp) < 0)
+		return -1;
+
+	out_8(scdp->base + (UART_FCR << scdp->reg_shift), 0x06);
+	return 0;
+}
+
+static void
+ns16550_putc(unsigned char c)
+{
+	struct serial_console_data *scdp = ops->console_ops->data;
+	while ((in_8(scdp->base + (UART_LSR << scdp->reg_shift))
+							& UART_LSR_THRE) == 0);
+	out_8(scdp->base, c);
+}
+
+static unsigned char
+ns16550_getc(void)
+{
+	struct serial_console_data *scdp = ops->console_ops->data;
+	while ((in_8(scdp->base + (UART_LSR << scdp->reg_shift))
+							& UART_LSR_DR) == 0);
+	return in_8(scdp->base);
+}
+
+static u8
+ns16550_tstc(void)
+{
+	struct serial_console_data *scdp = ops->console_ops->data;
+	return ((in_8(scdp->base + (UART_LSR << scdp->reg_shift)) & UART_LSR_DR)
+			!= 0);
+}
+
+static struct serial_console_data ns16550_scd;
+static struct console_ops ns16550_console_ops;
+
+struct console_ops *
+ns16550_init(void)
+{
+	ns16550_scd.open = ns16550_open;
+	ns16550_scd.putc = ns16550_putc;
+	ns16550_scd.getc = ns16550_getc;
+	ns16550_scd.tstc = ns16550_tstc;
+	ns16550_scd.close = NULL;
+	ns16550_scd.base = NULL;
+	ns16550_scd.reg_shift = 0;
+
+	ns16550_console_ops.open = serial_open;
+	ns16550_console_ops.write = serial_write;
+	ns16550_console_ops.edit_cmdline = serial_edit_cmdline;
+	ns16550_console_ops.close = serial_close;
+	ns16550_console_ops.data = &ns16550_scd;
+
+	return &ns16550_console_ops;
+}
diff --git a/arch/powerpc/boot/of.c b/arch/powerpc/boot/of.c
new file mode 100644
index 0000000..313f125
--- /dev/null
+++ b/arch/powerpc/boot/of.c
@@ -0,0 +1,301 @@
+/*
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "string.h"
+#include "stdio.h"
+#include "page.h"
+#include "ops.h"
+
+typedef void *ihandle;
+typedef void *phandle;
+
+extern char _end[];
+
+/* Value picked to match that used by yaboot */
+#define PROG_START	0x01400000	/* only used on 64-bit systems */
+#define RAM_END		(512<<20)	/* Fixme: use OF */
+#define	ONE_MB		0x100000
+
+int (*prom) (void *);
+
+
+static unsigned long claim_base;
+
+static int call_prom(const char *service, int nargs, int nret, ...)
+{
+	int i;
+	struct prom_args {
+		const char *service;
+		int nargs;
+		int nret;
+		unsigned int args[12];
+	} args;
+	va_list list;
+
+	args.service = service;
+	args.nargs = nargs;
+	args.nret = nret;
+
+	va_start(list, nret);
+	for (i = 0; i < nargs; i++)
+		args.args[i] = va_arg(list, unsigned int);
+	va_end(list);
+
+	for (i = 0; i < nret; i++)
+		args.args[nargs+i] = 0;
+
+	if (prom(&args) < 0)
+		return -1;
+
+	return (nret > 0)? args.args[nargs]: 0;
+}
+
+static int call_prom_ret(const char *service, int nargs, int nret,
+		  unsigned int *rets, ...)
+{
+	int i;
+	struct prom_args {
+		const char *service;
+		int nargs;
+		int nret;
+		unsigned int args[12];
+	} args;
+	va_list list;
+
+	args.service = service;
+	args.nargs = nargs;
+	args.nret = nret;
+
+	va_start(list, rets);
+	for (i = 0; i < nargs; i++)
+		args.args[i] = va_arg(list, unsigned int);
+	va_end(list);
+
+	for (i = 0; i < nret; i++)
+		args.args[nargs+i] = 0;
+
+	if (prom(&args) < 0)
+		return -1;
+
+	if (rets != (void *) 0)
+		for (i = 1; i < nret; ++i)
+			rets[i-1] = args.args[nargs+i];
+
+	return (nret > 0)? args.args[nargs]: 0;
+}
+
+/*
+ * Older OF's require that when claiming a specific range of addresses,
+ * we claim the physical space in the /memory node and the virtual
+ * space in the chosen mmu node, and then do a map operation to
+ * map virtual to physical.
+ */
+static int need_map = -1;
+static ihandle chosen_mmu;
+static phandle memory;
+
+/* returns true if s2 is a prefix of s1 */
+static int string_match(const char *s1, const char *s2)
+{
+	for (; *s2; ++s2)
+		if (*s1++ != *s2)
+			return 0;
+	return 1;
+}
+
+static int check_of_version(void)
+{
+	phandle oprom, chosen;
+	char version[64];
+
+	oprom = finddevice("/openprom");
+	if (oprom == (phandle) -1)
+		return 0;
+	if (getprop(oprom, "model", version, sizeof(version)) <= 0)
+		return 0;
+	version[sizeof(version)-1] = 0;
+	printf("OF version = '%s'\r\n", version);
+	if (!string_match(version, "Open Firmware, 1.")
+	    && !string_match(version, "FirmWorks,3."))
+		return 0;
+	chosen = finddevice("/chosen");
+	if (chosen == (phandle) -1) {
+		chosen = finddevice("/chosen@0");
+		if (chosen == (phandle) -1) {
+			printf("no chosen\n");
+			return 0;
+		}
+	}
+	if (getprop(chosen, "mmu", &chosen_mmu, sizeof(chosen_mmu)) <= 0) {
+		printf("no mmu\n");
+		return 0;
+	}
+	memory = (ihandle) call_prom("open", 1, 1, "/memory");
+	if (memory == (ihandle) -1) {
+		memory = (ihandle) call_prom("open", 1, 1, "/memory@0");
+		if (memory == (ihandle) -1) {
+			printf("no memory node\n");
+			return 0;
+		}
+	}
+	printf("old OF detected\r\n");
+	return 1;
+}
+
+static void *claim(unsigned long virt, unsigned long size, unsigned long align)
+{
+	int ret;
+	unsigned int result;
+
+	if (need_map < 0)
+		need_map = check_of_version();
+	if (align || !need_map)
+		return (void *) call_prom("claim", 3, 1, virt, size, align);
+
+	ret = call_prom_ret("call-method", 5, 2, &result, "claim", memory,
+			    align, size, virt);
+	if (ret != 0 || result == -1)
+		return (void *) -1;
+	ret = call_prom_ret("call-method", 5, 2, &result, "claim", chosen_mmu,
+			    align, size, virt);
+	/* 0x12 == coherent + read/write */
+	ret = call_prom("call-method", 6, 1, "map", chosen_mmu,
+			0x12, size, virt, virt);
+	return (void *) virt;
+}
+
+static void *of_try_claim(u32 size)
+{
+	unsigned long addr = 0;
+	static u8 first_time = 1;
+
+	if (first_time) {
+#if defined(PROG_START)
+		/*
+		 * Maintain a "magic" minimum address. This keeps some older
+		 * firmware platforms running.
+		 */
+
+		if (claim_base < PROG_START)
+			claim_base = PROG_START;
+#endif
+		claim_base = _ALIGN_UP((unsigned long)_end, ONE_MB);
+		first_time = 0;
+	}
+
+	for(; claim_base < RAM_END; claim_base += ONE_MB) {
+#ifdef DEBUG
+		printf("    trying: 0x%08lx\n\r", claim_base);
+#endif
+		addr = (unsigned long)claim(claim_base, size, 0);
+		if ((void *)addr != (void *)-1)
+			break;
+	}
+	if (addr == 0)
+		return NULL;
+	claim_base = PAGE_ALIGN(claim_base + size);
+	return (void *)addr;
+}
+
+static void of_fw_exit(void)
+{
+	call_prom("exit", 0, 0);
+}
+
+/*
+ * OF device tree routines
+ */
+static void *of_finddevice(const char *name)
+{
+	return (phandle) call_prom("finddevice", 1, 1, name);
+}
+
+static int of_getprop(void *phandle, const char *name,
+			  void *buf, int buflen)
+{
+	return call_prom("getprop", 4, 1, phandle, name, buf, buflen);
+}
+
+static int of_setprop(void *phandle, const char *name,
+			  void *buf, int buflen)
+{
+	return call_prom("setprop", 4, 1, phandle, name, buf, buflen);
+}
+
+static void of_call_kernel(void *entry_addr, unsigned long a1,
+		unsigned long a2, void *promptr, void *sp)
+{
+	void (*kernel_entry)(unsigned long a1, unsigned long a2, void *promptr,
+			void *sp);
+
+	kernel_entry = entry_addr;
+	kernel_entry(a1, a2, promptr, sp);
+}
+
+/*
+ * OF console routines
+ */
+static void *of_stdout_handle;
+
+static int of_console_open(void)
+{
+	void *devp;
+
+	if (((devp = finddevice("/chosen")) != NULL)
+			&& (getprop(devp, "stdout", &of_stdout_handle,
+				sizeof(of_stdout_handle))
+				== sizeof(of_stdout_handle)))
+		return 0;
+
+	return -1;
+}
+
+static void of_console_write(char *buf, int len)
+{
+	call_prom("write", 3, 1, of_stdout_handle, buf, len);
+}
+
+/* Init code that hooks up all of the routines */
+static struct platform_ops of_platform_ops;
+static struct fw_ops of_fw_ops;
+static struct dt_ops of_dt_ops;
+static struct console_ops of_console_ops;
+static struct ops of_ops;
+
+struct ops *platform_init(void *promptr)
+{
+	of_platform_ops.fixups = NULL;
+	of_platform_ops.exit = NULL;
+
+	of_fw_ops.malloc = of_try_claim;
+	of_fw_ops.free = NULL;
+	of_fw_ops.exit = of_fw_exit;
+
+	of_dt_ops.finddevice = of_finddevice;
+	of_dt_ops.getprop = of_getprop;
+	of_dt_ops.setprop = of_setprop;
+	of_dt_ops.call_kernel = of_call_kernel;
+
+	of_console_ops.open = of_console_open;
+	of_console_ops.write = of_console_write;
+	of_console_ops.edit_cmdline = NULL;
+	of_console_ops.close = NULL;
+	of_console_ops.data = NULL;
+
+	of_ops.platform_ops = &of_platform_ops;
+	of_ops.fw_ops = &of_fw_ops;
+	of_ops.dt_ops = &of_dt_ops;
+	of_ops.console_ops = &of_console_ops;
+
+	prom = (int (*)(void *))promptr;
+
+	return &of_ops;
+}
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
new file mode 100644
index 0000000..c214f2b
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
+extern struct dt_ops *fdt_init(void);
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
+	return (ops->fw_ops->malloc) ?  ops->fw_ops->malloc(size) : NULL;
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
diff --git a/arch/powerpc/boot/prom.c b/arch/powerpc/boot/prom.c
deleted file mode 100644
index fa00577..0000000
--- a/arch/powerpc/boot/prom.c
+++ /dev/null
@@ -1,165 +0,0 @@
-/*
- * Copyright (C) Paul Mackerras 1997.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#include <stdarg.h>
-#include <stddef.h>
-#include "string.h"
-#include "stdio.h"
-#include "prom.h"
-
-int (*prom)(void *);
-phandle chosen_handle;
-ihandle stdout;
-
-int call_prom(const char *service, int nargs, int nret, ...)
-{
-	int i;
-	struct prom_args {
-		const char *service;
-		int nargs;
-		int nret;
-		unsigned int args[12];
-	} args;
-	va_list list;
-
-	args.service = service;
-	args.nargs = nargs;
-	args.nret = nret;
-
-	va_start(list, nret);
-	for (i = 0; i < nargs; i++)
-		args.args[i] = va_arg(list, unsigned int);
-	va_end(list);
-
-	for (i = 0; i < nret; i++)
-		args.args[nargs+i] = 0;
-
-	if (prom(&args) < 0)
-		return -1;
-
-	return (nret > 0)? args.args[nargs]: 0;
-}
-
-int call_prom_ret(const char *service, int nargs, int nret,
-		  unsigned int *rets, ...)
-{
-	int i;
-	struct prom_args {
-		const char *service;
-		int nargs;
-		int nret;
-		unsigned int args[12];
-	} args;
-	va_list list;
-
-	args.service = service;
-	args.nargs = nargs;
-	args.nret = nret;
-
-	va_start(list, rets);
-	for (i = 0; i < nargs; i++)
-		args.args[i] = va_arg(list, unsigned int);
-	va_end(list);
-
-	for (i = 0; i < nret; i++)
-		args.args[nargs+i] = 0;
-
-	if (prom(&args) < 0)
-		return -1;
-
-	if (rets != (void *) 0)
-		for (i = 1; i < nret; ++i)
-			rets[i-1] = args.args[nargs+i];
-
-	return (nret > 0)? args.args[nargs]: 0;
-}
-
-int write(void *handle, void *ptr, int nb)
-{
-	return call_prom("write", 3, 1, handle, ptr, nb);
-}
-
-/*
- * Older OF's require that when claiming a specific range of addresses,
- * we claim the physical space in the /memory node and the virtual
- * space in the chosen mmu node, and then do a map operation to
- * map virtual to physical.
- */
-static int need_map = -1;
-static ihandle chosen_mmu;
-static phandle memory;
-
-/* returns true if s2 is a prefix of s1 */
-static int string_match(const char *s1, const char *s2)
-{
-	for (; *s2; ++s2)
-		if (*s1++ != *s2)
-			return 0;
-	return 1;
-}
-
-static int check_of_version(void)
-{
-	phandle oprom, chosen;
-	char version[64];
-
-	oprom = finddevice("/openprom");
-	if (oprom == (phandle) -1)
-		return 0;
-	if (getprop(oprom, "model", version, sizeof(version)) <= 0)
-		return 0;
-	version[sizeof(version)-1] = 0;
-	printf("OF version = '%s'\r\n", version);
-	if (!string_match(version, "Open Firmware, 1.")
-	    && !string_match(version, "FirmWorks,3."))
-		return 0;
-	chosen = finddevice("/chosen");
-	if (chosen == (phandle) -1) {
-		chosen = finddevice("/chosen@0");
-		if (chosen == (phandle) -1) {
-			printf("no chosen\n");
-			return 0;
-		}
-	}
-	if (getprop(chosen, "mmu", &chosen_mmu, sizeof(chosen_mmu)) <= 0) {
-		printf("no mmu\n");
-		return 0;
-	}
-	memory = (ihandle) call_prom("open", 1, 1, "/memory");
-	if (memory == (ihandle) -1) {
-		memory = (ihandle) call_prom("open", 1, 1, "/memory@0");
-		if (memory == (ihandle) -1) {
-			printf("no memory node\n");
-			return 0;
-		}
-	}
-	printf("old OF detected\r\n");
-	return 1;
-}
-
-void *claim(unsigned long virt, unsigned long size, unsigned long align)
-{
-	int ret;
-	unsigned int result;
-
-	if (need_map < 0)
-		need_map = check_of_version();
-	if (align || !need_map)
-		return (void *) call_prom("claim", 3, 1, virt, size, align);
-	
-	ret = call_prom_ret("call-method", 5, 2, &result, "claim", memory,
-			    align, size, virt);
-	if (ret != 0 || result == -1)
-		return (void *) -1;
-	ret = call_prom_ret("call-method", 5, 2, &result, "claim", chosen_mmu,
-			    align, size, virt);
-	/* 0x12 == coherent + read/write */
-	ret = call_prom("call-method", 6, 1, "map", chosen_mmu,
-			0x12, size, virt, virt);
-	return (void *) virt;
-}
diff --git a/arch/powerpc/boot/prom.h b/arch/powerpc/boot/prom.h
deleted file mode 100644
index 3e2ddd4..0000000
--- a/arch/powerpc/boot/prom.h
+++ /dev/null
@@ -1,34 +0,0 @@
-#ifndef _PPC_BOOT_PROM_H_
-#define _PPC_BOOT_PROM_H_
-
-typedef void *phandle;
-typedef void *ihandle;
-
-extern int (*prom) (void *);
-extern phandle chosen_handle;
-extern ihandle stdout;
-
-int	call_prom(const char *service, int nargs, int nret, ...);
-int	call_prom_ret(const char *service, int nargs, int nret,
-		      unsigned int *rets, ...);
-
-extern int write(void *handle, void *ptr, int nb);
-extern void *claim(unsigned long virt, unsigned long size, unsigned long aln);
-
-static inline void exit(void)
-{
-	call_prom("exit", 0, 0);
-}
-
-static inline phandle finddevice(const char *name)
-{
-	return (phandle) call_prom("finddevice", 1, 1, name);
-}
-
-static inline int getprop(void *phandle, const char *name,
-			  void *buf, int buflen)
-{
-	return call_prom("getprop", 4, 1, phandle, name, buf, buflen);
-}
-
-#endif				/* _PPC_BOOT_PROM_H_ */
diff --git a/arch/powerpc/boot/sandpoint.c b/arch/powerpc/boot/sandpoint.c
new file mode 100644
index 0000000..dc10e51
--- /dev/null
+++ b/arch/powerpc/boot/sandpoint.c
@@ -0,0 +1,148 @@
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
+#include "ops.h"
+
+#define	CPU_824X	0
+#define	CPU_7XX		1
+#define	CPU_7457	2
+#define	CPU_NUM		3
+
+static u32 cpu_pll[CPU_NUM][32] = {
+	[CPU_824X] = { /* 824x */
+		5, 6, 9, 4, 4, 5, 2, 6, 6, 4, 9, 6, 5, 7, 6, 7,
+		4, 5, 4, 6, 7, 8, 8, 4, 6, 5, 8, 6, 6, 5, 7, 0
+	},
+	[CPU_7XX] = { /* 750/755 */
+		0, 15, 14, 2, 4, 13, 20, 9, 6, 11, 8, 10, 16, 12, 7, 0,
+		0,  0,  0, 0, 0,  0,  0, 0, 0,  0, 0,  0,  0,  0, 0, 0
+
+	},
+	[CPU_7457] = { /* 7457 */
+		23, 34, 15, 30, 14, 36,  2, 40,  4, 42, 13, 26, 17, 48, 19, 18,
+		 6, 21, 11, 22,  8, 20, 10, 24, 16, 28, 12, 32, 27, 56,  0, 25
+	}
+};
+
+static struct processor_info {
+	u32	pvr;
+	u32	mask;
+	u32	bus_freq;
+	u32	hid1_shift;
+	u32	hid1_mask;
+	u32	pll_tbl_idx;
+	u32	max_mem;	/* 7457 flaky with > 64MB of mem */
+} processor_info_tbl[] = { /* From cputable -- MHz are only guesses */
+	/* 824x */
+	{ 0x00810000, 0x7fff0000, 100000000, 27, 0x1f, CPU_824X, 0x80000000 },
+	/* 750 */
+	{ 0x00084202, 0xffffffff, 100000000, 28, 0xf, CPU_7XX, 0x80000000 },
+	/* 745/755 */
+	{ 0x00083000, 0xfffff000, 100000000, 28, 0xf, CPU_7XX, 0x80000000 },
+	/* 7447/7457 Rev 1.0 */
+	{ 0x80020100, 0xffffffff, 100000000, 12, 0x1f, CPU_7457, 0x04000000 },
+	/* 7447/7457 Rev 1.1 */
+	{ 0x80020101, 0xffffffff, 100000000, 12, 0x1f, CPU_7457, 0x04000000 },
+	/* 7447/7457 Rev 1.2 & up*/
+	{ 0x80020000, 0xffff0000, 100000000, 12, 0x1f, CPU_7457, 0x04000000 },
+	/* 7447A */
+	{ 0x80030000, 0xffff0000, 100000000, 12, 0x1f, CPU_7457, 0x80000000 },
+};
+
+static struct processor_info *
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
+static void
+sandpoint_fixups(void)
+{
+	u32 i, v[2], hid1, max_mem = 0xffffffff;
+	void *devp;
+	struct processor_info *pit;
+	extern u32 mpc10x_get_mem_size(void);
+
+	if ((pit = get_processor_info(mfspr(SPRN_PVR)))
+			&& (devp = finddevice("/cpus/PowerPC,603e"))) {
+
+		max_mem = pit->max_mem;
+
+		hid1 = (mfspr(SPRN_HID1) >> pit->hid1_shift) & pit->hid1_mask;
+		v[0] = pit->bus_freq * cpu_pll[pit->pll_tbl_idx][hid1]/2;
+		setprop(devp, "clock-frequency", v, sizeof(v[0]));
+
+		v[0] = pit->bus_freq / 4;
+		setprop(devp, "timebase-frequency", v, sizeof(v[0]));
+	}
+
+	/* Get the RAM size from the memory controller */
+	if ((devp = finddevice("/memory"))) {
+		i = mpc10x_get_mem_size();
+		v[0] = 0;
+		v[1] = min(i, max_mem);
+		setprop(devp, "reg", v, sizeof(v));
+	}
+
+	/* XXXX stuff from platforms/.../sandpoint.c should be here */
+}
+
+static void
+sandpoint_reset(void)
+{
+	void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
+	_nmask_and_or_msr(0, (1<<6)); /* Set exception prefix high - firmware */
+
+	/* Reset system via Port 92 */
+	out_8((volatile unsigned char *)0xfe000092, 0x00);
+	out_8((volatile unsigned char *)0xfe000092, 0x01);
+
+	for(;;);	/* Spin until reset happens */
+}
+
+static struct ops sandpoint_ops;
+static struct platform_ops sandpoint_platform_ops;
+
+struct ops *
+platform_init(void *promptr)
+{
+	sandpoint_platform_ops.fixups = sandpoint_fixups;
+	sandpoint_platform_ops.exit = sandpoint_reset;
+
+	sandpoint_ops.platform_ops = &sandpoint_platform_ops;
+	sandpoint_ops.fw_ops = dink_init();
+	sandpoint_ops.dt_ops = fdt_init();
+	sandpoint_ops.console_ops = ns16550_init();
+
+	return &sandpoint_ops;
+}
diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
new file mode 100644
index 0000000..91d6e91
--- /dev/null
+++ b/arch/powerpc/boot/serial.c
@@ -0,0 +1,90 @@
+/*
+ * Generic serial console support
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * Code in serial_edit_cmdline() copied from arch/ppc/boot/simple/misc.c
+ * and was written by Matt Porter <mporter@kernel.crashing.org>.
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
+#include "ops.h"
+
+extern void udelay(long delay);
+
+int
+serial_open(void)
+{
+	struct serial_console_data *scdp = ops->console_ops->data;
+	return scdp->open();
+}
+
+void
+serial_write(char *buf, int len)
+{
+	struct serial_console_data *scdp = ops->console_ops->data;
+
+	while (*buf != '\0')
+		scdp->putc(*buf++);
+}
+
+void
+serial_edit_cmdline(char *buf, int len)
+{
+	int timer = 0, count;
+	char ch, *cp;
+	struct serial_console_data *scdp = ops->console_ops->data;
+
+	cp = buf;
+	count = strlen(buf);
+	cp = &buf[count];
+	count++;
+
+	while (timer++ < 5*1000) {
+		if (scdp->tstc()) {
+			while ((ch = scdp->getc()) != '\n' && ch != '\r') {
+				/* Test for backspace/delete */
+				if (ch == '\b' || ch == '\177') {
+					if (cp != buf) {
+						cp--;
+						count--;
+						printf("\b \b");
+					}
+				/* Test for ^x/^u (and wipe the line) */
+				} else if (ch == '\030' || ch == '\025') {
+					while (cp != buf) {
+						cp--;
+						count--;
+						printf("\b \b");
+					}
+				} else if (count < len) {
+						*cp++ = ch;
+						count++;
+						scdp->putc(ch);
+				}
+			}
+			break;  /* Exit 'timer' loop */
+		}
+		udelay(1000);  /* 1 msec */
+	}
+	*cp = 0;
+}
+
+void
+serial_close(void)
+{
+	struct serial_console_data *scdp = ops->console_ops->data;
+
+	if (scdp->close)
+		scdp->close();
+}
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
diff --git a/arch/powerpc/boot/util.S b/arch/powerpc/boot/util.S
new file mode 100644
index 0000000..c86d3ba
--- /dev/null
+++ b/arch/powerpc/boot/util.S
@@ -0,0 +1,101 @@
+/*
+ * Copied from arch/powerpc/kernel/misc_32.S
+ *
+ * This file contains miscellaneous low-level functions.
+ *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
+ *
+ * Largely rewritten by Cort Dougan (cort@cs.nmt.edu)
+ * and Paul Mackerras.
+ *
+ * kexec bits:
+ * Copyright (C) 2002-2003 Eric Biederman  <ebiederm@xmission.com>
+ * GameCube/ppc32 port Copyright (C) 2004 Albert Herranz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ */
+#include "ppc_asm.h"
+
+#define SPRN_PVR        0x11F   /* Processor Version Register */
+
+	.text
+/*
+ * complement mask on the msr then "or" some values on.
+ *     _nmask_and_or_msr(nmask, value_to_or)
+ */
+	.globl _nmask_and_or_msr
+_nmask_and_or_msr:
+	mfmsr	r0		/* Get current msr */
+	andc	r0,r0,r3	/* And off the bits set in r3 (first parm) */
+	or	r0,r0,r4	/* Or on the bits in r4 (second parm) */
+	SYNC			/* Some chip revs have problems here... */
+	mtmsr	r0		/* Update machine state */
+	isync
+	blr			/* Done */
+
+/* udelay (on non-601 processors) needs to know the period of the
+ * timebase in nanoseconds.  This used to be hardcoded to be 60ns
+ * (period of 66MHz/4).  Now a variable is used that is initialized to
+ * 60 for backward compatibility, but it can be overridden as necessary
+ * with code something like this:
+ *    extern unsigned long timebase_period_ns;
+ *    timebase_period_ns = 1000000000 / bd->bi_tbfreq;
+ */
+	.data
+	.globl timebase_period_ns
+timebase_period_ns:
+	.long	60
+
+	.text
+/*
+ * Delay for a number of microseconds
+ */
+	.globl	udelay
+udelay:
+	mfspr	r4,SPRN_PVR
+	srwi	r4,r4,16
+	cmpwi	0,r4,1		/* 601 ? */
+	bne	.udelay_not_601
+00:	li	r0,86	/* Instructions / microsecond? */
+	mtctr	r0
+10:	addi	r0,r0,0 /* NOP */
+	bdnz	10b
+	subic.	r3,r3,1
+	bne	00b
+	blr
+
+.udelay_not_601:
+	mulli	r4,r3,1000	/* nanoseconds */
+	/*  Change r4 to be the number of ticks using:
+	 *	(nanoseconds + (timebase_period_ns - 1 )) / timebase_period_ns
+	 *  timebase_period_ns defaults to 60 (16.6MHz) */
+	mflr	r5
+	bl	0f
+0:	mflr	r6
+	mtlr	r5
+	lis	r5,0b@ha
+	addi	r5,r5,0b@l
+	subf	r5,r5,r6	/* In case we're relocated */
+	addis	r5,r5,timebase_period_ns@ha
+	lwz	r5,timebase_period_ns@l(r5)
+	add	r4,r4,r5
+	addi	r4,r4,-1
+	divw	r4,r4,r5	/* BUS ticks */
+1:	mftbu	r5
+	mftb	r6
+	mftbu	r7
+	cmpw	0,r5,r7
+	bne	1b		/* Get [synced] base time */
+	addc	r9,r6,r4	/* Compute end time */
+	addze	r8,r5
+2:	mftbu	r5
+	cmpw	0,r5,r8
+	blt	2b
+	bgt	3f
+	mftb	r6
+	cmpw	0,r6,r9
+	blt	2b
+3:	blr
