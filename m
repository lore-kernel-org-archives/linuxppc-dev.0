Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40d6Bs2hV8zDqJl
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 08:29:41 +1000 (AEST)
Message-ID: <90144e7d99aca5c620b1e79a5152f150d76210cc.camel@kernel.crashing.org>
Subject: Re: [PATCH 4/4] powerpc/xive: prepare all hcalls to support long
 busy delays
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le
 Goater <clg@kaod.org>, linuxppc-dev@lists.ozlabs.org
Date: Sat, 05 May 2018 08:29:04 +1000
In-Reply-To: <87d0yb8zye.fsf@concordia.ellerman.id.au>
References: <20180403071548.19829-1-clg@kaod.org>
 <20180403071548.19829-5-clg@kaod.org>
 <87d0yb8zye.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-05-04 at 20:42 +1000, Michael Ellerman wrote:
> Cédric Le Goater <clg@kaod.org> writes:
> 
> > This is not the case for the moment, but future releases of pHyp might
> > need to introduce some synchronisation routines under the hood which
> > would make the XIVE hcalls longer to complete.
> > 
> > As this was done for H_INT_RESET, let's wrap the other hcalls in a
> > loop catching the H_LONG_BUSY_* codes.
> 
> Are we sure it's safe to msleep() in all these paths?

Probably not. We can have the IRQ descriptor lock. We might need to
mdelay.

There's a Kconfig option (forgot which one) that will add checks for
attempts to sleep inside locks, you should run with that.

Cheers,
Ben.

> 
> cheers
> 
> > diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
> > index 7113f5d87952..97ea0a67a173 100644
> > --- a/arch/powerpc/sysdev/xive/spapr.c
> > +++ b/arch/powerpc/sysdev/xive/spapr.c
> > @@ -165,7 +165,10 @@ static long plpar_int_get_source_info(unsigned long flags,
> >  	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
> >  	long rc;
> >  
> > -	rc = plpar_hcall(H_INT_GET_SOURCE_INFO, retbuf, flags, lisn);
> > +	do {
> > +		rc = plpar_hcall(H_INT_GET_SOURCE_INFO, retbuf, flags, lisn);
> > +	} while (plpar_busy_delay(rc));
> > +
> >  	if (rc) {
> >  		pr_err("H_INT_GET_SOURCE_INFO lisn=%ld failed %ld\n", lisn, rc);
> >  		return rc;
> > @@ -198,8 +201,11 @@ static long plpar_int_set_source_config(unsigned long flags,
> >  		flags, lisn, target, prio, sw_irq);
> >  
> >  
> > -	rc = plpar_hcall_norets(H_INT_SET_SOURCE_CONFIG, flags, lisn,
> > -				target, prio, sw_irq);
> > +	do {
> > +		rc = plpar_hcall_norets(H_INT_SET_SOURCE_CONFIG, flags, lisn,
> > +					target, prio, sw_irq);
> > +	} while (plpar_busy_delay(rc));
> > +
> >  	if (rc) {
> >  		pr_err("H_INT_SET_SOURCE_CONFIG lisn=%ld target=%lx prio=%lx failed %ld\n",
> >  		       lisn, target, prio, rc);
> > @@ -218,7 +224,11 @@ static long plpar_int_get_queue_info(unsigned long flags,
> >  	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
> >  	long rc;
> >  
> > -	rc = plpar_hcall(H_INT_GET_QUEUE_INFO, retbuf, flags, target, priority);
> > +	do {
> > +		rc = plpar_hcall(H_INT_GET_QUEUE_INFO, retbuf, flags, target,
> > +				 priority);
> > +	} while (plpar_busy_delay(rc));
> > +
> >  	if (rc) {
> >  		pr_err("H_INT_GET_QUEUE_INFO cpu=%ld prio=%ld failed %ld\n",
> >  		       target, priority, rc);
> > @@ -247,8 +257,11 @@ static long plpar_int_set_queue_config(unsigned long flags,
> >  	pr_devel("H_INT_SET_QUEUE_CONFIG flags=%lx target=%lx priority=%lx qpage=%lx qsize=%lx\n",
> >  		flags,  target, priority, qpage, qsize);
> >  
> > -	rc = plpar_hcall_norets(H_INT_SET_QUEUE_CONFIG, flags, target,
> > -				priority, qpage, qsize);
> > +	do {
> > +		rc = plpar_hcall_norets(H_INT_SET_QUEUE_CONFIG, flags, target,
> > +					priority, qpage, qsize);
> > +	} while (plpar_busy_delay(rc));
> > +
> >  	if (rc) {
> >  		pr_err("H_INT_SET_QUEUE_CONFIG cpu=%ld prio=%ld qpage=%lx returned %ld\n",
> >  		       target, priority, qpage, rc);
> > @@ -262,7 +275,10 @@ static long plpar_int_sync(unsigned long flags, unsigned long lisn)
> >  {
> >  	long rc;
> >  
> > -	rc = plpar_hcall_norets(H_INT_SYNC, flags, lisn);
> > +	do {
> > +		rc = plpar_hcall_norets(H_INT_SYNC, flags, lisn);
> > +	} while (plpar_busy_delay(rc));
> > +
> >  	if (rc) {
> >  		pr_err("H_INT_SYNC lisn=%ld returned %ld\n", lisn, rc);
> >  		return  rc;
> > @@ -285,7 +301,11 @@ static long plpar_int_esb(unsigned long flags,
> >  	pr_devel("H_INT_ESB flags=%lx lisn=%lx offset=%lx in=%lx\n",
> >  		flags,  lisn, offset, in_data);
> >  
> > -	rc = plpar_hcall(H_INT_ESB, retbuf, flags, lisn, offset, in_data);
> > +	do {
> > +		rc = plpar_hcall(H_INT_ESB, retbuf, flags, lisn, offset,
> > +				 in_data);
> > +	} while (plpar_busy_delay(rc));
> > +
> >  	if (rc) {
> >  		pr_err("H_INT_ESB lisn=%ld offset=%ld returned %ld\n",
> >  		       lisn, offset, rc);
> > -- 
> > 2.13.6
