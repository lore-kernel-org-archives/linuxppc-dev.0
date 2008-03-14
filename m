Return-Path: <dan.j.williams@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.224])
	by ozlabs.org (Postfix) with ESMTP id 59364DDEDF
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 11:06:20 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 67so2980005wri.3
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 17:06:19 -0700 (PDT)
Message-ID: <e9c3a7c20803131706m188f9494m1cdcda8354a65f4e@mail.gmail.com>
Date: Thu, 13 Mar 2008 17:06:19 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
Sender: dan.j.williams@gmail.com
To: "Olof Johansson" <olof@lixom.net>
Subject: Re: [PATCH] pasemi_dma: Driver for PA Semi PWRficient on-chip
	DMAengine
In-Reply-To: <20080313231442.GA4639@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080306233900.GA3969@lixom.net>
	<1205255051.26723.19.camel@dwillia2-linux.ch.intel.com>
	<20080313195431.GA1449@lixom.net>
	<e9c3a7c20803131529j22db434aqdab0ef6f18891d67@mail.gmail.com>
	<20080313231442.GA4639@lixom.net>
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

On Thu, Mar 13, 2008 at 4:14 PM, Olof Johansson <olof@lixom.net> wrote:
>  > Dummy descriptors that do nothing but cause an interrupt is the intent.
>
>  Well, it'd be slightly more efficient to do add the interrupt attribute
>  to the last issued descriptor when it's known in advance. If the
>  underlying driver doesn't support it, adding a separate descriptor would
>  be a good fallback.
>

When it is known in advance the interrupt attribute *is* set,
otherwise the descriptor may already be in flight.

>  Anyway, this isn't likely to be a performance bottleneck. If it turns
>  out to be, I'll refactor it and submit patches.
>

Would not hurt to have another pair of eyes on this part of the code.
A rewrite of the channel switch mechanism is currently pending in
async_tx.git#upstream.

[..]
>  > >  Can't do that if it's called both from the polling as well as the IRQ
>  > >  context, it'd need to hold off irqs. I.e. once I add the DMA_INTERRUPT
>  > >  support it will be needed.
>  > >
>  >
>  > ...do it in a tasklet.
>
>  Why? That just adds overhead and latency.
>

The original ioat_dma code used nothing heavier than spin_lock_bh.
Async_tx now assumes that local_bh_disable prevents races with any
channel's cleanup routine.  Clients can place the same kind of code in
an async_tx callback as they would in a timer callback.  The
assumption is that code using async_tx can afford its extra overhead,
which is true for raid.  This is also why you don't see async_memcpy
calls in net_dma.

--
Dan
