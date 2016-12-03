Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tW80H4SbTzDw28
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2016 22:28:15 +1100 (AEDT)
In-Reply-To: <20161108060806.16168-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/pseries: add definitions for new H_SIGNAL_SYS_RESET hcall
Message-Id: <3tW80H3Pn5z9t1F@ozlabs.org>
Date: Sat,  3 Dec 2016 22:28:15 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-08 at 06:08:06 UTC, Nicholas Piggin wrote:
> This has not made its way to a PAPR release yet, but we have an hcall
> number assigned.
> 
>   H_SIGNAL_SYS_RESET = 0x380
> 
>   Syntax:
>   hcall(uint64 H_SIGNAL_SYS_RESET, /* generate a system reset NMI on   */
>                                    /* the threads indicated by target  */
>         int64 target); /* thread target selection */
>         /* -1 = target all online threads including the caller         */
>         /* -2 = target all online threads except for the caller        */
>         /* All other negative values: reserved                         */
>         /* Positive values: The thread to be targeted,                 */
>         /* obtained from the value of the "ibm,ppc-interrupt-server#s" */
>         /* property of the CPU in the OF device tree                   */
> 
>   Semantics:
>   - If the NMI handlers are not registered, terminate the partition.
>   - Invalid target: return H_Parameter.
>   - Otherwise: Generate a system reset NMI on target thread(s),
>     return H_Success.
> 
> This will be used by crash/debug code to get stuck CPUs into a known state.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/53ce299615e587e900548eb6b384c3

cheers
