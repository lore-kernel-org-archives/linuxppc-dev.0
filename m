Return-Path: <mgreer@mvista.com>
Date: Wed, 19 Jul 2006 16:05:44 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/6] bootwrapper: Add device tree ops for flattened device tree
Message-ID: <20060719230544.GD3887@mag.az.mvista.com>
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

This patch adds the device tree operations (dt_ops) for a flattened
device tree (fdt).

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

 Makefile |    2 
 fdt.c    |  525 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 526 insertions(+), 1 deletion(-)
--

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index c2bb541..3e767e5 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -36,7 +36,7 @@ zliblinuxheader := zlib.h zconf.h zutil.
 $(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheader))
 #$(addprefix $(obj)/,main.o): $(addprefix $(obj)/,zlib.h)
 
-src-boot := crt0.S string.S stdio.c main.c div64.S
+src-boot := crt0.S string.S stdio.c main.c div64.S fdt.c
 ifeq ($(CONFIG_PPC_MULTIPLATFORM),y)
 src-boot += of.c
 endif
diff --git a/arch/powerpc/boot/fdt.c b/arch/powerpc/boot/fdt.c
new file mode 100644
index 0000000..ad7e7d5
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
+fdt_init(void *dt_blob)
+{
+	struct boot_param_header *bph;
+
+	fdt_dt_ops.finddevice = fdt_finddevice;
+	fdt_dt_ops.getprop = fdt_getprop;
+	fdt_dt_ops.setprop = fdt_setprop;
+	fdt_dt_ops.translate_addr = fdt_translate_addr;
+	fdt_dt_ops.call_kernel = fdt_call_kernel;
+
+	dtb_start = dt_blob;
+	bph = fdt_get_bph(dtb_start);
+	dtb_end = (void *)((u32)dtb_start + bph->totalsize);
+
+	return &fdt_dt_ops;
+}
