Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0140.outbound.protection.outlook.com [207.46.100.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E7491A0272
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 10:00:39 +1100 (AEDT)
Message-ID: <1427756416.22867.205.camel@freescale.com>
Subject: Re: [1/4] powerpc/fsl-booke: Add device tree support for
 T1024/T1023 SoC
From: Scott Wood <scottwood@freescale.com>
To: Liu Shengzhou-B36685 <Shengzhou.Liu@freescale.com>
Date: Mon, 30 Mar 2015 18:00:16 -0500
In-Reply-To: <DM2PR03MB398E5EB28719411243C1C76F8F50@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1422517947-28722-1-git-send-email-Shengzhou.Liu@freescale.com>
 <20150130011949.GA19864@home.buserror.net>
 <DM2PR03MB398E5EB28719411243C1C76F8F50@DM2PR03MB398.namprd03.prod.outlook.com>
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

On Mon, 2015-03-30 at 06:08 -0500, Liu Shengzhou-B36685 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, January 30, 2015 9:20 AM
> > To: Liu Shengzhou-B36685
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [1/4] powerpc/fsl-booke: Add device tree support for
> > T1024/T1023 SoC
> > 
> > On Thu, Jan 29, 2015 at 03:52:24PM +0800, Shengzhou Liu wrote:
> > > +	corenet-cf@18000 {
> > > +		compatible = "fsl,corenet2-cf";
> > 
> > While the damage has already been done by the t1040 device tree, this is
> > not 100% compatible with what's on t4240.  I'm not sure if it's worth
> > doing anything about it at this point, given that you can tell the
> > difference by the version register even though that register is reserved
> > on t4240 and simliar chips, which is what I do in
> > http://patchwork.ozlabs.org/patch/419911/
> 
> Now here "fsl,corenet2-cf" is suitable for t1024 after your t1040 patch was merged.
> T1024 and t1040 have the same version of ccf.

I wouldn't call it "suitable", just that there's a workaround for
existing badness.

> > > +/include/ "t1023si-post.dtsi"
> > > +&soc {
> > > +	display:display@180000 {
> > > +		compatible = "fsl,t1024-diu", "fsl,diu";
> > > +		reg = <0x180000 1000>;
> > > +		interrupts = <74 2 0 0>;
> > > +	};
> > > +};
> > 
> > There are other differences between t1023 an t1024.  Where do you
> > describe t1024's QE?  Where do you describe the DDR and IFC differences?
> > can they be detected at runtime?  t1024 supports deep sleep, but t1023
> > doesn't -- yet you label both chips as having t1024 rcpm.
> > 
> As QE IP block has not been upstream yet,

Huh?

arch/powerpc/sysdev/qe_lib/

>  so have to removed QE info in dts currently(same on t1040), 

That's not how it works.

> DDR and IFC differences are in u-boot, not in dts.

The differences are in hardware, which is what the dts is supposed to
describe.

> Both t1023 and t1024 support sleep, so label both chips as having t1024 rcpm.

That's not how it works.

> Only t1024 has deep sleep, the difference is identified in *.c not in dts (confirmed with deep sleep owner). 

Even if the C code chooses to use SVR to identify the difference (why?),
that doesn't mean it's OK for the device tree to contain wrong
information.

-Scott
