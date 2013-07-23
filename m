Return-Path: <B42677@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BE9562C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 12:03:32 +1000 (EST)
From: Zhang Haijun-B42677 <B42677@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 3/4 V2] mmc: esdhc: Correct host version of T4240-R1.0
Date: Tue, 23 Jul 2013 02:03:21 +0000
Message-ID: <99E897753B6F7048BD8CCDB4661D02E13E4903@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1374055891-20703-1-git-send-email-Haijun.Zhang@freescale.com>
 <1374055891-20703-2-git-send-email-Haijun.Zhang@freescale.com>
 <25F3761C-ECFA-4397-A4F0-551BDAEDA4C7@kernel.crashing.org>
In-Reply-To: <25F3761C-ECFA-4397-A4F0-551BDAEDA4C7@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>,
 "cjb@laptop.org" <cjb@laptop.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Thanks.

Regards
Haijun.


> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Monday, July 22, 2013 10:30 PM
> To: Zhang Haijun-B42677
> Cc: linux-mmc@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Wood Scott-
> B07421; cjb@laptop.org; Fleming Andy-AFLEMING; cbouatmailru@gmail.com
> Subject: Re: [PATCH 3/4 V2] mmc: esdhc: Correct host version of T4240-
> R1.0
>=20
>=20
> On Jul 17, 2013, at 5:11 AM, Haijun Zhang wrote:
>=20
> > Vender version and sdhc spec version of T4240-R1.0 is incorrect.
> > The right value should be VVN=3D0x13, SVN =3D 0x1. The wrong version
> > number will break down the ADMA data transfer.
> > This defect only exist in T4240-R1.0. Will be fixed in T4240-R2.0.
> > Also share vvn and svr for public use.
> >
> > Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> > ---
> > changes for V2:
> > 	- Remove broken ADMA quirk.
> > 	- Rebuild patch of  Add quirks to support T4240 board
> >
> > drivers/mmc/host/sdhci-of-esdhc.c | 29 +++++++++++++----------------
> > 1 file changed, 13 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-esdhc.c
> > b/drivers/mmc/host/sdhci-of-esdhc.c
> > index adfaadd..570bca8 100644
> > --- a/drivers/mmc/host/sdhci-of-esdhc.c
> > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> > @@ -26,7 +26,7 @@
> > #define VENDOR_V_22	0x12
> > #define VENDOR_V_23	0x13
> >
> > -static u32 svr;
> > +static u32 svr, vvn;
> >
> > static u32 esdhc_readl(struct sdhci_host *host, int reg) { @@ -43,11
> > +43,9 @@ static u32 esdhc_readl(struct sdhci_host *host, int reg)
> > 	 * For FSL eSDHC, must aligned 4-byte, so use 0xFC to read the
> > 	 * the verdor version number, oxFE is SDHCI_HOST_VERSION.
> > 	 */
> > -	if ((reg =3D=3D SDHCI_CAPABILITIES) && (ret & SDHCI_CAN_DO_ADMA1)) {
> > -		u32 tmp =3D in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
> > -		tmp =3D (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
> > -		if (tmp > VENDOR_V_22)
> > -			ret |=3D SDHCI_CAN_DO_ADMA2;
> > +	if ((reg =3D=3D SDHCI_CAPABILITIES) && (ret & SDHCI_CAN_DO_ADMA1) &&
> > +		(vvn > VENDOR_V_22)) {
> > +		ret |=3D SDHCI_CAN_DO_ADMA2;
> > 	}
> >
> > 	return ret;
> > @@ -63,6 +61,12 @@ static u16 esdhc_readw(struct sdhci_host *host, int
> reg)
> > 		ret =3D in_be32(host->ioaddr + base) & 0xffff;
> > 	else
> > 		ret =3D (in_be32(host->ioaddr + base) >> shift) & 0xffff;
> > +
> > +	/* T4240-R1.0 had a incorrect vendor version and spec version */
> > +	if ((reg =3D=3D SDHCI_HOST_VERSION) &&
> > +		((SVR_SOC_VER(svr) =3D=3D SVR_T4240) && (SVR_REV(svr) =3D=3D 0x10)))
> > +		ret =3D (VENDOR_V_23 << SDHCI_VENDOR_VER_SHIFT) |
> SDHCI_SPEC_200;
> > +
>=20
> is this check correct if this is on v2.0 Si as well?
[Haijun Wrote:] Oh, I forgot to rewrite the description above. This defect =
exist both
on T4-R1.0 and T4-R2.0. I'll send patch v3 to correct this. thanks
>=20
> - k
>=20
> > 	return ret;
> > }
> >
> > @@ -175,17 +179,12 @@ static void esdhc_reset(struct sdhci_host *host,
> > u8 mask)  */ static void esdhci_of_adma_workaround(struct sdhci_host
> > *host, u32 intmask) {
> > -	u32 tmp;
> > 	bool applicable;
> > 	dma_addr_t dmastart;
> > 	dma_addr_t dmanow;
> >
> > -	tmp =3D esdhc_readl(host, SDHCI_SLOT_INT_STATUS);
> > -	tmp =3D (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
> > -
> > 	applicable =3D (intmask & SDHCI_INT_DATA_END) &&
> > -		(intmask & SDHCI_INT_BLK_GAP) &&
> > -		(tmp =3D=3D VENDOR_V_23);
> > +		(intmask & SDHCI_INT_BLK_GAP) && (vvn =3D=3D VENDOR_V_23);
> > 	if (applicable) {
> >
> > 		esdhc_reset(host, SDHCI_RESET_DATA); @@ -318,10 +317,9 @@
> static
> > void esdhc_of_resume(struct sdhci_host *host)
> >
> > static void esdhc_of_platform_init(struct sdhci_host *host) {
> > -	u32 vvn;
> > +	svr =3D mfspr(SPRN_SVR);
> > +	vvn =3D esdhc_readw(host, SDHCI_HOST_VERSION);
> >
> > -	vvn =3D in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
> > -	vvn =3D (vvn & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
> > 	if (vvn =3D=3D VENDOR_V_22)
> > 		host->quirks2 |=3D SDHCI_QUIRK2_HOST_NO_CMD23;
> >
> > @@ -390,7 +388,6 @@ static int sdhci_esdhc_probe(struct platform_device
> *pdev)
> > 	struct device_node *np;
> > 	int ret;
> >
> > -	svr =3D mfspr(SPRN_SVR);
> > 	host =3D sdhci_pltfm_init(pdev, &sdhci_esdhc_pdata, 0);
> > 	if (IS_ERR(host))
> > 		return PTR_ERR(host);
> > --
> > 1.8.0
> >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
