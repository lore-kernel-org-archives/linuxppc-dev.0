Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0D5741007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 10:20:17 +1100 (EST)
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio, driver Apple
	PowerMac/PowerBook IDE controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tejun Heo <tj@kernel.org>
In-Reply-To: <4B14CD22.4020806@kernel.org>
References: <20091201070834.6A840B7B63@ozlabs.org>
	<4B14CD22.4020806@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Dec 2009 10:19:12 +1100
Message-ID: <1259709552.2076.1053.camel@pasglop>
Mime-Version: 1.0
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

On Tue, 2009-12-01 at 17:00 +0900, Tejun Heo wrote:

> > +#define IDE_WAKEUP_DELAY	(1*HZ)
> 
> nitpick: In libata, it's common to use msecs for timing values so that
> might be a better option.

Yeah, that's cruft lifted from the old driver, I'll fix it.

> > +static const struct pata_macio_timing *pata_macio_find_timing(
> > +					    struct pata_macio_priv *priv,
> > +					    int mode)
> > +{
> > +	int i = 0;
> > +
> > +	while (priv->timings[i].mode > 0) {
> > +		if (priv->timings[i].mode == mode)
> > +			return &priv->timings[i];
> > +		i++;
> > +	}
> > +	return NULL;
> 
> Wouldn't for (i = 0; ...) look better?

Yeah, I suppose so :-)

> > +static void pata_macio_bmdma_start(struct ata_queued_cmd *qc)
> > +{
> > +	struct ata_port *ap = qc->ap;
> > +	struct pata_macio_priv *priv = ap->private_data;
> > +	struct dbdma_regs __iomem *dma_regs = ap->ioaddr.bmdma_addr;
> > +
> > +	dev_dbgdma(priv->dev, "%s: qc %p\n", __func__, qc);
> > +
> > +	writel((RUN << 16) | RUN, &dma_regs->control);
> > +	/* Make sure it gets to the controller right now */
> > +	(void)readl(&dma_regs->control);
> 
> Is flushing necessary here?  There's no ordering issue here, right?

That's also lifted pretty-much as-is from the old driver. Now I probably
wrote that part of the old driver too ages ago :-) I think I just want
to make sure the DMA starts asap and doesn't sit in some bridge write
posting queue for hundreds of cycles.

> > +static void pata_macio_bmdma_stop(struct ata_queued_cmd *qc)
> > +{
> > +	struct ata_port *ap = qc->ap;
> > +	struct pata_macio_priv *priv = ap->private_data;
> > +	struct dbdma_regs __iomem *dma_regs = ap->ioaddr.bmdma_addr;
> > +
> > +	dev_dbgdma(priv->dev, "%s: qc %p\n", __func__, qc);
> > +
> > +	/* Stop the DMA engine and wait for it to full halt */
> > +	writel (((RUN|WAKE|DEAD) << 16), &dma_regs->control);
> > +	while (readl(&dma_regs->status) & RUN)
> > +		udelay(1);
> 
> Heh... this is a scary looking loop.  It would be great if the above
> loop can be capped somehow.

Yeah, again, lifted from the old driver. We do that sort of loops in
various other drivers that use those DBDMA channels and I don't think
ever saw the loop hang, so at least those HW aren't -that- broken but I
suppose a little timeout wouldn't hurt. Not sure what to do if we hit it
tho.
 
> > +static u8 pata_macio_bmdma_status(struct ata_port *ap)
> > +{
> > +	struct pata_macio_priv *priv = ap->private_data;
> > +	struct dbdma_regs __iomem *dma_regs = ap->ioaddr.bmdma_addr;
> > +	u32 dstat, rstat = ATA_DMA_INTR;
> > +	unsigned long timeout = 0;
> > +
> > +	dstat = readl(&dma_regs->status);
> > +
> > +	dev_dbgdma(priv->dev, "%s: dstat=%x\n", __func__, dstat);
> > +
> > +	/* We have to things to deal with here:
>                    ^^
>                    two

Yup.

> > +/* port_start is when we allocate the DMA command list */
> > +static int pata_macio_port_start(struct ata_port *ap)
> > +{
> > +	struct pata_macio_priv *priv = ap->private_data;
> > +	struct dbdma_regs __iomem *dma_regs = ap->ioaddr.bmdma_addr;
> > +
> > +	if (dma_regs == NULL)
> > +		return 0;
> > +
> > +	/* Make sure DMA controller is stopped */
> > +	writel((RUN|PAUSE|FLUSH|WAKE|DEAD) << 16, &dma_regs->control);
> > +	while (readl(&dma_regs->status) & RUN)
> > +		udelay(1);
> 
> Hmmm.... this probably belongs to ->freeze() which is responsible for
> stopping any in-flight operations and masking IRQ and libata will call
> it during initialization before requesting IRQ, so you won't need to
> call it explicitly here.

Well, I'm not sure I really -need- the above thing. It's there mostly
for the sake of paranoia. I suppose in case the firmware left it in some
stange state. Anyway, will move to freeze.

> > +#ifdef CONFIG_PMAC_MEDIABAY
> > +static void pata_macio_mb_event(struct macio_dev* mdev, int mb_state)
> > +{
> > +	struct ata_host *host = macio_get_drvdata(mdev);
> > +	struct ata_port *ap;
> > +	struct ata_eh_info *ehi;
> > +	struct ata_device *dev;
> > +	unsigned long flags;
> > +
> > +	if (!host)
> > +		return;
> > +	ap = host->ports[0];
> > +	spin_lock_irqsave(ap->lock, flags);
> > +	ehi = &ap->link.eh_info;
> > +	if (mb_state == MB_CD) {
> > +		ata_ehi_push_desc(ehi, "mediabay plug");
> > +		ata_ehi_hotplugged(ehi);
> > +		ata_port_freeze(ap);
> > +	} else {
> > +		ata_ehi_push_desc(ehi, "mediabay unplug");
> > +		ata_for_each_dev(dev, &ap->link, ALL)
> > +			dev->flags |= ATA_DFLAG_DETACH;
> > +		ata_port_schedule_eh(ap);
> 
> I think you'll need an ata_port_freeze() or abort() here because at
> this point the drive is already gone and all in-flight commands need
> to be failed right away.  Holger, do you remember why
> ata_acpi_detach_device() is using ata_port_schedule_eh() instead?  Was
> it because ata_port_freeze() might end up poking registers after
> hotunplug happened?  ISTR reports where accessing any register there
> causing the whole system to lock up but then why can't it use
> ata_port_abort() instead?

I'll try. Which one ? freeze or abort tho ?

Cheers,
Ben.
