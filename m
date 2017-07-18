Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBbyZ3qYZzDrFM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 20:30:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64s: Fix hypercall entry clobbering r12 input
In-Reply-To: <20170718053244.7665-1-npiggin@gmail.com>
References: <20170718053244.7665-1-npiggin@gmail.com>
Date: Tue, 18 Jul 2017 20:30:12 +1000
Message-ID: <87vamqhwaz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

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
>
> ---
> One brown paper bag please.

We're all out, Ben, Mikey and I used them all up :)

cheers
