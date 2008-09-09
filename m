Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8F089DDE04
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 20:55:08 +1000 (EST)
Subject: Re: [PATCH 4/4] POWERPC: Merge 32 and 64-bit dma code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20080908220349.GD1175@lst.de>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-3-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-4-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-5-git-send-email-becky.bruce@freescale.com>
	<20080908220349.GD1175@lst.de>
Content-Type: text/plain
Date: Tue, 09 Sep 2008 20:54:42 +1000
Message-Id: <1220957682.4879.372.camel@pasglop>
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

On Tue, 2008-09-09 at 00:03 +0200, Christoph Hellwig wrote:
> > -	if (unlikely(dev == NULL || dev->archdata.dma_ops == NULL))
> > +
> > +	if (unlikely(dev == NULL) || dev->archdata.dma_ops == NULL) {
> > +#ifdef CONFIG_PPC64
> >  		return NULL;
> > +#else
> > +		/* Use default on 32-bit if dma_ops is not set up */
> > +		return &dma_direct_ops;
> > +#endif
> > +	}
> > +
> 
> This is okay for the transition, but I think long-term it should
> be setup for all busses.

Agreed.

Ben.
