Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 08BEA1A0452
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 14:03:25 +1000 (AEST)
In-Reply-To: <1435732450-7258-1-git-send-email-shreyas@linux.vnet.ibm.com>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mahesh@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: powerpc/powernv: Fix race in updating core_idle_state
Message-Id: <20150706040324.E78D2140DC0@ozlabs.org>
Date: Mon,  6 Jul 2015 14:03:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-07 at 06:34:10 UTC, "Shreyas B. Prabhu" wrote:
> core_idle_state is maintained for each core. It uses 0-7 bits to track
> whether a thread in the core has entered fastsleep or winkle. 8th bit is
> used as a lock bit.
> The lock bit is set in these 2 scenarios-
>  - The thread is first in subcore to wakeup from sleep/winkle.
>  - If its the last thread in the core about to enter sleep/winkle
> 
> While the lock bit is set, if any other thread in the core wakes up, it
> loops until the lock bit is cleared before proceeding in the wakeup
> path. This helps prevent race conditions w.r.t fastsleep workaround and
> prevents threads from switching to process context before core/subcore
> resources are restored.
> 
> But, in the path to sleep/winkle entry, we currently don't check for
> lock-bit. This exposes us to following race when running with subcore
> on-
> 
> First thread in the subcorea		Another thread in the same
> waking up		   		core entering sleep/winkle
> 
> lwarx   r15,0,r14
> ori     r15,r15,PNV_CORE_IDLE_LOCK_BIT
> stwcx.  r15,0,r14
> [Code to restore subcore state]
> 
> 						lwarx   r15,0,r14
> 						[clear thread bit]
> 						stwcx.  r15,0,r14
> 
> andi.   r15,r15,PNV_CORE_IDLE_THREAD_BITS
> stw     r15,0(r14)
> 
> Here, after the thread entering sleep clears its thread bit in
> core_idle_state, the value is overwritten by the thread waking up.
> This patch fixes the above race by looping on the lock bit even while
> entering the idle states.

What are the symptoms of this bug?

I assume they're not good. In which case this should go to stable, shouldn't
it? If so which versions?

And which commit introduced the bug?

cheers
