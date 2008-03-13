Return-Path: <dan.j.williams@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.182])
	by ozlabs.org (Postfix) with ESMTP id 927D8DE046
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 09:29:31 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id v27so2508185ele.16
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 15:29:29 -0700 (PDT)
Message-ID: <e9c3a7c20803131529j22db434aqdab0ef6f18891d67@mail.gmail.com>
Date: Thu, 13 Mar 2008 15:29:29 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
Sender: dan.j.williams@gmail.com
To: "Olof Johansson" <olof@lixom.net>
Subject: Re: [PATCH] pasemi_dma: Driver for PA Semi PWRficient on-chip
	DMAengine
In-Reply-To: <20080313195431.GA1449@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080306233900.GA3969@lixom.net>
	<1205255051.26723.19.camel@dwillia2-linux.ch.intel.com>
	<20080313195431.GA1449@lixom.net>
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

On Thu, Mar 13, 2008 at 12:54 PM, Olof Johansson <olof@lixom.net> wrote:
> On Tue, Mar 11, 2008 at 10:04:11AM -0700, Dan Williams wrote:
>
>  > I notice that the driver does not handle callbacks in its descriptor
>  > cleanup path.  This could be ok if your intent is only to support the
>  > net_dma style polled operations, but this will not work for the
>  > raid-offload async_tx case.  I think the solution is for async_tx to
>  > ignore channels without the DMA_INTERRUPT capability.
>
>  Good point, and correct - I have mostly been testing this with the
>  NET_DMA offload. async_tx doesn't make use of just memcpy, does it?
>

Right, it makes use of any capability it can get its hands on,
otherwise fall back to software.

>  Also, how is DMA_INTERRUPT supposed to work? I see there's a separate
>  "prep_dma_interrupt" function, but that doesn't make sense to me. Don't
>  you want the interrupt associated with a specific transaction instead
>  of added as a separate (empty) transaction?
>

Yes, and that is what happens in most cases.  The additional
prep_dma_interrupt method is for two special cases:
1/ Locations where code is submitting an indeterminate number of
operations and wants an interrupt (callback) at the completion of the
chain.  Someting like:
list_for_each_entry()
     async_memcpy()
async_trigger_callback()

2/ For supporting channel switching on, for instance, a memcpy->xor
chain where chan1 supports memcpy and chan2 supports xor.  When
async_tx sees this it injects an interrupt for chan1.  The xor
operation gets kicked off by the bottom half of the chan1 interrupt
handler.  However, if chan1 can do both operations no interrupt is
needed.

>  Once I add the descriptor to the ring, I can't change it to set the
>  interrupt request bit on it. I suppose I could just add a dummy descriptor
>  to the ring, but that doesn't seem quite right either.
>

Dummy descriptors that do nothing but cause an interrupt is the intent.

>
>  > > +static void pasemi_dma_clean(struct pasemi_dma_chan *chan)
>  > > +{
>  > > +       int old, new, i;
>  > > +       unsigned long flags;
>  > > +       struct pasemi_dma_desc *desc;
>  > > +       spin_lock_irqsave(&chan->desc_lock, flags);
>  >
>  > Is spin_lock_bh() insufficient here?
>  >
>  > ...that's all that jumps out at the moment.
>
>  Can't do that if it's called both from the polling as well as the IRQ
>  context, it'd need to hold off irqs. I.e. once I add the DMA_INTERRUPT
>  support it will be needed.
>

...do it in a tasklet.

>
>  -Olof
>

Regards,
Dan
