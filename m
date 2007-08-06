Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 61DC6DDE1E
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 07:43:28 +1000 (EST)
Subject: Re: [PATCH 2.6.22.y] ieee1394: revert "sbp2: enforce 32bit
	DMA	mapping"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20070806115804.GA1734@suse.de>
References: <fa.Qn3Snqoik3hhnxcA6HqjGV0Yzck@ifi.uio.no>
	<46B4B3DC.7020609@shaw.ca> <46B4B7C6.1040107@s5r6.in-berlin.de>
	<1186272926.938.8.camel@localhost.localdomain>
	<46B5824B.1000103@s5r6.in-berlin.de>  <20070806115804.GA1734@suse.de>
Content-Type: text/plain
Date: Tue, 07 Aug 2007 07:43:17 +1000
Message-Id: <1186436597.938.71.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Robert Hancock <hancockr@shaw.ca>, linuxppc-dev@ozlabs.org,
	Stefan Richter <stefanr@s5r6.in-berlin.de>, stable@kernel.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-08-06 at 13:58 +0200, Olaf Hering wrote:
> On Sun, Aug 05, Stefan Richter wrote:
> 
> > Benjamin Herrenschmidt wrote:
> > >>> If setting 32-bit DMA mask fails on ppc64, that sounds like a problem
> > >>> with the DMA implementation on that architecture. There are enough cards
> > >>> out there that only support 32-bit DMA that this really needs to work..
> > >> Yes, could the PPC folks please have a look at it?  Thanks.
> > > 
> > > Smells like we may have a bug there. No worries though, all current PPC
> > > machines have an iommu that will not give out addresses above 32 bits
> > > anyway, but I'll double check what's up.
> > > 
> > > Do you see something in dmesg when that happens ?
> > 
> > There was nothing in Olaf's report, except for trouble in sbp2 _after_
> > the failure.  http://lkml.org/lkml/2007/8/1/344  (I don't have a PMac.)
> 
> sbp2util_remove_command_orb_pool() does not check for lu->hi being NULL.
> 
> dev->dma_mask is NULL too, thats why dma_direct_dma_supported() returns
> false, and dma_set_mask() will return -EIO.

Strange... PCI devices should never have a NULL dma mask. I wonder how
we get there... 

Ben.
