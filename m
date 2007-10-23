Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 37373DDE0F
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 08:47:19 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9NMlEXM010406
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 18:47:14 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9NMlElm043174
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 18:47:14 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9NMlEE8023792
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 18:47:14 -0400
Subject: Re: [PATCH 1/7] Implement arch disable/enable irq hooks.
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <471E68E2.3040008@freescale.com>
References: <20071023212404.GA30942@loki.buserror.net>
	<20071023163301.4857393e@weaponx.rchland.ibm.com>
	<471E68E2.3040008@freescale.com>
Content-Type: text/plain
Date: Tue, 23 Oct 2007 17:45:02 -0500
Message-Id: <1193179502.25515.16.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-10-23 at 16:34 -0500, Scott Wood wrote:
> Josh Boyer wrote:
> >> +#ifdef CONFIG_SUSPEND
> >> +void generic_suspend_disable_irqs(void)
> >> +{
> >> +	preempt_disable();
> >> +
> >> +	/* Disable the decrementer, so that it doesn't interfere
> >> +	 * with suspending.
> >> +	 */
> >> +
> >> +	set_dec(0x7fffffff);
> >> +	hard_irq_disable();
> >> +	set_dec(0x7fffffff);
> >> +}
> >> +
> >> +void generic_suspend_enable_irqs(void)
> >> +{
> >> +	wakeup_decrementer();
> >> +
> >> +	local_irq_enable();
> >> +	preempt_enable();
> >> +}
> > 
> > Should these be static functions?  Seems so...
> 
> I was asked to make them available to be called by non-generic 
> implementations.

Perhaps it's just me, but the names seem a bit _too_ generic if they
aren't going to be static functions.  Maybe I'm paranoid.

josh
