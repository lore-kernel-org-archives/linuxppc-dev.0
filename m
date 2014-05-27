Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 238011A05CA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 01:33:32 +1000 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [2/2] powerpc/corenet64_smp_defconfig: enable RTC support
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <a1c1a49caf9f4f2b82b517c5c2d598d1@DM2PR03MB398.namprd03.prod.outlook.com>
Date: Tue, 27 May 2014 10:33:11 -0500
Message-Id: <DA0A87E9-4152-4A7F-9399-20206E13ACFB@kernel.crashing.org>
References: <1400666751-11459-2-git-send-email-Shengzhou.Liu@freescale.com>
 <20140522225144.GA1670@home.buserror.net>
 <474028133ffd49cebfeb951498923caa@DM2PR03MB398.namprd03.prod.outlook.com>
 <1400864771.12823.51.camel@snotra.buserror.net>
 <a1c1a49caf9f4f2b82b517c5c2d598d1@DM2PR03MB398.namprd03.prod.outlook.com>
To: Shengzhou.Liu@freescale.com
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 25, 2014, at 10:08 PM, Shengzhou.Liu@freescale.com wrote:

>=20
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Saturday, May 24, 2014 1:06 AM
>> To: Liu Shengzhou-B36685
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Subject: Re: [2/2] powerpc/corenet64_smp_defconfig: enable RTC =
support
>>=20
>> On Fri, 2014-05-23 at 03:03 -0500, Liu Shengzhou-B36685 wrote:
>>>> -----Original Message-----
>>>> From: Wood Scott-B07421
>>>> Sent: Friday, May 23, 2014 6:52 AM
>>>> To: Liu Shengzhou-B36685
>>>> Cc: linuxppc-dev@lists.ozlabs.org
>>>> Subject: Re: [2/2] powerpc/corenet64_smp_defconfig: enable RTC
>>>> support
>>>>=20
>>>>> +++ b/arch/powerpc/configs/corenet64_smp_defconfig
>>>>> @@ -125,6 +125,11 @@ CONFIG_USB_EHCI_FSL=3Dy  CONFIG_USB_STORAGE=3Dy=

>>>>> CONFIG_MMC=3Dy  CONFIG_MMC_SDHCI=3Dy
>>>>> +CONFIG_RTC_CLASS=3Dy
>>>>> +CONFIG_RTC_DRV_CMOS=3Dy
>>>>> +CONFIG_RTC_DRV_DS1307=3Dy
>>>>> +CONFIG_RTC_DRV_DS1374=3Dy
>>>>> +CONFIG_RTC_DRV_DS3232=3Dy
>>>>> CONFIG_EDAC=3Dy
>>>>> CONFIG_EDAC_MM_EDAC=3Dy
>>>>> CONFIG_DMADEVICES=3Dy
>>>>=20
>>>> Why only corenet64 and not corenet32?
>>>>=20
>>>> -Scott
>>> [Shengzhou] There is already RTC support in corenet32, only missing =
in
>> corenet64.
>>=20
>> Only DS3232, not DS1307 or DS1374.  Which boards use the latter two?
>>=20
>> Why do we need CONFIG_RTC_DRV_CMOS?
>>=20
>> -Scott
>>=20
> [Shengzhou] so far DS1307 and DS1374 occur only on those boards with =
corenet64.=20
> CONFIG_RTC_DRV_CMOS is enabled in mpc85xx_defconfig, =
mpc85xx_smp_defconfig, corenet32_smp_defconfig, etc, here keeps =
consistent in corenet64.
> It seems CONFIG_RTC_DRV_CMOS is not needed on 85xx platform, do we =
need to remove CONFIG_RTC_DRV_CMOS from all 85xx/corenet defconfig? If =
so, I will post a new patch to do it.

The CDS board uses an RTC over ISA if I remember correctly, not sure =
what driver deals with that (if its CONFIG_RTC_DRV_CMOS) or something =
else.

- k=
