Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4A134DE4D1
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 02:28:03 +1000 (EST)
Subject: Re: New dma-noncoherent code, looking for comment and people to test
From: Remi Machet <rmachet@slac.stanford.edu>
To: benh@kernel.crashing.org
In-Reply-To: <1222759271.9006.45.camel@pasglop>
References: <1222709165.8628.4.camel@pcds-ts102.slac.stanford.edu>
	<1222759271.9006.45.camel@pasglop>
Content-Type: text/plain
Date: Tue, 30 Sep 2008 09:27:58 -0700
Message-Id: <1222792079.8628.18.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-09-30 at 17:21 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2008-09-29 at 10:26 -0700, Remi Machet wrote:
> > 
> > I also removed the HIGHMEM support in dma_sync since memory allocated for
> > DMA transfer should always be in ZONE_DMA (ie not in ZONE_HIGHMEM).
> 
> While I like the idea of simplifying that stuff, the above sentence is
> incorrect unfortunately.
> 
> ZONE_DMA is an artifact of x86 ISA DMA limitations. You -will- get
> request for mapping pages for DMA that have been allocated within
> different zones (notably highmem).
> 
> The problem with highmem is that whether you can or not DMA to/from
> highmem is somewhat unclear, drivers set flags individually in various
> layers to allow it, which is definitely not the right place to do so. So
> while it would be nice to think we never will, in practice, we do.
> 

Yes, I realized that looking at the changes Becky's made. I will put
back the highmem support when merging my changes with those.

Thanks!

Remi
