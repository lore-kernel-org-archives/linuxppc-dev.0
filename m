Return-Path: <akpm@linux-foundation.org>
Date: Tue, 11 Mar 2008 00:06:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] pasemi_dma: Driver for PA Semi PWRficient on-chip DMA
	engine
Message-Id: <20080311000619.ba39311f.akpm@linux-foundation.org>
In-Reply-To: <20080306233900.GA3969@lixom.net>
References: <20080306233900.GA3969@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 6 Mar 2008 17:39:00 -0600 Olof Johansson <olof@lixom.net> wrote:

> pasemi_dma: Driver for PA Semi PWRficient on-chip DMA engine
>     
> First cut at a dma copy offload driver for PA Semi PWRficient. It uses the
> platform-specific functions to allocate channels, etc.

Applied this on Paul's latest and powerpc allmodconfig goes boom.

drivers/dma/pasemi_dma.c: In function `pasemi_dma_alloc_chan_resources':
drivers/dma/pasemi_dma.c:152: error: `PAS_DMA_TXCHAN_CFG_TY_COPY' undeclared (first use in this function)
drivers/dma/pasemi_dma.c:152: error: (Each undeclared identifier is reported only once
drivers/dma/pasemi_dma.c:152: error: for each function it appears in.)
drivers/dma/pasemi_dma.c:154: error: `PAS_DMA_TXCHAN_CFG_LPDQ' undeclared (first use in this function)
drivers/dma/pasemi_dma.c:155: error: `PAS_DMA_TXCHAN_CFG_LPSQ' undeclared (first use in this function)
drivers/dma/pasemi_dma.c: In function `pasemi_dma_probe':
drivers/dma/pasemi_dma.c:394: error: structure has no member named `device_dependency_added'


Also this driver from git-md-accel is pretty sick:


drivers/dma/fsldma.c:439: warning: comparison of distinct pointer types lacks a cast
drivers/dma/fsldma.c: In function `fsl_chan_xfer_ld_queue':
drivers/dma/fsldma.c:584: warning: long long unsigned int format, dma_addr_t arg (arg 4)
drivers/dma/fsldma.c: In function `fsl_dma_chan_do_interrupt':
drivers/dma/fsldma.c:661: warning: unsigned int format, different type arg (arg 5)
drivers/dma/fsldma.c:677: warning: long long unsigned int format, dma_addr_t arg (arg 4)
drivers/dma/fsldma.c:677: warning: long long unsigned int format, dma_addr_t arg (arg 5)
drivers/dma/fsldma.c:694: warning: unsigned int format, different type arg (arg 4)
drivers/dma/fsldma.c: In function `fsl_dma_self_test':
drivers/dma/fsldma.c:833: warning: int format, different type arg (arg 5)
drivers/dma/fsldma.c: In function `of_fsl_dma_probe':
drivers/dma/fsldma.c:1003: warning: unsigned int format, different type arg (arg 5)
drivers/dma/fsldma.c: At top level:
drivers/dma/fsldma.c:723: warning: 'fsl_dma_callback_test' defined but not used
