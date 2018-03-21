Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x236.google.com (mail-pl0-x236.google.com
 [IPv6:2607:f8b0:400e:c01::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405Zhc3RQMzF1Sy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 14:16:31 +1100 (AEDT)
Received: by mail-pl0-x236.google.com with SMTP id 9-v6so2328334ple.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 20:16:31 -0700 (PDT)
Date: Wed, 21 Mar 2018 13:16:15 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, "Carol L. Soto" <clsoto@us.ibm.com>
Subject: Re: [PATCH] powerpc/64s: Fix lost pending interrupt due to race
 causing lost update to irq_happened
Message-ID: <20180321131615.7b8bd8e4@roar.ozlabs.ibm.com>
In-Reply-To: <1521599548.16434.263.camel@kernel.crashing.org>
References: <20180321022228.9606-1-npiggin@gmail.com>
 <1521599548.16434.263.camel@kernel.crashing.org>
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

Adding Carol...

On Wed, 21 Mar 2018 13:32:28 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2018-03-21 at 12:22 +1000, Nicholas Piggin wrote:
> > force_external_irq_replay() can be called in the do_IRQ path with
> > interrupts hard enabled and soft disabled if may_hard_irq_enable() set
> > MSR[EE]=1. It updates local_paca->irq_happened with a load, modify,
> > store sequence. If a maskable interrupt hits during this sequence, it
> > will go to the masked handler to be marked pending in irq_happened.
> > This update will be lost when the interrupt returns and the store
> > instruction executes.  This can result in unpredictable latencies,
> > timeouts, lockups, etc.
> > 
> > Fix this by ensuring hard interrupts are disabled before modifying
> > irq_happened.
> > 
> > This could cause any maskable asynchronous interrupt to get lost, but
> > it was noticed on P9 SMP system doing RDMA NVMe target over 100GbE,
> > so very high external interrupt rate and high IPI rate. The hang was
> > bisected down to enabling doorbell interrupts for IPIs. These provided
> > an interrupt type that could run at high rates in the do_IRQ path,
> > stressing the race.
> > 
> > Fixes: 1d607bb3bd ("powerpc/irq: Add mechanism to force a replay of interrupts")
> > Reported-by: Carol L. Soto <clsoto@us.ibm.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---  
> 
> Nice one. We need that back into the distros asap.


Yes Carol is working on this with distros. Backporting should be
simple, so hoping to get this upstream soon to help the process.
We can take that as a Reviewed-by:? :)

Thanks,
Nick
