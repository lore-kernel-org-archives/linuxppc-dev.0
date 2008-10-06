Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B47FADDE9E
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 04:39:01 +1100 (EST)
Subject: Re: [PATCH] dma: add new dma_mapping_ops API sync_page
From: Remi Machet <rmachet@slac.stanford.edu>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <48EA3D0C.1050107@freescale.com>
References: <1222898599.8628.52.camel@pcds-ts102.slac.stanford.edu>
	<1223051594.4251.12.camel@pcds-ts102.slac.stanford.edu>
	<48EA3D0C.1050107@freescale.com>
Content-Type: text/plain
Date: Mon, 06 Oct 2008 10:38:52 -0700
Message-Id: <1223314733.21869.38.camel@pcds-ts102.slac.stanford.edu>
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

On Mon, 2008-10-06 at 11:30 -0500, Scott Wood wrote:
> Remi Machet wrote:
> > After continuing to work on the dma noncoherent code I realized that
> > sync_page is not the best choice of API: 
> > -The API should preferably take a dma_addr_t in my opinion
> 
> A virtual address will typically be needed to perform the flush; why 
> pass the bus address?
Because it is a sync API. You want to make sure that a physical memory
area is in sync with the caches, not the virtual address. This
distinction can become important in the event where the page is mapped
multiple times in the memory and the architecture does not take care of
synchronizing the multiple mapping, the dma_mapping_ops code should be
able to synchronize the multiple mapping. In most case it would be easy
of course to go from virtual address to the page address, but not if the
page is in high memory ...

By the way I realized later on that scatter/gather structures contain 2
fields: dma_addr and dma_length that can be used to recover the bus
address => no need for sync_sg anymore.

Remi
