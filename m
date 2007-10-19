Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 327DBDDF06
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 14:29:42 +1000 (EST)
Subject: Re: [PATCH] synchronize_irq needs a barrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <20071019042025.GA9617@gondor.apana.org.au>
References: <E1IiWnJ-0000ne-00@gondolin.me.apana.org.au>
	<1192745137.7367.40.camel@pasglop>
	<alpine.LFD.0.999.0710181549330.26902@woody.linux-foundation.org>
	<1192749449.7367.51.camel@pasglop>
	<alpine.LFD.0.999.0710181627091.26902@woody.linux-foundation.org>
	<20071019023219.GB8453@gondor.apana.org.au>
	<alpine.LFD.0.999.0710181941020.26902@woody.linux-foundation.org>
	<alpine.LFD.0.999.0710182007170.26902@woody.linux-foundation.org>
	<20071019042025.GA9617@gondor.apana.org.au>
Content-Type: text/plain
Date: Fri, 19 Oct 2007 14:29:03 +1000
Message-Id: <1192768143.7367.98.camel@pasglop>
Mime-Version: 1.0
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-10-19 at 12:20 +0800, Herbert Xu wrote:
> 
> That's why I think this patch is in fact the only one that
> solves all the races in this thread.  The case that it solves
> which the lock/unlock patch does not is the one where action
> flows downwards past the clearing of IRQ_INPROGRESS.  I missed
> this case earlier.
> 
> In fact this bug exists elsewhere too.  For example, the network
> stack does this in net/sched/sch_generic.c:
> 
>         /* Wait for outstanding qdisc_run calls. */
>         while (test_bit(__LINK_STATE_QDISC_RUNNING, &dev->state))
>                 yield();
> 
> This has the same problem as the current synchronize_irq code.

The network stack always made be nervous with it's bitops use as locks.
Any loop of test_bit() alone as a synchronisation method, without locks
or barriers is, imho, inherently buggy.

Ben.
