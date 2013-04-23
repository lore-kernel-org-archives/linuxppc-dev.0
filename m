Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D75072C0116
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 01:23:25 +1000 (EST)
Message-ID: <1366730513.12131.5.camel@pasglop>
Subject: Re: [PATCH 4/5] powerpc/powernv: Patch MSI EOI handler on P8
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2013 01:21:53 +1000
In-Reply-To: <1366715034-24594-5-git-send-email-shangw@linux.vnet.ibm.com>
References: <1366715034-24594-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1366715034-24594-5-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-04-23 at 19:03 +0800, Gavin Shan wrote:
> 
> +static int pnv_pci_ioda_msi_eoi(struct pnv_phb *phb, unsigned int hw_irq)
> +{
> +       u8 p_bit = 1, q_bit = 1;
> +       long rc;
> +
> +       while (p_bit || q_bit) {
> +               rc = opal_pci_get_xive_reissue(phb->opal_id,
> +                               hw_irq - phb->msi_base, &p_bit, &q_bit);
> +               if (rc) {
> +                       pr_warning("%s: Failed to get P/Q bits of IRQ#%d "
> +                                  "on PHB#%d, rc=%ld\n", __func__, hw_irq,
> +                                  phb->hose->global_number, rc);
> +                       return -EIO;
> +               }
> +               if (!p_bit && !q_bit)
> +                       break;
> +
> +               rc = opal_pci_set_xive_reissue(phb->opal_id,
> +                               hw_irq - phb->msi_base, p_bit, q_bit);
> +               if (rc) {
> +                       pr_warning("%s: Failed to clear P/Q (%01d/%01d) of "
> +                                  "IRQ#%d on PHB#%d, rc=%ld\n", __func__,
> +                                  p_bit, q_bit, hw_irq,
> +                                  phb->hose->global_number, rc);
> +                       return -EIO;
> +               }
> +       }
> +
> +       return 0;
> +}

Can you turn that into a single opal_pci_msi_eoi() ? This means that a
single MSI will trigger only one OPAL call rather than two which is
better for performances.

We will later implement an "optimized" variant using direct MMIO based
on knowing specifically the HW type but not now.

Cheers,
Ben.
