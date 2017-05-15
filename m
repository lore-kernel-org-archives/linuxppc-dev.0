Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRHnh5CCNzDqFL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 21:06:16 +1000 (AEST)
Date: Mon, 15 May 2017 13:06:09 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com,
 Anton Blanchard <anton@samba.org>, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org, stewart@linux.vnet.ibm.com, dja@axtens.net,
 eranian@google.com, hemant@linux.vnet.ibm.com,
 Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 05/10] powerpc/perf: IMC pmu cpumask and cpuhotplug
 support
In-Reply-To: <f8972c0c-11db-fd43-09a3-200b90a34d3b@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1705151250540.2027@nanos>
References: <1493907596-11425-1-git-send-email-anju@linux.vnet.ibm.com>
 <1493907596-11425-6-git-send-email-anju@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1705101116380.1979@nanos>
 <f8972c0c-11db-fd43-09a3-200b90a34d3b@linux.vnet.ibm.com>
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

On Mon, 15 May 2017, Madhavan Srinivasan wrote:
> On Wednesday 10 May 2017 05:39 PM, Thomas Gleixner wrote:
> > On Thu, 4 May 2017, Anju T Sudhakar wrote:
> > > +	/*
> > > +	 * Update the cpumask with the target cpu and
> > > +	 * migrate the context if needed
> > > +	 */
> > > +	if (target >= 0 && target <= nr_cpu_ids) {
> > > +		cpumask_set_cpu(target, &nest_imc_cpumask);
> > > +		nest_change_cpu_context(cpu, target);
> > > +	}
> > What disables the perf context if this was the last CPU on the node?
> 
> My bad. i did not understand this. Is this regarding the updates
> of the "flags" in the perf_event and hw_perf_event structs?

Sorry, there is nothing to understand. It was me misreading it.

> > > +static int nest_pmu_cpumask_init(void)
> > > +{
> > > +	const struct cpumask *l_cpumask;
> > > +	int cpu, nid;
> > > +	int *cpus_opal_rc;
> > > +
> > > +	if (!cpumask_empty(&nest_imc_cpumask))
> > > +		return 0;
> > What's that for? Paranoia engineering?
> 
> No.  The idea here is to generate the cpu_mask attribute
> field only for the first "nest" pmu and use the same
> for other "nest" units.

Why is nest_pmu_cpumask_init() called more than once? If it is then you
should have a proper flag marking it initialiazed rather than making a
completely obscure check for a cpu mask. That check could be empty for the
second invocation when the first invocation fails.

> > But this whole function is completely overengineered. If you make that
> > nest_init() part of the online function then this works also for nodes
> > which come online later and it simplifies to:
> > 
> > static int ppc_nest_imc_cpu_online(unsigned int cpu)
> > {
> > 	const struct cpumask *l_cpumask;
> > 	static struct cpumask tmp_mask;
> > 	int res;
> > 
> > 	/* Get the cpumask of this node */
> > 	l_cpumask = cpumask_of_node(cpu_to_node(cpu));
> > 
> > 	/*
> > 	 * If this is not the first online CPU on this node, then IMC is
> > 	 * initialized already.
> > 	 */
> > 	if (cpumask_and(&tmp_mask, l_cpumask, &nest_imc_cpumask))
> > 		return 0;
> > 
> > 	/*
> > 	 * If this fails, IMC is not usable.
> > 	 *
> > 	 * FIXME: Add a understandable comment what this actually does
> > 	 * and why it can fail.
> > 	 */
> > 	res = opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST);
> > 	if (res)
> > 		return res;
> > 
> > 	/* Make this CPU the designated target for counter collection */
> > 	cpumask_set_cpu(cpu, &nest_imc_cpumask);
> > 	nest_change_cpu_context(-1, cpu);
> > 	return 0;
> > }
> > 
> > static int nest_pmu_cpumask_init(void)
> > {
> > 	return cpuhp_setup_state(CPUHP_AP_PERF_POWERPC_NEST_ONLINE,
> > 				 "perf/powerpc/imc:online",
> > 				 ppc_nest_imc_cpu_online,
> > 				 ppc_nest_imc_cpu_offline);
> > }
> > 
> > Hmm?
> 
> Yes this make sense. But we need to first designate a cpu in each
> chip at init setup and use opal api to disable the engine in the same.
> So probably, after cpuhp_setup_state, can we do that?

Errm. That's what ppc_nest_imc_cpu_online() does.

It checks whether this is the first online cpu on a node and if yes, it
calls opal_imc_counters_stop() and sets that cpu in nest_imc_cpumask.

cpuhp_setup_state() invokes the callback on each online CPU. Seo evrything
is set up proper after that.

Thanks,

	tglx
