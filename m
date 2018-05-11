Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40jRYF6RWkzF35K
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2018 09:45:37 +1000 (AEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 40jRYF58xSz9rvt
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2018 09:45:37 +1000 (AEST)
Message-ID: <1526082337.11357.17.camel@neuling.org>
Subject: Re: [PATCH] powerpc/perf: Fix memory allocation for core-imc based
 on num_possible_cpus()
From: Michael Neuling <mikey@neuling.org>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.vnet.ibm.com, ppaidipe@linux.vnet.ibm.com
Date: Sat, 12 May 2018 09:45:37 +1000
In-Reply-To: <1526046222-17842-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1526046222-17842-1-git-send-email-anju@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-05-11 at 19:13 +0530, Anju T Sudhakar wrote:
> Currently memory is allocated for core-imc based on cpu_present_mask, whi=
ch
> has
> bit 'cpu' set iff cpu is populated. We use  (cpu number / threads per cor=
e)
> as as array index to access the memory.
> So in a system with guarded cores, since allocation happens based on
> cpu_present_mask, (cpu number / threads per core) bounds the index and le=
ads
> to memory overflow.
>=20
> The issue is exposed in a guard test.
> The guard test will make some CPU's as un-available to the system during =
boot
> time as well as at runtime. So when the cpu is unavailable to the system
> during
> boot time, the memory allocation happens depending on the number of avail=
able
> cpus. And when we access the memory using (cpu number / threads per core)=
 as
> the
> index the system crashes due to memory overflow.
>=20
> Allocating memory for core-imc based on cpu_possible_mask, which has
> bit 'cpu' set iff cpu is populatable, will fix this issue.
>=20
> Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>

Thanks, this should be:=20

Cc: <stable@vger.kernel.org> # 4.14

> ---
>  arch/powerpc/perf/imc-pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index d7532e7..75fb23c 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -1146,7 +1146,7 @@ static int init_nest_pmu_ref(void)
> =20
>  static void cleanup_all_core_imc_memory(void)
>  {
> -	int i, nr_cores =3D DIV_ROUND_UP(num_present_cpus(), threads_per_core);
> +	int i, nr_cores =3D DIV_ROUND_UP(num_possible_cpus(),
> threads_per_core);
>  	struct imc_mem_info *ptr =3D core_imc_pmu->mem_info;
>  	int size =3D core_imc_pmu->counter_mem_size;
> =20
> @@ -1264,7 +1264,7 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, st=
ruct
> device_node *parent,
>  		if (!pmu_ptr->pmu.name)
>  			return -ENOMEM;
> =20
> -		nr_cores =3D DIV_ROUND_UP(num_present_cpus(),
> threads_per_core);
> +		nr_cores =3D DIV_ROUND_UP(num_possible_cpus(),
> threads_per_core);
>  		pmu_ptr->mem_info =3D kcalloc(nr_cores, sizeof(struct
> imc_mem_info),
>  								GFP_KERNEL);
> =20
