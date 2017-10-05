Return-Path: <santosh@fossix.org>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y77L66TQQzDr5w
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 20:50:22 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id i195so6965968pgd.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Oct 2017 02:50:22 -0700 (PDT)
Date: Thu, 5 Oct 2017 15:20:15 +0530
From: Santosh Sivaraj <santosh@fossix.org>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
 hemant@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/perf: Fix for core/nest imc call trace on
 cpuhotplug
Message-ID: <20171005095015.wr6spduebk4zqktk@santosiv.in.ibm.com>
References: <1507099852-28004-1-git-send-email-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1507099852-28004-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Anju T Sudhakar <anju@linux.vnet.ibm.com> wrote (on 2017-10-04 06:50:52 +0000):

> Nest/core pmu units are enabled only when it is used. A reference count is      
> maintained for the events which uses the nest/core pmu units. Currently in      
> *_imc_counters_release function a WARN() is used for notification of any        
> underflow of ref count.                                                         
>                                                                                 
> The case where event ref count hit a negative value is, when perf session is    
> started, followed by offlining of all cpus in a given core.                     
> i.e. in cpuhotplug offline path ppc_core_imc_cpu_offline() function set the     
> ref->count to zero, if the current cpu which is about to offline is the last    
> cpu in a given core and make an OPAL call to disable the engine in that core.   
> And on perf session termination, perf->destroy (core_imc_counters_release) will 
> first decrement the ref->count for this core and based on the ref->count value  
> an opal call is made to disable the core-imc engine.                            
> Now, since cpuhotplug path already clears the ref->count for core and disabled  
> the engine, perf->destroy() decrementing again at event termination make it     
> negative which in turn fires the WARN_ON. The same happens for nest units.      
>                                                                                 
> Add a check to see if the reference count is alreday zero, before decrementing  
> the count, so that the ref count will not hit a negative value.                 
>                                                                                 
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>

Reviewed-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  arch/powerpc/perf/imc-pmu.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index 9ccac86f3463..e3a1f65933b5 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -399,6 +399,20 @@ static void nest_imc_counters_release(struct perf_event *event)
>  
>  	/* Take the mutex lock for this node and then decrement the reference count */
>  	mutex_lock(&ref->lock);
> +	if (ref->refc == 0) {
> +		/*
> +		 * The scenario where this is true is, when perf session is
> +		 * started, followed by offlining of all cpus in a given node.
> +		 *
> +		 * In the cpuhotplug offline path, ppc_nest_imc_cpu_offline()
> +		 * function set the ref->count to zero, if the cpu which is
> +		 * about to offline is the last cpu in a given node and make
> +		 * an OPAL call to disable the engine in that node.
> +		 *
> +		 */
> +		mutex_unlock(&ref->lock);
> +		return;
> +	}
>  	ref->refc--;
>  	if (ref->refc == 0) {
>  		rc = opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST,
> @@ -646,6 +660,20 @@ static void core_imc_counters_release(struct perf_event *event)
>  		return;
>  
>  	mutex_lock(&ref->lock);
> +	if (ref->refc == 0) {
> +		/*
> +		 * The scenario where this is true is, when perf session is
> +		 * started, followed by offlining of all cpus in a given core.
> +		 *
> +		 * In the cpuhotplug offline path, ppc_core_imc_cpu_offline()
> +		 * function set the ref->count to zero, if the cpu which is
> +		 * about to offline is the last cpu in a given core and make
> +		 * an OPAL call to disable the engine in that core.
> +		 *
> +		 */
> +		mutex_unlock(&ref->lock);
> +		return;
> +	}
>  	ref->refc--;
>  	if (ref->refc == 0) {
>  		rc = opal_imc_counters_stop(OPAL_IMC_COUNTERS_CORE,

-- 
