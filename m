Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E6391A0C73
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 16:45:51 +1100 (AEDT)
Message-ID: <1419313550.30550.7.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/smp: Fix Non-boot cpus cannot be bring up.
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
Date: Tue, 23 Dec 2014 16:45:50 +1100
In-Reply-To: <BN1PR03MB1889A560297773EE7E2342B9D570@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1419230320-37558-1-git-send-email-dongsheng.wang@freescale.com>
 <1419296441.30550.3.camel@ellerman.id.au>
 <BN1PR03MB1889A560297773EE7E2342B9D570@BN1PR03MB188.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "anton@samba.org" <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-23 at 02:41 +0000, Dongsheng.Wang@freescale.com wrote:
> > -----Original Message-----
> > From: Michael Ellerman [mailto:mpe@ellerman.id.au]
> > Sent: Tuesday, December 23, 2014 9:01 AM
> > To: Wang Dongsheng-B40534
> > Cc: benh@kernel.crashing.org; Wood Scott-B07421; anton@samba.org; linuxppc-
> > dev@lists.ozlabs.org
> > Subject: Re: [PATCH] powerpc/smp: Fix Non-boot cpus cannot be bring up.
> > 
> > On Mon, 2014-12-22 at 14:38 +0800, Dongsheng Wang wrote:
> > > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > >
> > > Kernel cannot bring up Non-boot cpus always get "Processor xx is stuck".
> > > this issue bring by http://patchwork.ozlabs.org/patch/418912/ (powerpc:
> > > Secondary CPUs must set cpu_callin_map after setting active and
> > > online) We need to take timebase after bootup cpu give the timebase firstly.
> > >
> > > When start_secondary, non-boot cpus set cpu_callin_map for boot cpu
> > > after that boot cpu will give the timebase for non-boot cpu. Otherwise
> > > non-boot cpus will fall in dead loop to waiting bootup cpu to give
> > > imebase.
> > 
> > Right.
> > 
> > However, doesn't this introduce the possibility that the secondary cpu is up and
> > marked online but has an unsynchronised clock?
 
> Yes, right. But Freescale platform boot-cpu will freeze the TB until secondary cpu
> take the time base, so the clock is synchronized.

It does the freeze in give_timebase() doesn't it?

So there's still a window there where the secondary is up & online but hasn't
had it's timebase synchronised, and the primary hasn't frozen the timebase yet.
So that makes me nervous.

> For generic PowerPC maybe has this issue. So for safe I think we need to set cpu online
> after synchronized clock.
> 
> I will update my patch if you agree this way.
> +       if (smp_ops->take_timebase)
> +               smp_ops->take_timebase();
> +       secondary_cpu_time_init();
> +
> Move set_cpu_online to here.
> +       set_cpu_online(cpu, true);

But that reverses the effect of the original patch, which was that we have to
set online *before* we set the callin map.


Looking harder at Anton's patch I'm not sure it's right anyway.

The issue he was trying to fix was that the cpu was online but not active,
which confused the scheduler.

I think Anton missed that we have a loop that waits for online at the bottom of
__cpu_up():

	/* Wait until cpu puts itself in the online map */
	while (!cpu_online(cpu))
		cpu_relax();


He must have seen a case where that popped due to the cpu being online, but the
cpu wasn't yet active.

His patch fixed the problem by ensuring the previous loop that waits for
cpu_callin_map doesn't finish until active & online are set, making the while
loop above a nop.

So I think we should probably revert Anton's patch and instead change that
while loop to:

	/* Wait until cpu is online AND active */
	while (!cpu_online(cpu) || !cpu_active(cpu))
		cpu_relax();


cheers
