Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 91CD82C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 13:12:36 +1000 (EST)
Message-ID: <1377141057.25016.265.camel@pasglop>
Subject: Re: [RFC V2 PATCH 2/6] powerpc: Implement broadcast timer interrupt
 as an IPI message
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Thu, 22 Aug 2013 13:10:57 +1000
In-Reply-To: <20130814115602.5193.60835.stgit@preeti.in.ibm.com>
References: <20130814115311.5193.32212.stgit@preeti.in.ibm.com>
 <20130814115602.5193.60835.stgit@preeti.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: fweisbec@gmail.com, paul.gortmaker@windriver.com, paulus@samba.org,
 shangw@linux.vnet.ibm.com, rjw@sisk.pl, paulmck@linux.vnet.ibm.com,
 arnd@arndb.de, linux-pm@vger.kernel.org, rostedt@goodmis.org,
 john.stultz@linaro.org, tglx@linutronix.de, chenhui.zhao@freescale.com,
 deepthi@linux.vnet.ibm.com, r58472@freescale.com, geoff@infradead.org,
 linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
 schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-08-14 at 17:26 +0530, Preeti U Murthy wrote:
> -static irqreturn_t unused_action(int irq, void *data)
> +static irqreturn_t timer_action(int irq, void *data)
>  {
> -       /* This slot is unused and hence available for use, if needed
> */
> +       timer_interrupt();
>         return IRQ_HANDLED;
>  }
>  

That means we'll do irq_enter/irq_exit twice no ? And things like
may_hard_irq_enable() are also already done by do_IRQ so you
don't need timer_interrupt() to do it again.

We probably are better off breaking timer_interrupt in two:

void __timer_interrupt(struct pt_regs * regs)

Does the current stuff between irq_enter and irq_exit, timer_interrupt
does the remaining around it and calls __timer_interrupt.

Then from timer_action, you call __timer_interrupt()

Cheers,
Ben.
