Return-Path: <B08248@freescale.com>
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Meador Inge <meador_inge@mentor.com>
Subject: RE: [PATCH 1/2] powerpc: document the MPIC device tree binding
Date: Tue, 18 Jan 2011 20:21:33 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E150306A7A2@039-SN1MPN1-004.039d.mgd.msft.net>
References: <4D34E448.8000902@mentor.com>
	<AANLkTi=QX4BfLvPfQDMOgmh90TtX4MQqio6AOZR8JKas@mail.gmail.com>
In-Reply-To: <AANLkTi=QX4BfLvPfQDMOgmh90TtX4MQqio6AOZR8JKas@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "Blanchard, Hollis" <Hollis_Blanchard@mentor.com>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: Meador Inge <meador_inge@mentor.com>
> Date: Mon, Jan 17, 2011 at 6:52 PM
> Subject: [PATCH 1/2] powerpc: document the MPIC device tree binding
> To: linuxppc-dev@lists.ozlabs.org
> Cc: minge <meador_inge@mentor.com>,
> devicetree-discuss@lists.ozlabs.org, "Blanchard, Hollis"
> <Hollis_Blanchard@mentor.com>
>=20
>=20
> This binding documents several properties that have been in use for quite
> some time, and adds one new property 'no-reset', which controls whether t=
he
> MPIC should be reset during runtime initialization.
>=20
> Signed-off-by: Meador Inge <meador_inge@mentor.com>
> CC: Hollis Blanchard <hollis_blanchard@mentor.com>
> ---
> =A0Documentation/powerpc/dts-bindings/mpic.txt | =A0 78

This is really the binding for an open-pic interrupt controller
and I think the name should reflect that-- open-pic.txt.

> +++++++++++++++++++++++++++
> =A01 files changed, 78 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/powerpc/dts-bindings/mpic.txt
>=20
> diff --git a/Documentation/powerpc/dts-bindings/mpic.txt
> b/Documentation/powerpc/dts-bindings/mpic.txt
> new file mode 100644
> index 0000000..3a67919
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/mpic.txt
> @@ -0,0 +1,78 @@
> +* MPIC Binding
> +
> +This binding specifies what properties and child nodes must be
> +available on the device tree representation of the "MPIC" interrupt
> +controller. =A0This binding is based on the binding defined for Open PIC
> +in [1] and is a superset of that binding.

I think it would be better to base this on the ePAPR binding which
was based on the original chrp binding.  Properties like "name"
and "device_type" are deprecated not being used in flat device trees.

<http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf>

The proposed new properties really should go back into the ePAPR.=20

> +
> +** Required properties:
> +
> + =A0 NOTE: Many of these descriptions were paraphrased from [1] to aid
> + =A0 =A0 =A0 =A0 readability.
> +
> + =A0 - name : Specifies the name of the MPIC.

Drop this.  No DTS files use it.

> + =A0 - device_type : Specifies the device type of this MPIC. =A0The valu=
e
> + of this
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 property shall be "open-pic".

device_type is deprecated, since this is not real open-firmware.  In
practice the kernel is matching on device_type, but we want to move
away from that to match on "compatible", just hasn't been implemented
yet.

> + =A0 - reg : Specifies the base physical address(s) and size(s) of this
> + MPIC's
> + =A0 =A0 =A0 =A0 =A0 addressable register space.
> + =A0 - compatible : Specifies the compatibility list for the MPIC. =A0Th=
e
> + property
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0value shall include "chrp,open-pic".

In the ePAPR we modified this to just "open-pic", because this has
nothing to do with chrp anymore.   I think just "open-pic" is
what we want.

> + =A0 - interrupt-controller : The presence of this property identifies
> + the node
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0as a MPIC. =A0No=
 property value should be
> defined.
> + =A0 - #address-cells : Specifies the number of cells needed to encode a=
n
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0address. =A0The value of thi=
s property shall always
> + be 0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0so that 'interrupt-map' node=
s do not have to
> + specify a
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0parent unit address.
> + =A0 - #interrupt-cells : Specifies the number of cells needed to encode
> + an
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt source.

Should be 2, correct?

> +** Optional properties:
> +
> + =A0 - no-reset : The presence of this property indicates that the MPIC
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0should not be reset during runtime initi=
alization.
> + =A0 - protected-sources : Specifies a list of interrupt sources that ar=
e
> + not
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 available for use and w=
hose corresponding
> + vectors
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 should not be initializ=
ed. =A0A typical use case
> + for
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 this property is in AMP=
 systems where multiple
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 independent operating s=
ystems need to share
> + the MPIC
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 without clobbering each=
 other.

I do think you need to include the definition of interrupt
specifiers here.   Feel free to cut/paste text from my
Freescale mpic binding.

Stuart
