Return-Path: <yangbo.lu@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0055.outbound.protection.outlook.com [157.56.112.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0qg96lNNzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 19:41:41 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: Arnd Bergmann <arnd@arndb.de>, Scott Wood <oss@buserror.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Russell King
 <linux@arm.linux.org.uk>, Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Joerg Roedel <joro@8bytes.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 Yang-Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>, "Claudiu
 Manoil" <claudiu.manoil@freescale.com>, Kumar Gala <galak@codeaurora.org>,
 Xiaobo Xie <xiaobo.xie@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>
Subject: RE: [v10, 7/7] mmc: sdhci-of-esdhc: fix host version for
 T4240-R1.0-R2.0
Date: Thu, 5 May 2016 09:41:32 +0000
Message-ID: <HE1PR04MB0889B52134A43C0E7A452B7BF87C0@HE1PR04MB0889.eurprd04.prod.outlook.com>
References: <1462417950-46796-1-git-send-email-yangbo.lu@nxp.com>
 <1462417950-46796-8-git-send-email-yangbo.lu@nxp.com>
 <4448030.Zs8fVnr3nm@wuerfel>
In-Reply-To: <4448030.Zs8fVnr3nm@wuerfel>
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

Hi Arnd,


> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Thursday, May 05, 2016 4:32 PM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: Yangbo Lu; linux-mmc@vger.kernel.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> linux-clk@vger.kernel.org; linux-i2c@vger.kernel.org; iommu@lists.linux-
> foundation.org; netdev@vger.kernel.org; Mark Rutland;
> ulf.hansson@linaro.org; Russell King; Bhupesh Sharma; Joerg Roedel;
> Santosh Shilimkar; Yang-Leo Li; Scott Wood; Rob Herring; Claudiu Manoil;
> Kumar Gala; Xiaobo Xie; Qiang Zhao
> Subject: Re: [v10, 7/7] mmc: sdhci-of-esdhc: fix host version for T4240-
> R1.0-R2.0
>=20
> On Thursday 05 May 2016 11:12:30 Yangbo Lu wrote:
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
> >
>=20
>=20
> Sorry for jumping in again after not participating in the discussion for
> the past few versions.
>=20
> What happened to my suggestion of making this a platform-independent
> interface to avoid the link time dependency?
>=20
> Specifically, why not add an exported function to drivers/base/soc.c that
> uses glob_match() for comparing a string in the device driver to the ID
> of the SoC that is set by whatever SoC identifying driver the platform
> has?
>=20
> 	Arnd

[Lu Yangbo-B47093] I think this has been discussed in v6.
You can find Scott's comments about this in below link.
https://patchwork.kernel.org/patch/8544501/

Thanks.
