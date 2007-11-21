Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84C05DDE0A
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 06:53:30 +1100 (EST)
Subject: Re: [PATCH 1/8] ibm_newemac: Fix possible lockup on close
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20071121154123.GB23589@lst.de>
References: <1195625198.76200.922309668615.qpush@grosgo>
	<20071121060729.71A1FDDE01@ozlabs.org> <20071121154123.GB23589@lst.de>
Content-Type: text/plain
Date: Thu, 22 Nov 2007 06:53:11 +1100
Message-Id: <1195674791.6970.95.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-11-21 at 16:41 +0100, Christoph Hellwig wrote:
> On Wed, Nov 21, 2007 at 05:06:39PM +1100, Benjamin Herrenschmidt wrote:
> > It's a bad idea to call flush_scheduled_work from within a
> > netdev->stop because the linkwatch will occasionally take the
> > rtnl lock from a workqueue context, and thus that can deadlock.
> > 
> > This reworks things a bit in that area to avoid the problem.
> 
> So from the name of the driver you want to keep the previous emac
> driver around.  Is there a good reason for that?

Until arch/ppc is gone... the previous driver works with arch/ppc the
new one with arch/powerpc.

If we kill arch/ppc in .25, then we'll remove the old driver and rename
the new one. If not, that will wait til .26

I'm hard at work porting as much of 4xx over I can to get to the point
where we -can- kill arch/ppc but I'm not done yet.

Cheers,
Ben.
