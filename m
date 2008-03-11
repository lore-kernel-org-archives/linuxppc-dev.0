Return-Path: <dan.j.williams@intel.com>
Subject: Re: [PATCH] pasemi_dma: Driver for PA Semi PWRficient on-chip
	DMAengine
From: Dan Williams <dan.j.williams@intel.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20080306233900.GA3969@lixom.net>
References: <20080306233900.GA3969@lixom.net>
Content-Type: text/plain
Date: Tue, 11 Mar 2008 10:04:11 -0700
Message-Id: <1205255051.26723.19.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, pasemi-linux@ozlabs.org, "Nelson,
	Shannon" <shannon.nelson@intel.com>,
	linux-kernel@vger.kernel.org, hskinnemoen@atmel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-03-06 at 16:39 -0700, Olof Johansson wrote:
> pasemi_dma: Driver for PA Semi PWRficient on-chip DMA engine
>    
> First cut at a dma copy offload driver for PA Semi PWRficient. It uses the
> platform-specific functions to allocate channels, etc.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> 
> ---
> 
> This has some dependencies on other patches currently queued up in the
> powerpc git trees for 2.6.26. I'd appreciate reviews and acked-bys, but
> it might be easiest to just merge it up the powerpc path due to the
> dependencies.
> 
Apologies for not getting to this sooner.

I notice that the driver does not handle callbacks in its descriptor
cleanup path.  This could be ok if your intent is only to support the
net_dma style polled operations, but this will not work for the
raid-offload async_tx case.  I think the solution is for async_tx to
ignore channels without the DMA_INTERRUPT capability.

> +static void pasemi_dma_clean(struct pasemi_dma_chan *chan)
> +{
> +       int old, new, i;
> +       unsigned long flags;
> +       struct pasemi_dma_desc *desc;
> +       spin_lock_irqsave(&chan->desc_lock, flags);

Is spin_lock_bh() insufficient here?

...that's all that jumps out at the moment.

Regards,
Dan
