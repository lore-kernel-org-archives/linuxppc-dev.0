Return-Path: <yangbo.lu@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0059.outbound.protection.outlook.com [157.55.234.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qNtcR353BzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Mar 2016 21:03:34 +1100 (AEDT)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: Arnd Bergmann <arnd@arndb.de>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-mmc@vger.kernel.org"
 <linux-mmc@vger.kernel.org>, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>, Zhao Qiang <qiang.zhao@freescale.com>, Russell King
 <linux@arm.linux.org.uk>, Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Joerg Roedel <joro@8bytes.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 Scott Wood <scott.wood@nxp.com>, Rob Herring <robh+dt@kernel.org>, "Claudiu
 Manoil" <claudiu.manoil@freescale.com>, Kumar Gala <galak@codeaurora.org>,
 Yang-Leo Li <leoyang.li@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>
Subject: RE: [v6, 5/5] mmc: sdhci-of-esdhc: fix host version for
 T4240-R1.0-R2.0
Date: Mon, 14 Mar 2016 07:29:26 +0000
Message-ID: <HE1PR04MB0889CE4742B92461A925B9C4F8880@HE1PR04MB0889.eurprd04.prod.outlook.com>
References: <1457518131-11339-1-git-send-email-yangbo.lu@nxp.com>
 <1457518131-11339-6-git-send-email-yangbo.lu@nxp.com>
 <4947024.WeMycs2fID@wuerfel>
In-Reply-To: <4947024.WeMycs2fID@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Monday, March 14, 2016 6:26 AM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: Yangbo Lu; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> clk@vger.kernel.org; linux-i2c@vger.kernel.org; iommu@lists.linux-
> foundation.org; netdev@vger.kernel.org; linux-mmc@vger.kernel.org;
> ulf.hansson@linaro.org; Zhao Qiang; Russell King; Bhupesh Sharma; Joerg
> Roedel; Santosh Shilimkar; Scott Wood; Rob Herring; Claudiu Manoil; Kumar
> Gala; Yang-Leo Li; Xiaobo Xie
> Subject: Re: [v6, 5/5] mmc: sdhci-of-esdhc: fix host version for T4240-
> R1.0-R2.0
>=20
> On Wednesday 09 March 2016 18:08:51 Yangbo Lu wrote:
> > @@ -567,10 +580,20 @@ static void esdhc_init(struct platform_device
> *pdev, struct sdhci_host *host)
> >         struct sdhci_pltfm_host *pltfm_host;
> >         struct sdhci_esdhc *esdhc;
> >         u16 host_ver;
> > +       u32 svr;
> >
> >         pltfm_host =3D sdhci_priv(host);
> >         esdhc =3D sdhci_pltfm_priv(pltfm_host);
> >
> > +       fsl_guts_init();
> > +       svr =3D fsl_guts_get_svr();
> > +       if (svr) {
> > +               esdhc->soc_ver =3D SVR_SOC_VER(svr);
> > +               esdhc->soc_rev =3D SVR_REV(svr);
> > +       } else {
> > +               dev_err(&pdev->dev, "Failed to get SVR value!\n");
> > +       }
> > +
>=20
> This makes the driver non-portable. Better identify the specific
> workarounds based on the compatible string for this device, or add a
> boolean DT property for the quirk.
>=20
> 	Arnd

[Lu Yangbo-B47093] Hi Arnd, we did have a discussion about using DTS in v1 =
before.
https://patchwork.kernel.org/patch/6834221/

We don't have a separate DTS file for each revision of an SOC and if we did=
, we'd constantly have people using the wrong one.
In addition, the device tree is stable ABI and errata are often discovered =
after device tree are deployed.
See the link for details.

So we decide to read SVR from the device-config/guts MMIO block other than =
using DTS.
Thanks.
