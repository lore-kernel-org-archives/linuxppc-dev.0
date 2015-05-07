Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0131.outbound.protection.outlook.com [157.56.111.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D49EF1A0276
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 12:34:59 +1000 (AEST)
Message-ID: <1430966084.16357.335.camel@freescale.com>
Subject: Re: [PATCH] powerpc/dts: Add 1588 timer node for eTSEC
From: Scott Wood <scottwood@freescale.com>
To: Lu Yangbo-B47093 <yangbo.lu@freescale.com>
Date: Wed, 6 May 2015 21:34:44 -0500
In-Reply-To: <BY1PR0301MB119235AB83BDACB911B5B93AF2DF0@BY1PR0301MB1192.namprd03.prod.outlook.com>
References: <1430905256-4930-1-git-send-email-yangbo.lu@freescale.com>
 <1430945040.16357.293.camel@freescale.com>
 <BY1PR0301MB119235AB83BDACB911B5B93AF2DF0@BY1PR0301MB1192.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-05-06 at 21:26 -0500, Lu Yangbo-B47093 wrote:
> Thanks.
> Pls see my comments below.
> 
> -----Original Message-----
> From: Wood Scott-B07421 
> Sent: Thursday, May 07, 2015 4:44 AM
> To: Lu Yangbo-B47093
> Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] powerpc/dts: Add 1588 timer node for eTSEC
> 
> On Wed, 2015-05-06 at 17:40 +0800, Yangbo Lu wrote:
> > Add 1588 timer node in files:
> > arch/powerpc/boot/dts/bsc9131rdb.dtsi
> > arch/powerpc/boot/dts/bsc9132qds.dtsi
> > arch/powerpc/boot/dts/p1010rdb.dtsi
> > arch/powerpc/boot/dts/p1020rdb-pd.dts
> > arch/powerpc/boot/dts/p1021rdb-pc.dtsi
> > arch/powerpc/boot/dts/p1022ds.dtsi
> > arch/powerpc/boot/dts/p1025twr.dtsi
> > arch/powerpc/boot/dts/p2020rdb-pc.dtsi
> > 
> > Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> > ---
> >  arch/powerpc/boot/dts/bsc9131rdb.dtsi  | 12 ++++++++++++  
> > arch/powerpc/boot/dts/bsc9132qds.dtsi  | 12 ++++++++++++
> >  arch/powerpc/boot/dts/p1010rdb.dtsi    | 12 ++++++++++++
> >  arch/powerpc/boot/dts/p1020rdb-pd.dts  | 12 ++++++++++++  
> > arch/powerpc/boot/dts/p1021rdb-pc.dtsi | 12 ++++++++++++
> >  arch/powerpc/boot/dts/p1022ds.dtsi     | 12 ++++++++++++
> >  arch/powerpc/boot/dts/p1025twr.dtsi    | 12 ++++++++++++
> >  arch/powerpc/boot/dts/p2020rdb-pc.dtsi | 15 +++++++++------
> >  8 files changed, 93 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/powerpc/boot/dts/bsc9131rdb.dtsi 
> > b/arch/powerpc/boot/dts/bsc9131rdb.dtsi
> > index 45efcba..629cc03 100644
> > --- a/arch/powerpc/boot/dts/bsc9131rdb.dtsi
> > +++ b/arch/powerpc/boot/dts/bsc9131rdb.dtsi
> > @@ -80,6 +80,18 @@
> >  		status = "disabled";
> >  	};
> >  
> > +	ptp_clock@b0e00 {
> > +		compatible = "fsl,etsec-ptp";
> > +		reg = <0xb0e00 0xb0>;
> > +		interrupts = <68 2 0 0 69 2 0 0>;
> > +		fsl,tclk-period	= <5>;
> > +		fsl,tmr-prsc	= <2>;
> > +		fsl,tmr-add	= <0xcccccccd>;
> > +		fsl,tmr-fiper1	= <0x3b9ac9fb>;
> > +		fsl,tmr-fiper2	= <0x00018696>;
> > +		fsl,max-adj	= <249999999>;
> 
> Please don't use hex for numbers that make more sense as decimal.
> [Lu Yangbo-B47093] The hex value is register value, I think it's better to use hex.

Whether it goes into a register doesn't matter.  Hex values are useful
for values which are subdivided into various bitfields, or whose hex
representation is simpler than decimal.  I'm not familiar with the
details of this hardware, but I doubt the former is the case for
0x3b9ac9fb == 9999999995 or 0x18696 == 99990.

-Scott
