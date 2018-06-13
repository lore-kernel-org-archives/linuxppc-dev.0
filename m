Return-Path: <ricardo.neri-calderon@linux.intel.com>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4157kB38R3zDqsx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 11:01:38 +1000 (AEST)
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Jacob Pan <jacob.jun.pan@intel.com>, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux-foundation.org
Subject: [RFC PATCH 04/23] iommu/vt-d/irq_remapping: Add support for
 IRQCHIP_CAN_DELIVER_AS_NMI
Date: Tue, 12 Jun 2018 17:57:24 -0700
Message-Id: <1528851463-21140-5-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Intel IOMMU is capable of delivering remapped interrupts as non-
maskable. Add the IRQCHIP_CAN_DELIVER_AS_NMI flag to its irq_chip
structure to declare this capability. The delivery mode of each interrupt
can be set separately.

By default, the deliver mode is taken from the configuration field of the
interrupt data. If non-maskable delivery is requested in the interrupt
state flags, the respective entry in the remapping table is updated.

When remapping an interrupt from an IO APIC, modify the delivery
field in the interrupt remapping table entry. When remapping an MSI
interrupt, simply update the delivery mode when composing the message.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 drivers/iommu/intel_irq_remapping.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 9f3a04d..b6cf7c4 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1128,10 +1128,14 @@ static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
 	struct irte *irte = &ir_data->irte_entry;
 	struct irq_cfg *cfg = irqd_cfg(irqd);
 
+	if (irqd_deliver_as_nmi(irqd))
+		cfg->delivery_mode = dest_NMI;
+
 	/*
 	 * Atomically updates the IRTE with the new destination, vector
 	 * and flushes the interrupt entry cache.
 	 */
+	irte->dlvry_mode = cfg->delivery_mode;
 	irte->vector = cfg->vector;
 	irte->dest_id = IRTE_DEST(cfg->dest_apicid);
 
@@ -1182,6 +1186,9 @@ static void intel_ir_compose_msi_msg(struct irq_data *irq_data,
 {
 	struct intel_ir_data *ir_data = irq_data->chip_data;
 
+	if (irqd_deliver_as_nmi(irq_data))
+		ir_data->irte_entry.dlvry_mode = dest_NMI;
+
 	*msg = ir_data->msi_entry;
 }
 
@@ -1227,6 +1234,7 @@ static struct irq_chip intel_ir_chip = {
 	.irq_set_affinity	= intel_ir_set_affinity,
 	.irq_compose_msi_msg	= intel_ir_compose_msi_msg,
 	.irq_set_vcpu_affinity	= intel_ir_set_vcpu_affinity,
+	.flags			= IRQCHIP_CAN_DELIVER_AS_NMI,
 };
 
 static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
-- 
2.7.4
