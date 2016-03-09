Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E75541A0060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 10:59:49 +1100 (AEDT)
Message-ID: <1457567989.17010.9.camel@neuling.org>
Subject: Re: [PATCH] cxl: Remove dead code
From: Michael Neuling <mikey@neuling.org>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, ian@ozlabs.au.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Date: Thu, 10 Mar 2016 10:59:49 +1100
In-Reply-To: <1457524393-6717-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1457524393-6717-1-git-send-email-fbarrat@linux.vnet.ibm.com>
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

On Wed, 2016-03-09 at 12:53 +0100, Frederic Barrat wrote:
> Function cxl_get_phys_dev() was removed from the kernel API by a
> previous patch, but it's actually dead code. Remove it.
>=20
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Acked-by: Michael Neuling <mikey@neuling.org>

> ---
>  drivers/misc/cxl/api.c | 9 ---------
>  1 file changed, 9 deletions(-)
>=20
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index 2107c94..8075823 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -68,15 +68,6 @@ struct cxl_context *cxl_get_context(struct pci_dev
> *dev)
>  }
>  EXPORT_SYMBOL_GPL(cxl_get_context);
> =20
> -struct device *cxl_get_phys_dev(struct pci_dev *dev)
> -{
> -	struct cxl_afu *afu;
> -
> -	afu =3D cxl_pci_to_afu(dev);
> -
> -	return afu->adapter->dev.parent;
> -}
> -
>  int cxl_release_context(struct cxl_context *ctx)
>  {
>  	if (ctx->status >=3D STARTED)
