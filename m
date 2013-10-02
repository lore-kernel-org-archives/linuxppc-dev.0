Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 30B452C0085
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 02:40:59 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 45/77] megaraid: Update MSI/MSI-X interrupts enablement
 code
Date: Wed,  2 Oct 2013 12:49:01 +0200
Message-Id: <9c28bb824f403b6418840970f2a3b63d9fa9d924.1380703263.git.agordeev@redhat.com>
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
 drivers/scsi/megaraid/megaraid_sas_base.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3020921..b5973e4 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3727,18 +3727,16 @@ static int megasas_init_fw(struct megasas_instance *instance)
 					     (unsigned int)num_online_cpus());
 		for (i = 0; i < instance->msix_vectors; i++)
 			instance->msixentry[i].entry = i;
-		i = pci_enable_msix(instance->pdev, instance->msixentry,
-				    instance->msix_vectors);
-		if (i >= 0) {
-			if (i) {
-				if (!pci_enable_msix(instance->pdev,
-						     instance->msixentry, i))
-					instance->msix_vectors = i;
-				else
-					instance->msix_vectors = 0;
-			}
-		} else
+		i = pci_msix_table_size(instance->pdev);
+		if (i < 0) {
 			instance->msix_vectors = 0;
+		} else {
+			if (!pci_enable_msix(instance->pdev,
+					     instance->msixentry, i))
+				instance->msix_vectors = i;
+			else
+				instance->msix_vectors = 0;
+		}
 
 		dev_info(&instance->pdev->dev, "[scsi%d]: FW supports"
 			"<%d> MSIX vector,Online CPUs: <%d>,"
-- 
1.7.7.6
