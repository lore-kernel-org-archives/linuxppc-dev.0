Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7EB667C7B
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 20:28:51 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id kAF9Sl6Y008377
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 18:28:47 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id kAF9Smx8020717
	for linuxppc-dev@ozlabs.org; Wed, 15 Nov 2006 18:28:48 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id kAF9SlEr016791
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 18:28:47 +0900 (JST)
Date: Wed, 15 Nov 2006 18:28:46 +0900 (JST)
Message-Id: <200611150928.kAF9SkJN021123@toshiba.co.jp>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/16] add hypervisor support for SPU
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

This patch adds hypervisor support for spu.

Linux(GuestOS) needs to designate SPE ID number when it uses SPE on Beat,
and must read the number from DT.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-2.6.19/arch/powerpc/platforms/cell/Kconfig
diff -u linux-2.6.19/arch/powerpc/platforms/cell/Kconfig:1.1.1.1 linux-2.6.19/arch/powerpc/platforms/cell/Kconfig:1.2
--- linux-2.6.19/arch/powerpc/platforms/cell/Kconfig:1.1.1.1	Fri Oct  6 10:40:07 2006
+++ linux-2.6.19/arch/powerpc/platforms/cell/Kconfig	Fri Oct  6 12:26:35 2006
@@ -16,6 +16,10 @@
 	bool
 	default n
 
+config SPU_NEED_SHADOW_INT_MASK
+	bool
+	default n
+
 config CBE_RAS
 	bool "RAS features for bare metal Cell BE"
 	default y
Index: linux-2.6.19/arch/powerpc/platforms/cell/spu_base.c
diff -u linux-2.6.19/arch/powerpc/platforms/cell/spu_base.c:1.1.1.3 linux-2.6.19/arch/powerpc/platforms/cell/spu_base.c:1.6
--- linux-2.6.19/arch/powerpc/platforms/cell/spu_base.c:1.1.1.3	Tue Oct 24 13:35:57 2006
+++ linux-2.6.19/arch/powerpc/platforms/cell/spu_base.c	Tue Nov  7 12:44:38 2006
@@ -38,6 +38,7 @@
 #include <asm/spu.h>
 #include <asm/spu_priv1.h>
 #include <asm/mmu_context.h>
+#include <asm/firmware.h>
 
 #include "interrupt.h"
 
@@ -507,6 +508,13 @@
 	return id ? *id : 0;
 }
 
+static int __init find_spu_unit_number(struct device_node *spe)
+{
+	const unsigned int *reg;
+	reg = get_property(spe, "reg", NULL);
+	return reg ? *reg : 0;
+}
+
 static int __init cell_spuprop_present(struct spu *spu, struct device_node *spe,
 		const char *prop)
 {
@@ -554,10 +562,12 @@
 	int err = 0;
 
 	p = get_property(n, name, &proplen);
-	if (proplen != sizeof (struct address_prop))
+	if (!p || proplen != sizeof (struct address_prop))
 		return NULL;
 
 	prop = p;
+	if (prop->len == 0)
+		return NULL;
 
 	err = cell_spuprop_present(spu, n, name);
 	if (err && (err != -EEXIST))
@@ -788,6 +798,7 @@
 		printk(KERN_WARNING "Check if CONFIG_NUMA is enabled.\n");
 		return -ENODEV;
 	}
+	spu->unit_number = find_spu_unit_number(spe);
 	spu->nid = of_node_to_nid(spe);
 	if (spu->nid == -1)
 		spu->nid = 0;
@@ -805,7 +816,11 @@
 	if (ret)
 		goto out_unmap;
 	spin_lock_init(&spu->register_lock);
-	spu_mfc_sdr_set(spu, mfspr(SPRN_SDR1));
+#ifdef CONFIG_SPU_NEED_SHADOW_INT_MASK
+	spin_lock_init(&spu->int_mask_lock);
+#endif
+	if (!(firmware_has_feature(FW_FEATURE_LPAR)))
+		spu_mfc_sdr_set(spu, mfspr(SPRN_SDR1));
 	spu_mfc_sr1_set(spu, 0x33);
 	mutex_lock(&spu_mutex);
 
Index: linux-2.6.19/arch/powerpc/platforms/cell/spufs/switch.c
diff -u linux-2.6.19/arch/powerpc/platforms/cell/spufs/switch.c:1.1.1.1 linux-2.6.19/arch/powerpc/platforms/cell/spufs/switch.c:1.2
--- linux-2.6.19/arch/powerpc/platforms/cell/spufs/switch.c:1.1.1.1	Fri Oct  6 10:40:08 2006
+++ linux-2.6.19/arch/powerpc/platforms/cell/spufs/switch.c	Fri Oct  6 12:26:35 2006
@@ -48,6 +48,7 @@
 #include <asm/spu_priv1.h>
 #include <asm/spu_csa.h>
 #include <asm/mmu_context.h>
+#include <asm/firmware.h>
 
 #include "spu_save_dump.h"
 #include "spu_restore_dump.h"
@@ -2166,7 +2167,8 @@
 	    MFC_STATE1_RELOCATE_MASK | MFC_STATE1_BUS_TLBIE_MASK;
 
 	/* Set storage description.  */
-	csa->priv1.mfc_sdr_RW = mfspr(SPRN_SDR1);
+	if (!firmware_has_feature(FW_FEATURE_LPAR))
+		csa->priv1.mfc_sdr_RW = mfspr(SPRN_SDR1);
 
 	/* Enable OS-specific set of interrupts. */
 	csa->priv1.int_mask_class0_RW = CLASS0_ENABLE_DMA_ALIGNMENT_INTR |
Index: linux-2.6.19/include/asm-powerpc/spu.h
diff -u linux-2.6.19/include/asm-powerpc/spu.h:1.1.1.1 linux-2.6.19/include/asm-powerpc/spu.h:1.3
--- linux-2.6.19/include/asm-powerpc/spu.h:1.1.1.1	Fri Oct  6 10:43:21 2006
+++ linux-2.6.19/include/asm-powerpc/spu.h	Tue Nov  7 12:44:38 2006
@@ -120,9 +120,14 @@
 	unsigned int irqs[3];
 	u32 isrc;
 	u32 node;
+	u32 unit_number;
 	u64 flags;
 	u64 dar;
 	u64 dsisr;
+#ifdef	CONFIG_SPU_NEED_SHADOW_INT_MASK
+	spinlock_t int_mask_lock;
+	u64 shadow_int_mask_RW[3];
+#endif
 	size_t ls_size;
 	unsigned int slb_replace;
 	struct mm_struct *mm;
