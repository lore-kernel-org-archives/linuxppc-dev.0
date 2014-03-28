Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7D93E1400A2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Mar 2014 08:27:02 +1100 (EST)
Message-ID: <1396041923.11529.23.camel@pasglop>
Subject: Re: [PATCH] powerpc/irq: Remove HAVE_IRQ_EXIT_ON_IRQ_STACK feature
 at powerpc platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Sat, 29 Mar 2014 08:25:23 +1100
In-Reply-To: <1395992312-23035-1-git-send-email-dongsheng.wang@freescale.com>
References: <1395992312-23035-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: James Hogan <james.hogan@imgtec.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>,
 fweisbec@gmail.com, Helge Deller <deller@gmx.de>,
 linuxppc-dev@lists.ozlabs.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@au1.ibm.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, jason.jin@freescale.com,
 "H. Peter Anvin" <hpa@zytor.com>, scottwood@freescale.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-03-28 at 15:38 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> If softirq use hardirq stack, we will get kernel painc when a hard irq coming again
> during __do_softirq enable local irq to deal with softirq action. So we need to switch
> satck into softirq stack when invoke soft irq.

Yes, an interrupt can potentially nest but we should be near the top of
the stack at that point, as the comment says in softirq.c, it should
be fine. And your backtrace doesn't seem to indicate a major overflow.

The code in do_IRQ() will make sure we don't switch stack again if
we were already on either hard or softirq stack.

I need a better analysis of your problem. Is that really a stack
overflow ? Or is it a false positive due to a bug in the overflow
detection ?

I moved around the code that updates KSP_LIMIT in 32-bit to asm in
misc_32.S a while ago since we don't do that on 64-bit, maybe we are
getting it wrong...

Cheers,
Ben.
