Return-Path: <scott.wood@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0076.outbound.protection.outlook.com [157.56.112.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qP6zY4qWVzDqyC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 06:20:57 +1100 (AEDT)
From: Scott Wood <scott.wood@nxp.com>
To: Yangbo Lu <yangbo.lu@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
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
 Joerg Roedel <joro@8bytes.org>, Santosh Shilimkar <ssantosh@kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>, Claudiu Manoil <claudiu.manoil@freescale.com>,
 Kumar Gala <galak@codeaurora.org>, Yang-Leo Li <leoyang.li@nxp.com>, "Xiaobo
 Xie" <xiaobo.xie@nxp.com>
Subject: Re: [v6, 5/5] mmc: sdhci-of-esdhc: fix host version for
 T4240-R1.0-R2.0
Date: Mon, 14 Mar 2016 17:45:43 +0000
Message-ID: <DB5PR0401MB19286B2D23D07F5C60DB799D91880@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1457518131-11339-1-git-send-email-yangbo.lu@nxp.com>
 <1457518131-11339-6-git-send-email-yangbo.lu@nxp.com>
 <4947024.WeMycs2fID@wuerfel>
 <HE1PR04MB0889CE4742B92461A925B9C4F8880@HE1PR04MB0889.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/14/2016 02:29 AM, Yangbo Lu wrote:=0A=
>> -----Original Message-----=0A=
>> From: Arnd Bergmann [mailto:arnd@arndb.de]=0A=
>> Sent: Monday, March 14, 2016 6:26 AM=0A=
>> To: linuxppc-dev@lists.ozlabs.org=0A=
>> Cc: Yangbo Lu; devicetree@vger.kernel.org; linux-arm-=0A=
>> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-=0A=
>> clk@vger.kernel.org; linux-i2c@vger.kernel.org; iommu@lists.linux-=0A=
>> foundation.org; netdev@vger.kernel.org; linux-mmc@vger.kernel.org;=0A=
>> ulf.hansson@linaro.org; Zhao Qiang; Russell King; Bhupesh Sharma; Joerg=
=0A=
>> Roedel; Santosh Shilimkar; Scott Wood; Rob Herring; Claudiu Manoil; Kuma=
r=0A=
>> Gala; Yang-Leo Li; Xiaobo Xie=0A=
>> Subject: Re: [v6, 5/5] mmc: sdhci-of-esdhc: fix host version for T4240-=
=0A=
>> R1.0-R2.0=0A=
>>=0A=
>> On Wednesday 09 March 2016 18:08:51 Yangbo Lu wrote:=0A=
>>> @@ -567,10 +580,20 @@ static void esdhc_init(struct platform_device=0A=
>> *pdev, struct sdhci_host *host)=0A=
>>>         struct sdhci_pltfm_host *pltfm_host;=0A=
>>>         struct sdhci_esdhc *esdhc;=0A=
>>>         u16 host_ver;=0A=
>>> +       u32 svr;=0A=
>>>=0A=
>>>         pltfm_host =3D sdhci_priv(host);=0A=
>>>         esdhc =3D sdhci_pltfm_priv(pltfm_host);=0A=
>>>=0A=
>>> +       fsl_guts_init();=0A=
>>> +       svr =3D fsl_guts_get_svr();=0A=
>>> +       if (svr) {=0A=
>>> +               esdhc->soc_ver =3D SVR_SOC_VER(svr);=0A=
>>> +               esdhc->soc_rev =3D SVR_REV(svr);=0A=
>>> +       } else {=0A=
>>> +               dev_err(&pdev->dev, "Failed to get SVR value!\n");=0A=
>>> +       }=0A=
>>> +=0A=
>>=0A=
>> This makes the driver non-portable. Better identify the specific=0A=
>> workarounds based on the compatible string for this device, or add a=0A=
>> boolean DT property for the quirk.=0A=
>>=0A=
>> 	Arnd=0A=
> =0A=
> [Lu Yangbo-B47093] Hi Arnd, we did have a discussion about using DTS in v=
1 before.=0A=
> https://patchwork.kernel.org/patch/6834221/=0A=
> =0A=
> We don=92t have a separate DTS file for each revision of an SOC and if we=
 did, we'd constantly have people using the wrong one.=0A=
> In addition, the device tree is stable ABI and errata are often discovere=
d after device tree are deployed.=0A=
> See the link for details.=0A=
> =0A=
> So we decide to read SVR from the device-config/guts MMIO block other tha=
n using DTS.=0A=
> Thanks.=0A=
=0A=
Also note that this driver is already only for fsl-specific hardware,=0A=
and it will still work even if fsl_guts doesn't find anything to bind to=0A=
-- it just wouldn't be able to detect errata based on SVR in that case.=0A=
=0A=
-Scott=0A=
=0A=
