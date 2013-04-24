Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BBD742C011C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 10:04:20 +1000 (EST)
Date: Tue, 23 Apr 2013 19:04:06 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 12/15] powerpc/85xx: add time base sync support for
 e6500
To: Zhao Chenhui <chenhui.zhao@freescale.com>
References: <1366368468-29143-1-git-send-email-chenhui.zhao@freescale.com>
 <1366368468-29143-12-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1366368468-29143-12-git-send-email-chenhui.zhao@freescale.com>
 (from chenhui.zhao@freescale.com on Fri Apr 19 05:47:45 2013)
Message-ID: <1366761846.5825.21@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/19/2013 05:47:45 AM, Zhao Chenhui wrote:
> From: Chen-Hui Zhao <chenhui.zhao@freescale.com>
>=20
> For e6500, two threads in one core share one time base. Just need
> to do time base sync on first thread of one core, and skip it on
> the other thread.
>=20
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> ---
>  arch/powerpc/platforms/85xx/smp.c |   52 =20
> +++++++++++++++++++++++++++++++-----
>  1 files changed, 44 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/85xx/smp.c =20
> b/arch/powerpc/platforms/85xx/smp.c
> index 74d8cde..5f3eee3 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -26,6 +26,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/dbell.h>
>  #include <asm/fsl_guts.h>
> +#include <asm/cputhreads.h>
>=20
>  #include <sysdev/fsl_soc.h>
>  #include <sysdev/mpic.h>
> @@ -45,6 +46,7 @@ static u64 timebase;
>  static int tb_req;
>  static int tb_valid;
>  static u32 cur_booting_core;
> +static bool rcpmv2;
>=20
>  #ifdef CONFIG_PPC_E500MC
>  /* get a physical mask of online cores and booting core */
> @@ -53,26 +55,40 @@ static inline u32 get_phy_cpu_mask(void)
>  	u32 mask;
>  	int cpu;
>=20
> -	mask =3D 1 << cur_booting_core;
> -	for_each_online_cpu(cpu)
> -		mask |=3D 1 << get_hard_smp_processor_id(cpu);
> +	if (smt_capable()) {
> +		/* two threads in one core share one time base */
> +		mask =3D 1 << cpu_core_index_of_thread(cur_booting_core);
> +		for_each_online_cpu(cpu)
> +			mask |=3D 1 << cpu_core_index_of_thread(
> +					get_hard_smp_processor_id(cpu));
> +	} else {
> +		mask =3D 1 << cur_booting_core;
> +		for_each_online_cpu(cpu)
> +			mask |=3D 1 << get_hard_smp_processor_id(cpu);
> +	}

Where is smt_capable defined()?  I assume somewhere in the patchset but =20
it's a pain to search 12 patches...

Is this really about whether we're SMT-capable or whether we have rcpm =20
v2?

-Scott=
