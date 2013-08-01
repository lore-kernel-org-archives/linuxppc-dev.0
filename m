Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 701052C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 10:24:08 +1000 (EST)
Date: Wed, 31 Jul 2013 19:23:55 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] cpuidle: add freescale e500 family porcessors idle support
To: Wang Dongsheng-B40534 <B40534@freescale.com>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259FF2AAC@039-SN2MPN1-021.039d.mgd.msft.net>
 (from B40534@freescale.com on Wed Jul 31 01:30:06 2013)
Message-ID: <1375316635.30721.122@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "rjw@sisk.pl" <rjw@sisk.pl>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/31/2013 01:30:06 AM, Wang Dongsheng-B40534 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, July 31, 2013 3:38 AM
> > To: Wang Dongsheng-B40534
> > Cc: rjw@sisk.pl; daniel.lezcano@linaro.org; =20
> benh@kernel.crashing.org; Li
> > Yang-R58472; Zhao Chenhui-B35336; linux-pm@vger.kernel.org; =20
> linuxppc-
> > dev@lists.ozlabs.org
> > Subject: Re: [PATCH] cpuidle: add freescale e500 family porcessors =20
> idle
> > support
> >
> > On 07/30/2013 02:00:03 AM, Dongsheng Wang wrote:
> > > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > >
> > > Add cpuidle support for e500 family, using cpuidle framework to
> > > manage various low power modes. The new implementation will remain
> > > compatible with original idle method.
> > >
> > > Initially, this supports PW10, and subsequent patches will support
> > > PW20/DOZE/NAP.
> >
> > Could you explain what the cpuidle framework does for us that the
> > current idle code doesn't?
> >
>=20
> The current idle code, Only a state of low power can make the core =20
> idle.
> The core can't get into more low power state.
>=20
> > In particular, what scenario do you see where we would require a
> > software
> > governor to choose between idle states, and how much power is saved
> > compared to a simpler approach?  There is timer that can be used to
> > automatically enter PW20 after a certain amount of time in PW10.
>=20
> Yes, the hardware can automatically enter PW20 state. But this is =20
> hardware
> feature, we need to software to manage it. Only for PW20 state, we =20
> can drop
> this cpuidle and using the hardware to control it. But if we need to =20
> support
> PH10/PH15/PH20/PH30, the current idle code cannot support them.

PH30 wasn't really meant as idle state, but rather a CPU hotplug =20
state.  This isn't just about enter/exit latency (and complexity) but =20
also about wakeup events.

PH15 and PH20 were mainly intended as intermediate states on the way to =20
PH30 or debug halt.  It looks like PH15 is the deepest PH state in =20
which core timers continue to run.

The intended idle states on e6500 are PW10 and PW20.

> > How much better results do you get from a software governor?  Do we =20
> even
> > have the right data to characterize each state so that a software =20
> governor
> > could make good decisions?  Is cpuidle capable of governing the =20
> interval
> > of such a timer, rather than directly governing states?
> >
> >From now on we did not benchmark these data, because we only have =20
> PW10 state.
>=20
> I can do support doze/nap for e6500. To get some data to show you.
>=20
> > As for doze/nap, why would we want to use those on newer cores?  Do =20
> you
> > have numbers for how much power each mode saves?
> >
> The PH state is plan to support, if the core can make into more low =20
> power state,
> why not to do this.

We don't do things just to do them.  We do things to make things better.

> PH10(doze)/PH15(nap)/PH20/PH30, These states can save more CPU power.

If you have evidence that PH15 saves more power than PW20, please =20
provide it.

> > Active governors may be useful on older cores that only have =20
> doze/nap,
> > to
> > select between them, but if that's the use case then why start with
> > pw10?
> Pw10 is supported on E500MC/E5500/E6500. And we plan to support PW20 =20
> for E65OO core.
> I will take doze/nap up a bit later.

By "older cores" I meant before e500mc.

> > And I'd want to see numbers for how much power nap saves versus =20
> doze.
> >
> > > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > > ---
> > > This patch keep using cpuidle_register_device(), because we need =20
> to
> > > support cpu
> > > hotplug. I will fix "device" issue in this driver, after
> > > Deepthi Dharwar <deepthi@linux.vnet.ibm.com> add a hotplug handler
> > > into cpuidle
> > > freamwork.
> >
> > Where's the diffstat?
> >
> See, http://patchwork.ozlabs.org/patch/260997/

That's a totally different patch.

> > > @@ -0,0 +1,222 @@
> > > +/*
> > > + * Copyright 2013 Freescale Semiconductor, Inc.
> > > + *
> > > + * CPU Idle driver for Freescale PowerPC e500 family processors.
> > > + *
> > > + * This program is free software; you can redistribute it and/or
> > > modify
> > > + * it under the terms of the GNU General Public License version =20
> 2 as
> > > + * published by the Free Software Foundation.
> > > + *
> > > + * Author: Wang Dongsheng <dongsheng.wang@freescale.com>
> > > + */
> >
> > Is this derived from some other file?  It looks like it...  Where's =20
> the
> > attribution?
> >
> The copyright is from drivers/cpufreq/ppc-corenet-cpufreq.c

But the code isn't.

> > > +static void e500_cpuidle(void)
> > > +{
> > > +	/*
> > > +	 * This would call on the cpuidle framework, and the back-end
> > > +	 * driver to go to idle states.
> > > +	 */
> > > +	if (cpuidle_idle_call()) {
> > > +		/*
> > > +		 * On error, execute default handler
> > > +		 * to go into low thread priority and possibly
> > > +		 * low power mode.
> > > +		 */
> > > +		HMT_low();
> > > +		HMT_very_low();
> >
> > This HMT stuff doesn't do anything on e500 derivatives AFAIK.
> >
> Yes, there should do nothing, let arch_cpu_idle to do the failed.

I can't parse this.

> > > +static struct cpuidle_state fsl_pw_idle_states[] =3D {
> > > +	{
> > > +		.name =3D "pw10",
> > > +		.desc =3D "pw10",
> > > +		.flags =3D CPUIDLE_FLAG_TIME_VALID,
> > > +		.exit_latency =3D 0,
> > > +		.target_residency =3D 0,
> > > +		.enter =3D &pw10_enter
> >
> > Where is pw10_enter defined?
> >
> In this patch..

OK, I see it now -- sorry about that.

> > > +static int cpu_is_feature(unsigned long feature)
> > > +{
> > > +	return (cur_cpu_spec->cpu_features =3D=3D feature);
> > > +}
> > > +
> > > +static int __init e500_idle_init(void)
> > > +{
> > > +	struct cpuidle_state *cpuidle_state_table =3D NULL;
> > > +	struct cpuidle_driver *drv =3D &e500_idle_driver;
> > > +	int err;
> > > +	unsigned int max_idle_state =3D 0;
> > > +
> > > +	if (cpuidle_disable !=3D IDLE_NO_OVERRIDE)
> > > +		return -ENODEV;
> > > +
> > > +	if (cpu_is_feature(CPU_FTRS_E500MC) ||
> > > cpu_is_feature(CPU_FTRS_E5500) ||
> > > +			cpu_is_feature(CPU_FTRS_E6500)) {
> >
> > There's no guarantee that a CPU with the same set of features is the
> > exact same CPU.
> >
> > What specific feature are you looking for here?
> >
> Here is the type of the core. E500MC,E5500,E6500 do wait.

There's no guarantee that a CPU with the same set of features is the =20
exact same CPU.

The CPU feature mechanism is for checking *features*, not identity.

-Scott=
