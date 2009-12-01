Return-Path: <hmacht@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0C1CBB7B63
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 23:44:46 +1100 (EST)
From: Holger Macht <hmacht@suse.de>
To: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio,
	driver Apple PowerMac/PowerBook IDE controller
Date: Tue, 1 Dec 2009 13:44:38 +0100
References: <20091201070834.6A840B7B63@ozlabs.org>
	<4B14CD22.4020806@kernel.org>
In-Reply-To: <4B14CD22.4020806@kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200912011344.38656.hmacht@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, Jeff Garzik <jeff@garzik.org>,
	linux-ide@vger.kernel.org
Reply-To: hmacht@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 01 December 2009 09:00:34 Tejun Heo wrote:
> (cc'ing Holger Macht, please read the comment below pata_macio_mb_event())
> Hello,
> 
> On 12/01/2009 04:08 PM, Benjamin Herrenschmidt wrote:
> > This is a libata driver for the "macio" IDE controller used on most Apple
> > PowerMac and PowerBooks. It's a libata equivalent of drivers/ide/ppc/pmac.c
[...]
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

I do not remember any specific reason for using ata_port_schedule_eh(). I
guess it's just there because the previous implementation used
it. ata_port_freeze()/abort() might as well work properly. However, I
would hesitate to change the existing code, because verifying that
everything works contains quite some effort. There are so many different
use cases this code can be accessed with and it has to be verified with
all kind of different hardware to make sure we get no hard
freezes. Testing that freeze()/abort() in this new driver would be worth a
try, though. Next time I have setup my test environment again I can verify
that it also works in the general libata-acpi code.

Regards,
 Holger
