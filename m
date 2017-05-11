Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNmkD3sgBzDqLg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 18:39:32 +1000 (AEST)
Date: Thu, 11 May 2017 10:39:10 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>, stewart@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, mikey@neuling.org, maddy@linux.vnet.ibm.com,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 eranian@google.com, hemant@linux.vnet.ibm.com,
 Anton Blanchard <anton@samba.org>, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Subject: Re: [PATCH v8 05/10] powerpc/perf: IMC pmu cpumask and cpuhotplug
 support
In-Reply-To: <20170511094022.38a32f2e@canb.auug.org.au>
Message-ID: <alpine.DEB.2.20.1705111033500.1758@nanos>
References: <1493907596-11425-1-git-send-email-anju@linux.vnet.ibm.com>
 <1493907596-11425-6-git-send-email-anju@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1705101116380.1979@nanos>
 <20170511094022.38a32f2e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 11 May 2017, Stephen Rothwell wrote:

> Hi,
> 
> On Wed, 10 May 2017 14:09:53 +0200 (CEST) Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > > +static void nest_change_cpu_context(int old_cpu, int new_cpu)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0;
> > > +	     (per_nest_pmu_arr[i] != NULL) && (i < IMC_MAX_PMUS); i++)
> > > +		perf_pmu_migrate_context(&per_nest_pmu_arr[i]->pmu,
> > > +							old_cpu, new_cpu);  
> > 
> > Bah, this is horrible to read.
> > 
> > 	struct imc_pmu **pn = per_nest_pmu_arr;
> > 	int i;
> > 
> > 	for (i = 0; *pn && i < IMC_MAX_PMUS; i++, pn++)
> > 		perf_pmu_migrate_context(&(*pn)->pmu, old_cpu, new_cpu);
> 
> (Just a bit of bike shedding ...)
> 
> Or even (since "i" is not used any more):
> 
> 	struct imc_pmu **pn;
> 
> 	for (pn = per_nest_pmu_arr;
> 	     pn < &per_nest_pmu_arr[IMC_MAX_PMUS] && *pn;
> 	     pn++)
> 		perf_pmu_migrate_context(&(*pn)->pmu, old_cpu, new_cpu);

Which is equally unreadable as the original code I complained about. Is that
a corporate preference?

Thanks,

	tglx
