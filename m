Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0C4982C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jul 2013 03:14:09 +1000 (EST)
Date: Wed, 17 Jul 2013 12:13:49 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/4 V2] mmc: esdhc: Add broken timeout quirk for p4/p5
 board
To: Haijun Zhang <Haijun.Zhang@freescale.com>
References: <1374055891-20703-1-git-send-email-Haijun.Zhang@freescale.com>
 <1374055891-20703-3-git-send-email-Haijun.Zhang@freescale.com>
In-Reply-To: <1374055891-20703-3-git-send-email-Haijun.Zhang@freescale.com>
 (from Haijun.Zhang@freescale.com on Wed Jul 17 05:11:31 2013)
Message-ID: <1374081229.8183.361@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linux-mmc@vger.kernel.org, AFLEMING@freescale.com, cbouatmailru@gmail.com,
 cjb@laptop.org, linuxppc-dev@lists.ozlabs.org,
 Haijun Zhang <haijun.zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/17/2013 05:11:31 AM, Haijun Zhang wrote:
> Sometimes command can't be completed within the time give
> in eSDHC_SYSCTL[DTOCV]. So just give the max value 0x14 to
> avoid this issue.
>=20
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> ---
> changes for v2:
> 	- Rebuild patch of eSDHC host need long time to generate
> 	 command interrupt
>=20
>  drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c =20
> b/drivers/mmc/host/sdhci-of-esdhc.c
> index 570bca8..30bfb5c 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -325,6 +325,12 @@ static void esdhc_of_platform_init(struct =20
> sdhci_host *host)
>=20
>  	if (vvn > VENDOR_V_22)
>  		host->quirks &=3D ~SDHCI_QUIRK_NO_BUSY_IRQ;
> +
> +	if ((SVR_SOC_VER(svr) =3D=3D SVR_B4860) ||
> +		(SVR_SOC_VER(svr) =3D=3D SVR_P5020) ||
> +		(SVR_SOC_VER(svr) =3D=3D SVR_P5040) ||
> +		(SVR_SOC_VER(svr) =3D=3D SVR_P4080))
> +		host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>  }

Please don't line up the continuation lines of the if-condition with =20
the if-body.

Please check variant SoCs as well.  If the bug exists on p4080, then it =20
exists on p4040.  Likewise with p5040/p5021, and p5020/p5010.

Is it present on all revisions of these SoCs?  How about p3041, which =20
is usually pretty similar to p5020?  p2040/p2041?  Is there an erratum =20
number for this problem?

-Scott=
