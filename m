Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RH03h3szDqpn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:28:28 +1100 (AEDT)
In-Reply-To: <20180302051845.26844-1-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mark Hairgrove <mhairgrove@nvidia.com>,
 Alistair Popple <alistair@popple.id.au>
Subject: Re: [v3] powerpc/npu-dma.c: Fix deadlock in mmio_invalidate
Message-Id: <401RH00Qp3z9sVQ@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:21 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-03-02 at 05:18:45 UTC, Alistair Popple wrote:
> When sending TLB invalidates to the NPU we need to send extra flushes due
> to a hardware issue. The original implementation would lock the all the
> ATSD MMIO registers sequentially before unlocking and relocking each of
> them sequentially to do the extra flush.
> 
> This introduced a deadlock as it is possible for one thread to hold one
> ATSD register whilst waiting for another register to be freed while the
> other thread is holding that register waiting for the one in the first
> thread to be freed.
> 
> For example if there are two threads and two ATSD registers:
> 
> Thread A	Thread B
> Acquire 1
> Acquire 2
> Release 1	Acquire 1
> Wait 1		Wait 2
> 
> Both threads will be stuck waiting to acquire a register resulting in an
> RCU stall warning or soft lockup.
> 
> This patch solves the deadlock by refactoring the code to ensure registers
> are not released between flushes and to ensure all registers are either
> acquired or released together and in order.
> 
> Fixes: bbd5ff50afff ("powerpc/powernv/npu-dma: Add explicit flush when sending an ATSD")
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2b74e2a9b39df40a2b489af2d24079

cheers
