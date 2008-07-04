Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 7738FDDE1F
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 13:21:02 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id n7so656207wag.13
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jul 2008 20:21:00 -0700 (PDT)
Date: Thu, 3 Jul 2008 21:20:28 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH]: [MPC5200] (v2) Add ATA DMA support
Message-ID: <20080704032028.GC12945@secretlab.ca>
References: <792f5f410806270544p69c773b9o9df4a5618d4babe1@mail.gmail.com>
	<20080701234943.GA16391@secretlab.ca>
	<792f5f410807020548m107cd6a5xf0360e07053e104c@mail.gmail.com>
	<20080702173040.GB23846@secretlab.ca>
	<792f5f410807030835q4589a27eh4b7d13e93e922a5e@mail.gmail.com>
	<1215128823.7960.12.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1215128823.7960.12.camel@pasglop>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: Tim Yamin <plasm@roo.me.uk>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 04, 2008 at 09:47:03AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2008-07-03 at 16:35 +0100, Tim Yamin wrote:
> > >> +static void
> > >> +mpc52xx_bmdma_start(struct ata_queued_cmd *qc)
> > >> +{
> > >> +     struct ata_port *ap = qc->ap;
> > >> +     struct mpc52xx_ata_priv *priv = ap->host->private_data;
> > >> +
> > >> +     /* LocalBus lock */
> > >> +     while (test_and_set_bit(0, &pata_mpc52xx_ata_dma_lock) != 0)
> > >> +             ;
> > >
> > > Need to be able to bail on timeout.
> > 
> > A deadlock can't occur within the PATA driver because you won't have
> > two DMA requests happening at once, so there is no point in adding a
> > timeout. And even if you do have a timeout, you'd have to drop the I/O
> > request somehow, so it's not really a good idea. If anything else
> > needs to touch the DMA lock, it should do so in a sensible fashion...
> 
> But why a hand-coded lock with bitops ? Why not a real spinlock then ?
> The later is more efficient anyway.

Umm, yeah.... (don't know why I didn't clue into that).  This definitely
should be a spinlock.

g.
