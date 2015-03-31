Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0141.outbound.protection.outlook.com [157.56.110.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19BCA1A0058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 14:37:31 +1100 (AEDT)
Message-ID: <1427773038.22867.218.camel@freescale.com>
Subject: Re: [1/4] powerpc/fsl-booke: Add device tree support for
 T1024/T1023 SoC
From: Scott Wood <scottwood@freescale.com>
To: Liu Shengzhou-B36685 <Shengzhou.Liu@freescale.com>
Date: Mon, 30 Mar 2015 22:37:18 -0500
In-Reply-To: <DM2PR03MB398FAC6511FC9B94CEC4B03F8F40@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1422517947-28722-1-git-send-email-Shengzhou.Liu@freescale.com>
 <20150130011949.GA19864@home.buserror.net>
 <DM2PR03MB398E5EB28719411243C1C76F8F50@DM2PR03MB398.namprd03.prod.outlook.com>
 <1427756416.22867.205.camel@freescale.com>
 <DM2PR03MB398FAC6511FC9B94CEC4B03F8F40@DM2PR03MB398.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-30 at 22:32 -0500, Liu Shengzhou-B36685 wrote:
> > > > There are other differences between t1023 an t1024.  Where do you
> > > > describe t1024's QE?  Where do you describe the DDR and IFC differences?
> > > > can they be detected at runtime?  t1024 supports deep sleep, but
> > > > t1023 doesn't -- yet you label both chips as having t1024 rcpm.
> > > >
> > > As QE IP block has not been upstream yet, 
> > Huh? 
> > arch/powerpc/sysdev/qe_lib/
> 
> arch/powerpc/boot/dts/fsl/qoriq-tdm1.0.dtsi has not been upstream by TDM owner.
> Ok, I will first send qoriq-tdm1.0.dtsi upstream in order to include QE in t1024 dts.

Thanks, but make sure there's also a binding for it.

> > > DDR and IFC differences are in u-boot, not in dts. 
> > The differences are in hardware, which is what the dts is supposed to describe.
> 
> Theoretically I think so, but not all hardware details must be described in dts

No, but all hardware should be properly identified.

> as current IP driver doesn't take care of it from dts.

The device tree describes the hardware, not the driver.

> If so, IP owners will have to update drivers, for now let's keep as it's.    

Please don't use the phrase "IP owner" in upstream discussions.  Besides
being a bad name for "maintainer", SDK maintainership isn't relevant
here.

> > > Both t1023 and t1024 support sleep, so label both chips as having t1024 rcpm.
> > 
> > That's not how it works.
> > 
> > > Only t1024 has deep sleep, the difference is identified in *.c not in dts (confirmed with deep sleep owner).
> > 
> > Even if the C code chooses to use SVR to identify the difference (why?),
> > that doesn't mean it's OK for the device tree to contain wrong information.
>  
> Where is the wrong information?
> 
>         rcpm: global-utilities@e2000 {
>                 compatible = "fsl,t1024-rcpm", "fsl,qoriq-rcpm-2.0";
>                 reg = <0xe2000 0x1000>;
>         };
> 
>         sdhc@114000 {
>                 compatible = "fsl,t1024-esdhc", "fsl,esdhc";
>                 fsl,iommu-parent = <&pamu0>;
>                 fsl,liodn-reg = <&guts 0x530>; /* eSDHCLIODNR */
>                 sdhci,auto-cmd12;
>                 no-1-8-v;
>                 sleep = <&rcpm 0x00000080>;
>         };
> t1023 also supports sleep(not deep sleep), it needs the info above.

The part that's wrong is where it says "t1024".  It's not t1024 and for
rcpm it's not 100% compatible with t1024.

-Scott
