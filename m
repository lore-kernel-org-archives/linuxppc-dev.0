Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1313078831-2511-4-git-send-email-holt@sgi.com>
References: <1313078831-2511-1-git-send-email-holt@sgi.com>
	<1313078831-2511-4-git-send-email-holt@sgi.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Aug 2011 10:53:43 -0600
Message-ID: <CACxGe6vA8K7fhrSvBpKC+9aKftUc2+1EAUQ=A0SmmwzJ2Le=9A@mail.gmail.com>
Subject: Re: [PATCH v11 3/6] flexcan: Fix up fsl-flexcan device tree binding.
To: Robin Holt <holt@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	U Bhaskar-B22300 <B22300@freescale.com>, socketcan-core@lists.berlios.de,
	Scott Wood <scottwood@freescale.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2011 at 10:07 AM, Robin Holt <holt@sgi.com> wrote:
> This patch cleans up the documentation of the device-tree binding for
> the Flexcan devices on Freescale's PowerPC and ARM cores. Extra
> properties are not used by the driver so we are removing them.
>
> Signed-off-by: Robin Holt <holt@sgi.com>
> To: Marc Kleine-Budde <mkl@pengutronix.de>,
> To: Wolfgang Grandegger <wg@grandegger.com>,
> To: U Bhaskar-B22300 <B22300@freescale.com>
> To: Scott Wood <scottwood@freescale.com>
> To: Grant Likely <grant.likely@secretlab.ca>
> To: Kumar Gala <galak@kernel.crashing.org>
> Cc: socketcan-core@lists.berlios.de,
> Cc: netdev@vger.kernel.org,
> Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
> Cc: devicetree-discuss@lists.ozlabs.org
> ---
> =A0.../devicetree/bindings/net/can/fsl-flexcan.txt =A0 =A0| =A0 69 ++++--=
-------------
> =A0arch/powerpc/boot/dts/p1010rdb.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 10 +--
> =A0arch/powerpc/boot/dts/p1010si.dtsi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 10 +--
> =A03 files changed, 21 insertions(+), 68 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/=
Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> index 1a729f0..c78dcbb 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> @@ -1,61 +1,22 @@
> -CAN Device Tree Bindings
> -------------------------
> -2011 Freescale Semiconductor, Inc.
> +Flexcan CAN contoller on Freescale's ARM and PowerPC processors
>
> -fsl,flexcan-v1.0 nodes
> ------------------------
> -In addition to the required compatible-, reg- and interrupt-properties, =
you can
> -also specify which clock source shall be used for the controller.
> +Required properties:
>
> -CPI Clock- Can Protocol Interface Clock
> - =A0 =A0 =A0 This CLK_SRC bit of CTRL(control register) selects the cloc=
k source to
> - =A0 =A0 =A0 the CAN Protocol Interface(CPI) to be either the peripheral=
 clock
> - =A0 =A0 =A0 (driven by the PLL) or the crystal oscillator clock. The se=
lected clock
> - =A0 =A0 =A0 is the one fed to the prescaler to generate the Serial Cloc=
k (Sclock).
> - =A0 =A0 =A0 The PRESDIV field of CTRL(control register) controls a pres=
caler that
> - =A0 =A0 =A0 generates the Serial Clock (Sclock), whose period defines t=
he
> - =A0 =A0 =A0 time quantum used to compose the CAN waveform.
> +- compatible : Should be "fsl,<processor>-flexcan" and "fsl,flexcan"

Don't do this.  "fsl,flexcan" is far too generic.  Be specific to the
soc part number or the ip core implementation version.

>
> -Can Engine Clock Source
> - =A0 =A0 =A0 There are two sources for CAN clock
> - =A0 =A0 =A0 - Platform Clock =A0It represents the bus clock
> - =A0 =A0 =A0 - Oscillator Clock
> + =A0An implementation should also claim any of the following compatibles
> + =A0that it is fully backwards compatible with:
>
> - =A0 =A0 =A0 Peripheral Clock (PLL)
> - =A0 =A0 =A0 --------------
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --------- =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 -------------
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0 =A0 |CPI Clock =A0 =A0 =
=A0 =A0| Prescaler | =A0 =A0 =A0 Sclock
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0 =A0 |---------------->| (=
1.. 256) |------------>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --------- =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 -------------
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0|
> - =A0 =A0 =A0 -------------- =A0---------------------CLK_SRC
> - =A0 =A0 =A0 Oscillator Clock
> + =A0- fsl,p1010-flexcan
>
> -- fsl,flexcan-clock-source : CAN Engine Clock Source.This property selec=
ts
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0the peripheral c=
lock. PLL clock is fed to the
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prescaler to gen=
erate the Serial Clock (Sclock).
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Valid values are=
 "oscillator" and "platform"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"oscillator": CA=
N engine clock source is oscillator clock.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"platform" The C=
AN engine clock source is the bus clock
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(platform clock)=
.
> +- reg : Offset and length of the register set for this device
> +- interrupts : Interrupt tuple for this device
>
> -- fsl,flexcan-clock-divider : for the reference and system clock, an add=
itional
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock divider c=
an be specified.
> -- clock-frequency: frequency required to calculate the bitrate for FlexC=
AN.
> +Example:
>
> -Note:
> - =A0 =A0 =A0 - v1.0 of flexcan-v1.0 represent the IP block version for P=
1010 SOC.
> - =A0 =A0 =A0 - P1010 does not have oscillator as the Clock Source.So the=
 default
> - =A0 =A0 =A0 =A0 Clock Source is platform clock.
> -Examples:
> -
> - =A0 =A0 =A0 can0@1c000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,flexcan-v1.0";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1c000 0x1000>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <48 0x2>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&mpic>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,flexcan-clock-source =3D "platform";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,flexcan-clock-divider =3D <2>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <fixed by u-boot>;
> - =A0 =A0 =A0 };
> + =A0can@1c000 {
> + =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,p1010-flexcan", "fsl,flexcan";
> + =A0 =A0 =A0 =A0 =A0reg =3D <0x1c000 0x1000>;
> + =A0 =A0 =A0 =A0 =A0interrupts =3D <48 0x2>;
> + =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&mpic>;
> + =A0};

The diffstat for this patch looks too big because the whitespace has
changed.  Try to restrict whitespace changes so that the patch is
friendly to reviewers.

g.
