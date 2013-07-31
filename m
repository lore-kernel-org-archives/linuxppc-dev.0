Return-Path: <B40534@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2770C2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 16:30:14 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] cpuidle: add freescale e500 family porcessors idle support
Date: Wed, 31 Jul 2013 06:30:06 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259FF2AAC@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1375167603-16722-1-git-send-email-dongsheng.wang@freescale.com>
 (from	dongsheng.wang@freescale.com on Tue Jul 30 02:00:03 2013)
 <1375213104.30721.79@snotra>
In-Reply-To: <1375213104.30721.79@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "rjw@sisk.pl" <rjw@sisk.pl>, Zhao Chenhui-B35336 <B35336@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Wednesday, July 31, 2013 3:38 AM
> To: Wang Dongsheng-B40534
> Cc: rjw@sisk.pl; daniel.lezcano@linaro.org; benh@kernel.crashing.org; Li
> Yang-R58472; Zhao Chenhui-B35336; linux-pm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH] cpuidle: add freescale e500 family porcessors idle
> support
>=20
> On 07/30/2013 02:00:03 AM, Dongsheng Wang wrote:
> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > Add cpuidle support for e500 family, using cpuidle framework to
> > manage various low power modes. The new implementation will remain
> > compatible with original idle method.
> >
> > Initially, this supports PW10, and subsequent patches will support
> > PW20/DOZE/NAP.
>=20
> Could you explain what the cpuidle framework does for us that the
> current idle code doesn't?
>=20

The current idle code, Only a state of low power can make the core idle.
The core can't get into more low power state.

> In particular, what scenario do you see where we would require a
> software
> governor to choose between idle states, and how much power is saved
> compared to a simpler approach?  There is timer that can be used to
> automatically enter PW20 after a certain amount of time in PW10.

Yes, the hardware can automatically enter PW20 state. But this is hardware
feature, we need to software to manage it. Only for PW20 state, we can drop
this cpuidle and using the hardware to control it. But if we need to suppor=
t
PH10/PH15/PH20/PH30, the current idle code cannot support them.=20

> How much better results do you get from a software governor?  Do we even
> have the right data to characterize each state so that a software governo=
r
> could make good decisions?  Is cpuidle capable of governing the interval
> of such a timer, rather than directly governing states?
>=20
>From now on we did not benchmark these data, because we only have PW10 stat=
e.

I can do support doze/nap for e6500. To get some data to show you.

> As for doze/nap, why would we want to use those on newer cores?  Do you
> have numbers for how much power each mode saves?
>=20
The PH state is plan to support, if the core can make into more low power s=
tate,
why not to do this.

PH10(doze)/PH15(nap)/PH20/PH30, These states can save more CPU power.

> Active governors may be useful on older cores that only have doze/nap,
> to
> select between them, but if that's the use case then why start with
> pw10?
Pw10 is supported on E500MC/E5500/E6500. And we plan to support PW20 for E6=
5OO core.
I will take doze/nap up a bit later.

> And I'd want to see numbers for how much power nap saves versus doze.
>=20
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > ---
> > This patch keep using cpuidle_register_device(), because we need to
> > support cpu
> > hotplug. I will fix "device" issue in this driver, after
> > Deepthi Dharwar <deepthi@linux.vnet.ibm.com> add a hotplug handler
> > into cpuidle
> > freamwork.
>=20
> Where's the diffstat?
>=20
See, http://patchwork.ozlabs.org/patch/260997/

> > @@ -0,0 +1,222 @@
> > +/*
> > + * Copyright 2013 Freescale Semiconductor, Inc.
> > + *
> > + * CPU Idle driver for Freescale PowerPC e500 family processors.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * Author: Wang Dongsheng <dongsheng.wang@freescale.com>
> > + */
>=20
> Is this derived from some other file?  It looks like it...  Where's the
> attribution?
>=20
The copyright is from drivers/cpufreq/ppc-corenet-cpufreq.c

> > +#include <linux/cpu.h>
> > +#include <linux/cpuidle.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/notifier.h>
> > +
> > +#include <asm/machdep.h>
> > +
> > +static struct cpuidle_driver e500_idle_driver =3D {
> > +	.name =3D "e500_idle",
> > +	.owner =3D THIS_MODULE,
> > +};
> > +
> > +static struct cpuidle_device __percpu *e500_cpuidle_devices;
> > +
> > +static void e500_cpuidle(void)
> > +{
> > +	/*
> > +	 * This would call on the cpuidle framework, and the back-end
> > +	 * driver to go to idle states.
> > +	 */
> > +	if (cpuidle_idle_call()) {
> > +		/*
> > +		 * On error, execute default handler
> > +		 * to go into low thread priority and possibly
> > +		 * low power mode.
> > +		 */
> > +		HMT_low();
> > +		HMT_very_low();
>=20
> This HMT stuff doesn't do anything on e500 derivatives AFAIK.
>=20
Yes, there should do nothing, let arch_cpu_idle to do the failed.

> > +static struct cpuidle_state fsl_pw_idle_states[] =3D {
> > +	{
> > +		.name =3D "pw10",
> > +		.desc =3D "pw10",
> > +		.flags =3D CPUIDLE_FLAG_TIME_VALID,
> > +		.exit_latency =3D 0,
> > +		.target_residency =3D 0,
> > +		.enter =3D &pw10_enter
>=20
> Where is pw10_enter defined?
>=20
In this patch..

> > +static int cpu_is_feature(unsigned long feature)
> > +{
> > +	return (cur_cpu_spec->cpu_features =3D=3D feature);
> > +}
> > +
> > +static int __init e500_idle_init(void)
> > +{
> > +	struct cpuidle_state *cpuidle_state_table =3D NULL;
> > +	struct cpuidle_driver *drv =3D &e500_idle_driver;
> > +	int err;
> > +	unsigned int max_idle_state =3D 0;
> > +
> > +	if (cpuidle_disable !=3D IDLE_NO_OVERRIDE)
> > +		return -ENODEV;
> > +
> > +	if (cpu_is_feature(CPU_FTRS_E500MC) ||
> > cpu_is_feature(CPU_FTRS_E5500) ||
> > +			cpu_is_feature(CPU_FTRS_E6500)) {
>=20
> There's no guarantee that a CPU with the same set of features is the
> exact same CPU.
>=20
> What specific feature are you looking for here?
>=20
Here is the type of the core. E500MC,E5500,E6500 do wait.

> > +		cpuidle_state_table =3D fsl_pw_idle_states;
> > +		max_idle_state =3D ARRAY_SIZE(fsl_pw_idle_states);
> > +	}
> > +
> > +	if (!cpuidle_state_table || !max_idle_state)
> > +		return -EPERM;
>=20
> ENODEV?
>=20
Looks better than EPERM.

-dongsheng
