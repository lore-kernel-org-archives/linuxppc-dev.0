Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxg14frKzF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:10:53 +1000 (AEST)
In-Reply-To: <20180510122148.3996-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/powernv: call OPAL_QUIESCE before OPAL_SIGNAL_SYSTEM_RESET
Message-Id: <40zxg04Z4wz9s5R@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:51 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-05-10 at 12:21:48 UTC, Nicholas Piggin wrote:
> Although it is often possible to recover a CPU that was interrupted
> from OPAL with a system reset NMI, it's undesirable to interrupt them
> for a few reasons. Firstly because dump/debug code itself needs to
> call firmware, so it could hang on a lock or possibly corrupt a
> per-cpu data structure if it or another CPU was interrupted from
> OPAL. Secondly, the kexec crash dump code will not return from
> interrupt to unwind the OPAL call.
> 
> Call OPAL_QUIESCE with QUIESCE_HOLD before sending an NMI IPI to
> another CPU, which wait for it to leave firmware (or time out) to
> avoid this problem in normal conditions. Firmware bugs may still
> result in a timeout and interrupting OPAL, but that is the best
> option (stops the CPU, and possibly allows firmware to be debugged).
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ee03b9b4479d1302d01cebedda3518

cheers
