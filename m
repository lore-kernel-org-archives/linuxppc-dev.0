Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D0C41A0076
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 11:00:08 +1000 (AEST)
Message-ID: <1432083608.20823.19.camel@neuling.org>
Subject: Re: [PATCH] powerpc: Make doorbell check preemption safe
From: Michael Neuling <mikey@neuling.org>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Date: Wed, 20 May 2015 11:00:08 +1000
In-Reply-To: <1432062014-9115-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1432062014-9115-1-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-05-20 at 00:30 +0530, Shreyas B. Prabhu wrote:
> Doorbell can be used to cause ipi on cpus which are sibling threads on
> the same core. So icp_native_cause_ipi checks if the destination cpu
> is a sibling thread of the current cpu and uses doorbell in such cases.
>=20
> But while running with CONFIG_PREEMPT=3Dy, since this section is
> preemtible, we can run into issues if after we check if the destination
> cpu is a sibling cpu, the task gets migrated from a sibling cpu to a
> cpu on another core.
>=20
> Fix this by using get_cpu()/ put_cpu()

Thanks.  Looks good and it's boots for me.

Signed-off-by: Michael Neuling <mikey@neuling.org>

> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> ---
>  arch/powerpc/sysdev/xics/icp-native.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/=
xics/icp-native.c
> index 2fc4cf1..62fd478 100644
> --- a/arch/powerpc/sysdev/xics/icp-native.c
> +++ b/arch/powerpc/sysdev/xics/icp-native.c
> @@ -147,12 +147,16 @@ static void icp_native_cause_ipi(int cpu, unsigned =
long data)
>  {
>  	kvmppc_set_host_ipi(cpu, 1);
>  #ifdef CONFIG_PPC_DOORBELL
> -	if (cpu_has_feature(CPU_FTR_DBELL) &&
> -	    (cpumask_test_cpu(cpu, cpu_sibling_mask(smp_processor_id()))))
> -		doorbell_cause_ipi(cpu, data);
> -	else
> +	if (cpu_has_feature(CPU_FTR_DBELL)) {
> +		if (cpumask_test_cpu(cpu, cpu_sibling_mask(get_cpu()))) {
> +			doorbell_cause_ipi(cpu, data);
> +			put_cpu();
> +			return;
> +		}
> +		put_cpu();
> +	}
>  #endif
> -		icp_native_set_qirr(cpu, IPI_PRIORITY);
> +	icp_native_set_qirr(cpu, IPI_PRIORITY);
>  }
> =20
>  /*
