Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40D0d83DJwzF1xW
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 01:05:48 +1100 (AEDT)
In-Reply-To: <20180331140024.1610-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: powerpc/mpic: Check if cpu_possible() in mpic_physmask()
Message-Id: <40D0d75pJrz9s2t@ozlabs.org>
Date: Sun,  1 Apr 2018 01:05:47 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2018-03-31 at 14:00:24 UTC, Michael Ellerman wrote:
> In mpic_physmask() we loop over all CPUs up to 32, then get the hard
> SMP processor id of that CPU.
> 
> Currently that's possibly walking off the end of the paca array, but
> in a future patch we will change the paca array to be an array of
> pointers, and in that case we will get a NULL for missing CPUs and
> oops. eg:
> 
>   Unable to handle kernel paging request for data at address 0x88888888888888b8
>   Faulting instruction address: 0xc00000000004e380
>   Oops: Kernel access of bad area, sig: 11 [#1]
>   ...
>   NIP .mpic_set_affinity+0x60/0x1a0
>   LR  .irq_do_set_affinity+0x48/0x100
> 
> Fix it by checking the CPU is possible, this also fixes the code if
> there are gaps in the CPU numbering which probably never happens on
> mpic systems but who knows.
> 
> Debugged-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/0834d627fbea00c1444075eb3e448e

cheers
