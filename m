Return-Path: <jyoung5@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D0028DE103
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 06:09:00 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3AK6pU4015612
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 16:06:51 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3AK8s3t214624
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 14:08:54 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3AK8sdM020125
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 14:08:54 -0600
Subject: Re: [PATCH] [v5] Add idle wait support for 44x platforms
From: Jerone Young <jyoung5@us.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200804101544.44457.arnd@arndb.de>
References: <df0f79b7b4ab628887c2.1207673354@thinkpadL>
	<200804101544.44457.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 10 Apr 2008 15:08:51 -0500
Message-Id: <1207858131.26428.4.camel@thinkpadL>
Mime-Version: 1.0
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
Reply-To: jyoung5@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-04-10 at 15:44 +0200, Arnd Bergmann wrote:
> On Tuesday 08 April 2008, Jerone Young wrote:
> > +static struct sleep_mode modes[] = {
> > +       { .name = "wait", .entry = &ppc44x_idle },
> > +       { .name = "spin", .entry = NULL },
> > +};
> > +
> > +int __init ppc44x_idle_init(void)
> > +{
> > +       void *func = modes[current_mode].entry;
> > +       ppc_md.power_save = func;
> > +       return 0;
> > +}
> > +
> > +arch_initcall(ppc44x_idle_init);
> > +
> > +static int __init idle_param(char *p)
> > +{ 
> > +       int i;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(modes); i++) {
> > +               if (!strcmp(modes[i].name, p)) {
> > +                       current_mode = i;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +early_param("idle", idle_param);
> 
> ok, sorry to steal the show again, now that everyone seems to be happy
> with the current code, but isn't this equivalent to the simple

Well it could be this simple. But the current code leaves a lot more
room to add different type waits or spins if need be (if they are ever
needed ... though none off the top of my head at the moment)...but it
does allow you to create another wait state for whatever reason a lot
easier.

So I really don't think this needs to change. Unless everyone really
feels that it just has to be.

> 
> static int __init idle_param(char *p)
> {
> 	if (!strcmp(modes[i].name, "spin"))
> 		ppc_md.power_save = NULL;
> }
> early_param("idle", idle_param);
> 
> if you statically initialize the ppc_md.power_save function to ppc44x_idle
> in the platform setup files?

The idea is to not statically initialize ppc_md.power_save to
ppc44x_idle in each platform setup file.

> 
> 	Arnd <><
