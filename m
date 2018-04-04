Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GTBd1kX8zF1b9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 00:39:53 +1000 (AEST)
In-Reply-To: <20180401054855.17864-4-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v3,
 3/3] powerpc/64s/idle: POWER9 ESL=0 stop avoid save/restore overhead
Message-Id: <40GTBd0Svhz9s28@ozlabs.org>
Date: Thu,  5 Apr 2018 00:39:52 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-04-01 at 05:48:55 UTC, Nicholas Piggin wrote:
> When stop is executed with EC=ESL=0, it appears to execute like a
> normal instruction (resuming from NIP when woken by interrupt). So all
> the save/restore handling can be avoided completely. In particular NV
> GPRs do not have to be saved, and MSR does not have to be switched
> back to kernel MSR.
> 
> So move the test for EC=ESL=0 sleep states out to power9_idle_stop,
> and return directly to the caller after stop in that case.
> 
> This improves performance for ping-pong benchmark with the stop0_lite
> idle state by 2.54% for 2 threads in the same core, and 2.57% for
> different cores. Performance increase with HV_POSSIBLE defined will be
> improved further by avoiding the hwsync.
> 
> Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b9ee31e100e73075431faaf7af2ee0

cheers
