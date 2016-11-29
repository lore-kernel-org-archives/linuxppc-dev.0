Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSWb94WKPzDvMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 16:00:53 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAT4wX7C008869
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 00:00:51 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27128b4wy2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 00:00:50 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 29 Nov 2016 15:00:47 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D629A3578057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 16:00:44 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAT50jT530605542
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 16:00:45 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAT50ies000421
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 16:00:44 +1100
Date: Tue, 29 Nov 2016 16:02:05 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, clsoto@us.ibm.com,
 benh@kernel.crashing.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH v4 5/7] PCI: Remove pci_resource_bar() and
 pci_iov_resource_bar()
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161129041542.21453.14468.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161129041542.21453.14468.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-Id: <20161129050205.GA23115@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 28, 2016 at 10:15:42PM -0600, Bjorn Helgaas wrote:
>pci_std_update_resource() only deals with standard BARs, so we don't have
>to worry about the complications of VF BARs in an SR-IOV capability.
>
>Compute the BAR address inline and remove pci_resource_bar().  That makes
>pci_iov_resource_bar() unused, so remove that as well.
>
>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> drivers/pci/iov.c       |   18 ------------------
> drivers/pci/pci.c       |   30 ------------------------------
> drivers/pci/pci.h       |    6 ------
> drivers/pci/setup-res.c |   13 +++++++------
> 4 files changed, 7 insertions(+), 60 deletions(-)
>
>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>index a800ba2..c9c84ba 100644
>--- a/drivers/pci/iov.c
>+++ b/drivers/pci/iov.c
>@@ -554,24 +554,6 @@ void pci_iov_release(struct pci_dev *dev)
> }
>
> /**
>- * pci_iov_resource_bar - get position of the SR-IOV BAR
>- * @dev: the PCI device
>- * @resno: the resource number
>- *
>- * Returns position of the BAR encapsulated in the SR-IOV capability.
>- */
>-int pci_iov_resource_bar(struct pci_dev *dev, int resno)
>-{
>-	if (resno < PCI_IOV_RESOURCES || resno > PCI_IOV_RESOURCE_END)
>-		return 0;
>-
>-	BUG_ON(!dev->is_physfn);
>-
>-	return dev->sriov->pos + PCI_SRIOV_BAR +
>-		4 * (resno - PCI_IOV_RESOURCES);
>-}
>-
>-/**
>  * pci_iov_update_resource - update a VF BAR
>  * @dev: the PCI device
>  * @resno: the resource number
>diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>index 631eac2..ec3f16d 100644
>--- a/drivers/pci/pci.c
>+++ b/drivers/pci/pci.c
>@@ -4827,36 +4827,6 @@ int pci_select_bars(struct pci_dev *dev, unsigned long flags)
> }
> EXPORT_SYMBOL(pci_select_bars);
>
>-/**
>- * pci_resource_bar - get position of the BAR associated with a resource
>- * @dev: the PCI device
>- * @resno: the resource number
>- * @type: the BAR type to be filled in
>- *
>- * Returns BAR position in config space, or 0 if the BAR is invalid.
>- */
>-int pci_resource_bar(struct pci_dev *dev, int resno, enum pci_bar_type *type)
>-{
>-	int reg;
>-
>-	if (resno < PCI_ROM_RESOURCE) {
>-		*type = pci_bar_unknown;
>-		return PCI_BASE_ADDRESS_0 + 4 * resno;
>-	} else if (resno == PCI_ROM_RESOURCE) {
>-		*type = pci_bar_mem32;
>-		return dev->rom_base_reg;
>-	} else if (resno < PCI_BRIDGE_RESOURCES) {
>-		/* device specific resource */
>-		*type = pci_bar_unknown;
>-		reg = pci_iov_resource_bar(dev, resno);
>-		if (reg)
>-			return reg;
>-	}
>-
>-	dev_err(&dev->dev, "BAR %d: invalid resource\n", resno);
>-	return 0;
>-}
>-
> /* Some architectures require additional programming to enable VGA */
> static arch_set_vga_state_t arch_set_vga_state;
>
>diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>index 5bfcb92..a5d37f6 100644
>--- a/drivers/pci/pci.h
>+++ b/drivers/pci/pci.h
>@@ -245,7 +245,6 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
> int pci_setup_device(struct pci_dev *dev);
> int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> 		    struct resource *res, unsigned int reg);
>-int pci_resource_bar(struct pci_dev *dev, int resno, enum pci_bar_type *type);
> void pci_configure_ari(struct pci_dev *dev);
> void __pci_bus_size_bridges(struct pci_bus *bus,
> 			struct list_head *realloc_head);
>@@ -289,7 +288,6 @@ static inline void pci_restore_ats_state(struct pci_dev *dev)
> #ifdef CONFIG_PCI_IOV
> int pci_iov_init(struct pci_dev *dev);
> void pci_iov_release(struct pci_dev *dev);
>-int pci_iov_resource_bar(struct pci_dev *dev, int resno);
> void pci_iov_update_resource(struct pci_dev *dev, int resno);
> resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
> void pci_restore_iov_state(struct pci_dev *dev);
>@@ -304,10 +302,6 @@ static inline void pci_iov_release(struct pci_dev *dev)
>
> {
> }
>-static inline int pci_iov_resource_bar(struct pci_dev *dev, int resno)
>-{
>-	return 0;
>-}
> static inline void pci_restore_iov_state(struct pci_dev *dev)
> {
> }
>diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
>index ee0be34..09bdff7 100644
>--- a/drivers/pci/setup-res.c
>+++ b/drivers/pci/setup-res.c
>@@ -32,7 +32,6 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
> 	u16 cmd;
> 	u32 new, check, mask;
> 	int reg;
>-	enum pci_bar_type type;
> 	struct resource *res = dev->resource + resno;
>
> 	/* Per SR-IOV spec 3.4.1.11, VF BARs are RO zero */
>@@ -65,14 +64,16 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
> 	else
> 		mask = (u32)PCI_BASE_ADDRESS_MEM_MASK;
>
>-	reg = pci_resource_bar(dev, resno, &type);
>-	if (!reg)
>-		return;
>-	if (type != pci_bar_unknown) {
>+	if (resno < PCI_ROM_RESOURCE) {
>+		reg = PCI_BASE_ADDRESS_0 + 4 * resno;
>+	} else if (resno == PCI_ROM_RESOURCE) {
> 		if (!(res->flags & IORESOURCE_ROM_ENABLE))
> 			return;
>+
>+		reg = dev->rom_base_reg;
> 		new |= PCI_ROM_ADDRESS_ENABLE;
>-	}
>+	} else
>+		return;
>
> 	/*
> 	 * We can't update a 64-bit BAR atomically, so when possible,
>
