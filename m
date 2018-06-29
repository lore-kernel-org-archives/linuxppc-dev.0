Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41H7hg5lT5zF1d2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 17:34:59 +1000 (AEST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, alistair@popple.id.au, aik@ozlabs.ru,
 tpearson@raptorengineering.com, Russell Currey <ruscur@russell.cc>
Subject: [PATCH 3/3] powerpc/powernv/pci: Track TCE tables in debugfs
Date: Fri, 29 Jun 2018 17:34:37 +1000
Message-Id: <20180629073437.4060-4-ruscur@russell.cc>
In-Reply-To: <20180629073437.4060-1-ruscur@russell.cc>
References: <20180629073437.4060-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a new debugfs entry to trigger dumping out the TCEs for a
given PE using pseudo-bypass, for example PE 0x4 of PHB 2:

echo 0x4 > /sys/kernel/debug/powerpc/PCI0002/dump_tces

This will result in the table being dumped out in dmesg.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 34 +++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d2ca214610fd..91316d3c26dc 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3314,6 +3314,38 @@ static int pnv_pci_diag_data_set(void *data, u64 val)
 DEFINE_SIMPLE_ATTRIBUTE(pnv_pci_diag_data_fops, NULL,
 			pnv_pci_diag_data_set, "%llu\n");
 
+static int pnv_pci_dump_tces_set(void *data, u64 val)
+{
+	struct pci_controller *hose;
+	struct pnv_ioda_pe *pe;
+	struct pnv_phb *phb;
+	int i;
+
+	hose = (struct pci_controller *)data;
+	if (!hose || !hose->private_data)
+		return -ENODEV;
+
+	phb = hose->private_data;
+	pe = &phb->ioda.pe_array[val];
+
+	if (!pe)
+		return -EINVAL;
+
+	if (!pe->tces)
+		return -EIO;
+
+	for (i = 0; i < pe->tce_count; i++) {
+		if (i > 16 && pe->tces[i] == 0)
+			break;
+		pr_info("TCE %3d: %016llx\n", i, be64_to_cpu(pe->tces[i]));
+	}
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(pnv_pci_dump_tces_fops, NULL,
+			pnv_pci_dump_tces_set, "%llu\n");
+
+
 #endif /* CONFIG_DEBUG_FS */
 
 static void pnv_pci_ioda_create_dbgfs(void)
@@ -3339,6 +3371,8 @@ static void pnv_pci_ioda_create_dbgfs(void)
 
 		debugfs_create_file("dump_diag_regs", 0200, phb->dbgfs, hose,
 				    &pnv_pci_diag_data_fops);
+		debugfs_create_file("dump_tces", 0200, phb->dbgfs, hose,
+				    &pnv_pci_dump_tces_fops);
 	}
 #endif /* CONFIG_DEBUG_FS */
 }
-- 
2.17.1
