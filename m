Return-Path: <Yuantian.Tang@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A3AB61A001D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 19:25:48 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0109.outbound.protection.outlook.com [157.56.110.109])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D138B140092
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2014 19:25:47 +1100 (AEDT)
From: Yuantian Tang <Yuantian.Tang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH] cpufreq: qoriq: Make the driver usable on all QorIQ
 platforms
Date: Tue, 21 Oct 2014 08:25:42 +0000
Message-ID: <8cf6bdb05e9b4d04994366db335f3a52@DM2PR03MB574.namprd03.prod.outlook.com>
References: <1413515616-15874-1-git-send-email-B29983@freescale.com>
 <8F5E4DA7-8A64-4614-91E7-BFB28D91C737@kernel.crashing.org>
In-Reply-To: <8F5E4DA7-8A64-4614-91E7-BFB28D91C737@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > #ifndef CONFIG_SMP
> > static inline const struct cpumask *cpu_core_mask(int cpu) { @@ -79,6
> > +75,79 @@ static inline const struct cpumask *cpu_core_mask(int cpu) }
> > #endif
> >
> > +#if defined(CONFIG_PPC_E500MC)
>=20
> Probably should just be CONFIG_PPC, but do we need this at all.  Can't we=
 just
> use topology_core_id() on both ARM & PPC?
>=20
topology_core_id() doesn't work on PPC.
This function only supports PPC64 and non-thread SOCs.

I can make it work on PPC, but we are used to use get_hard_smp_processor_id=
() on ppc.

Regards,
Yuantian

> > +static int get_cpu_physical_id(int cpu) {
> > +	return get_hard_smp_processor_id(cpu); } #elif defined(CONFIG_ARM)
> > +static int get_cpu_physical_id(int cpu) {
> > +	return topology_core_id(cpu);
> > +}
> > +#endif
> > +
