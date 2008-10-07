Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8F5E9DDF0C
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 08:04:02 +1100 (EST)
Subject: [PATCH 0/3] powerpc: dma code cleanup
From: Remi Machet <rmachet@slac.stanford.edu>
To: Linux PPC <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 07 Oct 2008 14:03:53 -0700
Message-Id: <1223413433.17585.26.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Following is the whole DMA code cleanup on top of the work 
already done by Becky Bruce. It includes removing __dma_sync 
and __dma_sync_page that got replaced by dma_mapping_ops->sync,
getting rid of the old dma-noncoherent code which is now another
type of dma_mapping_ops and cleaning up the dma non-coherent
code by removing the virtual address pool it was using.

This code was tested on a 32bits PowerPC C2K board (noncoherent
cache) and I verified it builds on pmac32 (coherent cache, 32bits)
and pseries (64bits).

If anyone would be willing to test this code on other platforms 
(mainly ones with non-coherent DMA architectures), I would 
greatly appreciate!

Thanks,

Remi
