Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xW2131nb9zDqb3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 13:59:19 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7E3wkec109305
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Aug 2017 23:59:17 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cb2qjbq7v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Aug 2017 23:59:16 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 14 Aug 2017 13:59:14 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7E3x4O724772794
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 13:59:12 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7E3weDA029681
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 13:58:40 +1000
Subject: Re: [PATCH] powerpc/perf: double unlock bug in
 imc_common_cpuhp_mem_free()
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
References: <20170811200541.qlxcpp3og33sdki3@mwanda>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 14 Aug 2017 09:28:13 +0530
MIME-Version: 1.0
In-Reply-To: <20170811200541.qlxcpp3og33sdki3@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <0b9f75e5-4519-4d84-cf05-771c16e80db5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Saturday 12 August 2017 01:35 AM, Dan Carpenter wrote:
> There is a typo so we call unlock instead of lock.

Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

nest_imc_refc used to maintain list of perf sessions thats using the
nest units currently. This is needed in turning off nest engine microcode
when not in use.

Yes will send a patch to fix ref->lock change.

Thanks for fix

Maddy

>
> Fixes: 885dcd709ba9 ("powerpc/perf: Add nest IMC PMU support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> I also don't understand how the &nest_imc_refc[node_id].lock works.  Why
> can't we use ref->lock everywhere?  They seem equivalent, and my static
> checker complains if we call the same lock different names.
>
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index 46cd912af060..52017f6eafd9 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -1124,7 +1124,7 @@ static void cleanup_all_thread_imc_memory(void)
>   static void imc_common_cpuhp_mem_free(struct imc_pmu *pmu_ptr)
>   {
>   	if (pmu_ptr->domain == IMC_DOMAIN_NEST) {
> -		mutex_unlock(&nest_init_lock);
> +		mutex_lock(&nest_init_lock);
>   		if (nest_pmus == 1) {
>   			cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE);
>   			kfree(nest_imc_refc);
>
