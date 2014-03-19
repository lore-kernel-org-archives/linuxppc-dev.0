Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0237.outbound.protection.outlook.com [207.46.163.237])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7EA282C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 08:01:19 +1100 (EST)
Date: Wed, 19 Mar 2014 16:00:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Subject: Re: [2/2] fsl/pci: The new pci suspend/resume implementation
Message-ID: <20140319210041.GA14019@home.buserror.net>
References: <1389081848-26506-2-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1389081848-26506-2-git-send-email-dongsheng.wang@freescale.com>
Cc: roy.zang@freescale.com, galak@codeaurora.org, rjw@rjwysocki.net,
 linux-pci@vger.kernel.org, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 07, 2014 at 04:04:08PM +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> The new suspend/resume implementation, send pme turnoff message
> in suspend, and send pme exit message in resume.
> 
> Add a PME handler, to response PME & message interrupt.
> 
> Change platform_driver->suspend/resume to syscore->suspend/resume.
> pci-driver will call back EP device, to save EP state in
> pci_pm_suspend_noirq, so we need to keep the link, until
> pci_pm_suspend_noirq finish.
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

Is this patch OK to go in without patch 1/2?  It's not clear whether that
was deemed incorrect (as in new patch coming) or unnecessary.

It would also be good if you submit with the explanation from
http://www.spinics.net/lists/linux-pci/msg27844.html in the commit
message.

> -static int fsl_pci_probe(struct platform_device *pdev)
> +#ifdef CONFIG_PM
> +static irqreturn_t fsl_pci_pme_handle(int irq, void *dev_id)
>  {
> -	int ret;
> -	struct device_node *node;
> +	struct pci_controller *hose = dev_id;
> +	struct ccsr_pci __iomem *pci = hose->private_data;
> +	u32 dr;
>  
> -	node = pdev->dev.of_node;
> -	ret = fsl_add_bridge(pdev, fsl_pci_primary == node);
> +	dr = in_be32(&pci->pex_pme_mes_dr);
> +	if (dr)
> +		out_be32(&pci->pex_pme_mes_dr, dr);
> +	else
> +		return IRQ_NONE;
>  
> -	mpc85xx_pci_err_probe(pdev);
> +	return IRQ_HANDLED;
> +}

Why do you put some of the HANDLED path in the if statement, and some
outside?

Just do:

if (!dr)
	return IRQ_NONE;

out_be32(...);
return IRQ_HANDLED;

> +static int fsl_pci_pme_probe(struct pci_controller *hose)
> +{
> +	struct ccsr_pci __iomem *pci;
> +	struct pci_dev *dev = hose->bus->self;
> +	u16 pms;
> +	int pme_irq;
> +	int res;
> +
> +	/* PME Disable */
> +	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pms);
> +	pms &= ~PCI_PM_CTRL_PME_ENABLE;
> +	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pms);
> +
> +	pme_irq = irq_of_parse_and_map(hose->dn, 0);
> +	if (!pme_irq) {
> +		pr_warn("Failed to map PME interrupt.\n");

dev_err()

> +
> +		return -ENXIO;
> +	}
> +
> +	res = devm_request_irq(hose->parent, pme_irq,
> +			fsl_pci_pme_handle,
> +			IRQF_DISABLED | IRQF_SHARED,
> +			"[PCI] PME", hose);

IRQF_DISABLED is a deprecated no-op.

> +	if (res < 0) {
> +		pr_warn("Unable to requiest irq %d for PME\n", pme_irq);

dev_err() etc.

-Scott
