Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4DE15B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 22:30:04 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8C60CDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Aug 2009 22:30:02 +1000 (EST)
Subject: Re: [PATCH] powerpc: Change archdata dma_data type to dma_addr_t
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20090824194800.GA13503@lst.de>
References: <1251130634-15093-1-git-send-email-beckyb@kernel.crashing.org>
	<20090824194800.GA13503@lst.de>
Content-Type: text/plain
Date: Wed, 26 Aug 2009 22:29:50 +1000
Message-Id: <1251289790.1379.71.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-08-24 at 21:48 +0200, Christoph Hellwig wrote:
> On Mon, Aug 24, 2009 at 11:17:14AM -0500, Becky Bruce wrote:
> > Previously, this was specified as a void *, but that's not
> > large enough on 32-bit systems with 36-bit physical
> > addressing support.  Change the type to dma_addr_t so it
> > will scale based on the size of a dma address.
> 
> This looks extreml ugly to me.  It seems like the typical use is to
> store a pointer to a structure.  So what about making the direct
> dma case follow that general scheme instead?
> 
> E.g. declare a
> 
> struct direct_dma_data {
> 	dma_addr_t	direct_dma_offset;
> };
> 
> and have one normal instace of it, and one per weird cell device.

Right, but we want to avoid a structure for the classic case of 32-bit
systems with no iommu... 

I wouldn't mind doing a union here. 

The other option is to have a global somewhere that we make that point
to or something like that but it's probably even more ugly.

Cheers,
Ben.
