Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B523DDEC2
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 01:48:52 +1100 (EST)
Subject: Re: [PATCH 2/5] powerpc: fix suspend states again
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <20070319105358.796834000@sipsolutions.net>
References: <20070319105352.771599000@sipsolutions.net>
	<20070319105358.796834000@sipsolutions.net>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 15:48:47 +0100
Message-Id: <1174315727.5044.6.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-03-19 at 11:53 +0100, Johannes Berg wrote:
> plain text document attachment (002-fix-powermac-suspend-again.patch)
> In commit 0fba3a1f39f8b0a50b56c8b068fa52131cbc84c2 (a very long time ago,
> May 2006), I fixed a bug that caused powermacs to crash when you tried
> entering standby/mem suspend states.
> 
> As I'm now getting more familiar with the suspend code I notice a few
> more things:
>  1. we previously misunderstood what pm_ops is for, it isn't supposed to be
>     for doing platform dependent suspend/resume stuff that needs to be done
>     for suspend to disk (as we currently try to use it!), it is instead for
>     entering platform dependent suspend states ("standby", "mem").
>  2. due to the first point, we never properly save FPU and altivec states
>     when suspending to disk. It probably hasn't hurt yet because the process
>     that writes the "disk" to /sys/power/state uses neither and its context
>     is used.
> 
> This patch addresses these points as follows:
>  1. remove all pm_ops from powermac, powermac suspend to ram isn't currently
>     usable via /sys/power/state but is done via the PMU instead.
>  2. move the code responsible for storing FPU/altivec state into a new
>     arch_prepare_suspend function (previously, this was only present for
>     32-bit platforms from asm-ppc.)
> 
> A follow-on patch will create new pm_ops for via-pmu.
> 
> I removed
> 	set_context(current->active_mm->context.id, current->active_mm->pgd);
> because
>  1. it works without and
>  2. I don't see the point

No, you need that to restore the segment registers. I might work for you
by mere luck.

Ben.
