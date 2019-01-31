Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0A7C169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 05:40:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E5120870
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 05:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E5120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qpwy1fpDzDqWx
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 16:40:34 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qpv23NwzzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 16:38:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43qpv21SXvz9sBQ;
 Thu, 31 Jan 2019 16:38:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Juliet Kim <minkim@us.ibm.com>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Nathan Lynch <nathanl@linux.vnet.ibm.com>,
 Gustavo Walbon <gwalbon@linux.vnet.ibm.com>, mwb@linux.vnet.ibm.com
Subject: Re: [PATCH v02] powerpc/pseries: Check for ceded CPU's during LPAR
 migration
In-Reply-To: <20190130212220.11315.76901.stgit@ltcalpine2-lp20.aus.stglabs.ibm.com>
References: <20190130212220.11315.76901.stgit@ltcalpine2-lp20.aus.stglabs.ibm.com>
Date: Thu, 31 Jan 2019 16:38:51 +1100
Message-ID: <8736p9pes4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
> This patch is to check for cede'ed CPUs during LPM.  Some extreme
> tests encountered a problem ehere Linux has put some threads to
> sleep (possibly to save energy or something), LPM was attempted,
> and the Linux kernel didn't awaken the sleeping threads, but issued
> the H_JOIN for the active threads.  Since the sleeping threads
> are not awake, they can not issue the expected H_JOIN, and the
> partition would never suspend.  This patch wakes the sleeping
> threads back up.

I'm don't think this is the right solution.

Just after your for loop we do an on_each_cpu() call, which sends an IPI
to every CPU, and that should wake all CPUs up from CEDE.

If that's not happening then there is a bug somewhere, and we need to
work out where.


> diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
> index cff5a41..8292eff 100644
> --- a/arch/powerpc/include/asm/plpar_wrappers.h
> +++ b/arch/powerpc/include/asm/plpar_wrappers.h
> @@ -26,10 +26,8 @@ static inline void set_cede_latency_hint(u8 latency_hint)
>  	get_lppaca()->cede_latency_hint = latency_hint;
>  }
>  
> -static inline long cede_processor(void)
> -{
> -	return plpar_hcall_norets(H_CEDE);
> -}
> +int cpu_is_ceded(int cpu);
> +long cede_processor(void);
>  
>  static inline long extended_cede_processor(unsigned long latency_hint)
>  {
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index de35bd8f..fea3d21 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -44,6 +44,7 @@
>  #include <asm/time.h>
>  #include <asm/mmu.h>
>  #include <asm/topology.h>
> +#include <asm/plpar_wrappers.h>
>  
>  /* This is here deliberately so it's only used in this file */
>  void enter_rtas(unsigned long);
> @@ -942,7 +943,7 @@ int rtas_ibm_suspend_me(u64 handle)
>  	struct rtas_suspend_me_data data;
>  	DECLARE_COMPLETION_ONSTACK(done);
>  	cpumask_var_t offline_mask;
> -	int cpuret;
> +	int cpuret, cpu;
>  
>  	if (!rtas_service_present("ibm,suspend-me"))
>  		return -ENOSYS;
> @@ -991,6 +992,11 @@ int rtas_ibm_suspend_me(u64 handle)
>  		goto out_hotplug_enable;
>  	}
>  
> +	for_each_present_cpu(cpu) {
> +		if (cpu_is_ceded(cpu))
> +			plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(cpu));
> +	}

There's a race condition here, there's nothing to prevent the CPUs you
just PROD'ed from going back into CEDE before you do the on_each_cpu()
call below.

>  	/* Call function on all CPUs.  One of us will make the
>  	 * rtas call
>  	 */
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index 41f62ca2..48ae6d4 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -331,6 +331,24 @@ static int alloc_dispatch_log_kmem_cache(void)
>  }
>  machine_early_initcall(pseries, alloc_dispatch_log_kmem_cache);
>  
> +static DEFINE_PER_CPU(int, cpu_ceded);
> +
> +int cpu_is_ceded(int cpu)
> +{
> +	return per_cpu(cpu_ceded, cpu);
> +}
> +
> +long cede_processor(void)
> +{
> +	long rc;
> +
> +	per_cpu(cpu_ceded, raw_smp_processor_id()) = 1;

And there's also a race condition here. From the other CPU's perspective
the store to cpu_ceded is not necessarily ordered vs the hcall below.
Which means the other CPU can see cpu_ceded = 0, and therefore not prod
us, but this CPU has already called H_CEDE.

> +	rc = plpar_hcall_norets(H_CEDE);
> +	per_cpu(cpu_ceded, raw_smp_processor_id()) = 0;
> +
> +	return rc;
> +}
> +
>  static void pseries_lpar_idle(void)
>  {
>  	/*

cheers
