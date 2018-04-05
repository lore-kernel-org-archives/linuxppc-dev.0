Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40H5Cd20NWzF1kQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 00:42:53 +1000 (AEST)
In-Reply-To: <20180405055049.21883-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s: Fix dt_cpu_ftrs to have restore_cpu clear unwanted
 LPCR bits
Message-Id: <40H5Cc6zkrz9s27@ozlabs.org>
Date: Fri,  6 Apr 2018 00:42:52 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-04-05 at 05:50:49 UTC, Nicholas Piggin wrote:
> Presently the dt_cpu_ftrs restore_cpu will only add bits to the LPCR
> for secondaries, but some bits must be removed (e.g., UPRT for HPT).
> Not clearing these bits on secondaries causes checkstops when booting
> with disable_radix.
> 
> restore_cpu can not just set LPCR, because it is also called by the
> idle wakeup code which relies on opal_slw_set_reg to restore the value
> of LPCR, at least on P8 which does not save LPCR to stack in the idle
> code.
> 
> Fix this by including a mask of bits to clear from LPCR as well, which
> is used by restore_cpu.
> 
> This is a little messy now, but it's a minimal fix that can be
> backported.  Longer term, the idle SPR save/restore code can be
> reworked to completely avoid calls to restore_cpu, then restore_cpu
> would be able to unconditionally set LPCR to match boot processor
> environment.
> 
> Fixes: 5a61ef74f269f ("powerpc/64s: Support new device tree binding for discovering CPU features")
> Cc: stable@vger.kernel.org # v4.12+
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a57ac411832384eb93df4bfed2bf64

cheers
