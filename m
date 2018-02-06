Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zbNzh302vzF0X0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Feb 2018 23:28:48 +1100 (AEDT)
Received: by mail-pl0-x244.google.com with SMTP id 13so1138793plb.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Feb 2018 04:28:48 -0800 (PST)
Date: Tue, 6 Feb 2018 22:28:32 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64s: fix may_hard_irq_enable for PMI soft masking
Message-ID: <20180206222832.5aaddc60@roar.ozlabs.ibm.com>
In-Reply-To: <764f5253-eaab-4bae-24f6-6ca3bd5d4700@linux.vnet.ibm.com>
References: <20180203071750.6469-1-npiggin@gmail.com>
 <764f5253-eaab-4bae-24f6-6ca3bd5d4700@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 6 Feb 2018 15:30:43 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> On Saturday 03 February 2018 12:47 PM, Nicholas Piggin wrote:
> > vThe soft IRQ masking code has to hard-disable interrupts in cases
> > where the exception is not cleared by the masked handler. External
> > interrupts used this approach for soft masking. Now recently PMU
> > interrupts do the same thing.
> >
> > The soft IRQ masking code additionally allowed for interrupt handlers
> > to hard-enable interrupts after soft-disabling them. The idea is to
> > allow PMU interrupts through to profile interrupt handlers.
> >
> > So when interrupts are being replayed when there is a pending
> > interrupt that requires hard-disabling, there is a test to prevent
> > those handlers from hard-enabling them if there is a pending external
> > interrupt. may_hard_irq_enable() handles this.
> >
> > After f442d00480 ("powerpc/64s: Add support to mask perf interrupts
> > and replay them"), may_hard_irq_enable() could prematurely enable
> > MSR[EE] when a PMU exception exists, which would result in the
> > interrupt firing again while masked, and MSR[EE] being disabled again.
> >
> > I haven't seen that this could cause a serious problem, but it's
> > more consistent to handle these soft-masked interrupts in the same
> > way. So introduce a define for all types of interrupts that require
> > MSR[EE] masking in their soft-disable handlers, and use that in
> > may_hard_irq_enable().
> >
> > Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>  
> 
> Yes nice catch. We could get into a messy state.
> May be if I run my perf+kernbench longer, could get lucky.

I think we just get away with it, because I think the worst that
happens is a PMU exception will fire an interrupt again while it
is still soft-masked, during the interrupt replay code. It would
run its masked handler and set MSR[EE]=0 again and later be
replayed.

But this tidies things up and makes them consistent, and won't
cause any surprises if code changes in future. Thanks for the
review.

Thanks,
Nick
