Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yYHMl6jR6zDrKG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 22:08:35 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/3] powerpc/powernv: Always stop secondaries before
 reboot/shutdown
In-Reply-To: <20171023080507.21974-2-npiggin@gmail.com>
References: <20171023080507.21974-1-npiggin@gmail.com>
 <20171023080507.21974-2-npiggin@gmail.com>
Date: Fri, 10 Nov 2017 22:08:32 +1100
Message-ID: <87tvy2o0gf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> Currently powernv reboot and shutdown requests just leave secondaries
> to do their own things. This is undesirable because they can trigger
> any number of watchdogs while waiting for reboot, but also we don't
> know what else they might be doing, or they might be stuck somewhere
> causing trouble.
>
> The opal scheduled flash update code already ran into watchdog problems
> due to flashing taking a long time, but it's possible for regular
> reboots to trigger problems too (this is with watchdog_thresh set to 1,
> but I have seen it with watchdog_thresh at the default value once too):
>
>   reboot: Restarting system
>   [  360.038896709,5] OPAL: Reboot request...
>   Watchdog CPU:0 Hard LOCKUP
>   Watchdog CPU:44 detected Hard LOCKUP other CPUS:16
>   Watchdog CPU:16 Hard LOCKUP
>   watchdog: BUG: soft lockup - CPU#16 stuck for 3s! [swapper/16:0]
>
> So remove the special case for flash update, and unconditionally do
> smp_send_stop before rebooting.
>
> Return the CPUs to Linux stop loops rather than OPAL. The reason for
> this is that the path to firmware is longer, and the CPUs may have
> been interrupted from firmware, which may cause problems to re-enter
> it. It's better to put them into a simple spin loop to maximize the
> chance of a successful reboot.

I always assumed we had to send the CPUs back to OPAL for the flashing
procedure. Is it OK to leave them in Linux?

cheers
