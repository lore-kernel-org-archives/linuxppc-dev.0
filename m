Return-Path: <Li.Xiubo@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0140.outbound.protection.outlook.com [207.46.163.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2DBE114009C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 20:52:57 +1100 (EST)
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, Shawn Guo
 <shawn.guo@linaro.org>
Subject: RE: [PATCH v2 2/2] ARM: dts: Append clock bindings for sai2 on
 VF610 platform
Date: Fri, 4 Apr 2014 09:52:48 +0000
Message-ID: <1ce55f756ee04609a2d8ea1f14ad1f3f@BY2PR03MB505.namprd03.prod.outlook.com>
References: <cover.1396432924.git.Guangyu.Chen@freescale.com>
 <d09da3eb629143abd3f61ae037af4ddaf7286a83.1396432924.git.Guangyu.Chen@freescale.com>
 <20140402130302.GC8558@dragon> <20140402133955.GB29440@MrMyself>
In-Reply-To: <20140402133955.GB29440@MrMyself>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "timur@tabi.org" <timur@tabi.org>,
 "broonie@kernel.org" <broonie@kernel.org>, "rob@landley.net" <rob@landley.net>,
 "galak@codeaurora.org" <galak@codeaurora.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Subject: Re: [PATCH v2 2/2] ARM: dts: Append clock bindings for sai2 on V=
F610
> platform
>=20
> Hi Shawn,
>=20
>    Thanks for the comments, but...
>=20
> On Wed, Apr 02, 2014 at 09:03:04PM +0800, Shawn Guo wrote:
> > On Wed, Apr 02, 2014 at 06:10:20PM +0800, Nicolin Chen wrote:
> > > Since we added fours clock to the DT binding, we should update the cu=
rrent
> > > SAI dts/dtsi so as not to break their functions.
> > >
> > > Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
> > > ---
> > >  arch/arm/boot/dts/vf610.dtsi | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.d=
tsi
> > > index d31ce1b..9fd0007 100644
> > > --- a/arch/arm/boot/dts/vf610.dtsi
> > > +++ b/arch/arm/boot/dts/vf610.dtsi
> > > @@ -139,8 +139,10 @@
> > >  				compatible =3D "fsl,vf610-sai";
> > >  				reg =3D <0x40031000 0x1000>;
> > >  				interrupts =3D <0 86 0x04>;
> > > -				clocks =3D <&clks VF610_CLK_SAI2>;
> > > -				clock-names =3D "sai";
> > > +				clocks =3D <&clks VF610_CLK_SAI2>,
> > > +				       <&clks VF610_CLK_SAI2>,
> > > +				       <&clks 0>, <&clks 0>;
> >
> > So it seems that SAI on vf610 does work with only one clock.  So the
> > driver change will break old DTB for vf610?  If that's case, we will
> > have to need a new compatible for cases where 4 clocks are needed.
>=20
> According to Vybrid's RM Chapter 9.11.12 SAI clocking, the SoC actually
> connects SAI with two clocks: SAI_CLK and Platform Bus Clock. So the DT
> binding here still needs to be corrected even if ignoring driver change.
>=20
> Besides, I've checked both SAI on imx and vf610 and found that they are
> seemly identical, especially for the clock part -- "The transmitter and
> receiver can independently select between the bus clock and up to three
> audio master clocks to generate the bit clock." And the driver that was
> designed for vf610 already contains the code to switch the clock between
> Bus Clock and Three MCLKs. What I want to say is, even if SAI on vf610
> does work with only one clock, it still doesn't have the full function
> on vf610 -- driving clock from Platform Bus Clock unless we make this
> improvement to the DT binding.
>=20
> So I think it's fair to complete the code here for both platforms, even
> though we might take the risk of merging conflict. And I understand
> your point to avoid function break on those platform both of us aren't
> convenient to test. But I've already involved Xiubo in the list. And
> we can wait for his test result.
>=20

This has been test on my Vybird-TWR board and it's fine.

Thanks,

Brs
Xiubo



> Hope you can understand the circumstance,
> Nicolin
