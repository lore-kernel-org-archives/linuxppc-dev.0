Return-Path: <mgreer@mvista.com>
Date: Thu, 7 Sep 2006 20:38:14 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 3/6] bootwrapper: Add flat device tree ops glue code
Message-ID: <20060908033814.GC5203@mag.az.mvista.com>
References: <20060719230544.GD3887@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060719230544.GD3887@mag.az.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the "glue" files that interface between the bootwrapper
code and the shared code that is in flatdevtree.[ch].

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

 Makefile           |    2 
 flatdevtree_env.h  |   34 ++++++
 flatdevtree_misc.c |  259 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 295 insertions(+)
--

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index c2bb541..f1877ac 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -39,6 +39,8 @@ #$(addprefix $(obj)/,main.o): $(addprefi
 src-boot := crt0.S string.S stdio.c main.c div64.S
 ifeq ($(CONFIG_PPC_MULTIPLATFORM),y)
 src-boot += of.c
+else
+src-boot += flatdevtree_misc.c
 endif
 src-boot += $(zlib)
 src-boot := $(addprefix $(obj)/, $(src-boot))
diff --git a/arch/powerpc/boot/flatdevtree_env.h b/arch/powerpc/boot/flatdevtree_env.h
new file mode 100644
index 0000000..90e723b
--- /dev/null
+++ b/arch/powerpc/boot/flatdevtree_env.h
@@ -0,0 +1,34 @@
+/*
+ * This file adds the header file glue so that the shared files
+ * flatdevicetree.[ch] can compile and work in the powerpc bootwrapper.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2006 (c) MontaVista Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef _PPC_BOOT_FLATDEVTREE_ENV_H_
+#define _PPC_BOOT_FLATDEVTREE_ENV_H_
+
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "page.h"
+#include "string.h"
+#include "stdio.h"
+#include "ops.h"
+
+#define be16_to_cpu(x)		(x)
+#define cpu_to_be16(x)		(x)
+#define be32_to_cpu(x)		(x)
+#define cpu_to_be32(x)		(x)
+#define be64_to_cpu(x)		(x)
+#define cpu_to_be64(x)		(x)
+
+#define ft_malloc(s)		malloc(s)
+#define ft_free(p,s)		free(p,s)
+#define ft_exit(x)		exit()
+
+#endif /* _PPC_BOOT_FLATDEVTREE_ENV_H_ */
diff --git a/arch/powerpc/boot/flatdevtree_misc.c b/arch/powerpc/boot/flatdevtree_misc.c
new file mode 100644
index 0000000..603d89d
--- /dev/null
+++ b/arch/powerpc/boot/flatdevtree_misc.c
@@ -0,0 +1,259 @@
+/*
+ * This file does the necessary interface mapping between the bootwrapper
+ * device tree operations and the interface provided by shared source
+ * files flatdevicetree.[ch].  It also provides the bootwrapper-required
+ * functionality that is not provided by flatdevicetree.c
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ * 	ft_translate_addr() and related routines came from
+ * 	<file:arch/powerpc/kernel/prom_parse.c> which has no author or
+ * 	copyright notice.
+ *
+ * 2006 (c) MontaVista Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include "flatdevtree.h"
+
+#define MAX_ADDR_CELLS	4
+#define BAD_ADDR	((u64)-1)
+
+struct ft_bus {
+	u64	(*map)(u32 *addr, u32 *range, int na, int ns, int pna);
+	int	(*translate)(u32 *addr, u64 offset, int na);
+};
+
+static u32 ft_find_cells(char *path, char *prop)
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
+		ft_parentize(p, 0);
+	} while (strlen(p) > 0);
+	return 1; /* default of 1 */
+}
+
+static u64 ft_read_addr(u32 *cell, int size)
+{
+	u64 r = 0;
+	while (size--)
+		r = (r << 32) | *(cell++);
+	return r;
+}
+
+static u64 ft_bus_default_map(u32 *addr, u32 *range, int na, int ns, int pna)
+{
+	u64 cp, s, da;
+
+	cp = ft_read_addr(range, na);
+	s  = ft_read_addr(range + na + pna, ns);
+	da = ft_read_addr(addr, na);
+
+	if (da < cp || da >= (cp + s))
+		return BAD_ADDR;
+	return da - cp;
+}
+
+static int ft_bus_default_translate(u32 *addr, u64 offset, int na)
+{
+	u64 a = ft_read_addr(addr, na);
+	memset(addr, 0, na * 4);
+	a += offset;
+	if (na > 1)
+		addr[na - 2] = a >> 32;
+	addr[na - 1] = a & 0xffffffffu;
+
+	return 0;
+}
+
+static u64 ft_bus_pci_map(u32 *addr, u32 *range, int na, int ns, int pna)
+{
+	u64 cp, s, da;
+
+	/* Check address type match */
+	if ((addr[0] ^ range[0]) & 0x03000000)
+		return BAD_ADDR;
+
+	/* Read address values, skipping high cell */
+	cp = ft_read_addr(range + 1, na - 1);
+	s  = ft_read_addr(range + na + pna, ns);
+	da = ft_read_addr(addr + 1, na - 1);
+
+	if (da < cp || da >= (cp + s))
+		return BAD_ADDR;
+	return da - cp;
+}
+
+static int ft_bus_pci_translate(u32 *addr, u64 offset, int na)
+{
+	return ft_bus_default_translate(addr + 1, offset, na - 1);
+}
+
+static u64 ft_bus_isa_map(u32 *addr, u32 *range, int na, int ns, int pna)
+{
+	u64 cp, s, da;
+
+	/* Check address type match */
+	if ((addr[0] ^ range[0]) & 0x00000001)
+		return BAD_ADDR;
+
+	/* Read address values, skipping high cell */
+	cp = ft_read_addr(range + 1, na - 1);
+	s  = ft_read_addr(range + na + pna, ns);
+	da = ft_read_addr(addr + 1, na - 1);
+
+	if (da < cp || da >= (cp + s))
+		return BAD_ADDR;
+	return da - cp;
+}
+
+static int ft_bus_isa_translate(u32 *addr, u64 offset, int na)
+{
+	return ft_bus_default_translate(addr + 1, offset, na - 1);
+}
+
+static void ft_match_bus(char *path, struct ft_bus *bus)
+{
+	void *devp;
+	char dtype[128]; /* XXXX */
+
+	if ((devp = finddevice(path)) && (getprop(devp, "device_type", dtype,
+					sizeof(dtype)) > 0)) {
+		if (!strcmp(dtype, "isa")) {
+			bus->map = ft_bus_isa_map;
+			bus->translate = ft_bus_isa_translate;
+		} else if (!strcmp(dtype, "pci")) {
+			bus->map = ft_bus_pci_map;
+			bus->translate = ft_bus_pci_translate;
+		} else {
+			bus->map = ft_bus_default_map;
+			bus->translate = ft_bus_default_translate;
+		}
+	}
+}
+
+static int ft_translate_one(char *path, struct ft_bus *bus, struct ft_bus *pbus,
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
+		offset = ft_read_addr(addr, na);
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
+static u64 ft_translate_addr(const char *p, const u32 *in_addr,
+		const u32 addr_len)
+{
+	struct ft_bus	bus, pbus;
+	int na, ns, pna, pns;
+	u32 addr[MAX_ADDR_CELLS];
+	char path[MAX_PATH_LEN], ppath[MAX_PATH_LEN];
+
+	strcpy(ppath, p);
+	ft_parentize(ppath, 0);
+	ft_match_bus(ppath, &bus);
+	na = ft_find_cells(ppath, "#address-cells");
+	ns = ft_find_cells(ppath, "#size-cells");
+	memcpy(addr, in_addr, na * 4);
+
+	for (;;) {
+		strcpy(path, ppath);
+		ft_parentize(ppath, 0);
+
+		if (strlen(ppath) == 0)
+			return ft_read_addr(addr, na);
+
+		ft_match_bus(ppath, &pbus);
+		pna = ft_find_cells(ppath, "#address-cells");
+		pns = ft_find_cells(ppath, "#size-cells");
+
+		if (ft_translate_one(path, &bus, &pbus, addr, na, ns, pna))
+			exit();
+
+		na = pna;
+		ns = pns;
+		memcpy(&bus, &pbus, sizeof(struct ft_bus));
+	}
+}
+
+static void *dtb;
+
+static void *ft_finddevice(const char *name)
+{
+	return ft_find_node(dtb, name);
+}
+
+static int ft_getprop(const void *node, const char *propname, void *buf,
+		const int buflen)
+{
+	return ft_get_prop(dtb, node, propname, buf, buflen);
+}
+
+static int ft_setprop(const void *node, const char *propname, const void *buf,
+		const int buflen)
+{
+	return ft_set_prop(&dtb, node, propname, buf, buflen);
+}
+
+static void ft_call_kernel(void *entry_addr, unsigned long a1, unsigned long a2,
+		void *promptr, void *sp)
+{
+	void (*kernel_entry)(void *dt_blob, void *start_addr,
+			void *must_be_null);
+
+#ifdef DEBUG
+	printf("kernel:\n\r"
+		"        entry addr   = 0x%lx\n\r"
+		"        flattened dt = 0x%lx\n\r",
+		(unsigned long)entry_addr, dtb);
+#endif
+
+	kernel_entry = entry_addr;
+	kernel_entry(dtb, entry_addr, NULL);
+}
+
+void ft_init(void *dt_blob)
+{
+	dt_ops.finddevice = ft_finddevice;
+	dt_ops.getprop = ft_getprop;
+	dt_ops.setprop = ft_setprop;
+	dt_ops.translate_addr = ft_translate_addr;
+	dt_ops.call_kernel = ft_call_kernel;
+
+	dtb = dt_blob;
+}
