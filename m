Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AB2D967C20
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 14:14:40 +1100 (EST)
Date: Tue, 12 Dec 2006 12:14:34 +0900 (JST)
Message-Id: <200612120314.kBC3EZqp026763@toshiba.co.jp>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 2/15] powerpc, celleb: Basic supports for Celleb
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds base support for Celleb platform.

Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/Kconfig
diff -u linux-powerpc-git/arch/powerpc/Kconfig:1.1.1.1 linux-powerpc-git/arch/powerpc/Kconfig:1.3
--- linux-powerpc-git/arch/powerpc/Kconfig:1.1.1.1	Wed Dec  6 08:25:42 2006
+++ linux-powerpc-git/arch/powerpc/Kconfig	Mon Dec 11 15:30:41 2006
@@ -518,6 +518,13 @@
 	  This option enables support for the Sony PS3 game console
 	  and other platforms using the PS3 hypervisor.
 
+config PPC_CELLEB
+	bool "Toshiba's Cell Reference Set 'Celleb' Architecture"
+	depends on PPC_MULTIPLATFORM && PPC64
+	select PPC_CELL
+	select PPC_OF_PLATFORM_PCI
+	select HAS_TXX9_SERIAL
+
 config PPC_NATIVE
 	bool
 	depends on PPC_MULTIPLATFORM
Index: linux-powerpc-git/arch/powerpc/Kconfig.debug
diff -u linux-powerpc-git/arch/powerpc/Kconfig.debug:1.1.1.1 linux-powerpc-git/arch/powerpc/Kconfig.debug:1.2
--- linux-powerpc-git/arch/powerpc/Kconfig.debug:1.1.1.1	Wed Dec  6 08:25:42 2006
+++ linux-powerpc-git/arch/powerpc/Kconfig.debug	Wed Dec  6 08:43:14 2006
@@ -185,6 +185,12 @@
 	  Select this to enable early debugging for legacy iSeries. You need
 	  to hit "Ctrl-x Ctrl-x" to see the messages on the console.
 
+config PPC_EARLY_DEBUG_BEAT
+	bool "Beat HV Console"
+	depends on PPC_CELLEB
+	help
+	  Select this to enable early debugging for Celleb with Beat.
+
 endchoice
 
 endmenu
Index: linux-powerpc-git/arch/powerpc/boot/Makefile
diff -u linux-powerpc-git/arch/powerpc/boot/Makefile:1.1.1.1 linux-powerpc-git/arch/powerpc/boot/Makefile:1.2
--- linux-powerpc-git/arch/powerpc/boot/Makefile:1.1.1.1	Wed Dec  6 08:25:43 2006
+++ linux-powerpc-git/arch/powerpc/boot/Makefile	Wed Dec  6 08:43:14 2006
@@ -159,6 +159,7 @@
 image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
 image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
 image-$(CONFIG_PPC_PS3)			+= zImage.ps3
+image-$(CONFIG_PPC_CELLEB)		+= zImage.pseries
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
Index: linux-powerpc-git/arch/powerpc/kernel/udbg.c
diff -u linux-powerpc-git/arch/powerpc/kernel/udbg.c:1.1.1.1 linux-powerpc-git/arch/powerpc/kernel/udbg.c:1.2
--- linux-powerpc-git/arch/powerpc/kernel/udbg.c:1.1.1.1	Wed Dec  6 08:25:43 2006
+++ linux-powerpc-git/arch/powerpc/kernel/udbg.c	Wed Dec  6 08:43:15 2006
@@ -45,6 +45,8 @@
 #elif defined(CONFIG_PPC_EARLY_DEBUG_ISERIES)
 	/* For iSeries - hit Ctrl-x Ctrl-x to see the output */
 	udbg_init_iseries();
+#elif defined(CONFIG_PPC_EARLY_DEBUG_BEAT)
+	udbg_init_debug_beat();
 #endif
 }
 
Index: linux-powerpc-git/arch/powerpc/platforms/Makefile
diff -u linux-powerpc-git/arch/powerpc/platforms/Makefile:1.1.1.1 linux-powerpc-git/arch/powerpc/platforms/Makefile:1.2
--- linux-powerpc-git/arch/powerpc/platforms/Makefile:1.1.1.1	Wed Dec  6 08:25:43 2006
+++ linux-powerpc-git/arch/powerpc/platforms/Makefile	Wed Dec  6 08:43:15 2006
@@ -17,4 +17,5 @@
 obj-$(CONFIG_PPC_PASEMI)	+= pasemi/
 obj-$(CONFIG_PPC_CELL)		+= cell/
 obj-$(CONFIG_PPC_PS3)		+= ps3/
+obj-$(CONFIG_PPC_CELLEB)	+= celleb/
 obj-$(CONFIG_EMBEDDED6xx)	+= embedded6xx/
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile:1.3
--- /dev/null	Mon Dec 11 20:37:31 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile	Mon Dec 11 18:11:35 2006
@@ -0,0 +1,10 @@
+obj-$(CONFIG_PPC_CELLEB)		+= interrupt.o iommu.o setup.o \
+					   lpar.o beat.o pci.o \
+					   scc_epci.o scc_uhc.o
+
+ifeq ($(CONFIG_SMP),y)
+obj-$(CONFIG_PPC_CELLEB)		+= smp.o
+endif
+
+spu-priv1-$(CONFIG_PPC_CELLEB)		+= spu_priv1.o spu_manage.o
+obj-$(CONFIG_SPU_BASE)			+= $(spu-priv1-y)
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/beat.c
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/beat.c:1.2
--- /dev/null	Mon Dec 11 20:37:31 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/beat.c	Thu Dec  7 19:37:12 2006
@@ -0,0 +1,162 @@
+/*
+ * Simple routines for Celleb/Beat
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/rtc.h>
+#include <asm/hvconsole.h>
+#include <asm/time.h>
+
+#include "beat.h"
+
+int64_t	beat_errno;
+
+void beat_restart(char *cmd)
+{
+	beat_shutdown_logical_partition(1);
+}
+
+void beat_power_off(void)
+{
+	beat_shutdown_logical_partition(0);
+}
+
+u64 beat_halt_code = 0x1000000000000000UL;
+
+void beat_halt(void)
+{
+	beat_shutdown_logical_partition(beat_halt_code);
+}
+
+int beat_set_rtc_time(struct rtc_time *rtc_time)
+{
+	u64 tim;
+	tim = mktime(rtc_time->tm_year+1900,
+		     rtc_time->tm_mon+1, rtc_time->tm_mday,
+		     rtc_time->tm_hour, rtc_time->tm_min, rtc_time->tm_sec);
+	if (beat_rtc_write(tim))
+		return -1;
+	return 0;
+}
+
+void beat_get_rtc_time(struct rtc_time *rtc_time)
+{
+	u64 tim;
+
+	if (beat_rtc_read(&tim))
+		tim = 0;
+	to_tm(tim, rtc_time);
+	rtc_time->tm_year -= 1900;
+	rtc_time->tm_mon -= 1;
+}
+
+#define	BEAT_NVRAM_SIZE	4096
+#define	BEAT_NVRW_CNT	(sizeof(u64) * 6)
+
+ssize_t beat_nvram_read(char *buf, size_t count, loff_t *index)
+{
+	unsigned int i;
+	unsigned long len;
+	char *p = buf;
+
+	if (*index >= BEAT_NVRAM_SIZE)
+		return -ENODEV;
+	i = *index;
+	if (i + count > BEAT_NVRAM_SIZE)
+		count = BEAT_NVRAM_SIZE - i;
+
+	for (; count != 0; count -= len) {
+		u64 nb[6];
+
+		len = count;
+		if (len > BEAT_NVRW_CNT)
+			len = BEAT_NVRW_CNT;
+		if (beat_eeprom_read(i, len,
+			nb+0, nb+1, nb+2, nb+3, nb+4, nb+5)) {
+			return -EIO;
+		}
+
+		memcpy(p, nb, len);
+
+		p += len;
+		i += len;
+	}
+	*index = i;
+	return p - buf;
+}
+
+ssize_t beat_nvram_write(char *buf, size_t count, loff_t *index)
+{
+	unsigned int i;
+	unsigned long len;
+	char *p = buf;
+
+	if (*index >= BEAT_NVRAM_SIZE)
+		return -ENODEV;
+	i = *index;
+	if (i + count > BEAT_NVRAM_SIZE)
+		count = BEAT_NVRAM_SIZE - i;
+
+	for (; count != 0; count -= len) {
+		u64 nb[6];
+
+		len = count;
+		if (len > BEAT_NVRW_CNT)
+			len = BEAT_NVRW_CNT;
+		memcpy(nb, p, len);
+		if (beat_eeprom_write(i, len,
+			nb[0], nb[1], nb[2], nb[3], nb[4], nb[5])) {
+			return -EIO;
+		}
+
+		p += len;
+		i += len;
+	}
+	*index = i;
+	return p - buf;
+}
+
+ssize_t beat_nvram_get_size(void)
+{
+	return BEAT_NVRAM_SIZE;
+}
+
+int beat_set_xdabr(unsigned long dabr)
+{
+	if (beat_set_dabr(dabr, DABRX_KERNEL | DABRX_USER))
+		return -1;
+	return 0;
+}
+
+int64_t beat_get_term_char(u64 vterm, u64 *len, u64 *t1, u64 *t2)
+{
+	return beat_get_characters_from_console(vterm, len, t1, t2);
+}
+
+int64_t beat_put_term_char(u64 vterm, u64 len, u64 t1, u64 t2)
+{
+	return beat_put_characters_to_console(vterm, len, t1, t2);
+}
+
+EXPORT_SYMBOL(beat_get_term_char);
+EXPORT_SYMBOL(beat_put_term_char);
+EXPORT_SYMBOL(beat_errno);
+EXPORT_SYMBOL(beat_halt_code);
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/beat.h
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/beat.h:1.1
--- /dev/null	Mon Dec 11 20:37:31 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/beat.h	Wed Dec  6 08:43:15 2006
@@ -0,0 +1,41 @@
+/*
+ * Guest OS Interfaces.
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef _CELLEB_BEAT_H
+#define _CELLEB_BEAT_H
+#include "beat_sys.h"
+
+#define DABRX_KERNEL		(1UL<<1)
+#define DABRX_USER		(1UL<<0)
+
+int64_t beat_get_term_char(uint64_t,uint64_t*,uint64_t*,uint64_t*);
+int64_t beat_put_term_char(uint64_t,uint64_t,uint64_t,uint64_t);
+int64_t beat_repository_encode(int, const char *, uint64_t[4]);
+void beat_restart(char *);
+void beat_power_off(void);
+void beat_halt(void);
+int beat_set_rtc_time(struct rtc_time *);
+void beat_get_rtc_time(struct rtc_time *);
+ssize_t beat_nvram_get_size(void);
+ssize_t beat_nvram_read(char *, size_t, loff_t *);
+ssize_t beat_nvram_write(char *, size_t, loff_t *);
+int beat_set_xdabr(unsigned long);
+
+#endif /* _CELLEB_BEAT_H */
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/lpar.c
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/lpar.c:1.2
--- /dev/null	Mon Dec 11 20:37:31 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/lpar.c	Mon Dec 11 15:50:31 2006
@@ -0,0 +1,426 @@
+/*
+ * "Cell Reference Set" LPAR support.
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
+ *
+ * This code is based on arch/powerpc/platforms/pseries/lpar.c:
+ * Copyright (C) 2001 Todd Inglett, IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#undef DEBUG_LOW
+
+#include <linux/kernel.h>
+#include <linux/dma-mapping.h>
+#include <linux/console.h>
+#include <asm/processor.h>
+#include <asm/mmu.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/machdep.h>
+#include <asm/abs_addr.h>
+#include <asm/mmu_context.h>
+#include <asm/iommu.h>
+#include <asm/tlbflush.h>
+#include <asm/tlb.h>
+#include <asm/prom.h>
+#include <asm/abs_addr.h>
+#include <asm/cputable.h>
+#include <asm/udbg.h>
+#include <asm/smp.h>
+
+#include "beat.h"
+
+int	celleb_vtermno;
+
+#ifdef DEBUG_LOW
+#define DBG_LOW(fmt...) do { udbg_printf(fmt); } while(0)
+#else
+#define DBG_LOW(fmt...) do { } while(0)
+#endif
+
+static void udbg_putc_beat(char c)
+{
+	unsigned long rc;
+
+	if (c == '\n')
+		udbg_putc_beat('\r');
+
+	rc = beat_put_term_char(celleb_vtermno, 1, (uint64_t)c << 56, 0);
+}
+
+/* Buffered chars getc */
+static long inbuflen;
+static long inbuf[2];	/* must be 2 longs */
+
+static int udbg_getc_poll_beat(void)
+{
+	/* The interface is tricky because it may return up to 16 chars.
+	 * We save them statically for future calls to udbg_getc().
+	 */
+	char ch, *buf = (char *)inbuf;
+	int i;
+	long rc;
+	if (inbuflen == 0) {
+		/* get some more chars. */
+		inbuflen = 0;
+		rc = beat_get_term_char(celleb_vtermno, &inbuflen, inbuf+0, inbuf+1);
+		if (rc != 0)
+			inbuflen = 0;	/* otherwise inbuflen is garbage */
+	}
+	if (inbuflen <= 0 || inbuflen > 16) {
+		/* Catch error case as well as other oddities (corruption) */
+		inbuflen = 0;
+		return -1;
+	}
+	ch = buf[0];
+	for (i = 1; i < inbuflen; i++)	/* shuffle them down. */
+		buf[i-1] = buf[i];
+	inbuflen--;
+	return ch;
+}
+
+static int udbg_getc_beat(void)
+{
+	int ch;
+	for (;;) {
+		ch = udbg_getc_poll_beat();
+		if (ch == -1) {
+			/* This shouldn't be needed...but... */
+			volatile unsigned long delay;
+			for (delay=0; delay < 2000000; delay++)
+				;
+		} else {
+			return ch;
+		}
+	}
+}
+
+/* call this from early_init() for a working debug console on
+ * vterm capable LPAR machines
+ */
+void __init udbg_init_debug_beat(void)
+{
+	celleb_vtermno = 0;
+	udbg_putc = udbg_putc_beat;
+	udbg_getc = udbg_getc_beat;
+	udbg_getc_poll = udbg_getc_poll_beat;
+}
+
+#if 0
+/* returns 0 if couldn't find or use /chosen/stdout as console */
+void __init celleb_find_udbg_vterm(void)
+{
+	struct device_node *stdout_node;
+	const u32 *termno;
+	const char *name;
+	int add_console;
+
+	/* find the boot console from /chosen/stdout */
+	if (!of_chosen)
+		return;
+	name = get_property(of_chosen, "linux,stdout-path", NULL);
+	if (name == NULL)
+		return;
+	stdout_node = of_find_node_by_path(name);
+	if (!stdout_node)
+		return;
+	name = get_property(stdout_node, "name", NULL);
+	if (!name) {
+		printk(KERN_WARNING "stdout node missing 'name' property!\n");
+		goto out;
+	}
+	/* The user has requested a console so this is already set up. */
+	add_console = !strstr(cmd_line, "console=");
+
+	/* Check if it's a virtual terminal */
+	if (strncmp(name, "vty", 3) != 0)
+		goto out;
+	termno = get_property(stdout_node, "reg", NULL);
+	if (termno == NULL)
+		goto out;
+	celleb_vtermno = termno[0];
+
+	if (device_is_compatible(stdout_node, "hvterm1")) {
+		udbg_putc = udbg_putc_beat;
+		udbg_getc = udbg_getc_beat;
+		udbg_getc_poll = udbg_getc_poll_beat;
+		if (add_console)
+			add_preferred_console("hvc", termno[0] & 0xff, NULL);
+	}
+out:
+	of_node_put(stdout_node);
+}
+#endif
+
+static inline unsigned int beat_read_mask(unsigned hpte_group)
+{
+	unsigned long hpte_v0, hpte_v1, hpte_v2, hpte_v3, hpte_perms;
+	unsigned long rmask = 0;
+
+	beat_read_htab_entries(0, hpte_group + 0,
+		&hpte_v0, &hpte_v1, &hpte_v2, &hpte_v3, &hpte_perms);
+	if (!(hpte_v0 & HPTE_V_BOLTED))
+		rmask |= 0x8000;
+	if (!(hpte_v1 & HPTE_V_BOLTED))
+		rmask |= 0x4000;
+	if (!(hpte_v2 & HPTE_V_BOLTED))
+		rmask |= 0x2000;
+	if (!(hpte_v3 & HPTE_V_BOLTED))
+		rmask |= 0x1000;
+	beat_read_htab_entries(0, hpte_group + 4,
+		&hpte_v0, &hpte_v1, &hpte_v2, &hpte_v3, &hpte_perms);
+	if (!(hpte_v0 & HPTE_V_BOLTED))
+		rmask |= 0x0800;
+	if (!(hpte_v1 & HPTE_V_BOLTED))
+		rmask |= 0x0400;
+	if (!(hpte_v2 & HPTE_V_BOLTED))
+		rmask |= 0x0200;
+	if (!(hpte_v3 & HPTE_V_BOLTED))
+		rmask |= 0x0100;
+	hpte_group = ~hpte_group & (htab_hash_mask * HPTES_PER_GROUP);
+	beat_read_htab_entries(0, hpte_group + 0,
+		&hpte_v0, &hpte_v1, &hpte_v2, &hpte_v3, &hpte_perms);
+	if (!(hpte_v0 & HPTE_V_BOLTED))
+		rmask |= 0x80;
+	if (!(hpte_v1 & HPTE_V_BOLTED))
+		rmask |= 0x40;
+	if (!(hpte_v2 & HPTE_V_BOLTED))
+		rmask |= 0x20;
+	if (!(hpte_v3 & HPTE_V_BOLTED))
+		rmask |= 0x10;
+	beat_read_htab_entries(0, hpte_group + 4,
+		&hpte_v0, &hpte_v1, &hpte_v2, &hpte_v3, &hpte_perms);
+	if (!(hpte_v0 & HPTE_V_BOLTED))
+		rmask |= 0x08;
+	if (!(hpte_v1 & HPTE_V_BOLTED))
+		rmask |= 0x04;
+	if (!(hpte_v2 & HPTE_V_BOLTED))
+		rmask |= 0x02;
+	if (!(hpte_v3 & HPTE_V_BOLTED))
+		rmask |= 0x01;
+	return rmask;
+}
+
+static long beat_lpar_hpte_insert(unsigned long hpte_group,
+				  unsigned long va, unsigned long pa,
+				  unsigned long rflags, unsigned long vflags,
+				  int psize)
+{
+	unsigned long lpar_rc;
+	unsigned long slot;
+	unsigned long hpte_v, hpte_r;
+	unsigned long dummy0, dummy1;
+
+	/* same as iseries */
+	if (vflags & HPTE_V_SECONDARY)
+		return -1;
+
+	if (!(vflags & HPTE_V_BOLTED))
+		DBG_LOW("hpte_insert(group=%lx, va=%016lx, pa=%016lx, "
+			"rflags=%lx, vflags=%lx, psize=%d)\n",
+		hpte_group, va, pa, rflags, vflags, psize);
+
+	hpte_v = hpte_encode_v(va, psize) | vflags | HPTE_V_VALID;
+	hpte_r = hpte_encode_r(pa, psize) | rflags;
+
+	if (!(vflags & HPTE_V_BOLTED))
+		DBG_LOW(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
+
+	if (rflags & (_PAGE_GUARDED|_PAGE_NO_CACHE))
+		hpte_r &= ~_PAGE_COHERENT;
+
+	if ((lpar_rc = beat_read_mask(hpte_group)) == 0) {
+		if (!(vflags & HPTE_V_BOLTED))
+			DBG_LOW(" full\n");
+		return -1;
+	}
+
+	lpar_rc = beat_insert_htab_entry(0, hpte_group, lpar_rc << 48,
+		hpte_v, hpte_r, &slot, &dummy0, &dummy1);
+
+	/*
+	 * Since we try and ioremap PHBs we don't own, the pte insert
+	 * will fail. However we must catch the failure in hash_page
+	 * or we will loop forever, so return -2 in this case.
+	 */
+	if (unlikely(lpar_rc != 0)) {
+		if (!(vflags & HPTE_V_BOLTED))
+			DBG_LOW(" lpar err %lx\n", lpar_rc);
+		return -2;
+	}
+	if (!(vflags & HPTE_V_BOLTED))
+		DBG_LOW(" -> slot: %lx\n", slot);
+
+	/* We have to pass down the secondary bucket bit here as well */
+	return (slot ^ hpte_group) & 15;
+}
+
+static long beat_lpar_hpte_remove(unsigned long hpte_group)
+{
+	DBG_LOW("hpte_remove(group=%lx)\n", hpte_group);
+	return -1;
+}
+
+static unsigned long beat_lpar_hpte_getword0(unsigned long slot)
+{
+	unsigned long dword0, dword[4], dwordX;
+	unsigned long lpar_rc;
+
+	lpar_rc = beat_read_htab_entries(0, slot & ~3UL,
+		dword+0, dword+1, dword+2, dword+3, &dwordX);
+
+	dword0 = dword[slot&3];
+
+	BUG_ON(lpar_rc != 0);
+
+	return dword0;
+}
+
+static void beat_lpar_hptab_clear(void)
+{
+	unsigned long size_bytes = 1UL << ppc64_pft_size;
+	unsigned long hpte_count = size_bytes >> 4;
+	unsigned long dummy1, dummy2;
+	int i;
+
+	/* TODO: Use bulk call */
+	for (i = 0; i < hpte_count; i++)
+		beat_write_htab_entry(0, i, 0, 0, -1UL, -1UL, &dummy1, &dummy2);
+}
+
+/*
+ * NOTE: for updatepp ops we are fortunate that the linux "newpp" bits and
+ * the low 3 bits of flags happen to line up.  So no transform is needed.
+ * We can probably optimize here and assume the high bits of newpp are
+ * already zero.  For now I am paranoid.
+ */
+static long beat_lpar_hpte_updatepp(unsigned long slot,
+				    unsigned long newpp,
+				    unsigned long va,
+				    int psize, int local)
+{
+	unsigned long lpar_rc;
+	unsigned long dummy0, dummy1, want_v;
+
+	want_v = hpte_encode_v(va, psize);
+
+	DBG_LOW("    update: avpnv=%016lx, slot=%016lx, psize: %d, newpp %016lx ... ",
+		want_v & HPTE_V_AVPN, slot, psize, newpp);
+
+	dummy0 = beat_lpar_hpte_getword0(slot);
+	if ((dummy0 & ~0x7FUL) != (want_v & ~0x7FUL)) {
+		DBG_LOW("not found !\n");
+		return -1;
+	}
+
+	lpar_rc = beat_write_htab_entry(0, slot, 0, newpp, 0, 7,
+		&dummy0, &dummy1);
+
+	if (lpar_rc != 0 || dummy0 == 0) {
+		DBG_LOW("not found !\n");
+		return -1;
+	}
+
+	DBG_LOW("ok %lx %lx\n", dummy0, dummy1);
+
+	BUG_ON(lpar_rc != 0);
+
+	return 0;
+}
+
+static long beat_lpar_hpte_find(unsigned long va, int psize)
+{
+	unsigned long hash;
+	unsigned long i, j;
+	long slot;
+	unsigned long want_v, hpte_v;
+
+	hash = hpt_hash(va, mmu_psize_defs[psize].shift);
+	want_v = hpte_encode_v(va, psize);
+
+	for (j = 0; j < 2; j++) {
+		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+		for (i = 0; i < HPTES_PER_GROUP; i++) {
+			hpte_v = beat_lpar_hpte_getword0(slot);
+
+			if (HPTE_V_COMPARE(hpte_v, want_v)
+			    && (hpte_v & HPTE_V_VALID)
+			    && (!!(hpte_v & HPTE_V_SECONDARY) == j)) {
+				/* HPTE matches */
+				if (j)
+					slot = -slot;
+				return slot;
+			}
+			++slot;
+		}
+		hash = ~hash;
+	}
+
+	return -1;
+}
+
+static void beat_lpar_hpte_updateboltedpp(unsigned long newpp,
+					  unsigned long ea,
+					  int psize)
+{
+	unsigned long lpar_rc, slot, vsid, va, dummy0, dummy1;
+
+	vsid = get_kernel_vsid(ea);
+	va = (vsid << 28) | (ea & 0x0fffffff);
+
+	slot = beat_lpar_hpte_find(va, psize);
+	BUG_ON(slot == -1);
+
+	lpar_rc = beat_write_htab_entry(0, slot, 0, newpp, 0, 7,
+		&dummy0, &dummy1);
+
+	BUG_ON(lpar_rc != 0);
+}
+
+static void beat_lpar_hpte_invalidate(unsigned long slot, unsigned long va,
+					 int psize, int local)
+{
+	unsigned long want_v;
+	unsigned long lpar_rc;
+	unsigned long dummy1, dummy2;
+
+	DBG_LOW("    inval : slot=%lx, va=%016lx, psize: %d, local: %d\n",
+		slot, va, psize, local);
+	want_v = hpte_encode_v(va, psize);
+
+	dummy1 = beat_lpar_hpte_getword0(slot);
+
+	if ((dummy1 & ~0x7FUL) != (want_v & ~0x7FUL)) {
+		DBG_LOW("not found !\n");
+		return;
+	}
+
+	lpar_rc = beat_write_htab_entry(0, slot, 0, 0, HPTE_V_VALID, 0,
+		&dummy1, &dummy2);
+
+	BUG_ON(lpar_rc != 0);
+}
+
+void __init hpte_init_beat(void)
+{
+	ppc_md.hpte_invalidate	= beat_lpar_hpte_invalidate;
+	ppc_md.hpte_updatepp	= beat_lpar_hpte_updatepp;
+	ppc_md.hpte_updateboltedpp = beat_lpar_hpte_updateboltedpp;
+	ppc_md.hpte_insert	= beat_lpar_hpte_insert;
+	ppc_md.hpte_remove	= beat_lpar_hpte_remove;
+	ppc_md.hpte_clear_all	= beat_lpar_hptab_clear;
+}
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c:1.3
--- /dev/null	Mon Dec 11 20:37:31 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c	Mon Dec 11 19:55:10 2006
@@ -0,0 +1,314 @@
+/*
+ * Celleb setup code
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
+ *
+ * This code is based on arch/powerpc/platforms/cell/setup.c:
+ *  Copyright (C) 1995  Linus Torvalds
+ *  Adapted from 'alpha' version by Gary Thomas
+ *  Modified by Cort Dougan (cort@cs.nmt.edu)
+ *  Modified by PPC64 Team, IBM Corp
+ *  Modified by Cell Team, IBM Deutschland Entwicklung GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#undef DEBUG
+
+#include <linux/cpu.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/console.h>
+
+#include <asm/mmu.h>
+#include <asm/processor.h>
+#include <asm/io.h>
+#include <asm/kexec.h>
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+#include <asm/iommu.h>
+#include <asm/machdep.h>
+#include <asm/cputable.h>
+#include <asm/irq.h>
+#include <asm/spu_priv1.h>
+#include <asm/firmware.h>
+#include <asm/of_platform.h>
+
+#include "interrupt.h"
+#include "beat.h"
+
+#ifdef CONFIG_SERIAL_TXX9
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#endif
+
+#ifdef DEBUG
+#define DBG(fmt...) udbg_printf(fmt)
+#else
+#define DBG(fmt...)
+#endif
+
+static void celleb_show_cpuinfo(struct seq_file *m)
+{
+	struct device_node *root;
+	const char *model = "";
+
+	root = of_find_node_by_path("/");
+	if (root)
+		model = get_property(root, "model", NULL);
+	seq_printf(m, "machine\t\t: CHRP %s\n", model);
+	of_node_put(root);
+}
+
+static void celleb_progress(char *s, unsigned short hex)
+{
+	printk("*** %04x : %s\n", hex, s ? s : "");
+}
+
+static void __init celleb_setup_arch(void)
+{
+	ppc_md.init_IRQ = beatic_init_IRQ;
+	ppc_md.get_irq = beatic_get_irq;
+#ifdef CONFIG_SPU_BASE
+	spu_priv1_ops = &spu_priv1_beat_ops;
+	spu_management_ops = &spu_management_beat_ops;
+#endif
+
+#ifdef CONFIG_SMP
+	smp_init_celleb();
+#endif
+
+	/* init to some ~sane value until calibrate_delay() runs */
+	loops_per_jiffy = 50000000;
+
+	if (ROOT_DEV == 0) {
+		printk("No ramdisk, default root is /dev/hda2\n");
+		ROOT_DEV = Root_HDA2;
+	}
+
+#ifdef CONFIG_DUMMY_CONSOLE
+	conswitchp = &dummy_con;
+#endif
+}
+
+/*
+ * Early initialization.  Relocation is on but do not reference unbolted pages
+ */
+static void __init celleb_init_early(void)
+{
+	DBG(" -> celleb_init_early()\n");
+
+	celleb_init_iommu();
+
+	DBG(" <- celleb_init_early()\n");
+}
+
+static void beat_power_save(void)
+{
+	beat_pause(0);
+}
+
+static int __init celleb_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "Beat"))
+		return 0;
+
+	powerpc_firmware_features |= FW_FEATURE_LPAR;
+	hpte_init_beat();
+	return 1;
+}
+
+/*
+ * Cell has no legacy IO; anything calling this function has to
+ * fail or bad things will happen
+ */
+static int celleb_check_legacy_ioport(unsigned int baseport)
+{
+	return -ENODEV;
+}
+
+static int celleb_pci_probe_mode(struct pci_bus *bus){
+
+	struct device_node *node;
+	const char *name;
+
+	node = (struct device_node *)bus->sysdata;
+	name = get_property(node, "name", NULL);
+
+	if (strcmp(name, "pci-pseudo") == 0)
+		return PCI_PROBE_DEVTREE;
+
+	return PCI_PROBE_NORMAL;
+}
+
+static void celleb_kexec_cpu_down(int crash, int secondary)
+{
+	extern void	beatic_deinit_IRQ(void);
+
+	beatic_deinit_IRQ();
+}
+
+#ifdef CONFIG_SERIAL_TXX9
+/* sio irq0=0xb00010022 irq0=0xb00010023 irq2=0xb00010024
+    mmio=0xfff000-0x1000,0xff2000-0x1000 */
+static int txx9_serial_bitmap = 0;
+
+static struct {
+	uint32_t offset;
+	uint32_t index;
+} txx9_spider_tab[3] = {
+	{ 0x300, 0 },	/* 0xFFF300 */
+	{ 0x400, 0 },	/* 0xFFF400 */
+	{ 0x800, 1 }	/* 0xFF2800 */
+};
+
+static int txx9_serial_init(void)
+{
+	extern int early_serial_txx9_setup(struct uart_port *port);
+	struct device_node *node;
+	const uint64_t *irq_prop, *base_prop;
+	int irq_len, base_addr_len;
+	int i, maxi;
+	struct uart_port req;
+
+	node = of_find_node_by_path("/ioif1/sio");
+	if (!node)
+		return 0;
+
+	irq_prop = get_property(node, "interrupts", &irq_len);
+	if (!irq_prop)
+		goto out;
+	irq_len /= sizeof(uint64_t);
+
+	base_prop = get_property(node, "toshiba,reg", &base_addr_len);
+	if (!base_prop)
+		goto out;
+	base_addr_len /= sizeof(uint64_t) * 2;
+
+	maxi = sizeof(txx9_spider_tab)/sizeof(txx9_spider_tab[0]);
+	if (maxi > irq_len)
+		maxi = irq_len;
+
+	for(i = 0; i < maxi; i++) {
+		if (!(txx9_serial_bitmap & (1<<i)))
+			continue;
+		if (base_addr_len <= txx9_spider_tab[i].index)
+			continue;
+
+		memset(&req, 0, sizeof(req));
+		req.line = i;
+		req.iotype = UPIO_MEM;
+		req.mapbase = base_prop[txx9_spider_tab[i].index * 2]
+			+ txx9_spider_tab[i].offset;
+#ifdef CONFIG_SERIAL_TXX9_CONSOLE
+		req.membase = ioremap(req.mapbase, 0x24);
+#endif
+		req.irq = irq_create_mapping(NULL, irq_prop[i]);
+		req.flags |= UPF_IOREMAP | UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
+		req.uartclk = 83300000;
+		early_serial_txx9_setup(&req);
+	}
+
+out:
+	of_node_put(node);
+	return 0;
+}
+
+static int txx9_serial_config(char *ptr)
+{
+	int	i;
+
+	for (;;) {
+		switch(get_option(&ptr, &i)) {
+		default:
+			return 0;
+		case 2:
+			txx9_serial_bitmap |= 1 << i;
+			break;
+		case 1:
+			txx9_serial_bitmap |= 1 << i;
+			return 0;
+		}
+	}
+}
+__setup("txx9_serial=", txx9_serial_config);
+
+console_initcall(txx9_serial_init);
+#endif
+
+#if 1
+static struct of_device_id celleb_bus_ids[] = {
+	{ .type = "spider", },
+	{ .type = "ioif", },	/* old style */
+	{},
+};
+
+static int __init celleb_publish_devices(void)
+{
+	if (!machine_is(celleb))
+		return 0;
+
+	/* Publish OF platform devices for southbridge IOs */
+	of_platform_bus_probe(NULL, celleb_bus_ids, NULL);
+
+	return 0;
+}
+device_initcall(celleb_publish_devices);
+#endif
+
+extern int celleb_setup_phb(struct pci_controller *phb);
+extern void celleb_pcibios_fixup(void);
+
+define_machine(celleb) {
+	.name			= "Cell Reference Set",
+	.probe			= celleb_probe,
+	.setup_arch		= celleb_setup_arch,
+	.init_early		= celleb_init_early,
+	.show_cpuinfo		= celleb_show_cpuinfo,
+	.pci_probe_mode 	= celleb_pci_probe_mode,
+	.restart		= beat_restart,
+	.power_off		= beat_power_off,
+	.halt			= beat_halt,
+	.get_rtc_time		= beat_get_rtc_time,
+	.set_rtc_time		= beat_set_rtc_time,
+	.calibrate_decr		= generic_calibrate_decr,
+	.check_legacy_ioport	= celleb_check_legacy_ioport,
+	.progress		= celleb_progress,
+	.power_save		= beat_power_save,
+	.nvram_size		= beat_nvram_get_size,
+	.nvram_read		= beat_nvram_read,
+	.nvram_write		= beat_nvram_write,
+	.set_dabr		= beat_set_xdabr,
+	.pci_setup_phb		= celleb_setup_phb,
+	.pcibios_fixup		= celleb_pcibios_fixup,
+#ifdef CONFIG_KEXEC
+	.kexec_cpu_down		= celleb_kexec_cpu_down,
+	.machine_kexec		= default_machine_kexec,
+	.machine_kexec_prepare	= default_machine_kexec_prepare,
+	.machine_crash_shutdown	= default_machine_crash_shutdown,
+#endif
+};
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/smp.c
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/smp.c:1.1
--- /dev/null	Mon Dec 11 20:37:32 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/smp.c	Wed Dec  6 08:43:15 2006
@@ -0,0 +1,143 @@
+/*
+ * SMP support for Celleb platform. (Incomplete)
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
+ *
+ * This code is based on arch/powerpc/platforms/cell/smp.c:
+ * Dave Engebretsen, Peter Bergner, and
+ * Mike Corrigan {engebret|bergner|mikec}@us.ibm.com
+ * Plus various changes from other IBM teams...
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/cache.h>
+#include <linux/err.h>
+#include <linux/sysdev.h>
+#include <linux/cpu.h>
+
+#include <asm/ptrace.h>
+#include <asm/atomic.h>
+#include <asm/irq.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/smp.h>
+#include <asm/paca.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/cputable.h>
+#include <asm/firmware.h>
+#include <asm/system.h>
+#include <asm/rtas.h>
+#include <asm/udbg.h>
+
+#include "interrupt.h"
+
+#ifdef DEBUG
+#define DBG(fmt...) udbg_printf(fmt)
+#else
+#define DBG(fmt...)
+#endif
+
+/*
+ * The primary thread of each non-boot processor is recorded here before
+ * smp init.
+ */
+/* static cpumask_t of_spin_map; */
+
+/**
+ * smp_startup_cpu() - start the given cpu
+ *
+ * At boot time, there is nothing to do for primary threads which were
+ * started from Open Firmware.  For anything else, call RTAS with the
+ * appropriate start location.
+ *
+ * Returns:
+ *	0	- failure
+ *	1	- success
+ */
+static inline int __devinit smp_startup_cpu(unsigned int lcpu)
+{
+	return 0;
+}
+
+static void smp_beatic_message_pass(int target, int msg)
+{
+	unsigned int i;
+
+	if (target < NR_CPUS) {
+		beatic_cause_IPI(target, msg);
+	} else {
+		for_each_online_cpu(i) {
+			if (target == MSG_ALL_BUT_SELF
+			    && i == smp_processor_id())
+				continue;
+			beatic_cause_IPI(i, msg);
+		}
+	}
+}
+
+static int __init smp_beatic_probe(void)
+{
+	return cpus_weight(cpu_possible_map);
+}
+
+static void __devinit smp_beatic_setup_cpu(int cpu)
+{
+	beatic_setup_cpu(cpu);
+}
+
+static void __devinit smp_celleb_kick_cpu(int nr)
+{
+	BUG_ON(nr < 0 || nr >= NR_CPUS);
+
+	if (!smp_startup_cpu(nr))
+		return;
+	/*  */
+}
+
+static int smp_celleb_cpu_bootable(unsigned int nr)
+{
+	return 1;
+}
+static struct smp_ops_t bpa_beatic_smp_ops = {
+	.message_pass	= smp_beatic_message_pass,
+	.probe		= smp_beatic_probe,
+	.kick_cpu	= smp_celleb_kick_cpu,
+	.setup_cpu	= smp_beatic_setup_cpu,
+	.cpu_bootable	= smp_celleb_cpu_bootable,
+};
+
+/* This is called very early */
+void __init smp_init_celleb(void)
+{
+	DBG(" -> smp_init_celleb()\n");
+
+	smp_ops = &bpa_beatic_smp_ops;
+
+	DBG(" <- smp_init_celleb()\n");
+}
Index: linux-powerpc-git/include/asm-powerpc/firmware.h
diff -u linux-powerpc-git/include/asm-powerpc/firmware.h:1.1.1.1 linux-powerpc-git/include/asm-powerpc/firmware.h:1.2
--- linux-powerpc-git/include/asm-powerpc/firmware.h:1.1.1.1	Wed Dec  6 08:24:04 2006
+++ linux-powerpc-git/include/asm-powerpc/firmware.h	Wed Dec  6 08:43:16 2006
@@ -61,6 +61,8 @@
 	FW_FEATURE_ISERIES_ALWAYS = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
 	FW_FEATURE_PS3_POSSIBLE = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
 	FW_FEATURE_PS3_ALWAYS = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
+	FW_FEATURE_CELLEB_POSSIBLE = FW_FEATURE_LPAR,
+	FW_FEATURE_CELLEB_ALWAYS = FW_FEATURE_LPAR,
 	FW_FEATURE_NATIVE_POSSIBLE = 0,
 	FW_FEATURE_NATIVE_ALWAYS = 0,
 	FW_FEATURE_POSSIBLE =
@@ -73,6 +75,9 @@
 #ifdef CONFIG_PPC_PS3
 		FW_FEATURE_PS3_POSSIBLE |
 #endif
+#ifdef CONFIG_PPC_CELLEB
+		FW_FEATURE_CELLEB_POSSIBLE |
+#endif
 #ifdef CONFIG_PPC_NATIVE
 		FW_FEATURE_NATIVE_ALWAYS |
 #endif
@@ -87,6 +92,9 @@
 #ifdef CONFIG_PPC_PS3
 		FW_FEATURE_PS3_ALWAYS &
 #endif
+#ifdef CONFIG_PPC_CELLEB
+		FW_FEATURE_CELLEB_ALWAYS &
+#endif
 #ifdef CONFIG_PPC_NATIVE
 		FW_FEATURE_NATIVE_ALWAYS &
 #endif
Index: linux-powerpc-git/include/asm-powerpc/mmu.h
diff -u linux-powerpc-git/include/asm-powerpc/mmu.h:1.1.1.1 linux-powerpc-git/include/asm-powerpc/mmu.h:1.2
--- linux-powerpc-git/include/asm-powerpc/mmu.h:1.1.1.1	Wed Dec  6 08:24:04 2006
+++ linux-powerpc-git/include/asm-powerpc/mmu.h	Wed Dec  6 08:43:16 2006
@@ -247,6 +247,7 @@
 extern void hpte_init_native(void);
 extern void hpte_init_lpar(void);
 extern void hpte_init_iSeries(void);
+extern void hpte_init_beat(void);
 
 extern void stabs_alloc(void);
 extern void slb_initialize(void);
Index: linux-powerpc-git/include/asm-powerpc/smp.h
diff -u linux-powerpc-git/include/asm-powerpc/smp.h:1.1.1.1 linux-powerpc-git/include/asm-powerpc/smp.h:1.2
--- linux-powerpc-git/include/asm-powerpc/smp.h:1.1.1.1	Wed Dec  6 08:24:04 2006
+++ linux-powerpc-git/include/asm-powerpc/smp.h	Wed Dec  6 08:43:16 2006
@@ -75,6 +75,7 @@
 void smp_init_iSeries(void);
 void smp_init_pSeries(void);
 void smp_init_cell(void);
+void smp_init_celleb(void);
 void smp_setup_cpu_maps(void);
 
 extern int __cpu_disable(void);
Index: linux-powerpc-git/include/asm-powerpc/udbg.h
diff -u linux-powerpc-git/include/asm-powerpc/udbg.h:1.1.1.1 linux-powerpc-git/include/asm-powerpc/udbg.h:1.2
--- linux-powerpc-git/include/asm-powerpc/udbg.h:1.1.1.1	Wed Dec  6 08:24:04 2006
+++ linux-powerpc-git/include/asm-powerpc/udbg.h	Wed Dec  6 08:43:16 2006
@@ -44,6 +44,7 @@
 extern void __init udbg_init_iseries(void);
 extern void __init udbg_init_rtas_panel(void);
 extern void __init udbg_init_rtas_console(void);
+extern void __init udbg_init_debug_beat(void);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_UDBG_H */
