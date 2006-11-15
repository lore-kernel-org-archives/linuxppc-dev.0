Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 10BCD67DCD
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 20:51:10 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id kAF9p785014860
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 18:51:07 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id kAF9p81J004487
	for linuxppc-dev@ozlabs.org; Wed, 15 Nov 2006 18:51:08 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id kAF9p785009362
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 18:51:07 +0900 (JST)
Date: Wed, 15 Nov 2006 18:51:06 +0900 (JST)
Message-Id: <200611150951.kAF9p7fS010482@toshiba.co.jp>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 12/16] Accessing SPE priv1 registers
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

This patch creates Celleb platform depend file to access SPE priv1 registers.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-2.6.19/arch/powerpc/platforms/celleb/spu_priv1_beat.c
diff -u /dev/null linux-2.6.19/arch/powerpc/platforms/celleb/spu_priv1_beat.c:1.2
--- /dev/null	Thu Nov  9 18:40:50 2006
+++ linux-2.6.19/arch/powerpc/platforms/celleb/spu_priv1_beat.c	Tue Nov  7 12:44:38 2006
@@ -0,0 +1,205 @@
+/*
+ * spu hypervisor abstraction for Beat
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
+
+#include <asm/spu.h>
+#include <asm/spu_priv1.h>
+
+#include "beat.h"
+
+static inline void _int_mask_set(struct spu *spu, int class, u64 mask)
+{
+	spu->shadow_int_mask_RW[class] = mask;
+	beat_set_irq_mask_for_spe(spu->unit_number, class, mask);
+}
+
+static inline u64 _int_mask_get(struct spu *spu, int class)
+{
+	return spu->shadow_int_mask_RW[class];
+}
+
+static void int_mask_set(struct spu *spu, int class, u64 mask)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&spu->int_mask_lock, flags);
+	_int_mask_set(spu, class, mask);
+	spin_unlock_irqrestore(&spu->int_mask_lock, flags);
+}
+
+static u64 int_mask_get(struct spu *spu, int class)
+{
+	/* 64bit load is atomic and lock is not necessary */
+	return _int_mask_get(spu, class);
+}
+
+static void int_mask_and(struct spu *spu, int class, u64 mask)
+{
+	u64 old_mask;
+	unsigned long flags;
+	spin_lock_irqsave(&spu->int_mask_lock, flags);
+	old_mask = _int_mask_get(spu, class);
+	_int_mask_set(spu, class, old_mask & mask);
+	spin_unlock_irqrestore(&spu->int_mask_lock, flags);
+}
+
+static void int_mask_or(struct spu *spu, int class, u64 mask)
+{
+	u64 old_mask;
+	unsigned long flags;
+	spin_lock_irqsave(&spu->int_mask_lock, flags);
+	old_mask = _int_mask_get(spu, class);
+	_int_mask_set(spu, class, old_mask | mask);
+	spin_unlock_irqrestore(&spu->int_mask_lock, flags);
+}
+
+static void int_stat_clear(struct spu *spu, int class, u64 stat)
+{
+	beat_clear_interrupt_status_of_spe(spu->unit_number, class, stat);
+}
+
+static u64 int_stat_get(struct spu *spu, int class)
+{
+	u64 int_stat;
+	beat_get_interrupt_status_of_spe(spu->unit_number, class, &int_stat);
+	return int_stat;
+}
+
+static void cpu_affinity_set(struct spu *spu, int cpu)
+{
+	return;
+}
+
+static u64 mfc_dar_get(struct spu *spu)
+{
+	u64 dar;
+	beat_get_spe_privileged_state_1_registers(spu->unit_number,
+		offsetof(struct spu_priv1, mfc_dar_RW), &dar);
+	return dar;
+}
+
+static u64 mfc_dsisr_get(struct spu *spu)
+{
+	u64 dsisr;
+	beat_get_spe_privileged_state_1_registers(spu->unit_number,
+		offsetof(struct spu_priv1, mfc_dsisr_RW), &dsisr);
+	return dsisr;
+}
+
+static void mfc_dsisr_set(struct spu *spu, u64 dsisr)
+{
+	beat_set_spe_privileged_state_1_registers(spu->unit_number,
+		offsetof(struct spu_priv1, mfc_dsisr_RW), dsisr);
+}
+
+static void mfc_sdr_set(struct spu *spu, u64 sdr)
+{
+	return;
+}
+
+static void mfc_sr1_set(struct spu *spu, u64 sr1)
+{
+	beat_set_spe_privileged_state_1_registers(spu->unit_number,
+		offsetof(struct spu_priv1, mfc_sr1_RW), sr1);
+}
+
+static u64 mfc_sr1_get(struct spu *spu)
+{
+	u64 sr1;
+	beat_get_spe_privileged_state_1_registers(spu->unit_number,
+		offsetof(struct spu_priv1, mfc_sr1_RW), &sr1);
+	return sr1;
+}
+
+static void mfc_tclass_id_set(struct spu *spu, u64 tclass_id)
+{
+	beat_set_spe_privileged_state_1_registers(spu->unit_number,
+		offsetof(struct spu_priv1, mfc_tclass_id_RW), tclass_id);
+}
+
+static u64 mfc_tclass_id_get(struct spu *spu)
+{
+	u64 tclass_id;
+	beat_get_spe_privileged_state_1_registers(spu->unit_number,
+		offsetof(struct spu_priv1, mfc_tclass_id_RW), &tclass_id);
+	return tclass_id;
+}
+
+static void tlb_invalidate(struct spu *spu)
+{
+	beat_set_spe_privileged_state_1_registers(spu->unit_number,
+		offsetof(struct spu_priv1, tlb_invalidate_entry_W), 0ul);
+}
+
+static void resource_allocation_groupID_set(struct spu *spu, u64 id)
+{
+	beat_set_spe_privileged_state_1_registers(spu->unit_number,
+		offsetof(struct spu_priv1, resource_allocation_groupID_RW),
+		id);
+}
+
+static u64 resource_allocation_groupID_get(struct spu *spu)
+{
+	u64 id;
+	beat_get_spe_privileged_state_1_registers(spu->unit_number,
+		offsetof(struct spu_priv1, resource_allocation_groupID_RW),
+		&id);
+	return id;
+}
+
+static void resource_allocation_enable_set(struct spu *spu, u64 enable)
+{
+	beat_set_spe_privileged_state_1_registers(spu->unit_number,
+		offsetof(struct spu_priv1, resource_allocation_enable_RW),
+		enable);
+}
+
+static u64 resource_allocation_enable_get(struct spu *spu)
+{
+	u64 enable;
+	beat_get_spe_privileged_state_1_registers(spu->unit_number,
+		offsetof(struct spu_priv1, resource_allocation_enable_RW),
+		&enable);
+	return enable;
+}
+
+const struct spu_priv1_ops spu_priv1_beat_ops =
+{
+	.int_mask_and = int_mask_and,
+	.int_mask_or = int_mask_or,
+	.int_mask_set = int_mask_set,
+	.int_mask_get = int_mask_get,
+	.int_stat_clear = int_stat_clear,
+	.int_stat_get = int_stat_get,
+	.cpu_affinity_set = cpu_affinity_set,
+	.mfc_dar_get = mfc_dar_get,
+	.mfc_dsisr_get = mfc_dsisr_get,
+	.mfc_dsisr_set = mfc_dsisr_set,
+	.mfc_sdr_set = mfc_sdr_set,
+	.mfc_sr1_set = mfc_sr1_set,
+	.mfc_sr1_get = mfc_sr1_get,
+	.mfc_tclass_id_set = mfc_tclass_id_set,
+	.mfc_tclass_id_get = mfc_tclass_id_get,
+	.tlb_invalidate = tlb_invalidate,
+	.resource_allocation_groupID_set = resource_allocation_groupID_set,
+	.resource_allocation_groupID_get = resource_allocation_groupID_get,
+	.resource_allocation_enable_set = resource_allocation_enable_set,
+	.resource_allocation_enable_get = resource_allocation_enable_get,
+};
