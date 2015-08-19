Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C36091A0035
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 14:49:30 +1000 (AEST)
Message-ID: <1439959770.24918.5.camel@ellerman.id.au>
Subject: Re: [PATCH 2/2] cxl: add set/get private data to context struct
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: mikey <mikey@neuling.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Matt Ochs <mrochs@us.ibm.com>
Date: Wed, 19 Aug 2015 14:49:30 +1000
In-Reply-To: <1439957971-30483-2-git-send-email-imunsie@au.ibm.com>
References: <1439957971-30483-1-git-send-email-imunsie@au.ibm.com>
 <1439957971-30483-2-git-send-email-imunsie@au.ibm.com>
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

On Wed, 2015-08-19 at 14:19 +1000, Ian Munsie wrote:
> From: Michael Neuling <mikey@neuling.org>
> 
> This provides AFU drivers a means to associate private data with a cxl
> context. This is particularly intended for make the new callbacks for
> driver specific events easier for AFU drivers to use, as they can easily
> get back to any private data structures they may use.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> ---
>  drivers/misc/cxl/api.c | 21 +++++++++++++++++++++
>  drivers/misc/cxl/cxl.h |  3 +++
>  include/misc/cxl.h     |  7 +++++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index e0f0c78..5f0b22e 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -70,6 +70,27 @@ int cxl_release_context(struct cxl_context *ctx)
>  }
>  EXPORT_SYMBOL_GPL(cxl_release_context);
>  
> +
> +int cxl_set_priv(struct cxl_context *ctx, void *priv)
> +{
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	ctx->priv = priv;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cxl_set_priv);
> +
> +void *cxl_get_priv(struct cxl_context *ctx)
> +{
> +	if (!ctx)
> +		return ERR_PTR(-EINVAL);
> +
> +	return ctx->priv;
> +}
> +EXPORT_SYMBOL_GPL(cxl_get_priv);


Do we really need the accessors? They don't buy anything I can see over just
using ctx->priv directly.

cheers
