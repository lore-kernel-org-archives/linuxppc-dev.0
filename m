Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0138.outbound.protection.outlook.com [157.56.111.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 53B4E1A0143
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 03:14:56 +1000 (AEST)
Message-ID: <1429118075.22867.719.camel@freescale.com>
Subject: Re: [PATCH] powerpc/dts: Update the core cluster PLL node(s)
From: Scott Wood <scottwood@freescale.com>
To: Liberman Igal-B31950 <Igal.Liberman@freescale.com>
Date: Wed, 15 Apr 2015 12:14:35 -0500
In-Reply-To: <DM2PR03MB3831BEEDD2C17991818FFA9E6E50@DM2PR03MB383.namprd03.prod.outlook.com>
References: <1429005306-24544-1-git-send-email-igal.liberman@freescale.com>
 <1429042868.22867.689.camel@freescale.com>
 <1429042950.22867.690.camel@freescale.com>
 <DM2PR03MB3831BEEDD2C17991818FFA9E6E50@DM2PR03MB383.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-04-15 at 06:07 -0500, Liberman Igal-B31950 wrote:
> 
> 
> Regards,
> Igal Liberman.
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, April 14, 2015 11:23 PM
> > To: Liberman Igal-B31950
> > Cc: devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH] powerpc/dts: Update the core cluster PLL node(s)
> > 
> > On Tue, 2015-04-14 at 15:21 -0500, Scott Wood wrote:
> > > On Tue, 2015-04-14 at 12:55 +0300, Igal.Liberman wrote:
> > > > From: Igal Liberman <Igal.Liberman@freescale.com>
> > > >
> > > > This patch replaces the following:
> > > > 	https://patchwork.ozlabs.org/patch/427664/
> > > >
> > > > This patch is described by the following binding document update:
> > > > 	https://patchwork.ozlabs.org/patch/461150/
> > > >
> > > > Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> > > > ---
> > > >  arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi |    6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
> > > > b/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
> > > > index 48e0b6e..7e1f074 100644
> > > > --- a/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
> > > > +++ b/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
> > > > @@ -49,14 +49,16 @@ global-utilities@e1000 {
> > > >  		reg = <0x800 0x4>;
> > > >  		compatible = "fsl,qoriq-core-pll-2.0";
> > > >  		clocks = <&sysclk>;
> > > > -		clock-output-names = "pll0", "pll0-div2", "pll0-div4";
> > > > +		clock-output-names = "pll0", "pll0-div2", "pll0-div3",
> > > > +				      "pll0-div4";
> > > >  	};
> > > >  	pll1: pll1@820 {
> > > >  		#clock-cells = <1>;
> > > >  		reg = <0x820 0x4>;
> > > >  		compatible = "fsl,qoriq-core-pll-2.0";
> > > >  		clocks = <&sysclk>;
> > > > -		clock-output-names = "pll1", "pll1-div2", "pll1-div4";
> > > > +		clock-output-names = "pll1", "pll1-div2", "pll1-div3",
> > > > +				      "pll1-div4";
> > >
> > > Wait, so if the driver implements the binding you submitted, you'll
> > > break compatibility with these older device trees...
> > >
> > > I think we need to just accept the ugly count-the-clock-names approach
> > > and document it.
> > 
> > Is there any current 2.0 clock consumer that references pll-div4?
> > 
> 
> I looked at T4240 for example, there's a mux node which adds pll-div4 option:
> mux0: mux0@0 {
> 	#clock-cells = <0>;
> 	reg = <0x0 0x4>;
> 	compatible = "fsl,qoriq-core-mux-2.0";
> 	clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
> 		<&pll1 0>, <&pll1 1>, <&pll1 2>,
> 		<&pll2 0>, <&pll2 1>, <&pll2 2>;
> 	clock-names = "pll0", "pll0-div2", "pll0-div4",
> 		"pll1", "pll1-div2", "pll1-div4",
> 		"pll2", "pll2-div2", "pll2-div4";
> 	clock-output-names = "cmux0";
> };
> 
> After this change <&pll0 2> will represent "pll0-div3" and not "pll0-div4".

So this needs to be updated to match -- and it confirms that existing
device trees will be broken if you base the interpretation on compatible
rather than the number of clock-output-names.

-Scott
