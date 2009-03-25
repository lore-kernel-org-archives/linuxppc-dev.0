Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <1237975701-23201-4-git-send-email-wg@grandegger.com>
References: <1237975701-23201-1-git-send-email-wg@grandegger.com>
	<1237975701-23201-2-git-send-email-wg@grandegger.com>
	<1237975701-23201-3-git-send-email-wg@grandegger.com>
	<1237975701-23201-4-git-send-email-wg@grandegger.com>
Date: Wed, 25 Mar 2009 11:48:40 -0600
Message-ID: <fa686aa40903251048g479d63f8i5a715defdbfc33d4@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] powerpc: NAND: FSL UPM: document new bindings
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(cc'ing devicetree-discuss)

On Wed, Mar 25, 2009 at 4:08 AM, Wolfgang Grandegger <wg@grandegger.com> wr=
ote:
> This patch adds documentation for the new NAND FSL UPM bindings for:
>
> =A0NAND: FSL-UPM: add multi chip support
> =A0NAND: FSL-UPM: Add wait flags to support board/chip specific delays
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>

Mostly looks good to me; but some comments below.

> ---
> =A0.../powerpc/dts-bindings/fsl/upm-nand.txt =A0 =A0 =A0 =A0 =A0| =A0 39 =
+++++++++++++++++++-
> =A01 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/powerpc/dts-bindings/fsl/upm-nand.txt b/Docume=
ntation/powerpc/dts-bindings/fsl/upm-nand.txt
> index 84a04d5..0272e70 100644
> --- a/Documentation/powerpc/dts-bindings/fsl/upm-nand.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/upm-nand.txt
> @@ -5,9 +5,22 @@ Required properties:
> =A0- reg : should specify localbus chip select and size used for the chip=
.
> =A0- fsl,upm-addr-offset : UPM pattern offset for the address latch.
> =A0- fsl,upm-cmd-offset : UPM pattern offset for the command latch.
> -- gpios : may specify optional GPIO connected to the Ready-Not-Busy pin.
>
> -Example:
> +Optional properties:
> +- fsl,upm-wait-flags : add chip-dependent short delays after running the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0UPM pattern (0x1), after wri=
ting a data byte (0x2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0or after writing out a buffe=
r (0x4).
> +- gpios : may specify optional GPIOs connected to the Ready-Not-Busy pin=
s
> + =A0 =A0 =A0 =A0 (R/B#). For multi-chip devices, "num-chips" GPIO defini=
tions are
> + =A0 =A0 =A0 =A0 required.
> +- chip-delay : chip dependent delay for transfering data from array to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0read registers (tR). Required if property "g=
pios" is not
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0used (R/B# pins not connected).
> +- num-chips : number of chips per device for multi-chip support.
> +- chip-offset : address offset between chips for multi-chip support. The
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 corresponding address lines are used to sel=
ect the chip.

Since these properties (chip-delay, num-chips and chip-offset) are
currently controller specific, it would probably be a good idea to
prefix 'fsl,' onto them.  That way when common NAND controller
properties start getting defined then there won't be any concern about
conflicting with existing meanings.  If you do see these as properties
that other NAND controllers will use, then maybe a 'nand-' prefix is
appropriate (like the SPI binding in booting-without-of).

For the chip offset, it's not clear what the meaning is.  First, does
the UPM controller support access of multiple chips simultaneously?
If so, then can you elaborate in the description on how board design
translates to a chip-offset value.  If it cannot, then it might be
better to have multiple tuples in the 'reg' property for each discrete
chip.  Multiple reg tuples would also remove the need for the
num-chips property.

Cheers,
g.

> +
> +Examples:
>
> =A0upm@1,0 {
> =A0 =A0 =A0 =A0compatible =3D "fsl,upm-nand";
> @@ -26,3 +39,25 @@ upm@1,0 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> =A0 =A0 =A0 =A0};
> =A0};
> +
> +upm@3,0 {
> + =A0 =A0 =A0 compatible =3D "fsl,upm-nand";
> + =A0 =A0 =A0 reg =3D <3 0x0 0x800>;
> + =A0 =A0 =A0 fsl,upm-addr-offset =3D <0x10>;
> + =A0 =A0 =A0 fsl,upm-cmd-offset =3D <0x08>;
> + =A0 =A0 =A0 fsl,upm-wait-flags =3D <0x5>;
> + =A0 =A0 =A0 /* Multi-chip device */
> + =A0 =A0 =A0 num-chips =3D <2>;
> + =A0 =A0 =A0 chip-offset =3D <0x200>;
> + =A0 =A0 =A0 chip-delay =3D <25>; // in micro-seconds
> +
> + =A0 =A0 =A0 nand@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 partition@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 label =3D "fs";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x00000000=
 0x10000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> +};
> --
> 1.6.0.6
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
