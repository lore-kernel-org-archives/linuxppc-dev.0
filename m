Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4AC911A0202
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 20:14:02 +1100 (AEDT)
In-Reply-To: <1449786882.29188.32.camel@neuling.org>
To: Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org, Cyril Bur <cyrilbur@gmail.com>
Subject: Re: [v3,
 2/2] powerpc: Copy only required pieces of the mm_context_t to the
 paca
Message-Id: <20160111091402.01723140320@ozlabs.org>
Date: Mon, 11 Jan 2016 20:14:01 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-10-12 at 22:34:42 UTC, Michael Neuling wrote:
> Currently we copy the whole mm_context_t to the paca but only access a
> few bits of it.  This is wasteful of space paca and also takes quite
> some time in the hot path of context switching.
> 
> This patch pulls in only the required bits from the mm_context_t to
> the paca and on context switch, copies only those.
> 
> Benchmarking this (On top of Anton's recent MSR context switching
> changes [1]) using processes and yield shows an improvement of almost
> 3% on POWER8:
> 
>   http://ozlabs.org/~anton/junkcode/context_switch2.c
>   ./context_switch2 --test=yield --process 0 0
> 
> 1. https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-October/135700.html
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2fc251a8dda56b71ec491bee4c

cheers
