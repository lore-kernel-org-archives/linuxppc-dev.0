Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3FF7EB6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 19:00:33 +1100 (EST)
Message-ID: <4B14CD22.4020806@kernel.org>
Date: Tue, 01 Dec 2009 17:00:34 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio,
	driver Apple PowerMac/PowerBook IDE controller
References: <20091201070834.6A840B7B63@ozlabs.org>
In-Reply-To: <20091201070834.6A840B7B63@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ide@vger.kernel.org, Holger Macht <hmacht@suse.de>,
	linuxppc-dev@lists.ozlabs.org, Jeff Garzik <jeff@garzik.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(cc'ing Holger Macht, please read the comment below pata_macio_mb_event())
Hello,

On 12/01/2009 04:08 PM, Benjamin Herrenschmidt wrote:
> This is a libata driver for the "macio" IDE controller used on most Apple
> PowerMac and PowerBooks. It's a libata equivalent of drivers/ide/ppc/pmac.c

Don't know much about the controller or the platform so my comments
will be pretty confined.

> +/*
> + * Wait 1s for disk to answer on IDE bus after a hard reset
> + * of the device (via GPIO/FCR).
> + *
> + * Some devices seem to "pollute" the bus even after dropping
> + * the BSY bit (typically some combo drives slave on the UDMA
> + * bus) after a hard reset. Since we hard reset all drives on
> + * KeyLargo ATA66, we have to keep that delay around. I may end
> + * up not hard resetting anymore on these and keep the delay only
> + * for older interfaces instead (we have to reset when coming
> + * from MacOS...) --BenH.
> + */
> +#define IDE_WAKEUP_DELAY	(1*HZ)

nitpick: In libata, it's common to use msecs for timing values so that
might be a better option.

> +static const struct pata_macio_timing *pata_macio_find_timing(
> +					    struct pata_macio_priv *priv,
> +					    int mode)
> +{
> +	int i = 0;
> +
> +	while (priv->timings[i].mode > 0) {
> +		if (priv->timings[i].mode == mode)
> +			return &priv->timings[i];
> +		i++;
> +	}
> +	return NULL;

Wouldn't for (i = 0; ...) look better?

> +static void pata_macio_bmdma_start(struct ata_queued_cmd *qc)
> +{
> +	struct ata_port *ap = qc->ap;
> +	struct pata_macio_priv *priv = ap->private_data;
> +	struct dbdma_regs __iomem *dma_regs = ap->ioaddr.bmdma_addr;
> +
> +	dev_dbgdma(priv->dev, "%s: qc %p\n", __func__, qc);
> +
> +	writel((RUN << 16) | RUN, &dma_regs->control);
> +	/* Make sure it gets to the controller right now */
> +	(void)readl(&dma_regs->control);

Is flushing necessary here?  There's no ordering issue here, right?

> +static void pata_macio_bmdma_stop(struct ata_queued_cmd *qc)
> +{
> +	struct ata_port *ap = qc->ap;
> +	struct pata_macio_priv *priv = ap->private_data;
> +	struct dbdma_regs __iomem *dma_regs = ap->ioaddr.bmdma_addr;
> +
> +	dev_dbgdma(priv->dev, "%s: qc %p\n", __func__, qc);
> +
> +	/* Stop the DMA engine and wait for it to full halt */
> +	writel (((RUN|WAKE|DEAD) << 16), &dma_regs->control);
> +	while (readl(&dma_regs->status) & RUN)
> +		udelay(1);

Heh... this is a scary looking loop.  It would be great if the above
loop can be capped somehow.

> +static u8 pata_macio_bmdma_status(struct ata_port *ap)
> +{
> +	struct pata_macio_priv *priv = ap->private_data;
> +	struct dbdma_regs __iomem *dma_regs = ap->ioaddr.bmdma_addr;
> +	u32 dstat, rstat = ATA_DMA_INTR;
> +	unsigned long timeout = 0;
> +
> +	dstat = readl(&dma_regs->status);
> +
> +	dev_dbgdma(priv->dev, "%s: dstat=%x\n", __func__, dstat);
> +
> +	/* We have to things to deal with here:
                   ^^
                   two

> +/* port_start is when we allocate the DMA command list */
> +static int pata_macio_port_start(struct ata_port *ap)
> +{
> +	struct pata_macio_priv *priv = ap->private_data;
> +	struct dbdma_regs __iomem *dma_regs = ap->ioaddr.bmdma_addr;
> +
> +	if (dma_regs == NULL)
> +		return 0;
> +
> +	/* Make sure DMA controller is stopped */
> +	writel((RUN|PAUSE|FLUSH|WAKE|DEAD) << 16, &dma_regs->control);
> +	while (readl(&dma_regs->status) & RUN)
> +		udelay(1);

Hmmm.... this probably belongs to ->freeze() which is responsible for
stopping any in-flight operations and masking IRQ and libata will call
it during initialization before requesting IRQ, so you won't need to
call it explicitly here.

> +#ifdef CONFIG_PMAC_MEDIABAY
> +static void pata_macio_mb_event(struct macio_dev* mdev, int mb_state)
> +{
> +	struct ata_host *host = macio_get_drvdata(mdev);
> +	struct ata_port *ap;
> +	struct ata_eh_info *ehi;
> +	struct ata_device *dev;
> +	unsigned long flags;
> +
> +	if (!host)
> +		return;
> +	ap = host->ports[0];
> +	spin_lock_irqsave(ap->lock, flags);
> +	ehi = &ap->link.eh_info;
> +	if (mb_state == MB_CD) {
> +		ata_ehi_push_desc(ehi, "mediabay plug");
> +		ata_ehi_hotplugged(ehi);
> +		ata_port_freeze(ap);
> +	} else {
> +		ata_ehi_push_desc(ehi, "mediabay unplug");
> +		ata_for_each_dev(dev, &ap->link, ALL)
> +			dev->flags |= ATA_DFLAG_DETACH;
> +		ata_port_schedule_eh(ap);

I think you'll need an ata_port_freeze() or abort() here because at
this point the drive is already gone and all in-flight commands need
to be failed right away.  Holger, do you remember why
ata_acpi_detach_device() is using ata_port_schedule_eh() instead?  Was
it because ata_port_freeze() might end up poking registers after
hotunplug happened?  ISTR reports where accessing any register there
causing the whole system to lock up but then why can't it use
ata_port_abort() instead?

Thanks.

-- 
tejun
