Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxrB60TczF0X1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:34 +1100 (AEDT)
In-Reply-To: <20180117124722.31063-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/watchdog: remove arch_trigger_cpumask_backtrace
Message-Id: <3zPxr81Gk4z9t39@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:30 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-01-17 at 12:47:22 UTC, Nicholas Piggin wrote:
> The powerpc NMI IPIs may not be recoverable if they are taken in
> some sections of code, and also there have been and still are issues
> with taking NMIs (in KVM guest code, in firmware, etc) which makes them
> a bit dangerous to use.
> 
> Generic code like softlockup detector and rcu stall detectors really
> hammer on trigger_*_backtrace, which has lead to further problems
> because we've implemented it with the NMI.
> 
> So stop providing NMI backtraces for now. Importantly, the powerpc code
> uses NMI IPIs in crash/debug, and the SMP hardlockup watchdog. So if the
> softlockup and rcu hang detection traces are not being printed because
> the CPU is stuck with interrupts off, then the hard lockup watchdog
> should get it with the NMI IPI.
> 
> Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
> Signed-of-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/47712a921bb781caf69fca9eae43be

cheers
