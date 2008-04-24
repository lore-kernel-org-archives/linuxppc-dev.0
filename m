Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx2.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 08F19DDDF7
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 19:28:55 +1000 (EST)
Date: Thu, 24 Apr 2008 18:28:48 +0900 (JST)
Message-Id: <20080424.182848.-494095326.kouish@swc.toshiba.co.jp>
To: paulus@samba.org
Subject: [PATCH 6/9] celleb: move files for Beat mmu and iommu
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch moves files for mmu and iommu on Beat into platforms/cell/.
All files in this patch are used by celleb-beat only.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/Makefile     |    3 
 arch/powerpc/platforms/cell/beat_htab.c  |  441 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/cell/beat_iommu.c |  116 ++++++++
 arch/powerpc/platforms/celleb/Makefile   |    4 
 arch/powerpc/platforms/celleb/htab.c     |  441 -------------------------------
 arch/powerpc/platforms/celleb/iommu.c    |  116 --------
 6 files changed, 561 insertions(+), 560 deletions(-)

Index: b/arch/powerpc/platforms/cell/beat_htab.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/powerpc/platforms/cell/beat_htab.c	2008-04-23 21:38:30.000000000 +0900
@@ -0,0 +1,441 @@
+/*
+ * "Cell Reference Set" HTAB support.
+ *
+ * (C) Copyright 2006-2007 TOSHIBA CORPORATION
+ *
+ * This code is based on arch/powerpc/platforms/pseries/lpar.c:
+ *  Copyright (C) 2001 Todd Inglett, IBM Corporation
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
+#include <linux/spinlock.h>
+
+#include <asm/mmu.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/machdep.h>
+#include <asm/udbg.h>
+
+#include "beat_wrapper.h"
+
+#ifdef DEBUG_LOW
+#define DBG_LOW(fmt...) do { udbg_printf(fmt); } while (0)
+#else
+#define DBG_LOW(fmt...) do { } while (0)
+#endif
+
+static DEFINE_SPINLOCK(beat_htab_lock);
+
+static inline unsigned int beat_read_mask(unsigned hpte_group)
+{
+	unsigned long hpte_v[5];
+	unsigned long rmask = 0;
+
+	beat_read_htab_entries(0, hpte_group + 0, hpte_v);
+	if (!(hpte_v[0] & HPTE_V_BOLTED))
+		rmask |= 0x8000;
+	if (!(hpte_v[1] & HPTE_V_BOLTED))
+		rmask |= 0x4000;
+	if (!(hpte_v[2] & HPTE_V_BOLTED))
+		rmask |= 0x2000;
+	if (!(hpte_v[3] & HPTE_V_BOLTED))
+		rmask |= 0x1000;
+	beat_read_htab_entries(0, hpte_group + 4, hpte_v);
+	if (!(hpte_v[0] & HPTE_V_BOLTED))
+		rmask |= 0x0800;
+	if (!(hpte_v[1] & HPTE_V_BOLTED))
+		rmask |= 0x0400;
+	if (!(hpte_v[2] & HPTE_V_BOLTED))
+		rmask |= 0x0200;
+	if (!(hpte_v[3] & HPTE_V_BOLTED))
+		rmask |= 0x0100;
+	hpte_group = ~hpte_group & (htab_hash_mask * HPTES_PER_GROUP);
+	beat_read_htab_entries(0, hpte_group + 0, hpte_v);
+	if (!(hpte_v[0] & HPTE_V_BOLTED))
+		rmask |= 0x80;
+	if (!(hpte_v[1] & HPTE_V_BOLTED))
+		rmask |= 0x40;
+	if (!(hpte_v[2] & HPTE_V_BOLTED))
+		rmask |= 0x20;
+	if (!(hpte_v[3] & HPTE_V_BOLTED))
+		rmask |= 0x10;
+	beat_read_htab_entries(0, hpte_group + 4, hpte_v);
+	if (!(hpte_v[0] & HPTE_V_BOLTED))
+		rmask |= 0x08;
+	if (!(hpte_v[1] & HPTE_V_BOLTED))
+		rmask |= 0x04;
+	if (!(hpte_v[2] & HPTE_V_BOLTED))
+		rmask |= 0x02;
+	if (!(hpte_v[3] & HPTE_V_BOLTED))
+		rmask |= 0x01;
+	return rmask;
+}
+
+static long beat_lpar_hpte_insert(unsigned long hpte_group,
+				  unsigned long va, unsigned long pa,
+				  unsigned long rflags, unsigned long vflags,
+				  int psize, int ssize)
+{
+	unsigned long lpar_rc;
+	unsigned long slot;
+	unsigned long hpte_v, hpte_r;
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
+	hpte_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M) |
+		vflags | HPTE_V_VALID;
+	hpte_r = hpte_encode_r(pa, psize) | rflags;
+
+	if (!(vflags & HPTE_V_BOLTED))
+		DBG_LOW(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
+
+	if (rflags & (_PAGE_GUARDED|_PAGE_NO_CACHE))
+		hpte_r &= ~_PAGE_COHERENT;
+
+	spin_lock(&beat_htab_lock);
+	lpar_rc = beat_read_mask(hpte_group);
+	if (lpar_rc == 0) {
+		if (!(vflags & HPTE_V_BOLTED))
+			DBG_LOW(" full\n");
+		spin_unlock(&beat_htab_lock);
+		return -1;
+	}
+
+	lpar_rc = beat_insert_htab_entry(0, hpte_group, lpar_rc << 48,
+		hpte_v, hpte_r, &slot);
+	spin_unlock(&beat_htab_lock);
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
+	unsigned long dword0, dword[5];
+	unsigned long lpar_rc;
+
+	lpar_rc = beat_read_htab_entries(0, slot & ~3UL, dword);
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
+	int i;
+	unsigned long dummy0, dummy1;
+
+	/* TODO: Use bulk call */
+	for (i = 0; i < hpte_count; i++)
+		beat_write_htab_entry(0, i, 0, 0, -1UL, -1UL, &dummy0, &dummy1);
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
+				    int psize, int ssize, int local)
+{
+	unsigned long lpar_rc;
+	unsigned long dummy0, dummy1, want_v;
+
+	want_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M);
+
+	DBG_LOW("    update: "
+		"avpnv=%016lx, slot=%016lx, psize: %d, newpp %016lx ... ",
+		want_v & HPTE_V_AVPN, slot, psize, newpp);
+
+	spin_lock(&beat_htab_lock);
+	dummy0 = beat_lpar_hpte_getword0(slot);
+	if ((dummy0 & ~0x7FUL) != (want_v & ~0x7FUL)) {
+		DBG_LOW("not found !\n");
+		spin_unlock(&beat_htab_lock);
+		return -1;
+	}
+
+	lpar_rc = beat_write_htab_entry(0, slot, 0, newpp, 0, 7, &dummy0,
+					&dummy1);
+	spin_unlock(&beat_htab_lock);
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
+	hash = hpt_hash(va, mmu_psize_defs[psize].shift, MMU_SEGSIZE_256M);
+	want_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M);
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
+					  int psize, int ssize)
+{
+	unsigned long lpar_rc, slot, vsid, va, dummy0, dummy1;
+
+	vsid = get_kernel_vsid(ea, MMU_SEGSIZE_256M);
+	va = (vsid << 28) | (ea & 0x0fffffff);
+
+	spin_lock(&beat_htab_lock);
+	slot = beat_lpar_hpte_find(va, psize);
+	BUG_ON(slot == -1);
+
+	lpar_rc = beat_write_htab_entry(0, slot, 0, newpp, 0, 7,
+		&dummy0, &dummy1);
+	spin_unlock(&beat_htab_lock);
+
+	BUG_ON(lpar_rc != 0);
+}
+
+static void beat_lpar_hpte_invalidate(unsigned long slot, unsigned long va,
+					 int psize, int ssize, int local)
+{
+	unsigned long want_v;
+	unsigned long lpar_rc;
+	unsigned long dummy1, dummy2;
+	unsigned long flags;
+
+	DBG_LOW("    inval : slot=%lx, va=%016lx, psize: %d, local: %d\n",
+		slot, va, psize, local);
+	want_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M);
+
+	spin_lock_irqsave(&beat_htab_lock, flags);
+	dummy1 = beat_lpar_hpte_getword0(slot);
+
+	if ((dummy1 & ~0x7FUL) != (want_v & ~0x7FUL)) {
+		DBG_LOW("not found !\n");
+		spin_unlock_irqrestore(&beat_htab_lock, flags);
+		return;
+	}
+
+	lpar_rc = beat_write_htab_entry(0, slot, 0, 0, HPTE_V_VALID, 0,
+		&dummy1, &dummy2);
+	spin_unlock_irqrestore(&beat_htab_lock, flags);
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
+
+static long beat_lpar_hpte_insert_v3(unsigned long hpte_group,
+				  unsigned long va, unsigned long pa,
+				  unsigned long rflags, unsigned long vflags,
+				  int psize, int ssize)
+{
+	unsigned long lpar_rc;
+	unsigned long slot;
+	unsigned long hpte_v, hpte_r;
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
+	hpte_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M) |
+		vflags | HPTE_V_VALID;
+	hpte_r = hpte_encode_r(pa, psize) | rflags;
+
+	if (!(vflags & HPTE_V_BOLTED))
+		DBG_LOW(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
+
+	if (rflags & (_PAGE_GUARDED|_PAGE_NO_CACHE))
+		hpte_r &= ~_PAGE_COHERENT;
+
+	/* insert into not-volted entry */
+	lpar_rc = beat_insert_htab_entry3(0, hpte_group, hpte_v, hpte_r,
+		HPTE_V_BOLTED, 0, &slot);
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
+/*
+ * NOTE: for updatepp ops we are fortunate that the linux "newpp" bits and
+ * the low 3 bits of flags happen to line up.  So no transform is needed.
+ * We can probably optimize here and assume the high bits of newpp are
+ * already zero.  For now I am paranoid.
+ */
+static long beat_lpar_hpte_updatepp_v3(unsigned long slot,
+				    unsigned long newpp,
+				    unsigned long va,
+				    int psize, int ssize, int local)
+{
+	unsigned long lpar_rc;
+	unsigned long want_v;
+	unsigned long pss;
+
+	want_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M);
+	pss = (psize == MMU_PAGE_4K) ? -1UL : mmu_psize_defs[psize].penc;
+
+	DBG_LOW("    update: "
+		"avpnv=%016lx, slot=%016lx, psize: %d, newpp %016lx ... ",
+		want_v & HPTE_V_AVPN, slot, psize, newpp);
+
+	lpar_rc = beat_update_htab_permission3(0, slot, want_v, pss, 7, newpp);
+
+	if (lpar_rc == 0xfffffff7) {
+		DBG_LOW("not found !\n");
+		return -1;
+	}
+
+	DBG_LOW("ok\n");
+
+	BUG_ON(lpar_rc != 0);
+
+	return 0;
+}
+
+static void beat_lpar_hpte_invalidate_v3(unsigned long slot, unsigned long va,
+					 int psize, int ssize, int local)
+{
+	unsigned long want_v;
+	unsigned long lpar_rc;
+	unsigned long pss;
+
+	DBG_LOW("    inval : slot=%lx, va=%016lx, psize: %d, local: %d\n",
+		slot, va, psize, local);
+	want_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M);
+	pss = (psize == MMU_PAGE_4K) ? -1UL : mmu_psize_defs[psize].penc;
+
+	lpar_rc = beat_invalidate_htab_entry3(0, slot, want_v, pss);
+
+	/* E_busy can be valid output: page may be already replaced */
+	BUG_ON(lpar_rc != 0 && lpar_rc != 0xfffffff7);
+}
+
+static int64_t _beat_lpar_hptab_clear_v3(void)
+{
+	return beat_clear_htab3(0);
+}
+
+static void beat_lpar_hptab_clear_v3(void)
+{
+	_beat_lpar_hptab_clear_v3();
+}
+
+void __init hpte_init_beat_v3(void)
+{
+	if (_beat_lpar_hptab_clear_v3() == 0) {
+		ppc_md.hpte_invalidate	= beat_lpar_hpte_invalidate_v3;
+		ppc_md.hpte_updatepp	= beat_lpar_hpte_updatepp_v3;
+		ppc_md.hpte_updateboltedpp = beat_lpar_hpte_updateboltedpp;
+		ppc_md.hpte_insert	= beat_lpar_hpte_insert_v3;
+		ppc_md.hpte_remove	= beat_lpar_hpte_remove;
+		ppc_md.hpte_clear_all	= beat_lpar_hptab_clear_v3;
+	} else {
+		ppc_md.hpte_invalidate	= beat_lpar_hpte_invalidate;
+		ppc_md.hpte_updatepp	= beat_lpar_hpte_updatepp;
+		ppc_md.hpte_updateboltedpp = beat_lpar_hpte_updateboltedpp;
+		ppc_md.hpte_insert	= beat_lpar_hpte_insert;
+		ppc_md.hpte_remove	= beat_lpar_hpte_remove;
+		ppc_md.hpte_clear_all	= beat_lpar_hptab_clear;
+	}
+}
Index: b/arch/powerpc/platforms/cell/beat_iommu.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/powerpc/platforms/cell/beat_iommu.c	2008-04-23 21:38:30.000000000 +0900
@@ -0,0 +1,116 @@
+/*
+ * Support for IOMMU on Celleb platform.
+ *
+ * (C) Copyright 2006-2007 TOSHIBA CORPORATION
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
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/dma-mapping.h>
+#include <linux/pci.h>
+#include <linux/of_platform.h>
+
+#include <asm/machdep.h>
+
+#include "beat_wrapper.h"
+
+#define DMA_FLAGS 0xf800000000000000UL	/* r/w permitted, coherency required,
+					   strongest order */
+
+static int __init find_dma_window(u64 *io_space_id, u64 *ioid,
+				  u64 *base, u64 *size, u64 *io_page_size)
+{
+	struct device_node *dn;
+	const unsigned long *dma_window;
+
+	for_each_node_by_type(dn, "ioif") {
+		dma_window = of_get_property(dn, "toshiba,dma-window", NULL);
+		if (dma_window) {
+			*io_space_id = (dma_window[0] >> 32) & 0xffffffffUL;
+			*ioid = dma_window[0] & 0x7ffUL;
+			*base = dma_window[1];
+			*size = dma_window[2];
+			*io_page_size = 1 << dma_window[3];
+			of_node_put(dn);
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static unsigned long celleb_dma_direct_offset;
+
+static void __init celleb_init_direct_mapping(void)
+{
+	u64 lpar_addr, io_addr;
+	u64 io_space_id, ioid, dma_base, dma_size, io_page_size;
+
+	if (!find_dma_window(&io_space_id, &ioid, &dma_base, &dma_size,
+			     &io_page_size)) {
+		pr_info("No dma window found !\n");
+		return;
+	}
+
+	for (lpar_addr = 0; lpar_addr < dma_size; lpar_addr += io_page_size) {
+		io_addr = lpar_addr + dma_base;
+		(void)beat_put_iopte(io_space_id, io_addr, lpar_addr,
+				     ioid, DMA_FLAGS);
+	}
+
+	celleb_dma_direct_offset = dma_base;
+}
+
+static void celleb_dma_dev_setup(struct device *dev)
+{
+	dev->archdata.dma_ops = get_pci_dma_ops();
+	dev->archdata.dma_data = (void *)celleb_dma_direct_offset;
+}
+
+static void celleb_pci_dma_dev_setup(struct pci_dev *pdev)
+{
+	celleb_dma_dev_setup(&pdev->dev);
+}
+
+static int celleb_of_bus_notify(struct notifier_block *nb,
+				unsigned long action, void *data)
+{
+	struct device *dev = data;
+
+	/* We are only intereted in device addition */
+	if (action != BUS_NOTIFY_ADD_DEVICE)
+		return 0;
+
+	celleb_dma_dev_setup(dev);
+
+	return 0;
+}
+
+static struct notifier_block celleb_of_bus_notifier = {
+	.notifier_call = celleb_of_bus_notify
+};
+
+static int __init celleb_init_iommu(void)
+{
+	celleb_init_direct_mapping();
+	set_pci_dma_ops(&dma_direct_ops);
+	ppc_md.pci_dma_dev_setup = celleb_pci_dma_dev_setup;
+	bus_register_notifier(&of_platform_bus_type, &celleb_of_bus_notifier);
+
+	return 0;
+}
+
+machine_arch_initcall(celleb_beat, celleb_init_iommu);
Index: b/arch/powerpc/platforms/celleb/htab.c
===================================================================
--- a/arch/powerpc/platforms/celleb/htab.c	2008-04-23 21:38:14.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,441 +0,0 @@
-/*
- * "Cell Reference Set" HTAB support.
- *
- * (C) Copyright 2006-2007 TOSHIBA CORPORATION
- *
- * This code is based on arch/powerpc/platforms/pseries/lpar.c:
- *  Copyright (C) 2001 Todd Inglett, IBM Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#undef DEBUG_LOW
-
-#include <linux/kernel.h>
-#include <linux/spinlock.h>
-
-#include <asm/mmu.h>
-#include <asm/page.h>
-#include <asm/pgtable.h>
-#include <asm/machdep.h>
-#include <asm/udbg.h>
-
-#include "../cell/beat_wrapper.h"
-
-#ifdef DEBUG_LOW
-#define DBG_LOW(fmt...) do { udbg_printf(fmt); } while (0)
-#else
-#define DBG_LOW(fmt...) do { } while (0)
-#endif
-
-static DEFINE_SPINLOCK(beat_htab_lock);
-
-static inline unsigned int beat_read_mask(unsigned hpte_group)
-{
-	unsigned long hpte_v[5];
-	unsigned long rmask = 0;
-
-	beat_read_htab_entries(0, hpte_group + 0, hpte_v);
-	if (!(hpte_v[0] & HPTE_V_BOLTED))
-		rmask |= 0x8000;
-	if (!(hpte_v[1] & HPTE_V_BOLTED))
-		rmask |= 0x4000;
-	if (!(hpte_v[2] & HPTE_V_BOLTED))
-		rmask |= 0x2000;
-	if (!(hpte_v[3] & HPTE_V_BOLTED))
-		rmask |= 0x1000;
-	beat_read_htab_entries(0, hpte_group + 4, hpte_v);
-	if (!(hpte_v[0] & HPTE_V_BOLTED))
-		rmask |= 0x0800;
-	if (!(hpte_v[1] & HPTE_V_BOLTED))
-		rmask |= 0x0400;
-	if (!(hpte_v[2] & HPTE_V_BOLTED))
-		rmask |= 0x0200;
-	if (!(hpte_v[3] & HPTE_V_BOLTED))
-		rmask |= 0x0100;
-	hpte_group = ~hpte_group & (htab_hash_mask * HPTES_PER_GROUP);
-	beat_read_htab_entries(0, hpte_group + 0, hpte_v);
-	if (!(hpte_v[0] & HPTE_V_BOLTED))
-		rmask |= 0x80;
-	if (!(hpte_v[1] & HPTE_V_BOLTED))
-		rmask |= 0x40;
-	if (!(hpte_v[2] & HPTE_V_BOLTED))
-		rmask |= 0x20;
-	if (!(hpte_v[3] & HPTE_V_BOLTED))
-		rmask |= 0x10;
-	beat_read_htab_entries(0, hpte_group + 4, hpte_v);
-	if (!(hpte_v[0] & HPTE_V_BOLTED))
-		rmask |= 0x08;
-	if (!(hpte_v[1] & HPTE_V_BOLTED))
-		rmask |= 0x04;
-	if (!(hpte_v[2] & HPTE_V_BOLTED))
-		rmask |= 0x02;
-	if (!(hpte_v[3] & HPTE_V_BOLTED))
-		rmask |= 0x01;
-	return rmask;
-}
-
-static long beat_lpar_hpte_insert(unsigned long hpte_group,
-				  unsigned long va, unsigned long pa,
-				  unsigned long rflags, unsigned long vflags,
-				  int psize, int ssize)
-{
-	unsigned long lpar_rc;
-	unsigned long slot;
-	unsigned long hpte_v, hpte_r;
-
-	/* same as iseries */
-	if (vflags & HPTE_V_SECONDARY)
-		return -1;
-
-	if (!(vflags & HPTE_V_BOLTED))
-		DBG_LOW("hpte_insert(group=%lx, va=%016lx, pa=%016lx, "
-			"rflags=%lx, vflags=%lx, psize=%d)\n",
-		hpte_group, va, pa, rflags, vflags, psize);
-
-	hpte_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M) |
-		vflags | HPTE_V_VALID;
-	hpte_r = hpte_encode_r(pa, psize) | rflags;
-
-	if (!(vflags & HPTE_V_BOLTED))
-		DBG_LOW(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
-
-	if (rflags & (_PAGE_GUARDED|_PAGE_NO_CACHE))
-		hpte_r &= ~_PAGE_COHERENT;
-
-	spin_lock(&beat_htab_lock);
-	lpar_rc = beat_read_mask(hpte_group);
-	if (lpar_rc == 0) {
-		if (!(vflags & HPTE_V_BOLTED))
-			DBG_LOW(" full\n");
-		spin_unlock(&beat_htab_lock);
-		return -1;
-	}
-
-	lpar_rc = beat_insert_htab_entry(0, hpte_group, lpar_rc << 48,
-		hpte_v, hpte_r, &slot);
-	spin_unlock(&beat_htab_lock);
-
-	/*
-	 * Since we try and ioremap PHBs we don't own, the pte insert
-	 * will fail. However we must catch the failure in hash_page
-	 * or we will loop forever, so return -2 in this case.
-	 */
-	if (unlikely(lpar_rc != 0)) {
-		if (!(vflags & HPTE_V_BOLTED))
-			DBG_LOW(" lpar err %lx\n", lpar_rc);
-		return -2;
-	}
-	if (!(vflags & HPTE_V_BOLTED))
-		DBG_LOW(" -> slot: %lx\n", slot);
-
-	/* We have to pass down the secondary bucket bit here as well */
-	return (slot ^ hpte_group) & 15;
-}
-
-static long beat_lpar_hpte_remove(unsigned long hpte_group)
-{
-	DBG_LOW("hpte_remove(group=%lx)\n", hpte_group);
-	return -1;
-}
-
-static unsigned long beat_lpar_hpte_getword0(unsigned long slot)
-{
-	unsigned long dword0, dword[5];
-	unsigned long lpar_rc;
-
-	lpar_rc = beat_read_htab_entries(0, slot & ~3UL, dword);
-
-	dword0 = dword[slot&3];
-
-	BUG_ON(lpar_rc != 0);
-
-	return dword0;
-}
-
-static void beat_lpar_hptab_clear(void)
-{
-	unsigned long size_bytes = 1UL << ppc64_pft_size;
-	unsigned long hpte_count = size_bytes >> 4;
-	int i;
-	unsigned long dummy0, dummy1;
-
-	/* TODO: Use bulk call */
-	for (i = 0; i < hpte_count; i++)
-		beat_write_htab_entry(0, i, 0, 0, -1UL, -1UL, &dummy0, &dummy1);
-}
-
-/*
- * NOTE: for updatepp ops we are fortunate that the linux "newpp" bits and
- * the low 3 bits of flags happen to line up.  So no transform is needed.
- * We can probably optimize here and assume the high bits of newpp are
- * already zero.  For now I am paranoid.
- */
-static long beat_lpar_hpte_updatepp(unsigned long slot,
-				    unsigned long newpp,
-				    unsigned long va,
-				    int psize, int ssize, int local)
-{
-	unsigned long lpar_rc;
-	unsigned long dummy0, dummy1, want_v;
-
-	want_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M);
-
-	DBG_LOW("    update: "
-		"avpnv=%016lx, slot=%016lx, psize: %d, newpp %016lx ... ",
-		want_v & HPTE_V_AVPN, slot, psize, newpp);
-
-	spin_lock(&beat_htab_lock);
-	dummy0 = beat_lpar_hpte_getword0(slot);
-	if ((dummy0 & ~0x7FUL) != (want_v & ~0x7FUL)) {
-		DBG_LOW("not found !\n");
-		spin_unlock(&beat_htab_lock);
-		return -1;
-	}
-
-	lpar_rc = beat_write_htab_entry(0, slot, 0, newpp, 0, 7, &dummy0,
-					&dummy1);
-	spin_unlock(&beat_htab_lock);
-	if (lpar_rc != 0 || dummy0 == 0) {
-		DBG_LOW("not found !\n");
-		return -1;
-	}
-
-	DBG_LOW("ok %lx %lx\n", dummy0, dummy1);
-
-	BUG_ON(lpar_rc != 0);
-
-	return 0;
-}
-
-static long beat_lpar_hpte_find(unsigned long va, int psize)
-{
-	unsigned long hash;
-	unsigned long i, j;
-	long slot;
-	unsigned long want_v, hpte_v;
-
-	hash = hpt_hash(va, mmu_psize_defs[psize].shift, MMU_SEGSIZE_256M);
-	want_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M);
-
-	for (j = 0; j < 2; j++) {
-		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		for (i = 0; i < HPTES_PER_GROUP; i++) {
-			hpte_v = beat_lpar_hpte_getword0(slot);
-
-			if (HPTE_V_COMPARE(hpte_v, want_v)
-			    && (hpte_v & HPTE_V_VALID)
-			    && (!!(hpte_v & HPTE_V_SECONDARY) == j)) {
-				/* HPTE matches */
-				if (j)
-					slot = -slot;
-				return slot;
-			}
-			++slot;
-		}
-		hash = ~hash;
-	}
-
-	return -1;
-}
-
-static void beat_lpar_hpte_updateboltedpp(unsigned long newpp,
-					  unsigned long ea,
-					  int psize, int ssize)
-{
-	unsigned long lpar_rc, slot, vsid, va, dummy0, dummy1;
-
-	vsid = get_kernel_vsid(ea, MMU_SEGSIZE_256M);
-	va = (vsid << 28) | (ea & 0x0fffffff);
-
-	spin_lock(&beat_htab_lock);
-	slot = beat_lpar_hpte_find(va, psize);
-	BUG_ON(slot == -1);
-
-	lpar_rc = beat_write_htab_entry(0, slot, 0, newpp, 0, 7,
-		&dummy0, &dummy1);
-	spin_unlock(&beat_htab_lock);
-
-	BUG_ON(lpar_rc != 0);
-}
-
-static void beat_lpar_hpte_invalidate(unsigned long slot, unsigned long va,
-					 int psize, int ssize, int local)
-{
-	unsigned long want_v;
-	unsigned long lpar_rc;
-	unsigned long dummy1, dummy2;
-	unsigned long flags;
-
-	DBG_LOW("    inval : slot=%lx, va=%016lx, psize: %d, local: %d\n",
-		slot, va, psize, local);
-	want_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M);
-
-	spin_lock_irqsave(&beat_htab_lock, flags);
-	dummy1 = beat_lpar_hpte_getword0(slot);
-
-	if ((dummy1 & ~0x7FUL) != (want_v & ~0x7FUL)) {
-		DBG_LOW("not found !\n");
-		spin_unlock_irqrestore(&beat_htab_lock, flags);
-		return;
-	}
-
-	lpar_rc = beat_write_htab_entry(0, slot, 0, 0, HPTE_V_VALID, 0,
-		&dummy1, &dummy2);
-	spin_unlock_irqrestore(&beat_htab_lock, flags);
-
-	BUG_ON(lpar_rc != 0);
-}
-
-void __init hpte_init_beat(void)
-{
-	ppc_md.hpte_invalidate	= beat_lpar_hpte_invalidate;
-	ppc_md.hpte_updatepp	= beat_lpar_hpte_updatepp;
-	ppc_md.hpte_updateboltedpp = beat_lpar_hpte_updateboltedpp;
-	ppc_md.hpte_insert	= beat_lpar_hpte_insert;
-	ppc_md.hpte_remove	= beat_lpar_hpte_remove;
-	ppc_md.hpte_clear_all	= beat_lpar_hptab_clear;
-}
-
-static long beat_lpar_hpte_insert_v3(unsigned long hpte_group,
-				  unsigned long va, unsigned long pa,
-				  unsigned long rflags, unsigned long vflags,
-				  int psize, int ssize)
-{
-	unsigned long lpar_rc;
-	unsigned long slot;
-	unsigned long hpte_v, hpte_r;
-
-	/* same as iseries */
-	if (vflags & HPTE_V_SECONDARY)
-		return -1;
-
-	if (!(vflags & HPTE_V_BOLTED))
-		DBG_LOW("hpte_insert(group=%lx, va=%016lx, pa=%016lx, "
-			"rflags=%lx, vflags=%lx, psize=%d)\n",
-		hpte_group, va, pa, rflags, vflags, psize);
-
-	hpte_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M) |
-		vflags | HPTE_V_VALID;
-	hpte_r = hpte_encode_r(pa, psize) | rflags;
-
-	if (!(vflags & HPTE_V_BOLTED))
-		DBG_LOW(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
-
-	if (rflags & (_PAGE_GUARDED|_PAGE_NO_CACHE))
-		hpte_r &= ~_PAGE_COHERENT;
-
-	/* insert into not-volted entry */
-	lpar_rc = beat_insert_htab_entry3(0, hpte_group, hpte_v, hpte_r,
-		HPTE_V_BOLTED, 0, &slot);
-	/*
-	 * Since we try and ioremap PHBs we don't own, the pte insert
-	 * will fail. However we must catch the failure in hash_page
-	 * or we will loop forever, so return -2 in this case.
-	 */
-	if (unlikely(lpar_rc != 0)) {
-		if (!(vflags & HPTE_V_BOLTED))
-			DBG_LOW(" lpar err %lx\n", lpar_rc);
-		return -2;
-	}
-	if (!(vflags & HPTE_V_BOLTED))
-		DBG_LOW(" -> slot: %lx\n", slot);
-
-	/* We have to pass down the secondary bucket bit here as well */
-	return (slot ^ hpte_group) & 15;
-}
-
-/*
- * NOTE: for updatepp ops we are fortunate that the linux "newpp" bits and
- * the low 3 bits of flags happen to line up.  So no transform is needed.
- * We can probably optimize here and assume the high bits of newpp are
- * already zero.  For now I am paranoid.
- */
-static long beat_lpar_hpte_updatepp_v3(unsigned long slot,
-				    unsigned long newpp,
-				    unsigned long va,
-				    int psize, int ssize, int local)
-{
-	unsigned long lpar_rc;
-	unsigned long want_v;
-	unsigned long pss;
-
-	want_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M);
-	pss = (psize == MMU_PAGE_4K) ? -1UL : mmu_psize_defs[psize].penc;
-
-	DBG_LOW("    update: "
-		"avpnv=%016lx, slot=%016lx, psize: %d, newpp %016lx ... ",
-		want_v & HPTE_V_AVPN, slot, psize, newpp);
-
-	lpar_rc = beat_update_htab_permission3(0, slot, want_v, pss, 7, newpp);
-
-	if (lpar_rc == 0xfffffff7) {
-		DBG_LOW("not found !\n");
-		return -1;
-	}
-
-	DBG_LOW("ok\n");
-
-	BUG_ON(lpar_rc != 0);
-
-	return 0;
-}
-
-static void beat_lpar_hpte_invalidate_v3(unsigned long slot, unsigned long va,
-					 int psize, int ssize, int local)
-{
-	unsigned long want_v;
-	unsigned long lpar_rc;
-	unsigned long pss;
-
-	DBG_LOW("    inval : slot=%lx, va=%016lx, psize: %d, local: %d\n",
-		slot, va, psize, local);
-	want_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M);
-	pss = (psize == MMU_PAGE_4K) ? -1UL : mmu_psize_defs[psize].penc;
-
-	lpar_rc = beat_invalidate_htab_entry3(0, slot, want_v, pss);
-
-	/* E_busy can be valid output: page may be already replaced */
-	BUG_ON(lpar_rc != 0 && lpar_rc != 0xfffffff7);
-}
-
-static int64_t _beat_lpar_hptab_clear_v3(void)
-{
-	return beat_clear_htab3(0);
-}
-
-static void beat_lpar_hptab_clear_v3(void)
-{
-	_beat_lpar_hptab_clear_v3();
-}
-
-void __init hpte_init_beat_v3(void)
-{
-	if (_beat_lpar_hptab_clear_v3() == 0) {
-		ppc_md.hpte_invalidate	= beat_lpar_hpte_invalidate_v3;
-		ppc_md.hpte_updatepp	= beat_lpar_hpte_updatepp_v3;
-		ppc_md.hpte_updateboltedpp = beat_lpar_hpte_updateboltedpp;
-		ppc_md.hpte_insert	= beat_lpar_hpte_insert_v3;
-		ppc_md.hpte_remove	= beat_lpar_hpte_remove;
-		ppc_md.hpte_clear_all	= beat_lpar_hptab_clear_v3;
-	} else {
-		ppc_md.hpte_invalidate	= beat_lpar_hpte_invalidate;
-		ppc_md.hpte_updatepp	= beat_lpar_hpte_updatepp;
-		ppc_md.hpte_updateboltedpp = beat_lpar_hpte_updateboltedpp;
-		ppc_md.hpte_insert	= beat_lpar_hpte_insert;
-		ppc_md.hpte_remove	= beat_lpar_hpte_remove;
-		ppc_md.hpte_clear_all	= beat_lpar_hptab_clear;
-	}
-}
Index: b/arch/powerpc/platforms/celleb/iommu.c
===================================================================
--- a/arch/powerpc/platforms/celleb/iommu.c	2008-04-23 21:38:14.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,116 +0,0 @@
-/*
- * Support for IOMMU on Celleb platform.
- *
- * (C) Copyright 2006-2007 TOSHIBA CORPORATION
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/dma-mapping.h>
-#include <linux/pci.h>
-#include <linux/of_platform.h>
-
-#include <asm/machdep.h>
-
-#include "../cell/beat_wrapper.h"
-
-#define DMA_FLAGS 0xf800000000000000UL	/* r/w permitted, coherency required,
-					   strongest order */
-
-static int __init find_dma_window(u64 *io_space_id, u64 *ioid,
-				  u64 *base, u64 *size, u64 *io_page_size)
-{
-	struct device_node *dn;
-	const unsigned long *dma_window;
-
-	for_each_node_by_type(dn, "ioif") {
-		dma_window = of_get_property(dn, "toshiba,dma-window", NULL);
-		if (dma_window) {
-			*io_space_id = (dma_window[0] >> 32) & 0xffffffffUL;
-			*ioid = dma_window[0] & 0x7ffUL;
-			*base = dma_window[1];
-			*size = dma_window[2];
-			*io_page_size = 1 << dma_window[3];
-			of_node_put(dn);
-			return 1;
-		}
-	}
-	return 0;
-}
-
-static unsigned long celleb_dma_direct_offset;
-
-static void __init celleb_init_direct_mapping(void)
-{
-	u64 lpar_addr, io_addr;
-	u64 io_space_id, ioid, dma_base, dma_size, io_page_size;
-
-	if (!find_dma_window(&io_space_id, &ioid, &dma_base, &dma_size,
-			     &io_page_size)) {
-		pr_info("No dma window found !\n");
-		return;
-	}
-
-	for (lpar_addr = 0; lpar_addr < dma_size; lpar_addr += io_page_size) {
-		io_addr = lpar_addr + dma_base;
-		(void)beat_put_iopte(io_space_id, io_addr, lpar_addr,
-				     ioid, DMA_FLAGS);
-	}
-
-	celleb_dma_direct_offset = dma_base;
-}
-
-static void celleb_dma_dev_setup(struct device *dev)
-{
-	dev->archdata.dma_ops = get_pci_dma_ops();
-	dev->archdata.dma_data = (void *)celleb_dma_direct_offset;
-}
-
-static void celleb_pci_dma_dev_setup(struct pci_dev *pdev)
-{
-	celleb_dma_dev_setup(&pdev->dev);
-}
-
-static int celleb_of_bus_notify(struct notifier_block *nb,
-				unsigned long action, void *data)
-{
-	struct device *dev = data;
-
-	/* We are only intereted in device addition */
-	if (action != BUS_NOTIFY_ADD_DEVICE)
-		return 0;
-
-	celleb_dma_dev_setup(dev);
-
-	return 0;
-}
-
-static struct notifier_block celleb_of_bus_notifier = {
-	.notifier_call = celleb_of_bus_notify
-};
-
-static int __init celleb_init_iommu(void)
-{
-	celleb_init_direct_mapping();
-	set_pci_dma_ops(&dma_direct_ops);
-	ppc_md.pci_dma_dev_setup = celleb_pci_dma_dev_setup;
-	bus_register_notifier(&of_platform_bus_type, &celleb_of_bus_notifier);
-
-	return 0;
-}
-
-machine_arch_initcall(celleb_beat, celleb_init_iommu);
Index: b/arch/powerpc/platforms/cell/Makefile
===================================================================
--- a/arch/powerpc/platforms/cell/Makefile	2008-04-23 21:38:14.000000000 +0900
+++ b/arch/powerpc/platforms/cell/Makefile	2008-04-23 21:38:30.000000000 +0900
@@ -35,7 +35,8 @@
 					   celleb_pci.o celleb_scc_epci.o \
 					   celleb_scc_uhc.o \
 					   io-workarounds.o spider-pci.o \
-					   beat_hvCall.o
+					   beat_htab.o beat_hvCall.o \
+					   beat_iommu.o
 
 obj-$(CONFIG_SERIAL_TXX9)		+= celleb_scc_sio.o
 endif
Index: b/arch/powerpc/platforms/celleb/Makefile
===================================================================
--- a/arch/powerpc/platforms/celleb/Makefile	2008-04-23 21:38:14.000000000 +0900
+++ b/arch/powerpc/platforms/celleb/Makefile	2008-04-23 21:38:30.000000000 +0900
@@ -1,5 +1,5 @@
-obj-y				+= interrupt.o iommu.o \
-				   htab.o beat.o
+obj-y				+= interrupt.o \
+				   beat.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_PPC_UDBG_BEAT)	+= udbg_beat.o
