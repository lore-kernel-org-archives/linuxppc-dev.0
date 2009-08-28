Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6800AB7B6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 15:34:59 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8122DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 15:34:58 +1000 (EST)
Message-Id: <A4A4F2A7-4F4C-48A9-A598-6BFB0982656A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090827173017.GB739@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 2/5] powerpc/qe: Make qe_reset() code path safe for
	repeated invocation
Date: Fri, 28 Aug 2009 00:34:50 -0500
References: <20090827173017.GB739@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 27, 2009, at 12:30 PM, Anton Vorontsov wrote:

>
> For MPC8569 CPUs we'll need to reset QE after each suspend, so make
> qe_reset() code path suitable for repeated invocation, that is:
>
> - Don't initialize rheap structures if already initialized;
> - Don't allocate muram for SDMA if already allocated, just  
> reinitialize
>  registers with previously allocated muram offset;
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/sysdev/cpm_common.c |    3 +++
> arch/powerpc/sysdev/qe_lib/qe.c  |   10 ++++++----
> 2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/ 
> cpm_common.c
> index e4b6d66..ddfca52 100644
> --- a/arch/powerpc/sysdev/cpm_common.c
> +++ b/arch/powerpc/sysdev/cpm_common.c
> @@ -81,6 +81,9 @@ int __init cpm_muram_init(void)
> 	int i = 0;
> 	int ret = 0;
>
> +	if (muram_pbase)
> +		return 0;
> +
> 	spin_lock_init(&cpm_muram_lock);
> 	/* initialize the info header */
> 	rh_init(&cpm_muram_info, 1,
> diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/ 
> qe_lib/qe.c
> index b06564f..f485d5a 100644
> --- a/arch/powerpc/sysdev/qe_lib/qe.c
> +++ b/arch/powerpc/sysdev/qe_lib/qe.c
> @@ -317,16 +317,18 @@ EXPORT_SYMBOL(qe_put_snum);
> static int qe_sdma_init(void)
> {
> 	struct sdma __iomem *sdma = &qe_immr->sdma;
> -	unsigned long sdma_buf_offset;
> +	static unsigned long sdma_buf_offset;
>
> 	if (!sdma)
> 		return -ENODEV;
>
> 	/* allocate 2 internal temporary buffers (512 bytes size each) for
> 	 * the SDMA */
> - 	sdma_buf_offset = qe_muram_alloc(512 * 2, 4096);
> -	if (IS_ERR_VALUE(sdma_buf_offset))
> -		return -ENOMEM;
> +	if (!sdma_buf_offset) {
> +		sdma_buf_offset = qe_muram_alloc(512 * 2, 4096);
> +		if (IS_ERR_VALUE(sdma_buf_offset))

shouldn't we zero out sdma_buf_offset otherwise if we call this again  
we'll think its set.

> +			return -ENOMEM;
> +	}
>
> 	out_be32(&sdma->sdebcr, (u32) sdma_buf_offset & QE_SDEBCR_BA_MASK);
>  	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK |
> -- 
> 1.6.3.3
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
