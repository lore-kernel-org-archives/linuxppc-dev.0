Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77F11DDDD8
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 17:32:45 +1100 (EST)
Subject: Bug in "genirq: record trigger type"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200810202205.m9KM5une024759@hera.kernel.org>
References: <200810202205.m9KM5une024759@hera.kernel.org>
Content-Type: text/plain
Date: Tue, 21 Oct 2008 17:32:10 +1100
Message-Id: <1224570730.7654.242.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-10-20 at 22:05 +0000, Linux Kernel Mailing List wrote:
> Gitweb:     http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=0c5d1eb77a8be917b638344a22afe1398236482b
> Commit:     0c5d1eb77a8be917b638344a22afe1398236482b
> Parent:     d6d5aeb661fc14655c417f3582ae7ec52985d2a8
> Author:     David Brownell <dbrownell@users.sourceforge.net>
> AuthorDate: Wed Oct 1 14:46:18 2008 -0700
> Committer:  Ingo Molnar <mingo@elte.hu>
> CommitDate: Thu Oct 2 10:24:09 2008 +0200

This one is obviously broken and breaks booting on a whole bunch of
machines (including powermac's and thus my G5, it's never good when my
own machine breaks !).

Nice to see 3 SOB's and one Ack and nobody caught the obvious bug :-)

>  	desc = irq_desc + irq;
> -	if (desc->chip->set_type) {
> -		spin_lock_irqsave(&desc->lock, flags);
> -		ret = desc->chip->set_type(irq, type);
> -		spin_unlock_irqrestore(&desc->lock, flags);
> -	}
> +	if (type == IRQ_TYPE_NONE)
> +		return 0;
> +
> +	spin_lock_irqsave(&desc->lock, flags);
> +	ret = __irq_set_trigger(desc, irq, flags);
                                             ^^^^ type maybe ?

> +	spin_unlock_irqrestore(&desc->lock, flags);
>  	return ret;
>  }

I have to run so no patch until tomorrow unless somebody beats me to it.

Cheers,
Ben.
