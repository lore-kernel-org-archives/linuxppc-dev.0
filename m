Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 602BDDDED2
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 09:47:10 +1000 (EST)
Subject: Re: [PATCH]: [MPC5200] (v2) Add ATA DMA support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tim Yamin <plasm@roo.me.uk>
In-Reply-To: <792f5f410807030835q4589a27eh4b7d13e93e922a5e@mail.gmail.com>
References: <792f5f410806270544p69c773b9o9df4a5618d4babe1@mail.gmail.com>
	<20080701234943.GA16391@secretlab.ca>
	<792f5f410807020548m107cd6a5xf0360e07053e104c@mail.gmail.com>
	<20080702173040.GB23846@secretlab.ca>
	<792f5f410807030835q4589a27eh4b7d13e93e922a5e@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 04 Jul 2008 09:47:03 +1000
Message-Id: <1215128823.7960.12.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-07-03 at 16:35 +0100, Tim Yamin wrote:
> >> +static void
> >> +mpc52xx_bmdma_start(struct ata_queued_cmd *qc)
> >> +{
> >> +     struct ata_port *ap = qc->ap;
> >> +     struct mpc52xx_ata_priv *priv = ap->host->private_data;
> >> +
> >> +     /* LocalBus lock */
> >> +     while (test_and_set_bit(0, &pata_mpc52xx_ata_dma_lock) != 0)
> >> +             ;
> >
> > Need to be able to bail on timeout.
> 
> A deadlock can't occur within the PATA driver because you won't have
> two DMA requests happening at once, so there is no point in adding a
> timeout. And even if you do have a timeout, you'd have to drop the I/O
> request somehow, so it's not really a good idea. If anything else
> needs to touch the DMA lock, it should do so in a sensible fashion...

But why a hand-coded lock with bitops ? Why not a real spinlock then ?
The later is more efficient anyway.

Ben.
