Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1AEF02C0ADC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 04:03:36 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 41/77] lpfc: Do not call pci_disable_msix() if
 pci_enable_msix() failed
Date: Wed,  2 Oct 2013 12:48:57 +0200
Message-Id: <8e18482bc1c22d1764a743f053909c348d7acdec.1380703263.git.agordeev@redhat.com>
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
 drivers/scsi/lpfc/lpfc_init.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 647f5bf..0803b84 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -8080,7 +8080,7 @@ lpfc_sli_enable_msix(struct lpfc_hba *phba)
 	if (rc) {
 		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
 				"0420 PCI enable MSI-X failed (%d)\n", rc);
-		goto msi_fail_out;
+		goto vec_fail_out;
 	}
 	for (i = 0; i < LPFC_MSIX_VECTORS; i++)
 		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
@@ -8158,6 +8158,8 @@ irq_fail_out:
 msi_fail_out:
 	/* Unconfigure MSI-X capability structure */
 	pci_disable_msix(phba->pcidev);
+
+vec_fail_out:
 	return rc;
 }
 
@@ -8646,7 +8648,7 @@ enable_msix_vectors:
 	} else if (rc) {
 		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
 				"0484 PCI enable MSI-X failed (%d)\n", rc);
-		goto msi_fail_out;
+		goto vec_fail_out;
 	}
 
 	/* Log MSI-X vector assignment */
@@ -8698,9 +8700,10 @@ cfg_fail_out:
 			 &phba->sli4_hba.fcp_eq_hdl[index]);
 	}
 
-msi_fail_out:
 	/* Unconfigure MSI-X capability structure */
 	pci_disable_msix(phba->pcidev);
+
+vec_fail_out:
 	return rc;
 }
 
-- 
1.7.7.6
