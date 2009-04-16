Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <1239883865-17915-1-git-send-email-sr@denx.de>
References: <1239883865-17915-1-git-send-email-sr@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 16 Apr 2009 07:23:10 -0600
Message-ID: <fa686aa40904160623j1cc734a7qefe3c576f02f2042@mail.gmail.com>
Subject: Re: [PATCH 3/3 v3] mtd/powerpc: Describe multiple "reg" tuples usage
To: Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 16, 2009 at 6:11 AM, Stefan Roese <sr@denx.de> wrote:
> Signed-off-by: Stefan Roese <sr@denx.de>
> CC: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

I'll pick this one up too.

> ---
> Changes in ver3:
> - Removed reference to Intel P30 parts
> - Added exact chip compatible property for best practice.
>
> =A0Documentation/powerpc/dts-bindings/mtd-physmap.txt | =A0 19 ++++++++++=
++++++++-
> =A01 files changed, 18 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/powerpc/dts-bindings/mtd-physmap.txt b/Documen=
tation/powerpc/dts-bindings/mtd-physmap.txt
> index cd474f9..667c9bd 100644
> --- a/Documentation/powerpc/dts-bindings/mtd-physmap.txt
> +++ b/Documentation/powerpc/dts-bindings/mtd-physmap.txt
> @@ -5,7 +5,9 @@ file systems on embedded devices.
>
> =A0- compatible : should contain the specific model of flash chip(s)
> =A0 =A0used, if known, followed by either "cfi-flash" or "jedec-flash"
> - - reg : Address range of the flash chip
> + - reg : Address range(s) of the flash chip(s)
> + =A0 It's possible to (optionally) define multiple "reg" tuples so that
> + =A0 non-identical NOR chips can be described in one flash node.
> =A0- bank-width : Width (in bytes) of the flash bank. =A0Equal to the
> =A0 =A0device width times the number of interleaved chips.
> =A0- device-width : (optional) Width of a single flash chip. =A0If
> @@ -61,3 +63,18 @@ Example:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0read-only;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> =A0 =A0 =A0 =A0};
> +
> +Here an example with multiple "reg" tuples:
> +
> + =A0 =A0 =A0 flash@f0000000,0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "intel,PC48F4400P0VB", "cfi-=
flash";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0 0x00000000 0x02000000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 0x02000000 0x02000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank-width =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 partition@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 label =3D "test-part1";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0 0x04000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> --
> 1.6.2.3
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
