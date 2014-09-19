Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8098F1A04F7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 16:54:21 +1000 (EST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E1FF9140187
 for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2014 16:54:20 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 19 Sep 2014 16:54:19 +1000
Date: Fri, 19 Sep 2014 16:54:12 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 05/15] powerpc/powernv: Split out set MSI IRQ chip code
Message-ID: <20140919065412.GA27190@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1411028820-29933-1-git-send-email-mikey@neuling.org>
 <1411028820-29933-6-git-send-email-mikey@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411028820-29933-6-git-send-email-mikey@neuling.org>
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, greg@kroah.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, imunsie@au1.ibm.com,
 anton@samba.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 18, 2014 at 06:26:50PM +1000, Michael Neuling wrote:
>From: Ian Munsie <imunsie@au1.ibm.com>
>
>Some of the MSI IRQ code in pnv_pci_ioda_msi_setup() is generically useful so
>split it out.
>
>This will be used by some of the cxl PCIe code later.
>
>Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
>Signed-off-by: Michael Neuling <mikey@neuling.org>
>---
> arch/powerpc/platforms/powernv/pci-ioda.c | 43 ++++++++++++++++++-------------
> 1 file changed, 25 insertions(+), 18 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index df241b1..194f90a 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -1306,14 +1306,36 @@ static void pnv_ioda2_msi_eoi(struct irq_data *d)
> 	icp_native_eoi(d);
> }
> 
>+
>+static void set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq)
>+{
>+	struct irq_data *idata;
>+	struct irq_chip *ichip;
>+
>+	/*
>+	 * Change the IRQ chip for the MSI interrupts on PHB3.
>+	 * The corresponding IRQ chip should be populated for
>+	 * the first time.
>+	 */
>+	if (phb->type == PNV_PHB_IODA2) {
>+		if (!phb->ioda.irq_chip_init) {
>+			idata = irq_get_irq_data(virq);
>+			ichip = irq_data_get_irq_chip(idata);
>+			phb->ioda.irq_chip_init = 1;
>+			phb->ioda.irq_chip = *ichip;
>+			phb->ioda.irq_chip.irq_eoi = pnv_ioda2_msi_eoi;
>+		}
>+
>+		irq_set_chip(virq, &phb->ioda.irq_chip);
>+	}
>+}
>+

Nitpick: to check PHB type and bail early could avoid nested code :)

	if (phb->type != PNV_PHB_IODA2)
		return;

> static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
> 				  unsigned int hwirq, unsigned int virq,
> 				  unsigned int is_64, struct msi_msg *msg)
> {
> 	struct pnv_ioda_pe *pe = pnv_ioda_get_pe(dev);
> 	struct pci_dn *pdn = pci_get_pdn(dev);
>-	struct irq_data *idata;
>-	struct irq_chip *ichip;
> 	unsigned int xive_num = hwirq - phb->msi_base;
> 	__be32 data;
> 	int rc;
>@@ -1365,22 +1387,7 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
> 	}
> 	msg->data = be32_to_cpu(data);
> 
>-	/*
>-	 * Change the IRQ chip for the MSI interrupts on PHB3.
>-	 * The corresponding IRQ chip should be populated for
>-	 * the first time.
>-	 */
>-	if (phb->type == PNV_PHB_IODA2) {
>-		if (!phb->ioda.irq_chip_init) {
>-			idata = irq_get_irq_data(virq);
>-			ichip = irq_data_get_irq_chip(idata);
>-			phb->ioda.irq_chip_init = 1;
>-			phb->ioda.irq_chip = *ichip;
>-			phb->ioda.irq_chip.irq_eoi = pnv_ioda2_msi_eoi;
>-		}
>-
>-		irq_set_chip(virq, &phb->ioda.irq_chip);
>-	}
>+	set_msi_irq_chip(phb, virq);
> 
> 	pr_devel("%s: %s-bit MSI on hwirq %x (xive #%d),"
> 		 " address=%x_%08x data=%x PE# %d\n",

Thanks,
Gavin
