Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B0212DDF93
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 09:54:04 +1000 (EST)
Date: Fri, 08 May 2009 16:53:58 -0700 (PDT)
Message-Id: <20090508.165358.97542490.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: question about softirqs
From: David Miller <davem@davemloft.net>
In-Reply-To: <18948.49541.735156.176919@cargo.ozlabs.ibm.com>
References: <4A04B76D.20106@nortel.com>
	<18948.49541.735156.176919@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Sat, 9 May 2009 09:34:29 +1000

> If a soft irq is raised in process context, raise_softirq() in
> kernel/softirq.c calls wakeup_softirqd() to make sure that ksoftirqd
> runs soon to process the soft irq.  So what would happen is that we
> would see the TIF_RESCHED_PENDING flag on the current task in the
> syscall exit path and call schedule() which would switch to ksoftirqd
> to process the soft irq (if it hasn't already been processed by that
> stage).
> 
> If the soft irq is raised in interrupt context, then the soft irq gets
> run via the do_softirq() call in irq_exit(), as you saw.
> 
> The soft irq stuff is pretty much all generic code these days, except
> for the code to switch to the softirq stack.

Grumble, when did that happen :-(

That's horrible for latency compared to handling it directly
in the trap return path.
