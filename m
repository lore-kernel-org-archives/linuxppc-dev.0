Return-Path: <marc.zyngier@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tg3V71CFFzDw9p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 19:33:01 +1100 (AEDT)
Subject: Re: [PATCH v6 2/4] irqchip/qeic: merge qeic init code from platforms
 to a common function
To: Zhao Qiang <qiang.zhao@nxp.com>, oss@buserror.net, tglx@linutronix.de
References: <1475033103-18192-1-git-send-email-qiang.zhao@nxp.com>
 <1475033103-18192-2-git-send-email-qiang.zhao@nxp.com>
Cc: jason@lakedaemon.net, xiaobo.xie@nxp.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <45b9393b-bb29-4879-ee03-e4517b013e54@arm.com>
Date: Fri, 16 Dec 2016 08:32:53 +0000
MIME-Version: 1.0
In-Reply-To: <1475033103-18192-2-git-send-email-qiang.zhao@nxp.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28/09/16 04:25, Zhao Qiang wrote:
> The codes of qe_ic init from a variety of platforms are redundant,
> merge them to a common function and put it to irqchip/irq-qeic.c
> 
> For non-p1021_mds mpc85xx_mds boards, use "qe_ic_init(np, 0,
> qe_ic_cascade_low_mpic, qe_ic_cascade_high_mpic);" instead of
> "qe_ic_init(np, 0, qe_ic_cascade_muxed_mpic, NULL);".
> 
> qe_ic_cascade_muxed_mpic was used for boards has the same interrupt
> number for low interrupt and high interrupt, qe_ic_init has checked
> if "low interrupt == high interrupt"
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
> Changes for v2:
> 	- modify subject and commit msg
> 	- add check for qeic by type
> Changes for v3:
> 	- na
> Changes for v4:
> 	- na
> Changes for v5:
> 	- na
> Changes for v6:
> 	- rebase
> 
>  arch/powerpc/platforms/83xx/misc.c            | 15 ---------------
>  arch/powerpc/platforms/85xx/corenet_generic.c |  9 ---------
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c     | 14 --------------
>  arch/powerpc/platforms/85xx/mpc85xx_rdb.c     | 16 ----------------
>  arch/powerpc/platforms/85xx/twr_p102x.c       | 14 --------------
>  drivers/irqchip/irq-qeic.c                    | 16 ++++++++++++++++
>  6 files changed, 16 insertions(+), 68 deletions(-)
> 

[...]

> --- a/drivers/irqchip/irq-qeic.c
> +++ b/drivers/irqchip/irq-qeic.c
> @@ -598,4 +598,20 @@ static int __init init_qe_ic_sysfs(void)
>  	return 0;
>  }
>  
> +static int __init qeic_of_init(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> +	if (!np) {
> +		np = of_find_node_by_type(NULL, "qeic");
> +		if (!np)
> +			return;
> +	}
> +	qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
> +		   qe_ic_cascade_high_mpic);
> +	of_node_put(np);
> +}

Have you actually compiled that code?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
