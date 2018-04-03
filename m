Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Fv5p4fSDzF28m
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 02:03:42 +1000 (AEST)
In-Reply-To: <20180326150116.22990-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s: sreset panic if there is no debugger or crash dump
 handlers
Message-Id: <40Fv5n6c8Gz9s4V@ozlabs.org>
Date: Wed,  4 Apr 2018 02:03:41 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-03-26 at 15:01:16 UTC, Nicholas Piggin wrote:
> system_reset_exception does most of its own crash handling now,
> invoking the debugger or crash dumps if they are registered. If not,
> then it goes through to die() to print stack traces, and then is
> supposed to panic (according to comments).
> 
> However after die() prints oopses, it does its own handling which
> doesn't allow system_reset_exception to panic (e.g., it may just
> kill the current process). This patch causes sreset exceptions to
> return from die after it prints messages but before acting.
> 
> This also stops die from invoking the debugger on 0x100 crashes.
> system_reset_exception similarly calls the debugger. It had been
> thought this was harmless (because if the debugger was disabled,
> neither call would fire, and if it was enabled the first call
> would return). However in some cases like xmon 'X' command, the
> debugger returns 0, which currently causes it to be entered
> again (first in system_reset_exception, then in die), which is
> confusing.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d40b6768e45bd9213139b2d91d30c7

cheers
