Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40kmG82YbPzF3T4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 13:22:08 +1000 (AEST)
Message-ID: <1526268127.30369.21.camel@neuling.org>
Subject: Re: [PATCH 2/2] powerpc: Enable ASYM_SMT on interleaved big-core
 systems
From: Michael Neuling <mikey@neuling.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, Shilpasri G Bhat
 <shilpa.bhat@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>,
 Oliver O'Halloran <oohall@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 14 May 2018 13:22:07 +1000
In-Reply-To: <1526037444-22876-3-git-send-email-ego@linux.vnet.ibm.com>
References: <1526037444-22876-1-git-send-email-ego@linux.vnet.ibm.com>
 <1526037444-22876-3-git-send-email-ego@linux.vnet.ibm.com>
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

On Fri, 2018-05-11 at 16:47 +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>=20
> Each of the SMT4 cores forming a fused-core are more or less
> independent units. Thus when multiple tasks are scheduled to run on
> the fused core, we get the best performance when the tasks are spread
> across the pair of SMT4 cores.
>=20
> Since the threads in the pair of SMT4 cores of an interleaved big-core
> are numbered {0,2,4,6} and {1,3,5,7} respectively, enable ASYM_SMT on
> such interleaved big-cores that will bias the load-balancing of tasks
> on smaller numbered threads, which will automatically result in
> spreading the tasks uniformly across the associated pair of SMT4
> cores.
>=20
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 9ca7148..0153f01 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1082,7 +1082,7 @@ static int powerpc_smt_flags(void)
>  {
>  	int flags =3D SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
> =20
> -	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
> +	if (cpu_has_feature(CPU_FTR_ASYM_SMT) || has_interleaved_big_core) {

Shouldn't we just set CPU_FTR_ASYM_SMT and leave this code unchanged?


>  		printk_once(KERN_INFO "Enabling Asymmetric SMT
> scheduling\n");
>  		flags |=3D SD_ASYM_PACKING;
>  	}
