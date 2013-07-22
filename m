Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6608C2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 00:30:32 +1000 (EST)
Subject: Re: [PATCH 3/4 V2] mmc: esdhc: Correct host version of T4240-R1.0
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1374055891-20703-2-git-send-email-Haijun.Zhang@freescale.com>
Date: Mon, 22 Jul 2013 09:30:20 -0500
Message-Id: <25F3761C-ECFA-4397-A4F0-551BDAEDA4C7@kernel.crashing.org>
References: <1374055891-20703-1-git-send-email-Haijun.Zhang@freescale.com>
 <1374055891-20703-2-git-send-email-Haijun.Zhang@freescale.com>
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, AFLEMING@freescale.com, cbouatmailru@gmail.com,
 scottwood@freescale.com, cjb@laptop.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 17, 2013, at 5:11 AM, Haijun Zhang wrote:

> Vender version and sdhc spec version of T4240-R1.0 is incorrect.
> The right value should be VVN=3D0x13, SVN =3D 0x1. The wrong version
> number will break down the ADMA data transfer.
> This defect only exist in T4240-R1.0. Will be fixed in T4240-R2.0.
> Also share vvn and svr for public use.
>=20
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> ---
> changes for V2:
> 	- Remove broken ADMA quirk.
> 	- Rebuild patch of  Add quirks to support T4240 board
>=20
> drivers/mmc/host/sdhci-of-esdhc.c | 29 +++++++++++++----------------
> 1 file changed, 13 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c =
b/drivers/mmc/host/sdhci-of-esdhc.c
> index adfaadd..570bca8 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -26,7 +26,7 @@
> #define VENDOR_V_22	0x12
> #define VENDOR_V_23	0x13
>=20
> -static u32 svr;
> +static u32 svr, vvn;
>=20
> static u32 esdhc_readl(struct sdhci_host *host, int reg)
> {
> @@ -43,11 +43,9 @@ static u32 esdhc_readl(struct sdhci_host *host, int =
reg)
> 	 * For FSL eSDHC, must aligned 4-byte, so use 0xFC to read the
> 	 * the verdor version number, oxFE is SDHCI_HOST_VERSION.
> 	 */
> -	if ((reg =3D=3D SDHCI_CAPABILITIES) && (ret & =
SDHCI_CAN_DO_ADMA1)) {
> -		u32 tmp =3D in_be32(host->ioaddr + =
SDHCI_SLOT_INT_STATUS);
> -		tmp =3D (tmp & SDHCI_VENDOR_VER_MASK) >> =
SDHCI_VENDOR_VER_SHIFT;
> -		if (tmp > VENDOR_V_22)
> -			ret |=3D SDHCI_CAN_DO_ADMA2;
> +	if ((reg =3D=3D SDHCI_CAPABILITIES) && (ret & =
SDHCI_CAN_DO_ADMA1) &&
> +		(vvn > VENDOR_V_22)) {
> +		ret |=3D SDHCI_CAN_DO_ADMA2;
> 	}
>=20
> 	return ret;
> @@ -63,6 +61,12 @@ static u16 esdhc_readw(struct sdhci_host *host, int =
reg)
> 		ret =3D in_be32(host->ioaddr + base) & 0xffff;
> 	else
> 		ret =3D (in_be32(host->ioaddr + base) >> shift) & =
0xffff;
> +
> +	/* T4240-R1.0 had a incorrect vendor version and spec version */
> +	if ((reg =3D=3D SDHCI_HOST_VERSION) &&
> +		((SVR_SOC_VER(svr) =3D=3D SVR_T4240) && (SVR_REV(svr) =3D=3D=
 0x10)))
> +		ret =3D (VENDOR_V_23 << SDHCI_VENDOR_VER_SHIFT) | =
SDHCI_SPEC_200;
> +

is this check correct if this is on v2.0 Si as well?

- k

> 	return ret;
> }
>=20
> @@ -175,17 +179,12 @@ static void esdhc_reset(struct sdhci_host *host, =
u8 mask)
>  */
> static void esdhci_of_adma_workaround(struct sdhci_host *host, u32 =
intmask)
> {
> -	u32 tmp;
> 	bool applicable;
> 	dma_addr_t dmastart;
> 	dma_addr_t dmanow;
>=20
> -	tmp =3D esdhc_readl(host, SDHCI_SLOT_INT_STATUS);
> -	tmp =3D (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
> -
> 	applicable =3D (intmask & SDHCI_INT_DATA_END) &&
> -		(intmask & SDHCI_INT_BLK_GAP) &&
> -		(tmp =3D=3D VENDOR_V_23);
> +		(intmask & SDHCI_INT_BLK_GAP) && (vvn =3D=3D =
VENDOR_V_23);
> 	if (applicable) {
>=20
> 		esdhc_reset(host, SDHCI_RESET_DATA);
> @@ -318,10 +317,9 @@ static void esdhc_of_resume(struct sdhci_host =
*host)
>=20
> static void esdhc_of_platform_init(struct sdhci_host *host)
> {
> -	u32 vvn;
> +	svr =3D mfspr(SPRN_SVR);
> +	vvn =3D esdhc_readw(host, SDHCI_HOST_VERSION);
>=20
> -	vvn =3D in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
> -	vvn =3D (vvn & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
> 	if (vvn =3D=3D VENDOR_V_22)
> 		host->quirks2 |=3D SDHCI_QUIRK2_HOST_NO_CMD23;
>=20
> @@ -390,7 +388,6 @@ static int sdhci_esdhc_probe(struct =
platform_device *pdev)
> 	struct device_node *np;
> 	int ret;
>=20
> -	svr =3D mfspr(SPRN_SVR);
> 	host =3D sdhci_pltfm_init(pdev, &sdhci_esdhc_pdata, 0);
> 	if (IS_ERR(host))
> 		return PTR_ERR(host);
> --=20
> 1.8.0
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
