Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDSmf0dNRzDqts
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 21:13:06 +1000 (AEST)
In-Reply-To: <20170718053244.7665-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s: Fix hypercall entry clobbering r12 input
Message-Id: <3xDSmd6Xntz9t2H@ozlabs.org>
Date: Fri, 21 Jul 2017 21:13:05 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-07-18 at 05:32:44 UTC, Nicholas Piggin wrote:
> A previous optimisation incorrectly assumed the PAPR hcall does
> not use r12, and clobbers it upon entry. In fact it is used as
> an input. This can result in KVM guests crashing (observed with
> PR KVM).
> 
> Instead of using r12 to save r13, tihs patch saves r13 in ctr.
> This is more costly, but not as slow as using the SPRG.
> 
> Fixes: acd7d8cef0153 ("powerpc/64s: Optimize hypercall/syscall entry")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/76fc0cfcc5b0f520062ca6d7225b22

cheers
