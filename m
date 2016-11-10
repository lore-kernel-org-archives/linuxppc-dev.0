Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDlxc1zwvzDvbn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 12:36:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: fix graceful debugger recovery
In-Reply-To: <20161108121445.15303-2-npiggin@gmail.com>
References: <20161108121445.15303-1-npiggin@gmail.com>
 <20161108121445.15303-2-npiggin@gmail.com>
Date: Thu, 10 Nov 2016 12:35:59 +1100
Message-ID: <87mvh8jev4.fsf@concordia.ellerman.id.au>
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

> When exiting xmon with 'x' (exit and recover), oops_begin bails
> out immediately, but die then calls __die() and oops_end(), which
> cause a lot of bad things to happen.

In fact oops_begin() returns 1, which oops_end() then passes directly to
raw_local_irq_restore() as flags. On 64-bit that actually works because
arch_local_irq_restore() takes just "en" (enable), not real flags. But
on 32-bit it's supposed to be the MSR value. So that's impressively
broken.

> If the debugger was attached then went to graceful recovery, exit
> from die() immediately.

Right. Crucially it doesn't change anything in terms of the actual logic
of oops_begin(), ie. previously oops_begin() did nothing prior to
calling debugger(), and after this patch that remains the same (which
you did mention above but just spelling it out for myself).

cheers
