Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] Fix CPU hotplug when using the SLB shadow buffer 
In-reply-to: <20080111011221.GW14201@localdomain> 
References: <23336.1199947743@neuling.org> <26792.1199949114@neuling.org>
	<28640.1200012427@neuling.org> <20080111011221.GW14201@localdomain>
Date: Fri, 11 Jan 2008 13:59:30 +1100
Message-ID: <6532.1200020370@neuling.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > @@ -58,6 +59,7 @@ static void pseries_mach_cpu_die(void)
> >  	local_irq_disable();
> >  	idle_task_exit();
> >  	xics_teardown_cpu(0);
> > +	unregister_slb_shadow(smp_processor_id(), __pa(get_slb_shadow()));
>                                      ^
> Should that not be hard_smp_processor_id()?

Thanks.. I think you're right since we register each CPU with a
get_hard_smp_processor_id(cpu).  

I'll update.

Mikey
