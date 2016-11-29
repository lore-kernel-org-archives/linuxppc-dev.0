Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSWfj3dLfzDvmL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 16:03:57 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAT4wVCs072079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 00:03:55 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2712rw2m7b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 00:03:54 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 29 Nov 2016 15:03:51 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 20B832CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 16:03:49 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAT53nrO34537596
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 16:03:49 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAT53m1k026945
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 16:03:48 +1100
Date: Tue, 29 Nov 2016 16:05:10 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, clsoto@us.ibm.com,
 benh@kernel.crashing.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH v4 7/7] PCI: Add comments about ROM BAR updating
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161129041648.21453.94596.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161129041648.21453.94596.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-Id: <20161129050510.GA23688@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 28, 2016 at 10:16:48PM -0600, Bjorn Helgaas wrote:
>pci_update_resource() updates a hardware BAR so its address matches the
>kernel's struct resource UNLESS it's a disabled ROM BAR.  We only update
>those when we enable the ROM.
>
>It's not obvious from the code why ROM BARs should be handled specially.
>Apparently there are Matrox devices with defective ROM BARs that read as
>zero when disabled.  That means that if pci_enable_rom() reads the disabled
>BAR, sets PCI_ROM_ADDRESS_ENABLE (without re-inserting the address), and
>writes it back, it would enable the ROM at address zero.
>
>Add comments and references to explain why we can't make the code look more
>rational.
>
>The code changes are from 755528c860b0 ("Ignore disabled ROM resources at
>setup") and 8085ce084c0f ("[PATCH] Fix PCI ROM mapping").
>
>Link: https://lkml.org/lkml/2005/8/30/138
>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> drivers/pci/rom.c       |    5 +++++
> drivers/pci/setup-res.c |    6 ++++++
> 2 files changed, 11 insertions(+)
>
>diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
>index 06663d3..b6edb18 100644
>--- a/drivers/pci/rom.c
>+++ b/drivers/pci/rom.c
>@@ -35,6 +35,11 @@ int pci_enable_rom(struct pci_dev *pdev)
> 	if (res->flags & IORESOURCE_ROM_SHADOW)
> 		return 0;
>
>+	/*
>+	 * Ideally pci_update_resource() would update the ROM BAR address,
>+	 * and we would only set the enable bit here.  But apparently some
>+	 * devices have buggy ROM BARs that read as zero when disabled.
>+	 */
> 	pcibios_resource_to_bus(pdev->bus, &region, res);
> 	pci_read_config_dword(pdev, pdev->rom_base_reg, &rom_addr);
> 	rom_addr &= ~PCI_ROM_ADDRESS_MASK;
>diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
>index 09bdff7..57d7041 100644
>--- a/drivers/pci/setup-res.c
>+++ b/drivers/pci/setup-res.c
>@@ -67,6 +67,12 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
> 	if (resno < PCI_ROM_RESOURCE) {
> 		reg = PCI_BASE_ADDRESS_0 + 4 * resno;
> 	} else if (resno == PCI_ROM_RESOURCE) {
>+
>+		/*
>+		 * Apparently some Matrox devices have ROM BARs that read
>+		 * as zero when disabled, so don't update ROM BARs unless
>+		 * they're enabled.  See https://lkml.org/lkml/2005/8/30/138.
>+		 */
> 		if (!(res->flags & IORESOURCE_ROM_ENABLE))
> 			return;
>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
