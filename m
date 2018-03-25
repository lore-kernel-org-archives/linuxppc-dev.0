Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408Txl08SDzF1xF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 07:52:59 +1100 (AEDT)
In-Reply-To: <20180323055338.7066-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s: Fix i-side SLB miss bad address handler saving
 nonvolatile GPRs
Message-Id: <408Txk6Mnwz9s0m@ozlabs.org>
Date: Mon, 26 Mar 2018 07:52:58 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-03-23 at 05:53:38 UTC, Nicholas Piggin wrote:
> The SLB bad address handler's trap number fixup does not preserve the
> low bit that indicates nonvolatile GPRs have not been saved. This
> leads save_nvgprs to skip saving them, and subsequent functions and
> return from interrupt will think they are saved.
> 
> This causes kernel branch-to-garbage debugging to not have correct
> registers, can also cause userspace to have its registers clobbered
> after a segfault.
> 
> Fixes: f0f558b131 ("powerpc/mm: Preserve CFAR value on SLB miss caused by access to bogus address")
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

I added:
  Cc: stable@vger.kernel.org # v4.9+

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/52396500f97c53860164debc7d4f75

cheers
