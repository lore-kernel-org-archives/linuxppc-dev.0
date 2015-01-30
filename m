Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0145.outbound.protection.outlook.com [207.46.100.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 66CB01A0D16
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 15:12:26 +1100 (AEDT)
Message-ID: <1422591130.10544.150.camel@freescale.com>
Subject: Re: [PATCH] powerpc/dts: Update platform PLL node
From: Scott Wood <scottwood@freescale.com>
To: Liberman Igal-B31950 <Igal.Liberman@freescale.com>
Date: Thu, 29 Jan 2015 22:12:10 -0600
In-Reply-To: <DM2PR03MB3835E56F8A4080CB764E1FDE64B0@DM2PR03MB383.namprd03.prod.outlook.com>
References: <1421042407-13921-1-git-send-email-igal.liberman@freescale.com>
 <1421739810.4961.207.camel@freescale.com>
 <DM2PR03MB3835E56F8A4080CB764E1FDE64B0@DM2PR03MB383.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Medve
 Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-01-20 at 02:51 -0600, Liberman Igal-B31950 wrote:
> 
> 
> Regaeds,
> Igal Liberman.
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, January 20, 2015 9:44 AM
> > To: Liberman Igal-B31950
> > Cc: linuxppc-dev@lists.ozlabs.org; Medve Emilian-EMMEDVE1
> > Subject: Re: [PATCH] powerpc/dts: Update platform PLL node
> > 
> > On Mon, 2015-01-12 at 08:00 +0200, Igal.Liberman wrote:
> > > From: Igal Liberman <Igal.Liberman@freescale.com>
> > >
> > > Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> > > Change-Id: I92d020651237041d3767aa35e9345439714f9831
> > > ---
> > >  arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi |    6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > Please explain this more.  Was it just wrong before?  Is this for a new chip?  If
> > the latter, what effect does this have on existing chips?
> > 
> 
> It wasn't wrong, however it was missing some clocking options which
> might be used by some hardware accelerators available in T/B devices.
> I need this options for FMan, however it might be used for other
> accelerators too.

If the PLL had a div3 option and it wasn't described by the PLL node,
the node was wrong.

Do all chips that use this file have a div3?

> > > diff --git a/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
> > > b/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
> > > index 48e0b6e..7e1f074 100644
> > > --- a/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
> > > +++ b/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
> > > @@ -49,14 +49,16 @@ global-utilities@e1000 {
> > >  		reg = <0x800 0x4>;
> > >  		compatible = "fsl,qoriq-core-pll-2.0";
> > >  		clocks = <&sysclk>;
> > > -		clock-output-names = "pll0", "pll0-div2", "pll0-div4";
> > > +		clock-output-names = "pll0", "pll0-div2", "pll0-div3",
> > > +				      "pll0-div4";
> > 
> > You're changing the meaning of existing clock index 2.
> > 
> 
> Yes, however this platform PLL is a new work which is not yet used, so we aren't breaking any  functionality.

No, it's the core PLL node which is already in use.  However, it looks
like the driver already interprets clock index 2 differently based on
whether clock index 3 exists.  None of this is mentioned in the binding
document...

-Scott
