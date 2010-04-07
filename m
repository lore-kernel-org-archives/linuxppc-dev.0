Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 37FEDB7D59
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Apr 2010 17:42:09 +1000 (EST)
Subject: Re: [PATCH] 460EX on-chip SATA driver<kernel 2.6.33> <
	resubmission : 02>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <4BBB5045.5020004@pobox.com>
References: <201004061141.o36BfTsr028163@amcc.com> <4BBB5045.5020004@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Apr 2010 17:41:56 +1000
Message-ID: <1270626116.2300.68.camel@pasglop>
Mime-Version: 1.0
Cc: sr@denx.de, linux-ide@vger.kernel.org, Rupjyoti Sarmah <rsarmah@amcc.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-04-06 at 11:16 -0400, Jeff Garzik wrote:
> > +static irqreturn_t dma_dwc_interrupt(int irq, void *hsdev_instance)
> > +{
> > +     int chan;
> > +     u32 tfr_reg, err_reg;
> > +
> > +     struct sata_dwc_device *hsdev =
> > +             (struct sata_dwc_device *) hsdev_instance;
> > +     struct ata_host *host = (struct ata_host *) hsdev->host;
> > +     struct ata_port *ap;
> > +     struct sata_dwc_device_port *hsdevp;
> > +     u8 tag = 0;
> > +     unsigned int port = 0;
> > +     struct sata_dwc_host_priv *hp;
> > +     hp = kmalloc(sizeof(*hp), GFP_KERNEL);
> 
> 1) interrupt is not GFP_KERNEL
> 
> 2) you must failure kmalloc failure
> 
> 3) it is not clear to me where you initialize this structure???

And why the heck would you want to allocate it at interrupt time ? ? ?

BTW. Stefan mentioned earlier that they had some fixes for that driver
in the Denx tree. Are those fixes now included in that variant ?

Cheers,
Ben.
