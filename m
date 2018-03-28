Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B8xM19yKzF2MH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 01:13:27 +1100 (AEDT)
In-Reply-To: <1521632426-30770-1-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] powerpc/perf: Fix kernel address leaks via Sampling registers
Message-Id: <40B8xL6Jblz9s0q@ozlabs.org>
Date: Thu, 29 Mar 2018 01:13:26 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-03-21 at 11:40:24 UTC, Madhavan Srinivasan wrote:
> From: Michael Ellerman <mpe@ellerman.id.au>
> 
> Current code in power_pmu_disable() does not clear the sampling
> registers like Sampling Instruction Address Register (SAIR) and
> Sampling Data Address Register (SDAR) after disabling the PMU.
> Since these are userspace readable and could contain kernel
> address, add code to explicitly clear the content of these registers.
> Patch also adds a "context synchronizing instruction" to enforce
> no further updates to these registers as mandated by PowerISA.
> 
> "If an mtspr instruction is executed that changes the
> value of a Performance Monitor register other than
> SIAR, SDAR, and SIER, the change is not guaranteed
> to have taken effect until after a subsequent context
> synchronizing instruction has been executed (see
> Chapter 11. "Synchronization Requirements for Con-
> text Alterations" on page 1133)."
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e1ebd0e5b9d0a10ba65e63a3514b6d

cheers
