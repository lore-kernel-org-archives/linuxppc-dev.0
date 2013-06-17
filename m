Return-Path: <imr@rtschenk.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1BB482C029B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 23:21:21 +1000 (EST)
From: Rojhalat Ibrahim <imr@rtschenk.de>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Regression in RCU subsystem in latest mainline kernel
Date: Mon, 17 Jun 2013 15:21:15 +0200
Message-ID: <1558776.vQIgbXvFW8@pcimr>
In-Reply-To: <1371262654.9844.340.camel@gandalf.local.home>
References: <1626500.7WAVXjfS9F@pcimr> <1371261741.21896.20.camel@pasglop>
 <1371262654.9844.340.camel@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: paulmck@linux.vnet.ibm.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 14 June 2013 22:17:34 Steven Rostedt wrote:
> On Sat, 2013-06-15 at 12:02 +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2013-06-14 at 17:06 -0400, Steven Rostedt wrote:
> > > I was pretty much able to reproduce this on my PA Semi PPC box. Funny
> > > thing is, when I type on the console, it makes progress. Anyway, it
> > > seems that powerpc has an issue with irq_work(). I'll try to get some
> > > time either tonight or next week to figure it out.
> > 
> > Does this help ?
> 
> It did for me. Rojhalat, did this fix your issue too?
> 

FWIW, since the fix is already applied, but it fixes my problem too.

   Rojhalat


> -- Steve
> 
> > diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> > index 5cbcf4d..ea185e0 100644
> > --- a/arch/powerpc/kernel/irq.c
> > +++ b/arch/powerpc/kernel/irq.c
> > @@ -162,7 +162,7 @@ notrace unsigned int __check_irq_replay(void)
> > 
> >  	 * in case we also had a rollover while hard disabled
> >  	 */
> >  	
> >  	local_paca->irq_happened &= ~PACA_IRQ_DEC;
> > 
> > -	if (decrementer_check_overflow())
> > +	if ((happened & PACA_IRQ_DEC) || decrementer_check_overflow())
> > 
> >  		return 0x900;
> >  	
> >  	/* Finally check if an external interrupt happened */
> > 
> > Cheers,
> > Ben.
