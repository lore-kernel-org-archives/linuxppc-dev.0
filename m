Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 544A02C00B9
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Dec 2013 13:07:16 +1100 (EST)
Message-ID: <1386641226.32037.54.camel@pasglop>
Subject: Re: [PATCH] powerpc/pseries: Don't try to register pseries cpu
 hotplug on non-pseries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 10 Dec 2013 13:07:06 +1100
In-Reply-To: <1386640934.26691.5.camel@concordia>
References: <1386635462.32037.44.camel@pasglop>
 <1386640934.26691.5.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-12-10 at 13:02 +1100, Michael Ellerman wrote:
> On Tue, 2013-12-10 at 11:31 +1100, Benjamin Herrenschmidt wrote:
> > This results in oddball messages at boot on other platforms telling us
> > that CPU hotplug isn't supported even when it is.
> 
> We have a bunch more. Most are probably safe because they rely on the device
> tree but we should probably convert them anyway?

Possibly :-) This one I spotted specifically because I was looking at a
boot log on powernv and it was insulting me !

> $ git grep initcall arch/powerpc/platforms/pseries/ | grep -v machine_
> arch/powerpc/platforms/pseries/dtl.c:arch_initcall(dtl_init);
> arch/powerpc/platforms/pseries/eeh_pseries.c:early_initcall(eeh_pseries_init);
> arch/powerpc/platforms/pseries/hotplug-cpu.c:arch_initcall(pseries_cpu_hotplug_init);
> arch/powerpc/platforms/pseries/hvCall_inst.c:__initcall(hcall_inst_init);
> arch/powerpc/platforms/pseries/mobility.c:device_initcall(mobility_sysfs_init);
> arch/powerpc/platforms/pseries/msi.c:arch_initcall(rtas_msi_init);
> arch/powerpc/platforms/pseries/power.c:core_initcall(pm_init);
> arch/powerpc/platforms/pseries/power.c:__initcall(apo_pm_init);
> arch/powerpc/platforms/pseries/ras.c:subsys_initcall(init_ras_IRQ);
> arch/powerpc/platforms/pseries/reconfig.c:__initcall(proc_ppc64_create_ofdt);
> arch/powerpc/platforms/pseries/rng.c:subsys_initcall(rng_init);
> arch/powerpc/platforms/pseries/setup.c:early_initcall(alloc_dispatch_log_kmem_cache);
> arch/powerpc/platforms/pseries/suspend.c:__initcall(pseries_suspend_init);
> 
> cheers
> 
