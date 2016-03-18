Return-Path: <scott.wood@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0068.outbound.protection.outlook.com [157.56.112.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qRYct2WTrzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Mar 2016 05:28:13 +1100 (AEDT)
From: Scott Wood <scott.wood@nxp.com>
To: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>
CC: Yangbo Lu <yangbo.lu@nxp.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>, Zhao Qiang <qiang.zhao@freescale.com>, Russell King
 <linux@arm.linux.org.uk>, Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Joerg Roedel
 <joro@8bytes.org>, Kumar Gala <galak@codeaurora.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yang-Leo Li
 <leoyang.li@nxp.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>, Claudiu Manoil <claudiu.manoil@freescale.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [v6, 5/5] mmc: sdhci-of-esdhc: fix host version for
 T4240-R1.0-R2.0
Date: Fri, 18 Mar 2016 18:28:05 +0000
Message-ID: <DB5PR0401MB1928DA88B03970E1EACFB1FF918C0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1457518131-11339-1-git-send-email-yangbo.lu@nxp.com>
 <DB5PR0401MB19286B2D23D07F5C60DB799D91880@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <20160317170101.GA21009@rob-hp-laptop> <3706958.XeRFmKM0K5@wuerfel>
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

On 03/17/2016 12:06 PM, Arnd Bergmann wrote:=0A=
> On Thursday 17 March 2016 12:01:01 Rob Herring wrote:=0A=
>> On Mon, Mar 14, 2016 at 05:45:43PM +0000, Scott Wood wrote:=0A=
> =0A=
>>>>> This makes the driver non-portable. Better identify the specific=0A=
>>>>> workarounds based on the compatible string for this device, or add a=
=0A=
>>>>> boolean DT property for the quirk.=0A=
>>>>>=0A=
>>>>>    Arnd=0A=
>>>>=0A=
>>>> [Lu Yangbo-B47093] Hi Arnd, we did have a discussion about using DTS i=
n v1 before.=0A=
>>>> https://patchwork.kernel.org/patch/6834221/=0A=
>>>>=0A=
>>>> We don=92t have a separate DTS file for each revision of an SOC and if=
 we did, we'd constantly have people using the wrong one.=0A=
>>>> In addition, the device tree is stable ABI and errata are often discov=
ered after device tree are deployed.=0A=
>>>> See the link for details.=0A=
>>>>=0A=
>>>> So we decide to read SVR from the device-config/guts MMIO block other =
than using DTS.=0A=
>>>> Thanks.=0A=
>>>=0A=
>>> Also note that this driver is already only for fsl-specific hardware,=
=0A=
>>> and it will still work even if fsl_guts doesn't find anything to bind t=
o=0A=
>>> -- it just wouldn't be able to detect errata based on SVR in that case.=
=0A=
>>=0A=
>> IIRC, it is the same IP block as i.MX and Arnd's point is this won't =0A=
>> even compile on !PPC. It is things like this that prevent sharing the =
=0A=
>> driver.=0A=
=0A=
The whole point of using the MMIO SVR instead of the PPC SPR is so that=0A=
it will work on ARM...  The guts driver should build on any platform as=0A=
long as OF is enabled, and if it doesn't find a node to bind to it will=0A=
return 0 for SVR, and the eSDHC driver will continue (after printing an=0A=
error that should be removed) without the ability to test for errata=0A=
based on SVR.=0A=
=0A=
> I think the first four patches take care of building for ARM,=0A=
> but the problem remains if you want to enable COMPILE_TEST as=0A=
> we need for certain automated checking.=0A=
=0A=
What specific problem is there with COMPILE_TEST?=0A=
=0A=
>> Dealing with Si revs is a common problem. We should have a =0A=
>> common solution. There is soc_device for this purpose.=0A=
> =0A=
> Exactly. The last time this came up, I think we agreed to implement a=0A=
> helper using glob_match() on the soc_device strings. Unfortunately=0A=
> this hasn't happened then, but I'd still prefer that over yet another=0A=
> vendor-specific way of dealing with the generic issue.=0A=
=0A=
soc_device would require encoding the SVR as a string and then decoding=0A=
the string, which is more complicated and error prone than having=0A=
platform-specific code test a platform-specific number.  And when would=0A=
it get registered on arm64, which doesn't have platform code?=0A=
=0A=
-Scott=0A=
=0A=
