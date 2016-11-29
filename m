Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSWRw6cpNzDwVf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:54:36 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAT4s8uq037585
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 23:54:34 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 270w68nh9m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 23:54:34 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 29 Nov 2016 14:54:31 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 29A142BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:54:28 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAT4sR2C52166864
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:54:27 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAT4sQlZ011456
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:54:27 +1100
Date: Tue, 29 Nov 2016 15:55:46 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, clsoto@us.ibm.com,
 benh@kernel.crashing.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH v4 3/7] PCI: Separate VF BAR updates from standard BAR
 updates
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161129041506.21453.18478.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161129041506.21453.18478.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-Id: <20161129045546.GB20642@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 28, 2016 at 10:15:06PM -0600, Bjorn Helgaas wrote:
>Previously pci_update_resource() used the same code path for updating
>standard BARs and VF BARs in SR-IOV capabilities.
>
>Split the VF BAR update into a new pci_iov_update_resource() internal
>interface, which makes it simpler to compute the BAR address (we can get
>rid of pci_resource_bar() and pci_iov_resource_bar()).
>
>This patch:
>
>  - Renames pci_update_resource() to pci_std_update_resource(),
>  - Adds pci_iov_update_resource(),
>  - Makes pci_update_resource() a wrapper that calls the appropriate one,
>
>No functional change intended.
>
>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

With below minor comments fixed:

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> drivers/pci/iov.c       |   49 +++++++++++++++++++++++++++++++++++++++++++++++
> drivers/pci/pci.h       |    1 +
> drivers/pci/setup-res.c |   13 +++++++++++-
> 3 files changed, 61 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>index d41ec29..d00ed5c 100644
>--- a/drivers/pci/iov.c
>+++ b/drivers/pci/iov.c
>@@ -571,6 +571,55 @@ int pci_iov_resource_bar(struct pci_dev *dev, int resno)
> 		4 * (resno - PCI_IOV_RESOURCES);
> }
>
>+/**
>+ * pci_iov_update_resource - update a VF BAR
>+ * @dev: the PCI device
>+ * @resno: the resource number
>+ *
>+ * Update a VF BAR in the SR-IOV capability of a PF.
>+ */
>+void pci_iov_update_resource(struct pci_dev *dev, int resno)
>+{
>+	struct pci_sriov *iov = dev->is_physfn ? dev->sriov : NULL;
>+	struct resource *res = dev->resource + resno;
>+	int vf_bar = resno - PCI_IOV_RESOURCES;
>+	struct pci_bus_region region;
>+	u32 new;
>+	int reg;
>+
>+	/*
>+	 * The generic pci_restore_bars() path calls this for all devices,
>+	 * including VFs and non-SR-IOV devices.  If this is not a PF, we
>+	 * have nothing to do.
>+	 */
>+	if (!iov)
>+		return;
>+
>+	/*
>+	 * Ignore unimplemented BARs, unused resource slots for 64-bit
>+	 * BARs, and non-movable resources, e.g., those described via
>+	 * Enhanced Allocation.
>+	 */
>+	if (!res->flags)
>+		return;
>+
>+	if (res->flags & IORESOURCE_UNSET)
>+		return;
>+
>+	if (res->flags & IORESOURCE_PCI_FIXED)
>+		return;
>+
>+	pcibios_resource_to_bus(dev->bus, &region, res);
>+	new = region.start;
>+

The bits indicating the BAR's property (e.g. memory, IO etc) are missed in @new.

>+	reg = iov->pos + PCI_SRIOV_BAR + 4 * vf_bar;
>+	pci_write_config_dword(dev, reg, new);
>+	if (res->flags & IORESOURCE_MEM_64) {
>+		new = region.start >> 16 >> 16;

I think it was copied from pci_update_resource(). Why we can't just have "new = region.start >> 32"? 

>+		pci_write_config_dword(dev, reg + 4, new);
>+	}
>+}
>+
> resource_size_t __weak pcibios_iov_resource_alignment(struct pci_dev *dev,
> 						      int resno)
> {
>diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>index 4518562..5bfcb92 100644
>--- a/drivers/pci/pci.h
>+++ b/drivers/pci/pci.h
>@@ -290,6 +290,7 @@ static inline void pci_restore_ats_state(struct pci_dev *dev)
> int pci_iov_init(struct pci_dev *dev);
> void pci_iov_release(struct pci_dev *dev);
> int pci_iov_resource_bar(struct pci_dev *dev, int resno);
>+void pci_iov_update_resource(struct pci_dev *dev, int resno);
> resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
> void pci_restore_iov_state(struct pci_dev *dev);
> int pci_iov_bus_range(struct pci_bus *bus);
>diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
>index d2a32d8..ee0be34 100644
>--- a/drivers/pci/setup-res.c
>+++ b/drivers/pci/setup-res.c
>@@ -25,8 +25,7 @@
> #include <linux/slab.h>
> #include "pci.h"
>
>-
>-void pci_update_resource(struct pci_dev *dev, int resno)
>+static void pci_std_update_resource(struct pci_dev *dev, int resno)
> {
> 	struct pci_bus_region region;
> 	bool disable;
>@@ -109,6 +108,16 @@ void pci_update_resource(struct pci_dev *dev, int resno)
> 		pci_write_config_word(dev, PCI_COMMAND, cmd);
> }
>
>+void pci_update_resource(struct pci_dev *dev, int resno)
>+{
>+	if (resno <= PCI_ROM_RESOURCE)
>+		pci_std_update_resource(dev, resno);
>+#ifdef CONFIG_PCI_IOV
>+	else if (resno >= PCI_IOV_RESOURCES && resno < PCI_IOV_RESOURCE_END)

The last BAR is missed:

	else if (resno >= PCI_IOV_RESOURCES && resno <= PCI_IOV_RESOURCE_END)

>+		pci_iov_update_resource(dev, resno);
>+#endif
>+}
>+
> int pci_claim_resource(struct pci_dev *dev, int resource)
> {
> 	struct resource *res = &dev->resource[resource];
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
