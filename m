Return-Path: <olof@lixom.net>
Date: Tue, 11 Mar 2008 09:25:45 -0500
From: Olof Johansson <olof@lixom.net>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] pasemi_dma: Driver for PA Semi PWRficient on-chip DMA
	engine
Message-ID: <20080311142545.GA18843@lixom.net>
References: <20080306233900.GA3969@lixom.net>
	<20080311000619.ba39311f.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080311000619.ba39311f.akpm@linux-foundation.org>
Cc: hskinnemoen@atmel.com, shannon.nelson@intel.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	pasemi-linux@ozlabs.org, dan.j.williams@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 11, 2008 at 12:06:19AM -0700, Andrew Morton wrote:
> On Thu, 6 Mar 2008 17:39:00 -0600 Olof Johansson <olof@lixom.net> wrote:
> 
> > pasemi_dma: Driver for PA Semi PWRficient on-chip DMA engine
> >     
> > First cut at a dma copy offload driver for PA Semi PWRficient. It uses the
> > platform-specific functions to allocate channels, etc.
> 
> Applied this on Paul's latest and powerpc allmodconfig goes boom.

It's dependent on my latest pull request of pasemi.git for-2.6.26 that
Paul hasn't pulled/pushed yet.

> drivers/dma/pasemi_dma.c: In function `pasemi_dma_alloc_chan_resources':
> drivers/dma/pasemi_dma.c:152: error: `PAS_DMA_TXCHAN_CFG_TY_COPY' undeclared (first use in this function)
> drivers/dma/pasemi_dma.c:152: error: (Each undeclared identifier is reported only once
> drivers/dma/pasemi_dma.c:152: error: for each function it appears in.)
> drivers/dma/pasemi_dma.c:154: error: `PAS_DMA_TXCHAN_CFG_LPDQ' undeclared (first use in this function)
> drivers/dma/pasemi_dma.c:155: error: `PAS_DMA_TXCHAN_CFG_LPSQ' undeclared (first use in this function)
> drivers/dma/pasemi_dma.c: In function `pasemi_dma_probe':
> drivers/dma/pasemi_dma.c:394: error: structure has no member named `device_dependency_added'

.. and that one is caused by recent changes in async_tx.git. I was
waiting on other review comments from the DMA maintainers before
resubmitting; timer has expired though and I'll do it anyway today.

> Also this driver from git-md-accel is pretty sick:
> 
> 
> drivers/dma/fsldma.c:439: warning: comparison of distinct pointer types lacks a cast
> drivers/dma/fsldma.c: In function `fsl_chan_xfer_ld_queue':
> drivers/dma/fsldma.c:584: warning: long long unsigned int format, dma_addr_t arg (arg 4)
> drivers/dma/fsldma.c: In function `fsl_dma_chan_do_interrupt':
> drivers/dma/fsldma.c:661: warning: unsigned int format, different type arg (arg 5)
> drivers/dma/fsldma.c:677: warning: long long unsigned int format, dma_addr_t arg (arg 4)
> drivers/dma/fsldma.c:677: warning: long long unsigned int format, dma_addr_t arg (arg 5)
> drivers/dma/fsldma.c:694: warning: unsigned int format, different type arg (arg 4)
> drivers/dma/fsldma.c: In function `fsl_dma_self_test':
> drivers/dma/fsldma.c:833: warning: int format, different type arg (arg 5)
> drivers/dma/fsldma.c: In function `of_fsl_dma_probe':
> drivers/dma/fsldma.c:1003: warning: unsigned int format, different type arg (arg 5)
> drivers/dma/fsldma.c: At top level:
> drivers/dma/fsldma.c:723: warning: 'fsl_dma_callback_test' defined but not used

Yeah, Zhang Wei posted a patch for that on lkml yesterday.


-Olof
