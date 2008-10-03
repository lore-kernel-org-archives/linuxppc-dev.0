Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 452B0DE2C3
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 02:33:17 +1000 (EST)
Received: from mailgate02.slac.stanford.edu (mailgate02.slac.stanford.edu
	[134.79.18.92])
	by nospam3.slac.stanford.edu (8.13.8/8.13.8) with ESMTP id
	m93GXEW9020977
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Oct 2008 09:33:14 -0700 (PDT)
	(envelope-from rmachet@slac.stanford.edu)
Received: from [134.79.128.151] (pcds-ts102.slac.stanford.edu [134.79.128.151])
	by mailgate02.slac.stanford.edu (8.13.8/8.13.8) with ESMTP id
	m93GXEdY014830
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Oct 2008 09:33:14 -0700 (PDT)
	(envelope-from rmachet@slac.stanford.edu)
Subject: Re: [PATCH] dma: add new dma_mapping_ops API sync_page
From: Remi Machet <rmachet@slac.stanford.edu>
To: Linux PPC <linuxppc-dev@ozlabs.org>
In-Reply-To: <1222898599.8628.52.camel@pcds-ts102.slac.stanford.edu>
References: <1222898599.8628.52.camel@pcds-ts102.slac.stanford.edu>
Content-Type: text/plain
Date: Fri, 03 Oct 2008 09:33:13 -0700
Message-Id: <1223051594.4251.12.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-01 at 15:03 -0700, Remi Machet wrote:
> This patch replaces the global APIs __dma_sync and __dma_sync_page
> with a new dma_mapping_ops API named sync_page. This is necessary to make
> sure that the proper synchronization mechanism is used for a device
> DMA depending on the bus the device is on.
> 

After continuing to work on the dma noncoherent code I realized that
sync_page is not the best choice of API: 
-The API should preferably take a dma_addr_t in my opinion
-Using sync_page forced me to create a new define in io.h: bus_to_page.

I now think it would be better to have 2 new API: sync (which takes a
dma_addr_t) and sync_sg (which takes a scatter/gather list). Adding
sync_sg would make us get rid of the last page_to_bus in the code (to
get the dma_addr_t from the scatter gather list entry sg I do:
page_to_bus(sg_page(sg))+sg->offset).

Any feedback is welcome on this issue. I hate adding 2 new APIs but they
would make it possible to have 2 completely different DMA architectures
supported in one kernel on the same hardware.

Remi
