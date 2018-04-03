Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Fv5n0nDxzF28m
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 02:03:41 +1000 (AEST)
In-Reply-To: <20180326150103.22941-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s: return more carefully from sreset NMI
Message-Id: <40Fv5m40Rxz9s3c@ozlabs.org>
Date: Wed,  4 Apr 2018 02:03:40 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-03-26 at 15:01:03 UTC, Nicholas Piggin wrote:
> System Reset, being an NMI, must return more carefully than other
> interrupts. It has traditionally returned via the nromal return
> from exception path, but that has a number of problems.
> 
> - r13 does not get restored if returning to kernel. This is for
>   interrupts which may cause a context switch, which sreset will
>   never do. Interrupting OPAL (which uses a different r13) is one
>   place where this causes breakage.
> 
> - It may cause several other problems returning to kernel with
>   preempt or TIF_EMULATE_STACK_STORE if it hits at the wrong time.
> 
> It's safer just to have a simple restore and return, like machine
> check which is the other NMI.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/15b4dd7981496f51c5f9262a5e0761

cheers
