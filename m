Return-Path: <kirjanov@gmail.com>
Received: from mail-oa0-x235.google.com (mail-oa0-x235.google.com
 [IPv6:2607:f8b0:4003:c02::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B75BF1A07ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 23:51:21 +1000 (EST)
Received: by mail-oa0-f53.google.com with SMTP id j17so3098316oag.26
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 06:51:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1405677892-7201-1-git-send-email-nikhil.badola@freescale.com>
References: <1405677892-7201-1-git-send-email-nikhil.badola@freescale.com>
Date: Fri, 18 Jul 2014 17:51:16 +0400
Message-ID: <CAHj3AVmD1ecGor_z_bsVRty7KSh8CL1TW20=YGk60SXV1hjOtg@mail.gmail.com>
Subject: Re: [PATCH] powerpc : dma-mapping : Check null condition for
 dev->archdata.dma_ops
From: Denis Kirjanov <kirjanov@gmail.com>
To: Nikhil Badola <nikhil.badola@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 7/18/14, Nikhil Badola <nikhil.badola@freescale.com> wrote:
> Modifies get_dma_ops() implementation on ppc arch to check null condition
 which means that dma is not supported.

Could you please describe the use case where the ops is null.

> for dev->archdata.dma_ops; returns common dma_direct_ops structure in
> case its NULL
>
> Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
> ---
>  arch/powerpc/include/asm/dma-mapping.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/dma-mapping.h
> b/arch/powerpc/include/asm/dma-mapping.h
> index 150866b..d73bae8 100644
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -86,10 +86,12 @@ static inline struct dma_map_ops *get_dma_ops(struct
> device *dev)
>  	 */
>  	if (unlikely(dev == NULL))
>  		return NULL;
> -
> -	return dev->archdata.dma_ops;
> +	if (dev->archdata.dma_ops)
> +		return dev->archdata.dma_ops;
> +	return &dma_direct_ops;
>  }
>
> +
>  static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
>  {
>  	dev->archdata.dma_ops = ops;
> --
> 1.7.11.7
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


-- 
Regards,
Denis
