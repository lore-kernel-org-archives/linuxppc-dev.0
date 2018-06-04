Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxg24jrtzF0dd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:10:54 +1000 (AEST)
In-Reply-To: <20180510172005.27160-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alistair Popple <alistair@popple.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/powernv: process all OPAL event interrupts with kopald
Message-Id: <40zxg14GWMz9ryk@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:52 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-05-10 at 17:20:05 UTC, Nicholas Piggin wrote:
> Using irq_work for processing OPAL event interrupts is not necessary.
> irq_work is typically used to schedule work from NMI context, a
> softirq may be more appropriate. However OPAL events are not
> particularly performance or latency critical, so they can all be
> invoked by kopald.
> 
> This patch removes the irq_work queueing, and instead wakes up
> kopald when there is an event to be processed. kopald processes
> interrupts individually, enabling irqs and calling cond_resched
> between each one to minimise latencies.
> 
> Event handlers themselves should still use threaded handlers,
> workqueues, etc. as necessary to avoid high interrupts-off latencies
> within any single interrupt.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/56c0b48b1e443efa5d6f4d60513302

cheers
