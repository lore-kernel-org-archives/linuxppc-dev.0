Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 79CAE2C00D6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 09:13:26 +1000 (EST)
Received: from mail94-co9 (localhost [127.0.0.1])	by mail94-co9-R.bigfish.com
 (Postfix) with ESMTP id 6BE974C034E	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 24 Sep 2013 23:13:21 +0000 (UTC)
Received: from CO9EHSMHS001.bigfish.com (unknown [10.236.132.238])	by
 mail94-co9.bigfish.com (Postfix) with ESMTP id D4A5E2C005F	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 23:13:19 +0000 (UTC)
Message-ID: <1380064397.24959.135.camel@snotra.buserror.net>
Subject: Re: [PATCH V4 1/3] powerpc/85xx: Add QE common init functions
From: Scott Wood <scottwood@freescale.com>
To: Xie Xiaobo <X.Xie@freescale.com>
Date: Tue, 24 Sep 2013 18:13:17 -0500
In-Reply-To: <1380019739-8196-1-git-send-email-X.Xie@freescale.com>
References: <1380019739-8196-1-git-send-email-X.Xie@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-09-24 at 18:48 +0800, Xie Xiaobo wrote:
> Define two QE init functions in common file, and avoid
> the same codes being duplicated in board files.
> 
> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> ---
> V4 -> V3: Nochange
> 
>  arch/powerpc/platforms/85xx/common.c  | 51 +++++++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/85xx/mpc85xx.h |  8 ++++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
> index d0861a0..08fff48 100644
> --- a/arch/powerpc/platforms/85xx/common.c
> +++ b/arch/powerpc/platforms/85xx/common.c
> @@ -7,6 +7,9 @@
>   */
>  #include <linux/of_platform.h>
>  
> +#include <asm/machdep.h>
> +#include <asm/qe.h>
> +#include <asm/qe_ic.h>
>  #include <sysdev/cpm2_pic.h>
>  
>  #include "mpc85xx.h"
> @@ -80,3 +83,51 @@ void __init mpc85xx_cpm2_pic_init(void)
>  	irq_set_chained_handler(irq, cpm2_cascade);
>  }
>  #endif
> +
> +#ifdef CONFIG_QUICC_ENGINE
> +void __init mpc85xx_qe_pic_init(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> +	if (np) {
> +		if (machine_is(mpc8568_mds) || machine_is(mpc8569_mds))
> +			qe_ic_init(np, 0, qe_ic_cascade_muxed_mpic, NULL);
> +		else
> +			qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
> +					qe_ic_cascade_high_mpic);
> +		of_node_put(np);
> +	} else
> +		pr_err("%s: Could not find qe-ic node\n", __func__);
> +}

Have the caller pass in a flag indicating the type of cascade.  Or,
perhaps this function isn't worth factoring out.  Where is the check for
p1021_mds?  Where did 8568/9 MDS come from?  I don't see those checks
removed in patch 2.

BTW, when you move code from one place to another, do it in one patch.
Don't add it in one patch and then remove it in another.  A more useful
split would have been one patch handling qe_init and another handling
qe_pic_init.

-Scott
