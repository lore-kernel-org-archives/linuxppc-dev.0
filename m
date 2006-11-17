Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F031C67BF2
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 17:48:15 +1100 (EST)
Date: Fri, 17 Nov 2006 07:48:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 11/16] PATA driver for Celleb
Message-ID: <20061117064808.GA15013@lst.de>
References: <200611150949.kAF9nGUY009229@toshiba.co.jp>
	<20061115184416.GE21633@lst.de>
	<1163634900.5940.290.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1163634900.5940.290.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 16, 2006 at 10:55:00AM +1100, Benjamin Herrenschmidt wrote:
> > This needs to go to linux-ide for review.  But IIRC new PATA drivers
> > should use libata these days, not the old ide layer.
> 
> While I agree, there are still issues with libata vs. devices that needs
> special IOps. libata allows you to override writing/reading taskfiles,
> but there are cases, specifically in the EH/bus reset code, where it
> still assumes the standard taskfile byte access format for a few things
> and while it's possible to "override" these, that means re-implementing
> a lot of logic in the driver.
> 
> I need to sort that out with Jeff one of these days as there is a
> similar problem with the mpc52xx IDE driver.
> 
> In the meantime, I reckon it's ok to have a drivers/ide driver for
> 2.6.20

I don't know.  And I think we can't make the judgement here, we should
leave it to the IDE maintainers to a proper review and make this
decision, that's why this patch needs to go to linux-ide ASAP.
