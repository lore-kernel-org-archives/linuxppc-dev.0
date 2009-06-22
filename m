Return-Path: <dan.j.williams@intel.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F0565B7132
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 07:20:50 +1000 (EST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by ozlabs.org (Postfix) with ESMTP id 5957FDDD1C
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 07:20:49 +1000 (EST)
Subject: Re: [PATCH v3 2/2] fsldma: Add DMA_SLAVE support
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Snyder <iws@ovro.caltech.edu>
In-Reply-To: <20090619193134.GC30992@ovro.caltech.edu>
References: <20090619193134.GC30992@ovro.caltech.edu>
Content-Type: text/plain
Date: Mon, 22 Jun 2009 14:20:47 -0700
Message-Id: <1245705647.937.2.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-06-19 at 12:31 -0700, Ira Snyder wrote:
> Use the DMA_SLAVE capability of the DMAEngine API to copy/from a
> scatterlist into an arbitrary list of hardware address/length pairs.
> 
> This allows a single DMA transaction to copy data from several different
> devices into a scatterlist at the same time.
> 
> This also adds support to enable some controller-specific features such as
> external start and external pause for a DMA transaction.
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
> 
> This patch depends on the "fsldma: split apart external pause and
> request count features" patch.
> 
> After discussion with Dan Williams, this is the third version of the
> DMA_SLAVE API for the Freescale DMA controller. I've tested it heavily
> with both drivers I have written against this API, an FPGA programmer
> and an FPGA data grabber.
> 
> Kumar, Dan asked me to add you to the CC list, so you can have a look at
> this patch before he adds it to his tree.
> 
> The other two small patches I posted earlier are very helpful in testing
> this functionality. They make the fsldma driver leave the BWC (bandwidth
> control) bits alone on the 83xx controller, as well as making the
> external start feature available on 83xx.
> 

Kumar, Leo,

Can I get your acked-by's for the current state of async_tx.git/next?  I
just pushed out Ira's latest so it may take a moment to mirror out.

Thanks,
Dan

The following changes since commit f234012f52a37e48f2330e1ca2df69800e797c3b:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../drzeus/mmc

are available in the git repository at:

  ssh://git.kernel.org/pub/scm/linux/kernel/git/djbw/async_tx.git next

Dan Williams (1):
      dmaengine: move HIGHMEM64G restriction to ASYNC_TX_DMA

Ira Snyder (4):
      fsldma: enable external start for the 83xx controller
      fsldma: do not clear bandwidth control bits on the 83xx controller
      fsldma: split apart external pause and request count features
      fsldma: Add DMA_SLAVE support

Ira W. Snyder (1):
      fsldma: use PCI Read Multiple command

 arch/powerpc/include/asm/fsldma.h |  136 +++++++++++++++++
 drivers/dma/Kconfig               |    4 +-
 drivers/dma/fsldma.c              |  287 ++++++++++++++++++++++++++++++++++---
 drivers/dma/fsldma.h              |    4 +-
 4 files changed, 408 insertions(+), 23 deletions(-)
 create mode 100644 arch/powerpc/include/asm/fsldma.h
