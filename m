Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6704D1007D2
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 15:11:59 +1000 (EST)
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Darren Hart <dvhltc@us.ibm.com>
In-Reply-To: <4C491E14.9010100@us.ibm.com>
References: <4C488CCD.60004@us.ibm.com> <1279837509.1970.24.camel@pasglop>
	<4C48DADE.1050409@us.ibm.com>  <4C491E14.9010100@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 23 Jul 2010 15:09:27 +1000
Message-ID: <1279861767.1970.73.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Gautham R Shenoy <ego@in.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Will Schmidt <willschm@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-07-22 at 21:44 -0700, Darren Hart wrote:

>  suggestion I updated the instrumentation to display the
> local_save_flags and irqs_disabled_flags:

> Jul 22 23:36:58 igoort1 kernel: local flags: 0, irqs disabled: 1
> Jul 22 23:36:58 igoort1 kernel: before H_CEDE current->stack: c00000010e9e3ce0, pcnt: 1
> Jul 22 23:36:58 igoort1 kernel: after H_CEDE current->stack: c00000010e9e3ce0, pcnt: 1
> 
> I'm not sure if I'm reading that right, but I believe interrupts are
> intended to be disabled here. If accomplished via the
> spin_lock_irqsave() this would behave differently on RT. However, this
> path disables the interrupts handled by xics, all but the IPIs anyway.
> On RT I disabled the decrementer as well.
> 
> Is it possible for RT to be receiving other interrupts here?

Also you may want to call hard_irq_disable() to -really- disable
interrupts ... since we do lazy-disable on powerpc

Cheers,
Ben.
