Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7DF1B2C1F25
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 04:07:38 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 44/77] lpfc: Make MSI-X initialization routine more
 readable
Date: Wed,  2 Oct 2013 12:49:00 +0200
Message-Id: <f3a2e684c57fb47c8f789b0aca078d90c0e52878.1380703263.git.agordeev@redhat.com>
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 stable@vger.kernel.org, linux-s390@vger.kernel.org,
 Andy King <acking@vmware.com>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, x86@kernel.org,
 Alexander Gordeev <agordeev@redhat.com>, linux-pci@vger.kernel.org,
 iss_storagedev@hp.com, linux-driver@qlogic.com, Tejun Heo <tj@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jon Mason <jon.mason@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 e1000-devel@lists.sourceforge.net, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 drivers/scsi/lpfc/lpfc_init.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 0ec8008..0cfaf20 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -8633,10 +8633,6 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
 {
 	int vectors, rc, index;
 
-	/* Set up MSI-X multi-message vectors */
-	for (index = 0; index < phba->cfg_fcp_io_channel; index++)
-		phba->sli4_hba.msix_entries[index].entry = index;
-
 	/* Configure MSI-X capability structure */
 	vectors = phba->cfg_fcp_io_channel;
 
@@ -8650,14 +8646,14 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
 		goto msg_fail_out;
 	}
 
+	/* Set up MSI-X multi-message vectors */
+	for (index = 0; index < vectors; index++)
+		phba->sli4_hba.msix_entries[index].entry = index;
+
 	rc = pci_enable_msix(phba->pcidev, phba->sli4_hba.msix_entries,
 			     vectors);
-	if (rc) {
-msg_fail_out:
-		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
-				"0484 PCI enable MSI-X failed (%d)\n", rc);
-		goto vec_fail_out;
-	}
+	if (rc)
+		goto msg_fail_out;
 
 	/* Log MSI-X vector assignment */
 	for (index = 0; index < vectors; index++)
@@ -8697,7 +8693,7 @@ msg_fail_out:
 	}
 
 	lpfc_sli4_set_affinity(phba, vectors);
-	return rc;
+	return 0;
 
 cfg_fail_out:
 	/* free the irq already requested */
@@ -8710,8 +8706,11 @@ cfg_fail_out:
 
 	/* Unconfigure MSI-X capability structure */
 	pci_disable_msix(phba->pcidev);
+	return rc;
 
-vec_fail_out:
+msg_fail_out:
+	lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
+			"0484 PCI enable MSI-X failed (%d)\n", rc);
 	return rc;
 }
 
-- 
1.7.7.6
