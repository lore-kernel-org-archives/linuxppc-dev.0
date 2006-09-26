Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 45DEE67B6D
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 01:43:56 +1000 (EST)
Date: Tue, 26 Sep 2006 10:43:13 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Lazy interrupt disabling for 64-bit machines
Message-ID: <20060926104313.06653807@pb15>
In-Reply-To: <1159261926.5462.54.camel@localhost.localdomain>
References: <17688.45762.294594.33723@cargo.ozlabs.ibm.com>
	<20060926011055.32d533e7@pb15>
	<1159261926.5462.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 26 Sep 2006 19:12:06 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > I like it. Got any benchmarks that show a difference?
> > 
> > At first glance I found it a bit hard to follow, since the old+new
> > terminology is a bit complicated. There's softe, proc_enabled and
> > hard_enabled. A s/proc_enabled/soft_enabled/g (and similar for
> > asm-offsets) might make it a little more intuitive, since you're
> > touching most uses of it already?
> 
> Now think about using -ffixed=crN ... reserve a CR field and use that
> for per-cpu flags like that :)

You can also get away from doing the mfspr(SPRN_DEC) in
local_irq_enable() by changing the polarity of hard_enabled to
hard_disabled, and have different values for why it was disabled. Saves
an mfspr which can be costly, but adds one instruction (li (n>>8) or
so) in the exception entry path. Not which way that tradeoff will
swing, without benchmarking to show benefit it's just added complexity.

That can be done with a fixed cr too, it just uses two bits instead of
one. There are fewer to take from there though.


-Olof
