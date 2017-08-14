Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xW1N36tc1zDqgj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 13:30:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] powerpc/perf: double unlock bug in
 imc_common_cpuhp_mem_free()
In-Reply-To: <20170811200541.qlxcpp3og33sdki3@mwanda>
References: <20170811200541.qlxcpp3og33sdki3@mwanda>
Date: Mon, 14 Aug 2017 13:30:41 +1000
Message-ID: <87bmnisu5a.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dan Carpenter <dan.carpenter@oracle.com> writes:

> There is a typo so we call unlock instead of lock.
>
> Fixes: 885dcd709ba9 ("powerpc/perf: Add nest IMC PMU support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> I also don't understand how the &nest_imc_refc[node_id].lock works.  Why
> can't we use ref->lock everywhere?  They seem equivalent, and my static
> checker complains if we call the same lock different names.

That looks like a bug to me, ie. we should always use ref.

Maddy?

cheers

> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index 46cd912af060..52017f6eafd9 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -1124,7 +1124,7 @@ static void cleanup_all_thread_imc_memory(void)
>  static void imc_common_cpuhp_mem_free(struct imc_pmu *pmu_ptr)
>  {
>  	if (pmu_ptr->domain == IMC_DOMAIN_NEST) {
> -		mutex_unlock(&nest_init_lock);
> +		mutex_lock(&nest_init_lock);
>  		if (nest_pmus == 1) {
>  			cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE);
>  			kfree(nest_imc_refc);
