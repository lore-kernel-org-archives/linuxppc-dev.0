Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNQyz0CjRzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 20:19:39 +1000 (AEST)
In-Reply-To: <20170729125027.31835-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s: watchdog fix stack setup
Message-Id: <3xNQyy6p0fz9s81@ozlabs.org>
Date: Thu,  3 Aug 2017 20:19:38 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-07-29 at 12:50:27 UTC, Nicholas Piggin wrote:
> The watchdog soft-NMI exception stack setup loads a stack pointer
> twice, which is an obvious error. It ends up using the system reset
> interrupt (true-NMI) stack, which is also a bug because the watchdog
> could be preempted by a system reset interrupt that overwrites the
> NMI stack.
> 
> Change the soft-NMI to use the "emergency stack". The current kernel
> stack is not used, because of the longer-term goal to prevent
> asynchronous stack access using soft-disable.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/cc491f1d3583146eaee635c86b9c92

cheers
