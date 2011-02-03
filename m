Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1296697900-14004-3-git-send-email-meador_inge@mentor.com>
References: <1296697900-14004-1-git-send-email-meador_inge@mentor.com>
	<1296697900-14004-3-git-send-email-meador_inge@mentor.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 3 Feb 2011 08:56:51 -0700
Message-ID: <AANLkTinVak_ukf0wP8=zbGTq8ENV4d88hNuzW_tqvCFf@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] powerpc: document the Open PIC device tree binding
To: Meador Inge <meador_inge@mentor.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 2, 2011 at 6:51 PM, Meador Inge <meador_inge@mentor.com> wrote:
> This binding documents several properties that have been in use for quite
> some time, and adds one new property 'no-reset', which controls whether t=
he
> Open PIC should be reset during runtime initialization.
>
> The general formatting and interrupt specifier definition is based off of
> Stuart Yoder's FSL MPIC binding.
>
> Signed-off-by: Meador Inge <meador_inge@mentor.com>
> CC: Hollis Blanchard <hollis_blanchard@mentor.com>
> CC: Stuart Yoder <stuart.yoder@freescale.com>
> ---
> =A0Documentation/powerpc/dts-bindings/open-pic.txt | =A0115 +++++++++++++=
++++++++++
> =A01 files changed, 115 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/powerpc/dts-bindings/open-pic.txt
>
> diff --git a/Documentation/powerpc/dts-bindings/open-pic.txt b/Documentat=
ion/powerpc/dts-bindings/open-pic.txt
> new file mode 100644
> index 0000000..447ef65
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/open-pic.txt
> @@ -0,0 +1,115 @@
> +* Open PIC Binding
> +
> +This binding specifies what properties must be available in the device t=
ree
> +representation of an Open PIC compliant interrupt controller. =A0This bi=
nding is
> +based on the binding defined for Open PIC in [1] and is a superset of th=
at
> +binding.
> +
> +PROPERTIES
> +
> + =A0NOTE: Many of these descriptions were paraphrased here from [1] to a=
id
> + =A0 =A0 =A0 =A0readability.
> +
> + =A0- compatible
> + =A0 =A0 =A0Usage: required
> + =A0 =A0 =A0Value type: <string>
> + =A0 =A0 =A0Definition: Specifies the compatibility list for the PIC. =
=A0The
> + =A0 =A0 =A0 =A0 =A0property value shall include "open-pic".
> +
> + =A0- reg
> + =A0 =A0 =A0Usage: required
> + =A0 =A0 =A0Value type: <prop-encoded-array>
> + =A0 =A0 =A0Definition: Specifies the base physical address(s) and size(=
s) of this
> + =A0 =A0 =A0 =A0 =A0PIC's addressable register space.
> +
> + =A0- interrupt-controller
> + =A0 =A0 =A0Usage: required
> + =A0 =A0 =A0Value type: <empty>
> + =A0 =A0 =A0Definition: The presence of this property identifies the nod=
e
> + =A0 =A0 =A0 =A0 =A0as an Open PIC. =A0No property value should be defin=
ed.
> +
> + =A0- #interrupt-cells
> + =A0 =A0 =A0Usage: required
> + =A0 =A0 =A0Value type: <u32>
> + =A0 =A0 =A0Definition: Specifies the number of cells needed to encode a=
n
> + =A0 =A0 =A0 =A0 =A0interrupt source. =A0Shall be 2.
> +
> + =A0- #address-cells
> + =A0 =A0 =A0Usage: required
> + =A0 =A0 =A0Value type: <u32>
> + =A0 =A0 =A0Definition: Specifies the number of cells needed to encode a=
n
> + =A0 =A0 =A0 =A0 =A0address. =A0The value of this property shall always =
be 0.
> + =A0 =A0 =A0 =A0 =A0As such, 'interrupt-map' nodes do not have to specif=
y a
> + =A0 =A0 =A0 =A0 =A0parent unit address.
> +
> + =A0- no-reset
> + =A0 =A0 =A0Usage: optional
> + =A0 =A0 =A0Value type: <empty>
> + =A0 =A0 =A0Definition: The presence of this property indicates that the=
 PIC
> + =A0 =A0 =A0 =A0 =A0should not be reset during runtime initialization. =
=A0The presence of
> + =A0 =A0 =A0 =A0 =A0this property also mandates that any initialization =
related to
> + =A0 =A0 =A0 =A0 =A0interrupt sources shall be limited to sources explic=
itly referenced
> + =A0 =A0 =A0 =A0 =A0in the device tree.

Please follow the lead set by the other binding documentation which is
more concise and tends to be of the form:

    Required properties:
        - reg : <description>
        - interrupt-controller : <description>

    Optional Properties:
        - no-reset : blah

I'm considering formalizing the binding format so that fully specified
and cross-referenced documentation can be generated from the bindings
directory.

Also, to avoid the potential of a future namespace collision, it would
not be a bad idea to name this openpic-no-reset or something that
makes it clear that this is a binding specific property.  "no-reset"
sounds generic enough to give me pause.

> +
> +INTERRUPT SPECIFIER DEFINITION
> +
> + =A0Interrupt specifiers consists of 2 cells encoded as
> + =A0follows:
> +
> + =A0 <1st-cell> =A0 interrupt-number
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Identifies the interrupt source.
> +
> + =A0 <2nd-cell> =A0 level-sense information, encoded as follows:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 =3D low-to-high edge triggered
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01 =3D active low level-sensitive
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02 =3D active high level-sensitiv=
e
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03 =3D high-to-low edge triggered
> +
> +EXAMPLE 1
> +
> + =A0 =A0/*
> + =A0 =A0 * An Open PIC interrupt controller
> + =A0 =A0 */
> + =A0 =A0 =A0 mpic: pic@40000 {
> + =A0 =A0 =A0 =A0// This is an interrupt controller node.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-controller;
> +
> + =A0 =A0 =A0 =A0// No address cells so that 'interrupt-map' nodes which =
reference
> + =A0 =A0 =A0 =A0// this Open PIC node do not need a parent address speci=
fier.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <0>;
> +
> + =A0 =A0 =A0 =A0// Two cells to encode interrupt sources.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-cells =3D <2>;
> +
> + =A0 =A0 =A0 =A0// Offset address of 0x40000 and size of 0x40000.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x40000 0x40000>;
> +
> + =A0 =A0 =A0 =A0// Compatible with Open PIC.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "open-pic";
> +
> + =A0 =A0 =A0 =A0// The PIC should not be reset.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 no-reset;
> + =A0 =A0 =A0 };
> +
> +EXAMPLE 2
> +
> + =A0 =A0/*
> + =A0 =A0 * An interrupt generating device that is wired to an Open PIC.
> + =A0 =A0 */
> + =A0 =A0serial0: serial@4500 {
> + =A0 =A0 =A0 =A0// Interrupt source '42' that is active high level-sensi=
tive.
> + =A0 =A0 =A0 =A0// Note that there are only two cells as specified in th=
e interrupt
> + =A0 =A0 =A0 =A0// parent's '#interrupt-cells' property.
> + =A0 =A0 =A0 =A0interrupts =3D <42 2>;
> +
> + =A0 =A0 =A0 =A0// The interrupt controller that this device is wired to=
.
> + =A0 =A0 =A0 =A0interrupt-parent =3D <&mpic>;
> + =A0 =A0};
> +
> +REFERENCES
> +
> +[1] Power.org (TM) Standard for Embedded Power Architecture (TM) Platfor=
m
> + =A0 =A0Requirements (ePAPR), Version 1.0, July 2008.
> + =A0 =A0(http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v=
1.0.pdf)
> +
> --
> 1.6.3.3
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
