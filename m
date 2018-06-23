Return-Path: <tpearson@raptorengineering.com>
Received: from mail.rptsys.com (mail.rptsys.com [192.119.205.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Csw03nSmzF14f
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jun 2018 10:03:28 +1000 (AEST)
Date: Sat, 23 Jun 2018 18:53:28 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <1820986268.2569250.1529798008396.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH 3/7] powerpc/powernv/pci: Track DMA and TCE tables in debugfs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Add a new debugfs entry to trigger dumping out the tracking table and
TCEs for a given PE, for example PE 0x4 of PHB 2:

echo 0x4 > /sys/kernel/debug/powerpc/PCI0002/sketchy

This will result in the table being dumped out in dmesg.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 43 +++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 7ecc186493ca..55f0f7b885bc 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3342,6 +3342,47 @@ static int pnv_pci_diag_data_set(void *data, u64 val)
 DEFINE_SIMPLE_ATTRIBUTE(pnv_pci_diag_data_fops, NULL,
 			pnv_pci_diag_data_set, "%llu\n");
 
+static int pnv_pci_sketchy_set(void *data, u64 val)
+{
+	struct pci_controller *hose;
+	struct pnv_ioda_pe *pe;
+	struct pnv_phb *phb;
+	u64 entry1, entry2;
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
+	if (!pe->tces || !pe->tce_tracker)
+		return -EIO;
+
+	for (i = 0; i < pe->tce_count; i++) {
+		if (i > 16 && pe->tces[i] == 0)
+			break;
+		pr_info("%3d: %016llx\n", i, be64_to_cpu(pe->tces[i]));
+	}
+
+	for (i = 0; i < pe->tce_count; i++) {
+		entry1 = pe->tce_tracker[i * 2];
+		entry2 = pe->tce_tracker[i * 2 + 1];
+		if (!entry1)
+			break;
+		pr_info("%3d: %016llx %016llx\n", i, entry1, entry2);
+	}
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(pnv_pci_sketchy_fops, NULL,
+			pnv_pci_sketchy_set, "%llu\n");
+
+
 #endif /* CONFIG_DEBUG_FS */
 
 static void pnv_pci_ioda_create_dbgfs(void)
@@ -3367,6 +3408,8 @@ static void pnv_pci_ioda_create_dbgfs(void)
 
 		debugfs_create_file("dump_diag_regs", 0200, phb->dbgfs, hose,
 				    &pnv_pci_diag_data_fops);
+		debugfs_create_file("sketchy", 0200, phb->dbgfs, hose,
+				    &pnv_pci_sketchy_fops);
 	}
 #endif /* CONFIG_DEBUG_FS */
 }
-- 
2.17.1
