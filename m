Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 19055B6EF6
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 18:14:23 +1100 (EST)
Subject: Re: [Next] CPU Hotplug test failures on powerpc
From: Peter Zijlstra <peterz@infradead.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4B287242.5070002@in.ibm.com>
References: <4B2224C7.1020908@in.ibm.com> <1260786122.4165.142.camel@twins>
	<4B261D7A.9040802@in.ibm.com>  <1260793182.4165.223.camel@twins>
	<1260825420.2217.40.camel@pasglop>  <4B275A6B.9030200@in.ibm.com>
	<1260873827.4165.362.camel@twins>  <4B279370.5050800@in.ibm.com>
	<1260889402.4165.434.camel@twins>  <4B287242.5070002@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Dec 2009 08:14:07 +0100
Message-ID: <1260947647.8023.1273.camel@laptop>
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@elte.hu>, linux-next@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-12-16 at 11:08 +0530, Sachin Sant wrote:
> Peter Zijlstra wrote:
> > Could you try the below?
> >   
> No luck. Still the same issue. The mask values don't change.

Bugger, that patch did solve a similar problem for a patch I'm working
on.

Can you maybe add a print of the cpu_active_mask() in set_cpu_active()
using WARN() so we can see where it changes the mask, and why it things
its empty?

> > ---
> >  init/main.c |    7 +------
> >  1 files changed, 1 insertions(+), 6 deletions(-)
> >
> > diff --git a/init/main.c b/init/main.c
> > index 4051d75..4be7de2 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -369,12 +369,6 @@ static void __init smp_init(void)
> >  {
> >  	unsigned int cpu;
> >  
> > -	/*
> > -	 * Set up the current CPU as possible to migrate to.
> > -	 * The other ones will be done by cpu_up/cpu_down()
> > -	 */
> > -	set_cpu_active(smp_processor_id(), true);
> > -
> >  	/* FIXME: This should be done in userspace --RR */
> >  	for_each_present_cpu(cpu) {
> >  		if (num_online_cpus() >= setup_max_cpus)
> > @@ -486,6 +480,7 @@ static void __init boot_cpu_init(void)
> >  	int cpu = smp_processor_id();
> >  	/* Mark the boot cpu "present", "online" etc for SMP and UP case */
> >  	set_cpu_online(cpu, true);
> > +	set_cpu_active(cpu, true);
> >  	set_cpu_present(cpu, true);
> >  	set_cpu_possible(cpu, true);
> >  }
> >
> >
> >   
> 
> 
