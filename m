Return-Path: <olof@lixom.net>
Date: Thu, 13 Mar 2008 14:54:31 -0500
From: Olof Johansson <olof@lixom.net>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] pasemi_dma: Driver for PA Semi PWRficient on-chip
	DMAengine
Message-ID: <20080313195431.GA1449@lixom.net>
References: <20080306233900.GA3969@lixom.net>
	<1205255051.26723.19.camel@dwillia2-linux.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1205255051.26723.19.camel@dwillia2-linux.ch.intel.com>
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

On Tue, Mar 11, 2008 at 10:04:11AM -0700, Dan Williams wrote:

> I notice that the driver does not handle callbacks in its descriptor
> cleanup path.  This could be ok if your intent is only to support the
> net_dma style polled operations, but this will not work for the
> raid-offload async_tx case.  I think the solution is for async_tx to
> ignore channels without the DMA_INTERRUPT capability.

Good point, and correct - I have mostly been testing this with the
NET_DMA offload. async_tx doesn't make use of just memcpy, does it?

Also, how is DMA_INTERRUPT supposed to work? I see there's a separate
"prep_dma_interrupt" function, but that doesn't make sense to me. Don't
you want the interrupt associated with a specific transaction instead
of added as a separate (empty) transaction?

Once I add the descriptor to the ring, I can't change it to set the
interrupt request bit on it. I suppose I could just add a dummy descriptor
to the ring, but that doesn't seem quite right either.

> > +static void pasemi_dma_clean(struct pasemi_dma_chan *chan)
> > +{
> > +       int old, new, i;
> > +       unsigned long flags;
> > +       struct pasemi_dma_desc *desc;
> > +       spin_lock_irqsave(&chan->desc_lock, flags);
> 
> Is spin_lock_bh() insufficient here?
> 
> ...that's all that jumps out at the moment.

Can't do that if it's called both from the polling as well as the IRQ
context, it'd need to hold off irqs. I.e. once I add the DMA_INTERRUPT
support it will be needed.


-Olof
