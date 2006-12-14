Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5E4E167E6D
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 13:46:17 +1100 (EST)
Date: Thu, 14 Dec 2006 11:46:10 +0900 (JST)
Message-Id: <200612140246.kBE2kBDd028574@toshiba.co.jp>
Subject: [PATCH 15/19] powerpc: htab routines for Celleb
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adds htab routines for Celleb platform.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/htab.c
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/htab.c:1.3
--- /dev/null	Wed Dec 13 21:32:05 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/htab.c	Wed Dec 13 18:37:14 2006
@@ -0,0 +1,301 @@
+/*
+ * "Cell Reference Set" HTAB support.
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
+
+#include <asm/mmu.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/machdep.h>
+#include <asm/udbg.h>
+
+#include "beat.h"
+
+#ifdef DEBUG_LOW
+#define DBG_LOW(fmt...) do { udbg_printf(fmt); } while(0)
+#else
+#define DBG_LOW(fmt...) do { } while(0)
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
+		beat_write_htab_entry(0, i, 0, 0, -1UL, -1UL,
+				      &dummy1, &dummy2);
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
+	DBG_LOW("    update: "
+		"avpnv=%016lx, slot=%016lx, psize: %d, newpp %016lx ... ",
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
