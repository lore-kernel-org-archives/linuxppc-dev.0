Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hkL25dMfzF12N
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 20:48:42 +1000 (AEST)
In-Reply-To: <1533269016-16238-1-git-send-email-arbab@linux.ibm.com>
To: Reza Arbab <arbab@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alistair Popple <alistair@popple.id.au>
Subject: Re: powerpc/powernv: Fix concurrency issue with npu->mmio_atsd_usage
Message-Id: <41hkL22H2Dz9s4Z@ozlabs.org>
Date: Fri,  3 Aug 2018 20:48:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-08-03 at 04:03:36 UTC, Reza Arbab wrote:
> We've encountered a performance issue when multiple processors stress
> {get,put}_mmio_atsd_reg(). These functions contend for mmio_atsd_usage,
> an unsigned long used as a bitmask.
> 
> The accesses to mmio_atsd_usage are done using test_and_set_bit_lock()
> and clear_bit_unlock(). As implemented, both of these will require a
> (successful) stwcx to that same cache line.
> 
> What we end up with is thread A, attempting to unlock, being slowed by
> other threads repeatedly attempting to lock. A's stwcx instructions fail
> and retry because the memory reservation is lost every time a different
> thread beats it to the punch.
> 
> There may be a long-term way to fix this at a larger scale, but for now
> resolve the immediate problem by gating our call to
> test_and_set_bit_lock() with one to test_bit(), which is obviously
> implemented without using a store.
> 
> Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
> Acked-by: Alistair Popple <alistair@popple.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9eab9901b015f489199105c470de1f

cheers
