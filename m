Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <1239883857-17860-1-git-send-email-sr@denx.de>
References: <1239883857-17860-1-git-send-email-sr@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 16 Apr 2009 07:01:25 -0600
Message-ID: <fa686aa40904160601v451113e3nb6b31f1680ac51d0@mail.gmail.com>
Subject: Re: [PATCH 2/3 v3] mtd/powerpc: Factor out MTD physmap bindings into
	mtd-physmap.txt
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

Looks good, I'll pick this up

g.

On Thu, Apr 16, 2009 at 6:10 AM, Stefan Roese <sr@denx.de> wrote:
> It's easier to find bindings descriptions in separate files. So let's fac=
tor out
> the MTD physmap bindings into Documentation/powerpc/dts-bindings/mtd-phys=
map.txt
> to not clutter booting-without-of.txt more.
>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> Changes in ver3:
> - Added short patch desciption to commit message.
>
> =A0Documentation/powerpc/booting-without-of.txt =A0 =A0 =A0 | =A0 89 +++-=
----------------
> =A0Documentation/powerpc/dts-bindings/mtd-physmap.txt | =A0 63 ++++++++++=
++++
> =A02 files changed, 75 insertions(+), 77 deletions(-)
> =A0create mode 100644 Documentation/powerpc/dts-bindings/mtd-physmap.txt
>
> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation=
/powerpc/booting-without-of.txt
> index 0ab0230..d16b7a1 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -43,12 +43,11 @@ Table of Contents
> =A0 =A0 2) Representing devices without a current OF specification
> =A0 =A0 =A0 a) PHY nodes
> =A0 =A0 =A0 b) Interrupt controllers
> - =A0 =A0 =A0c) CFI or JEDEC memory-mapped NOR flash
> - =A0 =A0 =A0d) 4xx/Axon EMAC ethernet nodes
> - =A0 =A0 =A0e) Xilinx IP cores
> - =A0 =A0 =A0f) USB EHCI controllers
> - =A0 =A0 =A0g) MDIO on GPIOs
> - =A0 =A0 =A0h) SPI busses
> + =A0 =A0 =A0c) 4xx/Axon EMAC ethernet nodes
> + =A0 =A0 =A0d) Xilinx IP cores
> + =A0 =A0 =A0e) USB EHCI controllers
> + =A0 =A0 =A0f) MDIO on GPIOs
> + =A0 =A0 =A0g) SPI busses
>
> =A0 VII - Marvell Discovery mv64[345]6x System Controller chips
> =A0 =A0 1) The /system-controller node
> @@ -999,7 +998,7 @@ compatibility.
> =A0 =A0 =A0 translation of SOC addresses for memory mapped SOC registers.
> =A0 =A0 - bus-frequency: Contains the bus frequency for the SOC node.
> =A0 =A0 =A0 Typically, the value of this field is filled in by the boot
> - =A0 =A0 =A0loader.
> + =A0 =A0 =A0loader.
>
>
> =A0 Recommended properties:
> @@ -1287,71 +1286,7 @@ platforms are moved over to use the flattened-devi=
ce-tree model.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "open-pic";
> =A0 =A0 =A0 =A0};
>
> - =A0 c) CFI or JEDEC memory-mapped NOR flash
> -
> - =A0 =A0Flash chips (Memory Technology Devices) are often used for solid=
 state
> - =A0 =A0file systems on embedded devices.
> -
> - =A0 =A0 - compatible : should contain the specific model of flash chip(=
s)
> - =A0 =A0 =A0 used, if known, followed by either "cfi-flash" or "jedec-fl=
ash"
> - =A0 =A0 - reg : Address range of the flash chip
> - =A0 =A0 - bank-width : Width (in bytes) of the flash bank. =A0Equal to =
the
> - =A0 =A0 =A0 device width times the number of interleaved chips.
> - =A0 =A0 - device-width : (optional) Width of a single flash chip. =A0If
> - =A0 =A0 =A0 omitted, assumed to be equal to 'bank-width'.
> - =A0 =A0 - #address-cells, #size-cells : Must be present if the flash ha=
s
> - =A0 =A0 =A0 sub-nodes representing partitions (see below). =A0In this c=
ase
> - =A0 =A0 =A0 both #address-cells and #size-cells must be equal to 1.
> -
> - =A0 =A0For JEDEC compatible devices, the following additional propertie=
s
> - =A0 =A0are defined:
> -
> - =A0 =A0 - vendor-id : Contains the flash chip's vendor id (1 byte).
> - =A0 =A0 - device-id : Contains the flash chip's device id (1 byte).
> -
> - =A0 =A0In addition to the information on the flash bank itself, the
> - =A0 =A0device tree may optionally contain additional information
> - =A0 =A0describing partitions of the flash address space. =A0This can be
> - =A0 =A0used on platforms which have strong conventions about which
> - =A0 =A0portions of the flash are used for what purposes, but which don'=
t
> - =A0 =A0use an on-flash partition table such as RedBoot.
> -
> - =A0 =A0Each partition is represented as a sub-node of the flash device.
> - =A0 =A0Each node's name represents the name of the corresponding
> - =A0 =A0partition of the flash device.
> -
> - =A0 =A0Flash partitions
> - =A0 =A0 - reg : The partition's offset and size within the flash bank.
> - =A0 =A0 - label : (optional) The label / name for this flash partition.
> - =A0 =A0 =A0 If omitted, the label is taken from the node name (excludin=
g
> - =A0 =A0 =A0 the unit address).
> - =A0 =A0 - read-only : (optional) This parameter, if present, is a hint =
to
> - =A0 =A0 =A0 Linux that this flash partition should only be mounted
> - =A0 =A0 =A0 read-only. =A0This is usually used for flash partitions
> - =A0 =A0 =A0 containing early-boot firmware images or data which should =
not
> - =A0 =A0 =A0 be clobbered.
> -
> - =A0 =A0Example:
> -
> - =A0 =A0 =A0 flash@ff000000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "amd,am29lv128ml", "cfi-flas=
h";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <ff000000 01000000>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank-width =3D <4>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 device-width =3D <1>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fs@0 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 label =3D "fs";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0 f80000>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 firmware@f80000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 label =3D"firmware";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <f80000 80000>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read-only;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> - =A0 =A0 =A0 };
> -
> - =A0 =A0d) 4xx/Axon EMAC ethernet nodes
> + =A0 =A0c) 4xx/Axon EMAC ethernet nodes
>
> =A0 =A0 The EMAC ethernet controller in IBM and AMCC 4xx chips, and also
> =A0 =A0 the Axon bridge. =A0To operate this needs to interact with a ths
> @@ -1499,7 +1434,7 @@ platforms are moved over to use the flattened-devic=
e-tree model.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 available.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 For Axon: 0x0000012a
>
> - =A0 e) Xilinx IP cores
> + =A0 d) Xilinx IP cores
>
> =A0 =A0The Xilinx EDK toolchain ships with a set of IP cores (devices) fo=
r use
> =A0 =A0in Xilinx Spartan and Virtex FPGAs. =A0The devices cover the whole=
 range
> @@ -1761,7 +1696,7 @@ platforms are moved over to use the flattened-devic=
e-tree model.
> =A0 =A0 =A0 listed above, nodes for these devices should include a phy-ha=
ndle
> =A0 =A0 =A0 property, and may include other common network device propert=
ies
> =A0 =A0 =A0 like local-mac-address.
> -
> +
> =A0 =A0 =A0 iv) Xilinx Uartlite
>
> =A0 =A0 =A0 Xilinx uartlite devices are simple fixed speed serial ports.
> @@ -1793,7 +1728,7 @@ platforms are moved over to use the flattened-devic=
e-tree model.
> =A0 =A0 =A0 =A0- reg-offset : A value of 3 is required
> =A0 =A0 =A0 =A0- reg-shift : A value of 2 is required
>
> - =A0 =A0f) USB EHCI controllers
> + =A0 =A0e) USB EHCI controllers
>
> =A0 =A0 Required properties:
> =A0 =A0 =A0 - compatible : should be "usb-ehci".
> @@ -1819,7 +1754,7 @@ platforms are moved over to use the flattened-devic=
e-tree model.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 big-endian;
> =A0 =A0 =A0 =A0 =A0 };
>
> - =A0 g) MDIO on GPIOs
> + =A0 f) MDIO on GPIOs
>
> =A0 =A0Currently defined compatibles:
> =A0 =A0- virtual,gpio-mdio
> @@ -1839,7 +1774,7 @@ platforms are moved over to use the flattened-devic=
e-tree model.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &qe_pio_c 6>;
> =A0 =A0 =A0 =A0};
>
> - =A0 =A0h) SPI (Serial Peripheral Interface) busses
> + =A0 =A0g) SPI (Serial Peripheral Interface) busses
>
> =A0 =A0 SPI busses can be described with a node for the SPI master device
> =A0 =A0 and a set of child nodes for each SPI slave on the bus. =A0For th=
is
> diff --git a/Documentation/powerpc/dts-bindings/mtd-physmap.txt b/Documen=
tation/powerpc/dts-bindings/mtd-physmap.txt
> new file mode 100644
> index 0000000..cd474f9
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/mtd-physmap.txt
> @@ -0,0 +1,63 @@
> +CFI or JEDEC memory-mapped NOR flash
> +
> +Flash chips (Memory Technology Devices) are often used for solid state
> +file systems on embedded devices.
> +
> + - compatible : should contain the specific model of flash chip(s)
> + =A0 used, if known, followed by either "cfi-flash" or "jedec-flash"
> + - reg : Address range of the flash chip
> + - bank-width : Width (in bytes) of the flash bank. =A0Equal to the
> + =A0 device width times the number of interleaved chips.
> + - device-width : (optional) Width of a single flash chip. =A0If
> + =A0 omitted, assumed to be equal to 'bank-width'.
> + - #address-cells, #size-cells : Must be present if the flash has
> + =A0 sub-nodes representing partitions (see below). =A0In this case
> + =A0 both #address-cells and #size-cells must be equal to 1.
> +
> +For JEDEC compatible devices, the following additional properties
> +are defined:
> +
> + - vendor-id : Contains the flash chip's vendor id (1 byte).
> + - device-id : Contains the flash chip's device id (1 byte).
> +
> +In addition to the information on the flash bank itself, the
> +device tree may optionally contain additional information
> +describing partitions of the flash address space. =A0This can be
> +used on platforms which have strong conventions about which
> +portions of the flash are used for what purposes, but which don't
> +use an on-flash partition table such as RedBoot.
> +
> +Each partition is represented as a sub-node of the flash device.
> +Each node's name represents the name of the corresponding
> +partition of the flash device.
> +
> +Flash partitions
> + - reg : The partition's offset and size within the flash bank.
> + - label : (optional) The label / name for this flash partition.
> + =A0 If omitted, the label is taken from the node name (excluding
> + =A0 the unit address).
> + - read-only : (optional) This parameter, if present, is a hint to
> + =A0 Linux that this flash partition should only be mounted
> + =A0 read-only. =A0This is usually used for flash partitions
> + =A0 containing early-boot firmware images or data which should not
> + =A0 be clobbered.
> +
> +Example:
> +
> + =A0 =A0 =A0 flash@ff000000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "amd,am29lv128ml", "cfi-flas=
h";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <ff000000 01000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank-width =3D <4>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device-width =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fs@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 label =3D "fs";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0 f80000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 firmware@f80000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 label =3D"firmware";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <f80000 80000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read-only;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> --
> 1.6.2.3
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
