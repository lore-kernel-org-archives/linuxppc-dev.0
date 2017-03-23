Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpn3H6RxPzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 00:10:19 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2ND9mHI065572
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 09:10:18 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29bxhudbf1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 09:10:16 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 23 Mar 2017 09:10:05 -0400
Date: Thu, 23 Mar 2017 18:39:47 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Hemant Kumar <hemant@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Stephane Eranian <eranian@google.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 08/13] powerpc/perf: PMU functions for Core IMC and
 hotplugging
Reply-To: ego@linux.vnet.ibm.com
References: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1489649707-8021-9-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489649707-8021-9-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <20170323130947.GB4897@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Maddy, Hemant, Anju,

On Thu, Mar 16, 2017 at 01:05:02PM +0530, Madhavan Srinivasan wrote:

[..snip..]

> +
> +static void core_imc_change_cpu_context(int old_cpu, int new_cpu)
> +{
> +	if (!core_imc_pmu)
> +		return;
> +	perf_pmu_migrate_context(&core_imc_pmu->pmu, old_cpu, new_cpu);
> +}
> +
> +
> +static int ppc_core_imc_cpu_online(unsigned int cpu)
> +{
> +	int ret;
> +
> +	/* If a cpu for this core is already set, then, don't do anything */
> +	ret = cpumask_any_and(&core_imc_cpumask,
> +				 cpu_sibling_mask(cpu));
> +	if (ret < nr_cpu_ids)
> +		return 0;
> +
> +	/* Else, set the cpu in the mask, and change the context */
> +	cpumask_set_cpu(cpu, &core_imc_cpumask);
> +	core_imc_change_cpu_context(-1, cpu);

So, in the core case, we are ok as long as any cpu in the core is
present in the imc_cpumask. It need not have to be the smallest online
cpu in the core.

Can the same logic be applied to the earlier nest case ?

We can have a single function for cpu_offline and cpu_online which
implements these checks and sets the cpu bit if required.

ppc_entity_imc_cpu_offline(unsigned int cpu, cpumask_t
			   entity_imc_mask,
			   entity_imc_change_cpu_context_fn)
{
	.
	.
	.
	
}


static ppc_nest_imc_cpu_offline(unsigned int cpu)
{
	return ppc_entity_imc_cpu_offline(cpu, nest_imc_mask,
					  nest_imc_change_cpu_context);
}

And similar ones for core imc and thread imc.

Does this sound reasonable ?

> +	return 0;
> +}
> +
> +static int ppc_core_imc_cpu_offline(unsigned int cpu)
> +{
> +	int target;
> +	unsigned int ncpu;
> +
> +	/*
> +	 * clear this cpu out of the mask, if not present in the mask,
> +	 * don't bother doing anything.
> +	 */
> +	if (!cpumask_test_and_clear_cpu(cpu, &core_imc_cpumask))
> +		return 0;
> +
> +	/* Find any online cpu in that core except the current "cpu" */
> +	ncpu = cpumask_any_but(cpu_sibling_mask(cpu), cpu);
> +
> +	if (ncpu < nr_cpu_ids) {
> +		target = ncpu;
> +		cpumask_set_cpu(target, &core_imc_cpumask);
> +	} else
> +		target = -1;
> +
> +	/* migrate the context */
> +	core_imc_change_cpu_context(cpu, target);
> +
> +	return 0;
> +}
> +

--
Thanks and Regards
gautham.
