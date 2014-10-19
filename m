Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F17BA1A0246
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 10:03:20 +1100 (AEDT)
Message-ID: <1413759798.8865.117.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: Quieten relocation on exceptions warning
From: Michael Neuling <mikey@neuling.org>
To: Anton Blanchard <anton@samba.org>
Date: Mon, 20 Oct 2014 10:03:18 +1100
In-Reply-To: <1413755489-28682-1-git-send-email-anton@samba.org>
References: <1413755489-28682-1-git-send-email-anton@samba.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: mikey@neuling.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> The hypervisor returns H_P2 if relocation on exceptions are
> not supported. If we get this, just print a lower priority
> informational message.

Can you add something about why this is needed?  Something about
h_set_mode being available so we can enable LE but not supporting any of
the other calls like AIL?

Mikey

> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/platforms/pseries/setup.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platfo=
rms/pseries/setup.c
> index 125c589..fcc9227 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -499,7 +499,11 @@ static void __init pSeries_setup_arch(void)
> =20
>  	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
>  		long rc;
> -		if ((rc =3D pSeries_enable_reloc_on_exc()) !=3D H_SUCCESS) {
> +
> +		rc =3D pSeries_enable_reloc_on_exc();
> +		if (rc =3D=3D H_P2) {
> +			pr_info("Relocation on exceptions not supported\n");
> +		} else if (rc !=3D H_SUCCESS) {
>  			pr_warn("Unable to enable relocation on exceptions: "
>  				"%ld\n", rc);
>  		}
