Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WtRm6Bw9zF24d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 20:22:44 +1000 (AEST)
In-Reply-To: <20180426101902.22886-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: [v3] powerpc: Fix smp_send_stop NMI IPI handling
Message-Id: <40WtRm4wzjz9s0p@ozlabs.org>
Date: Thu, 26 Apr 2018 20:22:44 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-04-26 at 10:19:02 UTC, Michael Ellerman wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> The NMI IPI handler for a receiving CPU increments nmi_ipi_busy_count
> over the handler function call, which causes later smp_send_nmi_ipi()
> callers to spin until the call is finished.
> 
> The stop_this_cpu() function never returns, so the busy count is never
> decremeted, which can cause the system to hang in some cases. For
> example panic() will call smp_send_stop() early on which calls
> stop_this_cpu() on other CPUs, then later in the reboot path,
> pnv_restart() will call smp_send_stop() again, which hangs.
> 
> Fix this by adding a special case to the stop_this_cpu() handler to
> decrement the busy count, because it will never return.
> 
> Now that the NMI/non-NMI versions of stop_this_cpu() are different,
> split them out into separate functions rather than doing #ifdef tricks
> to share the body between the two functions.
> 
> Fixes: 6bed3237624e3 ("powerpc: use NMI IPI for smp_send_stop")
> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> [mpe: Split out the functions, tweak change log a bit]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/ac61c1156623455c46701654abd8c9

cheers
