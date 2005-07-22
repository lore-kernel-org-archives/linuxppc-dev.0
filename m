Return-Path: <extabe@bredband.net>
Received: from mxfep04.bredband.com (mxfep04.bredband.com [195.54.107.79])
	by ozlabs.org (Postfix) with ESMTP id 07E5F67D17
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Jul 2005 19:41:33 +1000 (EST)
Received: from mxfep03 ([195.54.107.76] [195.54.107.76])
	by mxfep03.bredband.com with SMTP
	id <20050722092743.YKYC4674.mxfep03.bredband.com@mxfep03>
	for <linuxppc-embedded@ozlabs.org>; Fri, 22 Jul 2005 11:27:43 +0200
From: <extabe@bredband.net>
To: <linuxppc-embedded@ozlabs.org>
Date: Fri, 22 Jul 2005 11:27:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <20050722092743.YKYC4674.mxfep03.bredband.com@mxfep03>
Subject: DMA-transfer on 440ep
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm having problem with DMA on the EBC bus on the PPC440ep preocessor. Previously we have the dma code working on the PPC405gpr.

We are doing a read and write from pheriperal to memory and the system hangs a short time after enabling the dma channel.
Using linux 2.4.20 and the same kernel-dma code as for 405 (patched ppc4xx_dma.c/sgdma.c).

Changes i've made for the 440ep:
 * the GPIO multiplexing for DMA is setup correctly (at least i'm getting a DMAreq on the channel).
 * the EBC is 16 bits instead of 32 (PW_16 in dma setup).
 * the irqs are on different numbers. (dma irq works)

Also if i do a memory to memory transfer just for debugging, the dma works as far as not hanging, but no data has changed in the destination memory when the transfer is done...

 * Are there more setup to be made to get the dma controller to be enabled?
 * What is the DMA2P30_ADR register good for?

What am i missing?
