Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A5F3C1A0809
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 14:11:41 +1100 (AEDT)
Message-ID: <1449544301.3197.21.camel@neuling.org>
Subject: Re: [PATCH] cxl: Set endianess of kernel contexts
From: Michael Neuling <mikey@neuling.org>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, mpe@ellerman.id.au, stable@vger.kernel.org
Date: Tue, 08 Dec 2015 14:11:41 +1100
In-Reply-To: <1449495280-18819-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1449495280-18819-1-git-send-email-fbarrat@linux.vnet.ibm.com>
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

On Mon, 2015-12-07 at 14:34 +0100, Frederic Barrat wrote:
> A process element (defined in CAIA) keeps track of the endianess of
> contexts through the Little Endian (LE) bit of the State Register. It
> is currently set for user contexts, but was somehow forgotten for
> kernel contexts, so this patch fixes it.
> It could lead to erratic behavior from an AFU when the context is
> attached through the kernel API.
>=20
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Suggested-by: Michael Neuling <mikey@neuling.org>
> Cc: <stable@vger.kernel.org> # 4.3+
> ---
> cxl kernel API is supported starting with 4.3 (for cxlflash)

The cxlflash's AFU doesn't use this bit, so the stable@ marker here is
probably not strictly needed.

Mikey


>  drivers/misc/cxl/native.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index d2e75c8..f409097 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -497,6 +497,7 @@ static u64 calculate_sr(struct cxl_context *ctx)
>  {
>  	u64 sr =3D 0;
> =20
> +	set_endian(sr);
>  	if (ctx->master)
>  		sr |=3D CXL_PSL_SR_An_MP;
>  	if (mfspr(SPRN_LPCR) & LPCR_TC)
> @@ -506,7 +507,6 @@ static u64 calculate_sr(struct cxl_context *ctx)
>  		sr |=3D CXL_PSL_SR_An_HV;
>  	} else {
>  		sr |=3D CXL_PSL_SR_An_PR | CXL_PSL_SR_An_R;
> -		set_endian(sr);
>  		sr &=3D ~(CXL_PSL_SR_An_HV);
>  		if (!test_tsk_thread_flag(current, TIF_32BIT))
>  			sr |=3D CXL_PSL_SR_An_SF;
