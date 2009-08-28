Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [59.145.155.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp04.in.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CCF35B7CB0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 18:20:42 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp04.in.ibm.com (8.14.3/8.13.1) with ESMTP id n7S8KSAa022674
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2009 13:50:28 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7S8KRgf2867422
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2009 13:50:28 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n7S8KPb9029426
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2009 13:50:26 +0530
Date: Fri, 28 Aug 2009 13:49:21 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/4]: CPUIDLE: Introduce architecture independent
	cpuidle_pm_idle in drivers/cpuidle/cpuidle.c
Message-ID: <20090828074721.GA6129@dirshya.in.ibm.com>
References: <20090827114908.GA24986@linux.vnet.ibm.com>
	<20090827115354.GC24986@linux.vnet.ibm.com>
	<1251377607.18584.96.camel@twins>
	<20090828061434.GA11863@linux.vnet.ibm.com>
	<1251442085.18584.120.camel@twins>
	<1251442872.18584.125.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1251442872.18584.125.camel@twins>
Cc: Gautham R Shenoy <ego@in.ibm.com>, "Pallipadi,
	Venkatesh" <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	arun@linux.vnet.ibm.com, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org, Balbir Singh <balbir@linux.vnet.ibm.com>
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Peter Zijlstra <peterz@infradead.org> [2009-08-28 09:01:12]:

> On Fri, 2009-08-28 at 08:48 +0200, Peter Zijlstra wrote:
> > 
> > > void cpuidle_install_idle_handler(void)
> > > {
> > >       .........
> > >       .........
> > >       cpuidle_pm_idle = cpuidle_idle_call;
> > > }
> > 
> > All I'm seeing here is a frigging mess.
> > 
> > How on earths can something called: cpuidle_install_idle_handler() have
> > a void argument, _WHAT_ handler is it going to install?
> 
> Argh, now I see, it installs itself as the platform idle handler.
> 
> so cpuidle_install_idle_handler() pokes at the unmanaged pm_idle pointer
> to make cpuidle take control.
> 
> On module load it does:
> 
>  pm_idle_old = pm_idle;
> 
> then in the actual idle loop it does:
> 
>         if (!dev || !dev->enabled) {
>                 if (pm_idle_old)
>                         pm_idle_old();
> 
> who is to say that the pointer stored at module init time is still
> around at that time?
> 
> So cpuidle recognised the pm_idle stuff was a flaky, but instead of
> fixing it, they build a whole new layer on top of it. Brilliant.
> 
> /me goes mark this whole thread read, I've got enough things to do.

Hi Peter,

I understand that you are frustrated with the mess.  We are willing
to clean up the pm_idle pointer at the moment before the cpuidle
framework is exploited my more archs.

At this moment we need your suggestions on what interface should we
call 'clean' and safe.

cpuidle.c and the arch independent cpuidle subsystem is not a module
and its cpuidle_idle_call() routine is valid and can be safely called
from arch dependent process.c

The fragile part is how cpuidle_idle_call() is hooked onto arch
specific cpu_idle() function at runtime.  x86 has the pm_idle pointer
exported while powerpc has ppc_md.power_save pointer being called.

At cpuidle init time we can override the platform idle function, but
that will mean we are including arch specific code in cpuidle.c

Do you think having an exported function in cpuidle.c to give us the
correct pointer to arch code be better than the current situation:

in drivers/cpuidle/cpuidle.c

void (*get_cpuidle_handler(void))(void)
{
        return cpuidle_pm_idle;
}
EXPORT_SYMBOL(get_cpuidle_handler);

and from pseries/processor_idle.c,

ppc_md.power_save = get_cpuidle_handler();

--Vaidy
