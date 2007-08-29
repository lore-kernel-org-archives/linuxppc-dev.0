Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6D195DDEF5
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 06:08:14 +1000 (EST)
Date: Thu, 30 Aug 2007 02:25:48 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/9] cpm2: Add SCCs to cpm2_clk_setup(), and
	cpm2_smc_clk_setup().
Message-ID: <20070830022548.6e0ce296@localhost.localdomain>
In-Reply-To: <20070828201922.GC24329@ld0162-tx32.am.freescale.net>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201922.GC24329@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 28 Aug 2007 15:19:22 -0500
Scott Wood wrote:

I would have it in the same patch, that adds clocking stuff to 8xx. And
maybe in the same, segregate source rather then having it in the foo_common.c, to ease fix/update/rework.

Just imho, not pressing for that.
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/sysdev/cpm2_common.c |  100
> +++++++++++++++++++++++++++++++++++--
> include/asm-powerpc/cpm2.h        |    5 ++- 2 files changed, 99
> insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/cpm2_common.c
> b/arch/powerpc/sysdev/cpm2_common.c index 99ad1ed..549da4b 100644
> --- a/arch/powerpc/sysdev/cpm2_common.c
> +++ b/arch/powerpc/sysdev/cpm2_common.c
> @@ -140,7 +140,8 @@ int cpm2_clk_setup(enum cpm_clk_target target,
> int clock, int mode) cpmux_t __iomem *im_cpmux;
>  	u32 __iomem *reg;
>  	u32 mask = 7;
> -	u8 clk_map [24][3] = {
> +
> +	u8 clk_map[][3] = {
>  		{CPM_CLK_FCC1, CPM_BRG5, 0},
>  		{CPM_CLK_FCC1, CPM_BRG6, 1},
>  		{CPM_CLK_FCC1, CPM_BRG7, 2},
> @@ -164,8 +165,40 @@ int cpm2_clk_setup(enum cpm_clk_target target,
> int clock, int mode) {CPM_CLK_FCC3, CPM_CLK13, 4},
>  		{CPM_CLK_FCC3, CPM_CLK14, 5},
>  		{CPM_CLK_FCC3, CPM_CLK15, 6},
> -		{CPM_CLK_FCC3, CPM_CLK16, 7}
> -		};
> +		{CPM_CLK_FCC3, CPM_CLK16, 7},
> +		{CPM_CLK_SCC1, CPM_BRG1, 0},
> +		{CPM_CLK_SCC1, CPM_BRG2, 1},
> +		{CPM_CLK_SCC1, CPM_BRG3, 2},
> +		{CPM_CLK_SCC1, CPM_BRG4, 3},
> +		{CPM_CLK_SCC1, CPM_CLK11, 4},
> +		{CPM_CLK_SCC1, CPM_CLK12, 5},
> +		{CPM_CLK_SCC1, CPM_CLK3, 6},
> +		{CPM_CLK_SCC1, CPM_CLK4, 7},
> +		{CPM_CLK_SCC2, CPM_BRG1, 0},
> +		{CPM_CLK_SCC2, CPM_BRG2, 1},
> +		{CPM_CLK_SCC2, CPM_BRG3, 2},
> +		{CPM_CLK_SCC2, CPM_BRG4, 3},
> +		{CPM_CLK_SCC2, CPM_CLK11, 4},
> +		{CPM_CLK_SCC2, CPM_CLK12, 5},
> +		{CPM_CLK_SCC2, CPM_CLK3, 6},
> +		{CPM_CLK_SCC2, CPM_CLK4, 7},
> +		{CPM_CLK_SCC3, CPM_BRG1, 0},
> +		{CPM_CLK_SCC3, CPM_BRG2, 1},
> +		{CPM_CLK_SCC3, CPM_BRG3, 2},
> +		{CPM_CLK_SCC3, CPM_BRG4, 3},
> +		{CPM_CLK_SCC3, CPM_CLK5, 4},
> +		{CPM_CLK_SCC3, CPM_CLK6, 5},
> +		{CPM_CLK_SCC3, CPM_CLK7, 6},
> +		{CPM_CLK_SCC3, CPM_CLK8, 7},
> +		{CPM_CLK_SCC4, CPM_BRG1, 0},
> +		{CPM_CLK_SCC4, CPM_BRG2, 1},
> +		{CPM_CLK_SCC4, CPM_BRG3, 2},
> +		{CPM_CLK_SCC4, CPM_BRG4, 3},
> +		{CPM_CLK_SCC4, CPM_CLK5, 4},
> +		{CPM_CLK_SCC4, CPM_CLK6, 5},
> +		{CPM_CLK_SCC4, CPM_CLK7, 6},
> +		{CPM_CLK_SCC4, CPM_CLK8, 7},
> +	};
>  
>  	im_cpmux = cpm2_map(im_cpmux);
>  
> @@ -205,23 +238,80 @@ int cpm2_clk_setup(enum cpm_clk_target target,
> int clock, int mode) if (mode == CPM_CLK_RX)
>  		shift += 3;
>  
> -	for (i=0; i<24; i++) {
> +	for (i = 0; i < ARRAY_SIZE(clk_map); i++) {
>  		if (clk_map[i][0] == target && clk_map[i][1] ==
> clock) { bits = clk_map[i][2];
>  			break;
>  		}
>  	}
> -	if (i == sizeof(clk_map)/3)
> +	if (i == ARRAY_SIZE(clk_map))
>  	    ret = -EINVAL;
>  
>  	bits <<= shift;
>  	mask <<= shift;
> +
>  	out_be32(reg, (in_be32(reg) & ~mask) | bits);
>  
>  	cpm2_unmap(im_cpmux);
>  	return ret;
>  }
>  
> +int cpm2_smc_clk_setup(enum cpm_clk_target target, int clock)
> +{
> +	int ret = 0;
> +	int shift;
> +	int i, bits = 0;
> +	cpmux_t __iomem *im_cpmux;
> +	u8 __iomem *reg;
> +	u8 mask = 3;
> +
> +	u8 clk_map[][3] = {
> +		{CPM_CLK_SMC1, CPM_BRG1, 0},
> +		{CPM_CLK_SMC1, CPM_BRG7, 1},
> +		{CPM_CLK_SMC1, CPM_CLK7, 2},
> +		{CPM_CLK_SMC1, CPM_CLK9, 3},
> +		{CPM_CLK_SMC2, CPM_BRG2, 0},
> +		{CPM_CLK_SMC2, CPM_BRG8, 1},
> +		{CPM_CLK_SMC2, CPM_CLK4, 2},
> +		{CPM_CLK_SMC2, CPM_CLK15, 3},
> +	};
> +
> +	im_cpmux = cpm2_map(im_cpmux);
> +
> +	switch (target) {
> +	case CPM_CLK_SMC1:
> +		reg = &im_cpmux->cmx_smr;
> +		mask = 3;
> +		shift = 4;
> +		break;
> +	case CPM_CLK_SMC2:
> +		reg = &im_cpmux->cmx_smr;
> +		mask = 3;
> +		shift = 0;
> +		break;
> +	default:
> +		printk(KERN_ERR "cpm2_smc_clock_setup: invalid clock
> target\n");
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(clk_map); i++) {
> +		if (clk_map[i][0] == target && clk_map[i][1] ==
> clock) {
> +			bits = clk_map[i][2];
> +			break;
> +		}
> +	}
> +	if (i == ARRAY_SIZE(clk_map))
> +	    ret = -EINVAL;
> +
> +	bits <<= shift;
> +	mask <<= shift;
> +
> +	out_8(reg, (in_8(reg) & ~mask) | bits);
> +
> +	cpm2_unmap(im_cpmux);
> +	return ret;
> +}
> +
>  /*
>   * dpalloc / dpfree bits.
>   */
> diff --git a/include/asm-powerpc/cpm2.h b/include/asm-powerpc/cpm2.h
> index c036506..41a45db 100644
> --- a/include/asm-powerpc/cpm2.h
> +++ b/include/asm-powerpc/cpm2.h
> @@ -1206,7 +1206,9 @@ enum cpm_clk_target {
>  	CPM_CLK_SCC4,
>  	CPM_CLK_FCC1,
>  	CPM_CLK_FCC2,
> -	CPM_CLK_FCC3
> +	CPM_CLK_FCC3,
> +	CPM_CLK_SMC1,
> +	CPM_CLK_SMC2,
>  };
>  
>  enum cpm_clk {
> @@ -1243,6 +1245,7 @@ enum cpm_clk {
>  };
>  
>  extern int cpm2_clk_setup(enum cpm_clk_target target, int clock, int
> mode); +extern int cpm2_smc_clk_setup(enum cpm_clk_target target, int
> clock); 
>  #endif /* __CPM2__ */
>  #endif /* __KERNEL__ */


-- 
Sincerely, Vitaly
