Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6BC432C186C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 03:52:42 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 03/77] PCI/MSI/s390: Fix single MSI only check
Date: Wed,  2 Oct 2013 12:48:19 +0200
Message-Id: <8c9811b13fd93e73641dab8e3bd1bd5b2dc37a61.1380703262.git.agordeev@redhat.com>
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

Multiple MSIs have never been supported on s390 architecture,
but the platform code fails to report single MSI only.

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 arch/s390/pci/pci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index f17a834..c79c6e4 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -427,6 +427,8 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	pr_debug("%s: requesting %d MSI-X interrupts...", __func__, nvec);
 	if (type != PCI_CAP_ID_MSIX && type != PCI_CAP_ID_MSI)
 		return -EINVAL;
+	if (type == PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
 	msi_vecs = min(nvec, ZPCI_MSI_VEC_MAX);
 	msi_vecs = min_t(unsigned int, msi_vecs, CONFIG_PCI_NR_MSI);
 
-- 
1.7.7.6
