Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D999C1A05CA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 02:21:41 +1000 (EST)
Message-ID: <1401207688.6603.9.camel@snotra.buserror.net>
Subject: Re: [2/2] powerpc/corenet64_smp_defconfig: enable RTC support
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Tue, 27 May 2014 11:21:28 -0500
In-Reply-To: <DA0A87E9-4152-4A7F-9399-20206E13ACFB@kernel.crashing.org>
References: <1400666751-11459-2-git-send-email-Shengzhou.Liu@freescale.com>
 <20140522225144.GA1670@home.buserror.net>
 <474028133ffd49cebfeb951498923caa@DM2PR03MB398.namprd03.prod.outlook.com>
 <1400864771.12823.51.camel@snotra.buserror.net>
 <a1c1a49caf9f4f2b82b517c5c2d598d1@DM2PR03MB398.namprd03.prod.outlook.com>
 <DA0A87E9-4152-4A7F-9399-20206E13ACFB@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Shengzhou.Liu@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-05-27 at 10:33 -0500, Kumar Gala wrote:
> On May 25, 2014, at 10:08 PM, Shengzhou.Liu@freescale.com wrote:
> 
> > 
> >> -----Original Message-----
> >> From: Wood Scott-B07421
> >> Sent: Saturday, May 24, 2014 1:06 AM
> >> To: Liu Shengzhou-B36685
> >> Cc: linuxppc-dev@lists.ozlabs.org
> >> Subject: Re: [2/2] powerpc/corenet64_smp_defconfig: enable RTC support
> >> 
> >> On Fri, 2014-05-23 at 03:03 -0500, Liu Shengzhou-B36685 wrote:
> >>>> -----Original Message-----
> >>>> From: Wood Scott-B07421
> >>>> Sent: Friday, May 23, 2014 6:52 AM
> >>>> To: Liu Shengzhou-B36685
> >>>> Cc: linuxppc-dev@lists.ozlabs.org
> >>>> Subject: Re: [2/2] powerpc/corenet64_smp_defconfig: enable RTC
> >>>> support
> >>>> 
> >>>>> +++ b/arch/powerpc/configs/corenet64_smp_defconfig
> >>>>> @@ -125,6 +125,11 @@ CONFIG_USB_EHCI_FSL=y  CONFIG_USB_STORAGE=y
> >>>>> CONFIG_MMC=y  CONFIG_MMC_SDHCI=y
> >>>>> +CONFIG_RTC_CLASS=y
> >>>>> +CONFIG_RTC_DRV_CMOS=y
> >>>>> +CONFIG_RTC_DRV_DS1307=y
> >>>>> +CONFIG_RTC_DRV_DS1374=y
> >>>>> +CONFIG_RTC_DRV_DS3232=y
> >>>>> CONFIG_EDAC=y
> >>>>> CONFIG_EDAC_MM_EDAC=y
> >>>>> CONFIG_DMADEVICES=y
> >>>> 
> >>>> Why only corenet64 and not corenet32?
> >>>> 
> >>>> -Scott
> >>> [Shengzhou] There is already RTC support in corenet32, only missing in
> >> corenet64.
> >> 
> >> Only DS3232, not DS1307 or DS1374.  Which boards use the latter two?
> >> 
> >> Why do we need CONFIG_RTC_DRV_CMOS?
> >> 
> >> -Scott
> >> 
> > [Shengzhou] so far DS1307 and DS1374 occur only on those boards with corenet64. 

Which boards?  I don't see them in any corenet dts files.  I do see some
instances of ds1374 in the dts files of boards non-corenet mpc85xx
boards (mpc8568mds, mpc8569mds, and p1021mds), yet it's not in the
mpc85xx_defconfig or mpc85xx_smp_defconfig.

> > CONFIG_RTC_DRV_CMOS is enabled in mpc85xx_defconfig, mpc85xx_smp_defconfig, corenet32_smp_defconfig, etc, here keeps consistent in corenet64.
> > It seems CONFIG_RTC_DRV_CMOS is not needed on 85xx platform, do we need to remove CONFIG_RTC_DRV_CMOS from all 85xx/corenet defconfig? If so, I will post a new patch to do it.
> 
> The CDS board uses an RTC over ISA if I remember correctly, not sure what driver deals with that (if its CONFIG_RTC_DRV_CMOS) or something else.

If it's just CDS then we don't need it in either corenet config.

-Scott
