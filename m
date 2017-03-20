Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmjhz4j9czDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 15:32:19 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2K4T5AL050384
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 00:32:10 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2990vvxp13-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 00:32:10 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Mon, 20 Mar 2017 14:32:07 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2K4Vuxd49217678
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 15:32:04 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2K4VUmF006216
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 15:31:30 +1100
Date: Mon, 20 Mar 2017 10:01:12 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv/cpuidle: Pass correct drv->cpumask for
 registration
Reply-To: svaidy@linux.vnet.ibm.com
References: <20170317180550.9931-1-svaidy@linux.vnet.ibm.com>
 <1489814882.5616.11.camel@neuling.org>
 <20170318064425.GC4225@drishya.in.ibm.com>
 <87k27kzlz0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <87k27kzlz0.fsf@concordia.ellerman.id.au>
Message-Id: <20170320043112.GA4123@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Michael Ellerman <mpe@ellerman.id.au> [2017-03-20 14:05:39]:

> Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> writes:
> 
> > * Michael Neuling <mikey@neuling.org> [2017-03-18 16:28:02]:
> >
> >> Vaidy,
> >> 
> >> Thanks for fixing this.
> >> 
> >> > drv->cpumask defaults to cpu_possible_mask in __cpuidle_driver_init().
> >> > This breaks cpuidle on powernv where sysfs files are not created for
> >> > cpus in cpu_possible_mask that cannot be hot-added.
> >> 
> >> I think I prefer the longer description below than this.
> >
> > [PATCH] powerpc/powernv/cpuidle: Pass correct drv->cpumask for
> >
> > drv->cpumask defaults to cpu_possible_mask in __cpuidle_driver_init().
> > This breaks cpuidle on powernv where sysfs files are not created for
> > cpus in cpu_possible_mask that cannot be hot-added.
> 
> I'm confused.

It depends on CONFIG_HOTPLUG_CPU now, but we have the following
combinations to handle:
(a) CONFIG_HOTPLUG_CPU=y/n
(b) pseries vs powernv
 
> > On powernv platform cpu_present could be less than cpu_possible
> > in cases where firmware detects the cpu, but it is not available
> > for OS.
> 
> It's entirely normal for present < possible, on my laptop for example,
> so I don't see how that causes the bug.

Yes, present < possible in itself not a problem.  It is whether
cpu_device exist for that cpu or not.

> > Such cpus are not hotplugable at runtime on powernv and
> > hence we skip creating sysfs files for these cpus.
> 
> Why are they not hotpluggable? Looking at topology_init() they should be
> hotpluggable as long as ppc_md.cpu_die is populated, which it is on
> PowerNV AFAICS.

Currently it depends on CONFIG_HOTPLUG_CPU=y.
 
> Is it really "creating sysfs files" that's important, or is that we
> don't call register_cpu() for those CPUs?

Currently if CONFIG_HOTPLUG_CPU=n, then we skip calling register_cpu()
and that causes the problem.

The fix in cpuidle-powernv.c could be based on CONFIG_HOTPLUG_CPU, but
since we can choose to set cpu->hotpluggable based on other factors
even when CONFIG_HOTPLUG_CPU=y, I choose to use cpu_possible.  We will
need to change  cpuidle-powernv to register for additional cpus when
we really support hot-add of cpus that did not exist at boot.

> > Trying cpuidle_register_device() on cpu without sysfs node will
> > cause crash like:
> >
> > cpu 0xf: Vector: 380 (Data SLB Access) at [c000000ff1503490]
> >     pc: c00000000022c8bc: string+0x34/0x60
> >     lr: c00000000022ed78: vsnprintf+0x284/0x42c
> >     sp: c000000ff1503710
> >    msr: 9000000000009033
> >    dar: 6000000060000000
> >   current = 0xc000000ff1480000
> >   paca    = 0xc00000000fe82d00   softe: 0        irq_happened: 0x01
> >     pid   = 1, comm = swapper/8
> > Linux version 4.11.0-rc2 (sv@sagarika) (gcc version 4.9.4 (Buildroot 2017.02-00004-gc28573e) ) #15 SMP Fri Mar 17 19:32:02 IST 2017
> > enter ? for help
> > [link register   ] c00000000022ed78 vsnprintf+0x284/0x42c
> > [c000000ff1503710] c00000000022ebb8 vsnprintf+0xc4/0x42c (unreliable)
> > [c000000ff1503800] c00000000022ef40 vscnprintf+0x20/0x44
> > [c000000ff1503830] c0000000000ab61c vprintk_emit+0x94/0x2cc
> > [c000000ff15038a0] c0000000000acc9c vprintk_func+0x60/0x74
> > [c000000ff15038c0] c000000000619694 printk+0x38/0x4c
> > [c000000ff15038e0] c000000000224950 kobject_get+0x40/0x60
> > [c000000ff1503950] c00000000022507c kobject_add_internal+0x60/0x2c4
> > [c000000ff15039e0] c000000000225350 kobject_init_and_add+0x70/0x78
> > [c000000ff1503a60] c00000000053c288 cpuidle_add_sysfs+0x9c/0xe0
> > [c000000ff1503ae0] c00000000053aeac cpuidle_register_device+0xd4/0x12c
> > [c000000ff1503b30] c00000000053b108 cpuidle_register+0x98/0xcc
> > [c000000ff1503bc0] c00000000085eaf0 powernv_processor_idle_init+0x140/0x1e0
> > [c000000ff1503c60] c00000000000cd60 do_one_initcall+0xc0/0x15c
> > [c000000ff1503d20] c000000000833e84 kernel_init_freeable+0x1a0/0x25c
> > [c000000ff1503dc0] c00000000000d478 kernel_init+0x24/0x12c
> > [c000000ff1503e30] c00000000000b564 ret_from_kernel_thread+0x5c/0x78
> 
> I really don't understand how a CPU not being present leads to a crash
> in printf()? Something in that call chain should have checked that the
> CPU was registered before crashing in printf() - surely?

Yes, we should have just failed to register the cpuidle driver.  I have
the fix here:

[PATCH] cpuidle: Validate cpu_dev in cpuidle_add_sysfs
http://patchwork.ozlabs.org/patch/740634/

--Vaidy
