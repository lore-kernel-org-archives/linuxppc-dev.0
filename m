Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LXS51LQ1zF1RK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 15:20:36 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w3B5KWsk006023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 00:20:33 -0500
Message-ID: <1523424031.11062.128.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc/xive: Fix trying to "push" an already
 active pool VP
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Wed, 11 Apr 2018 15:20:31 +1000
In-Reply-To: <20180411051801.30194-1-benh@kernel.crashing.org>
References: <20180411051801.30194-1-benh@kernel.crashing.org>
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

On Wed, 2018-04-11 at 15:17 +1000, Benjamin Herrenschmidt wrote:
> When setting up a CPU, we "push" (activate) a pool VP for it.
> 
> However it's an error to do so if it already has an active
> pool VP.
> 
> This happens when doing soft CPU hotplug on powernv since we
> don't tear down the CPU on unplug. The HW flags the error which
> gets captured by the diagnostics.
> 
> Fix this by making sure to "pull" out any already active pool
> first.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

CC: stable@vger.kernel.org...

> ---
>  arch/powerpc/sysdev/xive/native.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
> index d22aeb0b69e1..b48454be5b98 100644
> --- a/arch/powerpc/sysdev/xive/native.c
> +++ b/arch/powerpc/sysdev/xive/native.c
> @@ -389,6 +389,10 @@ static void xive_native_setup_cpu(unsigned int cpu, struct xive_cpu *xc)
>  	if (xive_pool_vps == XIVE_INVALID_VP)
>  		return;
>  
> +	/* Check if pool VP already active, if it is, pull it */
> +	if (in_be32(xive_tima + TM_QW2_HV_POOL + TM_WORD2) & TM_QW2W2_VP)
> +		in_be64(xive_tima + TM_SPC_PULL_POOL_CTX);
> +
>  	/* Enable the pool VP */
>  	vp = xive_pool_vps + cpu;
>  	pr_debug("CPU %d setting up pool VP 0x%x\n", cpu, vp);
