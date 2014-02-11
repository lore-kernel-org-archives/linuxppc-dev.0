Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 85BCE2C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 19:41:18 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 11 Feb 2014 14:11:04 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3D317394005B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 14:11:02 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1B8evgl43319416
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 14:10:57 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1B8f1hg003840
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 14:11:01 +0530
Message-ID: <52F9E14A.5090101@linux.vnet.ibm.com>
Date: Tue, 11 Feb 2014 14:07:30 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 1/2] powernv: cpufreq driver for powernv platform
References: <20140211065757.21159.49689.stgit@drishya>
 <20140211070201.21159.31101.stgit@drishya>
In-Reply-To: <20140211070201.21159.31101.stgit@drishya>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Vaidy,

On 02/11/2014 12:32 PM, Vaidyanathan Srinivasan wrote:
> Backend driver to dynamically set voltage and frequency on
> IBM POWER non-virtualized platforms.  Power management SPRs
> are used to set the required PState.
> 
> This driver works in conjunction with cpufreq governors
> like 'ondemand' to provide a demand based frequency and
> voltage setting on IBM POWER non-virtualized platforms.
> 
> PState table is obtained from OPAL v3 firmware through device
> tree.
> 
> powernv_cpufreq back-end driver would parse the relevant device-tree
> nodes and initialise the cpufreq subsystem on powernv platform.
> 
> Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
<snip>

> +static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +	int base, i;
> +
> +#ifdef CONFIG_SMP
> +	base = cpu_first_thread_sibling(policy->cpu);
> +
> +	for (i = 0; i < threads_per_core; i++)
> +		cpumask_set_cpu(base + i, policy->cpus);
> +#endif
> +	policy->cpuinfo.transition_latency = 25000;

Is it ok to hard code this field? How about getting this also from the
device tree?

> +
> +	/* Print frequency table */
> +	for (i = 0; powernv_freqs[i].frequency != CPUFREQ_TABLE_END; i++)
> +		pr_debug("%d: %d\n", i, powernv_freqs[i].frequency);

The frequency table as a result will be printed on every cpu when
cpufreq gets initialized. Considering this information will not vary
across CPUs, can we print this during powernv_cpufreq_init() after
parsing the device tree for the pstates?

Thanks

Regards
Preeti U Murthy
