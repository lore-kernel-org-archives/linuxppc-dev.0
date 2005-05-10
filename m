Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 80C49679F1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 May 2005 00:53:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 10 May 2005 09:53:25 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B85938C@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Matt Porter" <mporter@kernel.crashing.org>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: RE: [PATCH  03/04] Freescale Ethernet combined driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20
> > What's the recommended function to call to go from a
> > virtual -> physical address, but without doing a cache
> > flush/invalidate?
>=20
> There is no generic function to do that in a driver since
> no mainstream drivers in the kernel need to do it. Generally
> you can rework the driver such that you cache the DMA address
> as Dan suggested already.  I don't know your exact usage, however,
> you can allocate memory with dma_alloc_noncoherent() that is
> cached on ppc32 NOT_CACHE_COHERENT prcoessors and stash the
> dma_addr_t/void * for later use. The other way is to kmalloc and
> dma_map_single() (stashing the same way) which is basically the
> same thing.

For 8xx/82xx (and other PQ cpus) there is a lot of drivers liberally
using
__pa and __va to get physical and virtual adresses for structures and
buffer descriptor tables for the CPM.

What would the preferred way of handling both of these be?
__pa() -> dma_map_single() ?

__va() -> ?
