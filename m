Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id E671A2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 12:17:36 +1000 (EST)
Message-ID: <1371262654.9844.340.camel@gandalf.local.home>
Subject: Re: Regression in RCU subsystem in latest mainline kernel
From: Steven Rostedt <rostedt@goodmis.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 14 Jun 2013 22:17:34 -0400
In-Reply-To: <1371261741.21896.20.camel@pasglop>
References: <1626500.7WAVXjfS9F@pcimr>
 <20130614122800.GL5146@linux.vnet.ibm.com> <1645938.As0LR1yeVd@pcimr>
 <1371243967.9844.338.camel@gandalf.local.home>
 <1371261741.21896.20.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, paulmck@linux.vnet.ibm.com,
 Rojhalat Ibrahim <imr@rtschenk.de>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2013-06-15 at 12:02 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2013-06-14 at 17:06 -0400, Steven Rostedt wrote:
> > I was pretty much able to reproduce this on my PA Semi PPC box. Funny
> > thing is, when I type on the console, it makes progress. Anyway, it
> > seems that powerpc has an issue with irq_work(). I'll try to get some
> > time either tonight or next week to figure it out.
> 
> Does this help ?

It did for me. Rojhalat, did this fix your issue too?

-- Steve

> 
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 5cbcf4d..ea185e0 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -162,7 +162,7 @@ notrace unsigned int __check_irq_replay(void)
>  	 * in case we also had a rollover while hard disabled
>  	 */
>  	local_paca->irq_happened &= ~PACA_IRQ_DEC;
> -	if (decrementer_check_overflow())
> +	if ((happened & PACA_IRQ_DEC) || decrementer_check_overflow())
>  		return 0x900;
>  
>  	/* Finally check if an external interrupt happened */
> 
> Cheers,
> Ben.
> 
