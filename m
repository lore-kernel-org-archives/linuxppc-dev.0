Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D1A3A2C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 02:37:49 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 70/77] vmci: Update MSI/MSI-X interrupts enablement code
Date: Wed,  2 Oct 2013 12:49:26 +0200
Message-Id: <654a7884b9ad6fbe777d00bb0a226010e421b3b9.1380703263.git.agordeev@redhat.com>
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-s390@vger.kernel.org, Andy King <acking@vmware.com>,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org,
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

As result of recent re-design of the MSI/MSI-X interrupts enabling
pattern this driver has to be updated to use the new technique to
obtain a optimal number of MSI/MSI-X interrupts required.

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index b3a2b76..af5caf8 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -377,19 +377,27 @@ static int vmci_enable_msix(struct pci_dev *pdev,
 {
 	int i;
 	int result;
+	int nvec;
 
-	for (i = 0; i < VMCI_MAX_INTRS; ++i) {
+	result = pci_msix_table_size(pdev);
+	if (result < 0)
+		return result;
+
+	nvec = min(result, VMCI_MAX_INTRS);
+	if (nvec < VMCI_MAX_INTRS)
+		nvec = 1;
+
+	for (i = 0; i < nvec; ++i) {
 		vmci_dev->msix_entries[i].entry = i;
 		vmci_dev->msix_entries[i].vector = i;
 	}
 
-	result = pci_enable_msix(pdev, vmci_dev->msix_entries, VMCI_MAX_INTRS);
-	if (result == 0)
-		vmci_dev->exclusive_vectors = true;
-	else if (result > 0)
-		result = pci_enable_msix(pdev, vmci_dev->msix_entries, 1);
+	result = pci_enable_msix(pdev, vmci_dev->msix_entries, nvec);
+	if (result)
+		return result;
 
-	return result;
+	vmci_dev->exclusive_vectors = true;
+	return 0;
 }
 
 /*
-- 
1.7.7.6
