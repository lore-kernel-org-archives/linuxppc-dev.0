Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D5CF81A0611
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2015 10:23:16 +1000 (AEST)
Message-ID: <1435882996.2425.0.camel@neuling.org>
Subject: Re: [PATCH] cxl: Test the correct mmio space before unmapping
From: Michael Neuling <mikey@neuling.org>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 imunsie@au.ibm.com
Date: Fri, 03 Jul 2015 10:23:16 +1000
In-Reply-To: <1435816521-13159-1-git-send-email-dja@axtens.net>
References: <1435816521-13159-1-git-send-email-dja@axtens.net>
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

On Thu, 2015-07-02 at 15:55 +1000, Daniel Axtens wrote:
> Before freeing p2n, test p2n, not p1n.
>=20
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Nice catch but can you resend with a CC stable?

Mikey

>=20
> ---
>=20
> While a potentially nasty bug, this is only hit (at the moment)
> in cxl_remove, so it's probably not a candidate for stable.
> ---
>  drivers/misc/cxl/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index a16988d..fd43462 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -540,7 +540,7 @@ err:
> =20
>  static void cxl_unmap_slice_regs(struct cxl_afu *afu)
>  {
> -	if (afu->p1n_mmio)
> +	if (afu->p2n_mmio)
>  		iounmap(afu->p2n_mmio);
>  	if (afu->p1n_mmio)
>  		iounmap(afu->p1n_mmio);
