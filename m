Return-Path: <kronos.it@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id 3236D67B67
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 08:06:18 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id i2so1088334nfe
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 15:06:15 -0700 (PDT)
Date: Sat, 23 Sep 2006 00:06:29 +0200
From: Luca <kronos.it@gmail.com>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH]: PCI Error Recovery: Symbios SCSI device driver
Message-ID: <20060922220629.GA4600@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060921231314.GW29167@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Linas,

Linas Vepstas <linas@austin.ibm.com> ha scritto:
> Index: linux-2.6.18-rc7-git1/drivers/scsi/sym53c8xx_2/sym_glue.c
> ===================================================================
> --- linux-2.6.18-rc7-git1.orig/drivers/scsi/sym53c8xx_2/sym_glue.c      2006-09-21 17:32:54.000000000 -0500
> +++ linux-2.6.18-rc7-git1/drivers/scsi/sym53c8xx_2/sym_glue.c   2006-09-21 17:35:37.000000000 -0500
> +/**
> + * sym2_io_slot_reset() -- called when the pci bus has been reset.
> + * @pdev: pointer to PCI device
> + *
> + * Restart the card from scratch.
> + */
> +static pci_ers_result_t sym2_io_slot_reset (struct pci_dev *pdev)
> +{
> +       struct sym_hcb *np = pci_get_drvdata(pdev);
> +
> +       printk (KERN_INFO "%s: recovering from a PCI slot reset\n",

Space after function name? You put in other places too, it's not
consistent with the rest of the patch.

> +           sym_name(np));
> +
> +       if (pci_enable_device(pdev))
> +               printk (KERN_ERR "%s: device setup failed most egregiously\n",
> +                           sym_name(np));

Is the failure of pci_enable_device ignored on purpose?
(plus extra space)

> +
> +       pci_set_master(pdev);
> +       enable_irq (pdev->irq);

Spurious space.

> +
> +       /* Perform host reset only on one instance of the card */
> +       if (0 == PCI_FUNC (pdev->devfn)) {

Ditto.

> +               if (sym_reset_scsi_bus(np, 0)) {
> +                  printk(KERN_ERR "%s: Unable to reset scsi host controller\n",
> +                                                 sym_name(np));
> +                       return PCI_ERS_RESULT_DISCONNECT;
> +               }
> +               sym_start_up (np, 1);

Ditto.

> +       }
> +
> +       return PCI_ERS_RESULT_RECOVERED;
> +}


Luca
-- 
"L'abilita` politica e` l'abilita` di prevedere quello che
 accadra` domani, la prossima settimana, il prossimo mese e
 l'anno prossimo. E di essere cosi` abili, piu` tardi,
 da spiegare  perche' non e` accaduto."
