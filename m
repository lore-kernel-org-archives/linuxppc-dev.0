Return-Path: <s.miroshnichenko@yadro.com>
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4257FV0FPtzF38Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 01:40:30 +1000 (AEST)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 059CB418FB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 15:40:21 +0000 (UTC)
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qKUlcxjype-V for <linuxppc-dev@lists.ozlabs.org>;
 Wed,  5 Sep 2018 18:40:20 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id D6A8A404D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 18:40:18 +0300 (MSK)
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: <linux@yadro.com>, Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH 5/5] PCI/powerpc/eeh: Add pcibios hooks for preparing to rescan
Date: Wed, 5 Sep 2018 18:40:08 +0300
Message-ID: <20180905154008.11130-6-s.miroshnichenko@yadro.com>
In-Reply-To: <20180905154008.11130-1-s.miroshnichenko@yadro.com>
References: <20180905154008.11130-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reading an empty slot returns all ones, which triggers a false
EEH error event on PowerNV.

New callbacks pcibios_rescan_prepare/done are introduced to
pause/resume the EEH during rescan.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/include/asm/eeh.h               |  2 ++
 arch/powerpc/kernel/eeh.c                    | 14 ++++++++++++++
 arch/powerpc/platforms/powernv/eeh-powernv.c | 20 ++++++++++++++++++++
 drivers/pci/probe.c                          | 14 ++++++++++++++
 include/linux/pci.h                          |  2 ++
 5 files changed, 52 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 219637ea69a1..926c3e31df99 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -219,6 +219,8 @@ struct eeh_ops {
 	int (*next_error)(struct eeh_pe **pe);
 	int (*restore_config)(struct pci_dn *pdn);
 	int (*notify_resume)(struct pci_dn *pdn);
+	int (*pause)(struct pci_bus *bus);
+	int (*resume)(struct pci_bus *bus);
 };
 
 extern int eeh_subsystem_flags;
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 6ebba3e48b01..dce9b0978cb5 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1831,3 +1831,17 @@ static int __init eeh_init_proc(void)
 	return 0;
 }
 __initcall(eeh_init_proc);
+
+void pcibios_rescan_prepare(struct pci_bus *bus)
+{
+	if (eeh_ops && eeh_ops->pause) {
+		eeh_ops->pause(bus);
+	}
+}
+
+void pcibios_rescan_done(struct pci_bus *bus)
+{
+	if (eeh_ops && eeh_ops->resume) {
+		eeh_ops->resume(bus);
+	}
+}
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 3c1beae29f2d..9c9213d92550 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -59,6 +59,24 @@ void pnv_pcibios_bus_add_device(struct pci_dev *pdev)
 	eeh_sysfs_add_device(pdev);
 }
 
+static int pnv_eeh_pause(struct pci_bus *bus)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct pnv_phb *phb = hose->private_data;
+	phb->flags &= ~PNV_PHB_FLAG_EEH;
+	disable_irq(eeh_event_irq);
+	return 0;
+}
+
+static int pnv_eeh_resume(struct pci_bus *bus)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct pnv_phb *phb = hose->private_data;
+	enable_irq(eeh_event_irq);
+	phb->flags |= PNV_PHB_FLAG_EEH;
+	return 0;
+}
+
 static int pnv_eeh_init(void)
 {
 	struct pci_controller *hose;
@@ -1710,6 +1728,8 @@ static struct eeh_ops pnv_eeh_ops = {
 	.write_config           = pnv_eeh_write_config,
 	.next_error		= pnv_eeh_next_error,
 	.restore_config		= pnv_eeh_restore_config,
+	.pause			= pnv_eeh_pause,
+	.resume			= pnv_eeh_resume,
 	.notify_resume		= NULL
 };
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ec784009a36b..203368566896 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2893,6 +2893,14 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
 {
 }
 
+void __weak pcibios_rescan_prepare(struct pci_bus *bus)
+{
+}
+
+void __weak pcibios_rescan_done(struct pci_bus *bus)
+{
+}
+
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
@@ -3147,9 +3155,15 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
 unsigned int pci_rescan_bus(struct pci_bus *bus)
 {
 	unsigned int max;
+	struct pci_bus *root = bus;
+	while (!pci_is_root_bus(root)) {
+		root = root->parent;
+	}
 
+	pcibios_rescan_prepare(root);
 	max = pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
+	pcibios_rescan_done(root);
 	pci_bus_add_devices(bus);
 
 	return max;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e72ca8dd6241..d7fe72aa53b3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1952,6 +1952,8 @@ void pcibios_penalize_isa_irq(int irq, int active);
 int pcibios_alloc_irq(struct pci_dev *dev);
 void pcibios_free_irq(struct pci_dev *dev);
 resource_size_t pcibios_default_alignment(void);
+void pcibios_rescan_prepare(struct pci_bus *bus);
+void pcibios_rescan_done(struct pci_bus *bus);
 
 #ifdef CONFIG_HIBERNATE_CALLBACKS
 extern struct dev_pm_ops pcibios_pm_ops;
-- 
2.17.1
