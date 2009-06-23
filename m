Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 83870B70B5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 02:11:00 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <1245425785-9950-1-git-send-email-galak@kernel.crashing.org>
References: <1245425785-9950-1-git-send-email-galak@kernel.crashing.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 23 Jun 2009 10:10:35 -0600
Message-ID: <fa686aa40906230910x2e116374x35f97784a182d8c9@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Refactor device tree binding
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 19, 2009 at 9:36 AM, Kumar Gala<galak@kernel.crashing.org> wrot=
e:
> Split device tree binding out of booting-without-of.txt and put them
> into their own files per binding.
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0Documentation/powerpc/booting-without-of.txt =A0 =A0 | 1168 +---------=
------------
> =A0Documentation/powerpc/dts-bindings/4xx/emac.txt =A0| =A0148 +++
> =A0Documentation/powerpc/dts-bindings/gpio/gpio.txt | =A0 50 +
> =A0Documentation/powerpc/dts-bindings/gpio/mdio.txt | =A0 19 +
> =A0Documentation/powerpc/dts-bindings/marvell.txt =A0 | =A0521 ++++++++++
> =A0Documentation/powerpc/dts-bindings/phy.txt =A0 =A0 =A0 | =A0 25 +
> =A0Documentation/powerpc/dts-bindings/spi-bus.txt =A0 | =A0 57 ++
> =A0Documentation/powerpc/dts-bindings/usb-ehci.txt =A0| =A0 25 +
> =A0Documentation/powerpc/dts-bindings/xilinx.txt =A0 =A0| =A0295 ++++++
> =A09 files changed, 1142 insertions(+), 1166 deletions(-)
> =A0create mode 100644 Documentation/powerpc/dts-bindings/4xx/emac.txt
> =A0create mode 100644 Documentation/powerpc/dts-bindings/gpio/gpio.txt
> =A0create mode 100644 Documentation/powerpc/dts-bindings/gpio/mdio.txt
> =A0create mode 100644 Documentation/powerpc/dts-bindings/marvell.txt
> =A0create mode 100644 Documentation/powerpc/dts-bindings/phy.txt
> =A0create mode 100644 Documentation/powerpc/dts-bindings/spi-bus.txt
> =A0create mode 100644 Documentation/powerpc/dts-bindings/usb-ehci.txt
> =A0create mode 100644 Documentation/powerpc/dts-bindings/xilinx.txt
>
> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation=
/powerpc/booting-without-of.txt
> index 8d999d8..79f533f 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1238,1122 +1238,7 @@ descriptions for the SOC devices for which new n=
odes have been
> =A0defined; this list will expand as more and more SOC-containing
> =A0platforms are moved over to use the flattened-device-tree model.
>
> - =A0 a) PHY nodes
> -
> - =A0 Required properties:
> -
> - =A0 =A0- device_type : Should be "ethernet-phy"
> - =A0 =A0- interrupts : <a b> where a is the interrupt number and b is a
> - =A0 =A0 =A0field that represents an encoding of the sense and level
> - =A0 =A0 =A0information for the interrupt. =A0This should be encoded bas=
ed on
> - =A0 =A0 =A0the information in section 2) depending on the type of inter=
rupt
> - =A0 =A0 =A0controller you have.
> - =A0 =A0- interrupt-parent : the phandle for the interrupt controller th=
at
> - =A0 =A0 =A0services interrupts for this device.
> - =A0 =A0- reg : The ID number for the phy, usually a small integer
> - =A0 =A0- linux,phandle : =A0phandle for this node; likely referenced by=
 an
> - =A0 =A0 =A0ethernet controller node.
> -
> -
> - =A0 Example:
> -
> - =A0 =A0 =A0 ethernet-phy@0 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 linux,phandle =3D <2452000>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <40000>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <35 1>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "ethernet-phy";
> - =A0 =A0 =A0 };
> -
> -
> - =A0 b) Interrupt controllers
> -
> - =A0 Some SOC devices contain interrupt controllers that are different
> - =A0 from the standard Open PIC specification. =A0The SOC device nodes f=
or
> - =A0 these types of controllers should be specified just like a standard
> - =A0 OpenPIC controller. =A0Sense and level information should be encode=
d
> - =A0 as specified in section 2) of this chapter for each device that
> - =A0 specifies an interrupt.
> -
> - =A0 Example :
> -
> - =A0 =A0 =A0 pic@40000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 linux,phandle =3D <40000>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-controller;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <40000 40000>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "chrp,open-pic";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "open-pic";
> - =A0 =A0 =A0 };
> -
> - =A0 =A0c) 4xx/Axon EMAC ethernet nodes
> -
> - =A0 =A0The EMAC ethernet controller in IBM and AMCC 4xx chips, and also
> - =A0 =A0the Axon bridge. =A0To operate this needs to interact with a ths
> - =A0 =A0special McMAL DMA controller, and sometimes an RGMII or ZMII
> - =A0 =A0interface. =A0In addition to the nodes and properties described
> - =A0 =A0below, the node for the OPB bus on which the EMAC sits must have=
 a
> - =A0 =A0correct clock-frequency property.
> -
> - =A0 =A0 =A0i) The EMAC node itself
> -
> - =A0 =A0Required properties:
> - =A0 =A0- device_type =A0 =A0 =A0 : "network"
> -
> - =A0 =A0- compatible =A0 =A0 =A0 =A0: compatible list, contains 2 entrie=
s, first is
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ibm,emac-CHIP" where C=
HIP is the host ASIC (440gx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 405gp, Axon) and second=
 is either "ibm,emac" or
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ibm,emac4". =A0For Axo=
n, thus, we have: "ibm,emac-axon",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ibm,emac4"
> - =A0 =A0- interrupts =A0 =A0 =A0 =A0: <interrupt mapping for EMAC IRQ an=
d WOL IRQ>
> - =A0 =A0- interrupt-parent =A0: optional, if needed for interrupt mappin=
g
> - =A0 =A0- reg =A0 =A0 =A0 =A0 =A0 =A0 =A0 : <registers mapping>
> - =A0 =A0- local-mac-address : 6 bytes, MAC address
> - =A0 =A0- mal-device =A0 =A0 =A0 =A0: phandle of the associated McMAL no=
de
> - =A0 =A0- mal-tx-channel =A0 =A0: 1 cell, index of the tx channel on McM=
AL associated
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 with this EMAC
> - =A0 =A0- mal-rx-channel =A0 =A0: 1 cell, index of the rx channel on McM=
AL associated
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 with this EMAC
> - =A0 =A0- cell-index =A0 =A0 =A0 =A0: 1 cell, hardware index of the EMAC=
 cell on a given
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ASIC (typically 0x0 and=
 0x1 for EMAC0 and EMAC1 on
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 each Axon chip)
> - =A0 =A0- max-frame-size =A0 =A0: 1 cell, maximum frame size supported i=
n bytes
> - =A0 =A0- rx-fifo-size =A0 =A0 =A0: 1 cell, Rx fifo size in bytes for 10=
 and 100 Mb/sec
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 operations.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 For Axon, 2048
> - =A0 =A0- tx-fifo-size =A0 =A0 =A0: 1 cell, Tx fifo size in bytes for 10=
 and 100 Mb/sec
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 operations.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 For Axon, 2048.
> - =A0 =A0- fifo-entry-size =A0 : 1 cell, size of a fifo entry (used to ca=
lculate
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thresholds).
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 For Axon, 0x00000010
> - =A0 =A0- mal-burst-size =A0 =A0: 1 cell, MAL burst size (used to calcul=
ate thresholds)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in bytes.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 For Axon, 0x00000100 (I=
 think ...)
> - =A0 =A0- phy-mode =A0 =A0 =A0 =A0 =A0: string, mode of operations of th=
e PHY interface.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Supported values are: "=
mii", "rmii", "smii", "rgmii",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "tbi", "gmii", rtbi", "=
sgmii".
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 For Axon on CAB, it is =
"rgmii"
> - =A0 =A0- mdio-device =A0 =A0 =A0 : 1 cell, required iff using shared MD=
IO registers
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (440EP). =A0phandle of =
the EMAC to use to drive the
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MDIO lines for the PHY =
used by this EMAC.
> - =A0 =A0- zmii-device =A0 =A0 =A0 : 1 cell, required iff connected to a =
ZMII. =A0phandle of
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 the ZMII device node
> - =A0 =A0- zmii-channel =A0 =A0 =A0: 1 cell, required iff connected to a =
ZMII. =A0Which ZMII
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 channel or 0xffffffff i=
f ZMII is only used for MDIO.
> - =A0 =A0- rgmii-device =A0 =A0 =A0: 1 cell, required iff connected to an=
 RGMII. phandle
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of the RGMII device nod=
e.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 For Axon: phandle of pl=
b5/plb4/opb/rgmii
> - =A0 =A0- rgmii-channel =A0 =A0 : 1 cell, required iff connected to an R=
GMII. =A0Which
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RGMII channel is used b=
y this EMAC.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Fox Axon: present, what=
ever value is appropriate for each
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EMAC, that is the conte=
nt of the current (bogus) "phy-port"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 property.
> -
> - =A0 =A0Optional properties:
> - =A0 =A0- phy-address =A0 =A0 =A0 : 1 cell, optional, MDIO address of th=
e PHY. If absent,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a search is performed.
> - =A0 =A0- phy-map =A0 =A0 =A0 =A0 =A0 : 1 cell, optional, bitmap of addr=
esses to probe the PHY
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for, used if phy-addres=
s is absent. bit 0x00000001 is
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MDIO address 0.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 For Axon it can be abse=
nt, though my current driver
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 doesn't handle phy-addr=
ess yet so for now, keep
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x00ffffff in it.
> - =A0 =A0- rx-fifo-size-gige : 1 cell, Rx fifo size in bytes for 1000 Mb/=
sec
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 operations (if absent t=
he value is the same as
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx-fifo-size). =A0For A=
xon, either absent or 2048.
> - =A0 =A0- tx-fifo-size-gige : 1 cell, Tx fifo size in bytes for 1000 Mb/=
sec
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 operations (if absent t=
he value is the same as
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx-fifo-size). For Axon=
, either absent or 2048.
> - =A0 =A0- tah-device =A0 =A0 =A0 =A0: 1 cell, optional. If connected to =
a TAH engine for
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 offload, phandle of the=
 TAH device node.
> - =A0 =A0- tah-channel =A0 =A0 =A0 : 1 cell, optional. If appropriate, ch=
annel used on the
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TAH engine.
> -
> - =A0 =A0Example:
> -
> - =A0 =A0 =A0 EMAC0: ethernet@40000800 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "network";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ibm,emac-440gp", "ibm,emac"=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&UIC1>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <1c 4 1d 4>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <40000800 70>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 local-mac-address =3D [00 04 AC E3 1B 1E];
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mal-device =3D <&MAL0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mal-tx-channel =3D <0 1>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mal-rx-channel =3D <0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 max-frame-size =3D <5dc>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx-fifo-size =3D <1000>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx-fifo-size =3D <800>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy-mode =3D "rmii";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy-map =3D <00000001>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 zmii-device =3D <&ZMII0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 zmii-channel =3D <0>;
> - =A0 =A0 =A0 };
> -
> - =A0 =A0 =A0ii) McMAL node
> -
> - =A0 =A0Required properties:
> - =A0 =A0- device_type =A0 =A0 =A0 =A0: "dma-controller"
> - =A0 =A0- compatible =A0 =A0 =A0 =A0 : compatible list, containing 2 ent=
ries, first is
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"ibm,mcmal-CHIP" whe=
re CHIP is the host ASIC (like
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0emac) and the second=
 is either "ibm,mcmal" or
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"ibm,mcmal2".
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0For Axon, "ibm,mcmal=
-axon","ibm,mcmal2"
> - =A0 =A0- interrupts =A0 =A0 =A0 =A0 : <interrupt mapping for the MAL in=
terrupts sources:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 5 sources: tx_eob, =
rx_eob, serr, txde, rxde>.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 For Axon: This is _=
different_ from the current
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0firmware. =A0We use =
the "delayed" interrupts for txeob
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0and rxeob. Thus we e=
nd up with mapping those 5 MPIC
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts, all leve=
l positive sensitive: 10, 11, 32,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A033, 34 (in decimal)
> - =A0 =A0- dcr-reg =A0 =A0 =A0 =A0 =A0 =A0: < DCR registers range >
> - =A0 =A0- dcr-parent =A0 =A0 =A0 =A0 : if needed for dcr-reg
> - =A0 =A0- num-tx-chans =A0 =A0 =A0 : 1 cell, number of Tx channels
> - =A0 =A0- num-rx-chans =A0 =A0 =A0 : 1 cell, number of Rx channels
> -
> - =A0 =A0 =A0iii) ZMII node
> -
> - =A0 =A0Required properties:
> - =A0 =A0- compatible =A0 =A0 =A0 =A0 : compatible list, containing 2 ent=
ries, first is
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"ibm,zmii-CHIP" wher=
e CHIP is the host ASIC (like
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EMAC) and the second=
 is "ibm,zmii".
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0For Axon, there is n=
o ZMII node.
> - =A0 =A0- reg =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: <registers mapping>
> -
> - =A0 =A0 =A0iv) RGMII node
> -
> - =A0 =A0Required properties:
> - =A0 =A0- compatible =A0 =A0 =A0 =A0 : compatible list, containing 2 ent=
ries, first is
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"ibm,rgmii-CHIP" whe=
re CHIP is the host ASIC (like
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EMAC) and the second=
 is "ibm,rgmii".
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 For Axon, "ibm,rgmi=
i-axon","ibm,rgmii"
> - =A0 =A0- reg =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: <registers mapping>
> - =A0 =A0- revision =A0 =A0 =A0 =A0 =A0 : as provided by the RGMII new ve=
rsion register if
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0available.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0For Axon: 0x0000012a
> -
> - =A0 d) Xilinx IP cores
> -
> - =A0 The Xilinx EDK toolchain ships with a set of IP cores (devices) for=
 use
> - =A0 in Xilinx Spartan and Virtex FPGAs. =A0The devices cover the whole =
range
> - =A0 of standard device types (network, serial, etc.) and miscellaneous
> - =A0 devices (gpio, LCD, spi, etc). =A0Also, since these devices are
> - =A0 implemented within the fpga fabric every instance of the device can=
 be
> - =A0 synthesised with different options that change the behaviour.
> -
> - =A0 Each IP-core has a set of parameters which the FPGA designer can us=
e to
> - =A0 control how the core is synthesized. =A0Historically, the EDK tool =
would
> - =A0 extract the device parameters relevant to device drivers and copy t=
hem
> - =A0 into an 'xparameters.h' in the form of #define symbols. =A0This tel=
ls the
> - =A0 device drivers how the IP cores are configured, but it requres the =
kernel
> - =A0 to be recompiled every time the FPGA bitstream is resynthesized.
> -
> - =A0 The new approach is to export the parameters into the device tree a=
nd
> - =A0 generate a new device tree each time the FPGA bitstream changes. =
=A0The
> - =A0 parameters which used to be exported as #defines will now become
> - =A0 properties of the device node. =A0In general, device nodes for IP-c=
ores
> - =A0 will take the following form:
> -
> - =A0 =A0 =A0 (name): (generic-name)@(base-address) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,(ip-core-name)-(HW_VER=
)"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[, (list of comp=
atible devices), ...];
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <(baseaddr) (size)>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&interrupt-controller=
-phandle>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D < ... >;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,(parameter1) =3D "(string-value)";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,(parameter2) =3D <(int-value)>;
> - =A0 =A0 =A0 };
> -
> - =A0 =A0 =A0 (generic-name): =A0 an open firmware-style name that descri=
bes the
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 generic class of device. =
=A0Preferably, this is one word, such
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 as 'serial' or 'ethernet'.
> - =A0 =A0 =A0 (ip-core-name): the name of the ip block (given after the B=
EGIN
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 directive in system.mhs). =
=A0Should be in lowercase
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 and all underscores '_' con=
verted to dashes '-'.
> - =A0 =A0 =A0 (name): =A0 =A0 =A0 =A0 is derived from the "PARAMETER INST=
ANCE" value.
> - =A0 =A0 =A0 (parameter#): =A0 C_* parameters from system.mhs. =A0The C_=
 prefix is
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dropped from the parameter =
name, the name is converted
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 to lowercase and all unders=
core '_' characters are
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 converted to dashes '-'.
> - =A0 =A0 =A0 (baseaddr): =A0 =A0 the baseaddr parameter value (often nam=
ed C_BASEADDR).
> - =A0 =A0 =A0 (HW_VER): =A0 =A0 =A0 from the HW_VER parameter.
> - =A0 =A0 =A0 (size): =A0 =A0 =A0 =A0 the address range size (often C_HIG=
HADDR - C_BASEADDR + 1).
> -
> - =A0 Typically, the compatible list will include the exact IP core versi=
on
> - =A0 followed by an older IP core version which implements the same
> - =A0 interface or any other device with the same interface.
> -
> - =A0 'reg', 'interrupt-parent' and 'interrupts' are all optional propert=
ies.
> -
> - =A0 For example, the following block from system.mhs:
> -
> - =A0 =A0 =A0 BEGIN opb_uartlite
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER INSTANCE =3D opb_uartlite_0
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER HW_VER =3D 1.00.b
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_BAUDRATE =3D 115200
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_DATA_BITS =3D 8
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_ODD_PARITY =3D 0
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_USE_PARITY =3D 0
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_CLK_FREQ =3D 50000000
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_BASEADDR =3D 0xEC100000
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_HIGHADDR =3D 0xEC10FFFF
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUS_INTERFACE SOPB =3D opb_7
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT OPB_Clk =3D CLK_50MHz
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Interrupt =3D opb_uartlite_0_Interrupt
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT RX =3D opb_uartlite_0_RX
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT TX =3D opb_uartlite_0_TX
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT OPB_Rst =3D sys_bus_reset_0
> - =A0 =A0 =A0 END
> -
> - =A0 becomes the following device tree node:
> -
> - =A0 =A0 =A0 opb_uartlite_0: serial@ec100000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "serial";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,opb-uartlite-1.00.b";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <ec100000 10000>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&opb_intc_0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <1 0>; // got this from the =
opb_intc parameters
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 current-speed =3D <d#115200>; =A0 =A0 // st=
andard serial device prop
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <d#50000000>; // standa=
rd serial device prop
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,data-bits =3D <8>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,odd-parity =3D <0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,use-parity =3D <0>;
> - =A0 =A0 =A0 };
> -
> - =A0 Some IP cores actually implement 2 or more logical devices. =A0In
> - =A0 this case, the device should still describe the whole IP core with
> - =A0 a single node and add a child node for each logical device. =A0The
> - =A0 ranges property can be used to translate from parent IP-core to the
> - =A0 registers of each device. =A0In addition, the parent node should be
> - =A0 compatible with the bus type 'xlnx,compound', and should contain
> - =A0 #address-cells and #size-cells, as with any other bus. =A0(Note: th=
is
> - =A0 makes the assumption that both logical devices have the same bus
> - =A0 binding. =A0If this is not true, then separate nodes should be used
> - =A0 for each logical device). =A0The 'cell-index' property can be used =
to
> - =A0 enumerate logical devices within an IP core. =A0For example, the
> - =A0 following is the system.mhs entry for the dual ps2 controller found
> - =A0 on the ml403 reference design.
> -
> - =A0 =A0 =A0 BEGIN opb_ps2_dual_ref
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER INSTANCE =3D opb_ps2_dual_ref_0
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER HW_VER =3D 1.00.a
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_BASEADDR =3D 0xA9000000
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_HIGHADDR =3D 0xA9001FFF
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUS_INTERFACE SOPB =3D opb_v20_0
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Sys_Intr1 =3D ps2_1_intr
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Sys_Intr2 =3D ps2_2_intr
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Clkin1 =3D ps2_clk_rx_1
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Clkin2 =3D ps2_clk_rx_2
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Clkpd1 =3D ps2_clk_tx_1
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Clkpd2 =3D ps2_clk_tx_2
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Rx1 =3D ps2_d_rx_1
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Rx2 =3D ps2_d_rx_2
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Txpd1 =3D ps2_d_tx_1
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Txpd2 =3D ps2_d_tx_2
> - =A0 =A0 =A0 END
> -
> - =A0 It would result in the following device tree nodes:
> -
> - =A0 =A0 =A0 opb_ps2_dual_ref_0: opb-ps2-dual-ref@a9000000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,compound";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0 a9000000 2000>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 // If this device had extra parameters, the=
n they would
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 // go here.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ps2@0 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,opb-ps=
2-dual-ref-1.00.a";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0 40>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&opb_=
intc_0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <3 0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ps2@1000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,opb-ps=
2-dual-ref-1.00.a";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <1000 40>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&opb_=
intc_0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <3 0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> - =A0 =A0 =A0 };
> -
> - =A0 Also, the system.mhs file defines bus attachments from the processo=
r
> - =A0 to the devices. =A0The device tree structure should reflect the bus
> - =A0 attachments. =A0Again an example; this system.mhs fragment:
> -
> - =A0 =A0 =A0 BEGIN ppc405_virtex4
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER INSTANCE =3D ppc405_0
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER HW_VER =3D 1.01.a
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUS_INTERFACE DPLB =3D plb_v34_0
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUS_INTERFACE IPLB =3D plb_v34_0
> - =A0 =A0 =A0 END
> -
> - =A0 =A0 =A0 BEGIN opb_intc
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER INSTANCE =3D opb_intc_0
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER HW_VER =3D 1.00.c
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_BASEADDR =3D 0xD1000FC0
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_HIGHADDR =3D 0xD1000FDF
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUS_INTERFACE SOPB =3D opb_v20_0
> - =A0 =A0 =A0 END
> -
> - =A0 =A0 =A0 BEGIN opb_uart16550
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER INSTANCE =3D opb_uart16550_0
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER HW_VER =3D 1.00.d
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_BASEADDR =3D 0xa0000000
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_HIGHADDR =3D 0xa0001FFF
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUS_INTERFACE SOPB =3D opb_v20_0
> - =A0 =A0 =A0 END
> -
> - =A0 =A0 =A0 BEGIN plb_v34
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER INSTANCE =3D plb_v34_0
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER HW_VER =3D 1.02.a
> - =A0 =A0 =A0 END
> -
> - =A0 =A0 =A0 BEGIN plb_bram_if_cntlr
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER INSTANCE =3D plb_bram_if_cntlr_0
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER HW_VER =3D 1.00.b
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_BASEADDR =3D 0xFFFF0000
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_HIGHADDR =3D 0xFFFFFFFF
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUS_INTERFACE SPLB =3D plb_v34_0
> - =A0 =A0 =A0 END
> -
> - =A0 =A0 =A0 BEGIN plb2opb_bridge
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER INSTANCE =3D plb2opb_bridge_0
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER HW_VER =3D 1.01.a
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_RNG0_BASEADDR =3D 0x20000000
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_RNG0_HIGHADDR =3D 0x3FFFFFFF
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_RNG1_BASEADDR =3D 0x60000000
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_RNG1_HIGHADDR =3D 0x7FFFFFFF
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_RNG2_BASEADDR =3D 0x80000000
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_RNG2_HIGHADDR =3D 0xBFFFFFFF
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_RNG3_BASEADDR =3D 0xC0000000
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_RNG3_HIGHADDR =3D 0xDFFFFFFF
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUS_INTERFACE SPLB =3D plb_v34_0
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUS_INTERFACE MOPB =3D opb_v20_0
> - =A0 =A0 =A0 END
> -
> - =A0 Gives this device tree (some properties removed for clarity):
> -
> - =A0 =A0 =A0 plb@0 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,plb-v34-1.02.a";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "ibm,plb";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges; // 1:1 translation
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 plb_bram_if_cntrl_0: bram@ffff0000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <ffff0000 10000>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 opb@20000000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <20000000 200000=
00 20000000
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 6000000=
0 60000000 20000000
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 8000000=
0 80000000 40000000
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c000000=
0 c0000000 20000000>;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 opb_uart16550_0: serial@a00=
00000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <a0=
0000000 2000>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 opb_intc_0: interrupt-contr=
oller@d1000fc0 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <d1=
000fc0 20>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> - =A0 =A0 =A0 };
> -
> - =A0 That covers the general approach to binding xilinx IP cores into th=
e
> - =A0 device tree. =A0The following are bindings for specific devices:
> -
> - =A0 =A0 =A0i) Xilinx ML300 Framebuffer
> -
> - =A0 =A0 =A0Simple framebuffer device from the ML300 reference design (a=
lso on the
> - =A0 =A0 =A0ML403 reference design as well as others).
> -
> - =A0 =A0 =A0Optional properties:
> - =A0 =A0 =A0 - resolution =3D <xres yres> : pixel resolution of framebuf=
fer. =A0Some
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
implementations use a different resolution.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
Default is <d#640 d#480>
> - =A0 =A0 =A0 - virt-resolution =3D <xvirt yvirt> : Size of framebuffer i=
n memory.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 Default is <d#1024 d#480>.
> - =A0 =A0 =A0 - rotate-display (empty) : rotate display 180 degrees.
> -
> - =A0 =A0 =A0ii) Xilinx SystemACE
> -
> - =A0 =A0 =A0The Xilinx SystemACE device is used to program FPGAs from an=
 FPGA
> - =A0 =A0 =A0bitstream stored on a CF card. =A0It can also be used as a g=
eneric CF
> - =A0 =A0 =A0interface device.
> -
> - =A0 =A0 =A0Optional properties:
> - =A0 =A0 =A0 - 8-bit (empty) : Set this property for SystemACE in 8 bit =
mode
> -
> - =A0 =A0 =A0iii) Xilinx EMAC and Xilinx TEMAC
> -
> - =A0 =A0 =A0Xilinx Ethernet devices. =A0In addition to general xilinx pr=
operties
> - =A0 =A0 =A0listed above, nodes for these devices should include a phy-h=
andle
> - =A0 =A0 =A0property, and may include other common network device proper=
ties
> - =A0 =A0 =A0like local-mac-address.
> -
> - =A0 =A0 =A0iv) Xilinx Uartlite
> -
> - =A0 =A0 =A0Xilinx uartlite devices are simple fixed speed serial ports.
> -
> - =A0 =A0 =A0Required properties:
> - =A0 =A0 =A0 - current-speed : Baud rate of uartlite
> -
> - =A0 =A0 =A0v) Xilinx hwicap
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 Xilinx hwicap devices provide access to the=
 configuration logic
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 of the FPGA through the Internal Configurat=
ion Access Port
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ICAP). =A0The ICAP enables partial reconfi=
guration of the FPGA,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 readback of the configuration information, =
and some control over
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 'warm boots' of the FPGA fabric.
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 Required properties:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 - xlnx,family : The family of the FPGA, nec=
essary since the
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0capabilities of the underlyi=
ng ICAP hardware
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0differ between different fam=
ilies. =A0May be
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0'virtex2p', 'virtex4', or 'v=
irtex5'.
> -
> - =A0 =A0 =A0vi) Xilinx Uart 16550
> -
> - =A0 =A0 =A0Xilinx UART 16550 devices are very similar to the NS16550 bu=
t with
> - =A0 =A0 =A0different register spacing and an offset from the base addre=
ss.
> -
> - =A0 =A0 =A0Required properties:
> - =A0 =A0 =A0 - clock-frequency : Frequency of the clock input
> - =A0 =A0 =A0 - reg-offset : A value of 3 is required
> - =A0 =A0 =A0 - reg-shift : A value of 2 is required
> -
> - =A0 =A0e) USB EHCI controllers
> -
> - =A0 =A0Required properties:
> - =A0 =A0 =A0- compatible : should be "usb-ehci".
> - =A0 =A0 =A0- reg : should contain at least address and length of the st=
andard EHCI
> - =A0 =A0 =A0 =A0register set for the device. Optional platform-dependent=
 registers
> - =A0 =A0 =A0 =A0(debug-port or other) can be also specified here, but on=
ly after
> - =A0 =A0 =A0 =A0definition of standard EHCI registers.
> - =A0 =A0 =A0- interrupts : one EHCI interrupt should be described here.
> - =A0 =A0If device registers are implemented in big endian mode, the devi=
ce
> - =A0 =A0node should have "big-endian-regs" property.
> - =A0 =A0If controller implementation operates with big endian descriptor=
s,
> - =A0 =A0"big-endian-desc" property should be specified.
> - =A0 =A0If both big endian registers and descriptors are used by the con=
troller
> - =A0 =A0implementation, "big-endian" property can be specified instead o=
f having
> - =A0 =A0both "big-endian-regs" and "big-endian-desc".
> -
> - =A0 =A0 Example (Sequoia 440EPx):
> - =A0 =A0 =A0 =A0 =A0 ehci@e0000300 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "ibm,usb-ehci-440epx"=
, "usb-ehci";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&UIC0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <1a 4>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0 e0000300 90 0 e0000390 70=
>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0big-endian;
> - =A0 =A0 =A0 =A0 =A0};
> -
> - =A0 f) MDIO on GPIOs
> -
> - =A0 Currently defined compatibles:
> - =A0 - virtual,gpio-mdio
> -
> - =A0 MDC and MDIO lines connected to GPIO controllers are listed in the
> - =A0 gpios property as described in section VIII.1 in the following orde=
r:
> -
> - =A0 MDC, MDIO.
> -
> - =A0 Example:
> -
> - =A0 =A0 =A0 mdio {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "virtual,mdio-gpio";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpios =3D <&qe_pio_a 11
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&qe_pio_c 6>;
> - =A0 =A0 =A0 };
> -
> - =A0 =A0g) SPI (Serial Peripheral Interface) busses
> -
> - =A0 =A0SPI busses can be described with a node for the SPI master devic=
e
> - =A0 =A0and a set of child nodes for each SPI slave on the bus. =A0For t=
his
> - =A0 =A0discussion, it is assumed that the system's SPI controller is in
> - =A0 =A0SPI master mode. =A0This binding does not describe SPI controlle=
rs
> - =A0 =A0in slave mode.
> -
> - =A0 =A0The SPI master node requires the following properties:
> - =A0 =A0- #address-cells =A0- number of cells required to define a chip =
select
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 address on the SPI bus.
> - =A0 =A0- #size-cells =A0 =A0 - should be zero.
> - =A0 =A0- compatible =A0 =A0 =A0- name of SPI bus controller following g=
eneric names
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 recommended practice.
> - =A0 =A0No other properties are required in the SPI bus node. =A0It is a=
ssumed
> - =A0 =A0that a driver for an SPI bus device will understand that it is a=
n SPI bus.
> - =A0 =A0However, the binding does not attempt to define the specific met=
hod for
> - =A0 =A0assigning chip select numbers. =A0Since SPI chip select configur=
ation is
> - =A0 =A0flexible and non-standardized, it is left out of this binding wi=
th the
> - =A0 =A0assumption that board specific platform code will be used to man=
age
> - =A0 =A0chip selects. =A0Individual drivers can define additional proper=
ties to
> - =A0 =A0support describing the chip select layout.
> -
> - =A0 =A0SPI slave nodes must be children of the SPI master node and can
> - =A0 =A0contain the following properties.
> - =A0 =A0- reg =A0 =A0 =A0 =A0 =A0 =A0 - (required) chip select address o=
f device.
> - =A0 =A0- compatible =A0 =A0 =A0- (required) name of SPI device followin=
g generic names
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 recommended practice
> - =A0 =A0- spi-max-frequency - (required) Maximum SPI clocking speed of d=
evice in Hz
> - =A0 =A0- spi-cpol =A0 =A0 =A0 =A0- (optional) Empty property indicating=
 device requires
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 inverse clock polarity (CPO=
L) mode
> - =A0 =A0- spi-cpha =A0 =A0 =A0 =A0- (optional) Empty property indicating=
 device requires
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 shifted clock phase (CPHA) =
mode
> - =A0 =A0- spi-cs-high =A0 =A0 - (optional) Empty property indicating dev=
ice requires
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip select active high
> -
> - =A0 =A0SPI example for an MPC5200 SPI bus:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi@f00 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5200=
b-spi","fsl,mpc5200-spi";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0xf00 0x20>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <2 13 0 2 14=
 0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&mpc5=
200_pic>;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ethernet-switch@0 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "micrel,ks8995m";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi-max-fre=
quency =3D <1000000>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0>=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 codec@1 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "ti,tlv320aic26";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi-max-fre=
quency =3D <100000>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <1>=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> -
> -VII - Marvell Discovery mv64[345]6x System Controller chips
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -The Marvell mv64[345]60 series of system controller chips contain
> -many of the peripherals needed to implement a complete computer
> -system. =A0In this section, we define device tree nodes to describe
> -the system controller chip itself and each of the peripherals
> -which it contains. =A0Compatible string values for each node are
> -prefixed with the string "marvell,", for Marvell Technology Group Ltd.
> -
> -1) The /system-controller node
> -
> - =A0This node is used to represent the system-controller and must be
> - =A0present when the system uses a system controller chip. The top-level
> - =A0system-controller node contains information that is global to all
> - =A0devices within the system controller chip. The node name begins
> - =A0with "system-controller" followed by the unit address, which is
> - =A0the base address of the memory-mapped register set for the system
> - =A0controller chip.
> -
> - =A0Required properties:
> -
> - =A0 =A0- ranges : Describes the translation of system controller addres=
ses
> - =A0 =A0 =A0for memory mapped registers.
> - =A0 =A0- clock-frequency: Contains the main clock frequency for the sys=
tem
> - =A0 =A0 =A0controller chip.
> - =A0 =A0- reg : This property defines the address and size of the
> - =A0 =A0 =A0memory-mapped registers contained within the system controll=
er
> - =A0 =A0 =A0chip. =A0The address specified in the "reg" property should =
match
> - =A0 =A0 =A0the unit address of the system-controller node.
> - =A0 =A0- #address-cells : Address representation for system controller
> - =A0 =A0 =A0devices. =A0This field represents the number of cells needed=
 to
> - =A0 =A0 =A0represent the address of the memory-mapped registers of devi=
ces
> - =A0 =A0 =A0within the system controller chip.
> - =A0 =A0- #size-cells : Size representation for for the memory-mapped
> - =A0 =A0 =A0registers within the system controller chip.
> - =A0 =A0- #interrupt-cells : Defines the width of cells used to represen=
t
> - =A0 =A0 =A0interrupts.
> -
> - =A0Optional properties:
> -
> - =A0 =A0- model : The specific model of the system controller chip. =A0S=
uch
> - =A0 =A0 =A0as, "mv64360", "mv64460", or "mv64560".
> - =A0 =A0- compatible : A string identifying the compatibility identifier=
s
> - =A0 =A0 =A0of the system controller chip.
> -
> - =A0The system-controller node contains child nodes for each system
> - =A0controller device that the platform uses. =A0Nodes should not be cre=
ated
> - =A0for devices which exist on the system controller chip but are not us=
ed
> -
> - =A0Example Marvell Discovery mv64360 system-controller node:
> -
> - =A0 =A0system-controller@f1000000 { /* Marvell Discovery mv64360 */
> - =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> - =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> - =A0 =A0 =A0 =A0 =A0 model =3D "mv64360"; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0/* Default */
> - =A0 =A0 =A0 =A0 =A0 compatible =3D "marvell,mv64360";
> - =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <133333333>;
> - =A0 =A0 =A0 =A0 =A0 reg =3D <0xf1000000 0x10000>;
> - =A0 =A0 =A0 =A0 =A0 virtual-reg =3D <0xf1000000>;
> - =A0 =A0 =A0 =A0 =A0 ranges =3D <0x88000000 0x88000000 0x1000000 /* PCI =
0 I/O Space */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x80000000 0x80000000 0x8000000 /* =
PCI 0 MEM Space */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xa0000000 0xa0000000 0x4000000 /* =
User FLASH */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x00000000 0xf1000000 0x0010000 /* =
Bridge's regs */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xf2000000 0xf2000000 0x0040000>;/*=
 Integrated SRAM */
> -
> - =A0 =A0 =A0 =A0 =A0 [ child node definitions... ]
> - =A0 =A0}
> -
> -2) Child nodes of /system-controller
> -
> - =A0 a) Marvell Discovery MDIO bus
> -
> - =A0 The MDIO is a bus to which the PHY devices are connected. =A0For ea=
ch
> - =A0 device that exists on this bus, a child node should be created. =A0=
See
> - =A0 the definition of the PHY node below for an example of how to defin=
e
> - =A0 a PHY.
> -
> - =A0 Required properties:
> - =A0 =A0 - #address-cells : Should be <1>
> - =A0 =A0 - #size-cells : Should be <0>
> - =A0 =A0 - device_type : Should be "mdio"
> - =A0 =A0 - compatible : Should be "marvell,mv64360-mdio"
> -
> - =A0 Example:
> -
> - =A0 =A0 mdio {
> - =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <1>;
> - =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <0>;
> - =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "mdio";
> - =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-mdio";
> -
> - =A0 =A0 =A0 =A0 =A0 =A0ethernet-phy@0 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0......
> - =A0 =A0 =A0 =A0 =A0 =A0};
> - =A0 =A0 };
> -
> -
> - =A0 b) Marvell Discovery ethernet controller
> -
> - =A0 The Discover ethernet controller is described with two levels
> - =A0 of nodes. =A0The first level describes an ethernet silicon block
> - =A0 and the second level describes up to 3 ethernet nodes within
> - =A0 that block. =A0The reason for the multiple levels is that the
> - =A0 registers for the node are interleaved within a single set
> - =A0 of registers. =A0The "ethernet-block" level describes the
> - =A0 shared register set, and the "ethernet" nodes describe ethernet
> - =A0 port-specific properties.
> -
> - =A0 Ethernet block node
> -
> - =A0 Required properties:
> - =A0 =A0 - #address-cells : <1>
> - =A0 =A0 - #size-cells : <0>
> - =A0 =A0 - compatible : "marvell,mv64360-eth-block"
> - =A0 =A0 - reg : Offset and length of the register set for this block
> -
> - =A0 Example Discovery Ethernet block node:
> - =A0 =A0 ethernet-block@2000 {
> - =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <1>;
> - =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <0>;
> - =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-eth-block";
> - =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x2000 0x2000>;
> - =A0 =A0 =A0 =A0 =A0 =A0ethernet@0 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.......
> - =A0 =A0 =A0 =A0 =A0 =A0};
> - =A0 =A0 };
> -
> - =A0 Ethernet port node
> -
> - =A0 Required properties:
> - =A0 =A0 - device_type : Should be "network".
> - =A0 =A0 - compatible : Should be "marvell,mv64360-eth".
> - =A0 =A0 - reg : Should be <0>, <1>, or <2>, according to which register=
s
> - =A0 =A0 =A0 within the silicon block the device uses.
> - =A0 =A0 - interrupts : <a> where a is the interrupt number for the port=
.
> - =A0 =A0 - interrupt-parent : the phandle for the interrupt controller
> - =A0 =A0 =A0 that services interrupts for this device.
> - =A0 =A0 - phy : the phandle for the PHY connected to this ethernet
> - =A0 =A0 =A0 controller.
> - =A0 =A0 - local-mac-address : 6 bytes, MAC address
> -
> - =A0 Example Discovery Ethernet port node:
> - =A0 =A0 ethernet@0 {
> - =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "network";
> - =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-eth";
> - =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0>;
> - =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <32>;
> - =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> - =A0 =A0 =A0 =A0 =A0 =A0phy =3D <&PHY0>;
> - =A0 =A0 =A0 =A0 =A0 =A0local-mac-address =3D [ 00 00 00 00 00 00 ];
> - =A0 =A0 };
> -
> -
> -
> - =A0 c) Marvell Discovery PHY nodes
> -
> - =A0 Required properties:
> - =A0 =A0 - device_type : Should be "ethernet-phy"
> - =A0 =A0 - interrupts : <a> where a is the interrupt number for this phy=
.
> - =A0 =A0 - interrupt-parent : the phandle for the interrupt controller t=
hat
> - =A0 =A0 =A0 services interrupts for this device.
> - =A0 =A0 - reg : The ID number for the phy, usually a small integer
> -
> - =A0 Example Discovery PHY node:
> - =A0 =A0 ethernet-phy@1 {
> - =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "ethernet-phy";
> - =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "broadcom,bcm5421";
> - =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <76>; =A0 =A0 =A0/* GPP 12 */
> - =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> - =A0 =A0 =A0 =A0 =A0 =A0reg =3D <1>;
> - =A0 =A0 };
> -
> -
> - =A0 d) Marvell Discovery SDMA nodes
> -
> - =A0 Represent DMA hardware associated with the MPSC (multiprotocol
> - =A0 serial controllers).
> -
> - =A0 Required properties:
> - =A0 =A0 - compatible : "marvell,mv64360-sdma"
> - =A0 =A0 - reg : Offset and length of the register set for this device
> - =A0 =A0 - interrupts : <a> where a is the interrupt number for the DMA
> - =A0 =A0 =A0 device.
> - =A0 =A0 - interrupt-parent : the phandle for the interrupt controller
> - =A0 =A0 =A0 that services interrupts for this device.
> -
> - =A0 Example Discovery SDMA node:
> - =A0 =A0 sdma@4000 {
> - =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-sdma";
> - =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x4000 0xc18>;
> - =A0 =A0 =A0 =A0 =A0 =A0virtual-reg =3D <0xf1004000>;
> - =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <36>;
> - =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> - =A0 =A0 };
> -
> -
> - =A0 e) Marvell Discovery BRG nodes
> -
> - =A0 Represent baud rate generator hardware associated with the MPSC
> - =A0 (multiprotocol serial controllers).
> -
> - =A0 Required properties:
> - =A0 =A0 - compatible : "marvell,mv64360-brg"
> - =A0 =A0 - reg : Offset and length of the register set for this device
> - =A0 =A0 - clock-src : A value from 0 to 15 which selects the clock
> - =A0 =A0 =A0 source for the baud rate generator. =A0This value correspon=
ds
> - =A0 =A0 =A0 to the CLKS value in the BRGx configuration register. =A0Se=
e
> - =A0 =A0 =A0 the mv64x60 User's Manual.
> - =A0 =A0 - clock-frequence : The frequency (in Hz) of the baud rate
> - =A0 =A0 =A0 generator's input clock.
> - =A0 =A0 - current-speed : The current speed setting (presumably by
> - =A0 =A0 =A0 firmware) of the baud rate generator.
> -
> - =A0 Example Discovery BRG node:
> - =A0 =A0 brg@b200 {
> - =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-brg";
> - =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xb200 0x8>;
> - =A0 =A0 =A0 =A0 =A0 =A0clock-src =3D <8>;
> - =A0 =A0 =A0 =A0 =A0 =A0clock-frequency =3D <133333333>;
> - =A0 =A0 =A0 =A0 =A0 =A0current-speed =3D <9600>;
> - =A0 =A0 };
> -
> -
> - =A0 f) Marvell Discovery CUNIT nodes
> -
> - =A0 Represent the Serial Communications Unit device hardware.
> -
> - =A0 Required properties:
> - =A0 =A0 - reg : Offset and length of the register set for this device
> -
> - =A0 Example Discovery CUNIT node:
> - =A0 =A0 cunit@f200 {
> - =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xf200 0x200>;
> - =A0 =A0 };
> -
> -
> - =A0 g) Marvell Discovery MPSCROUTING nodes
> -
> - =A0 Represent the Discovery's MPSC routing hardware
> -
> - =A0 Required properties:
> - =A0 =A0 - reg : Offset and length of the register set for this device
> -
> - =A0 Example Discovery CUNIT node:
> - =A0 =A0 mpscrouting@b500 {
> - =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xb400 0xc>;
> - =A0 =A0 };
> -
> -
> - =A0 h) Marvell Discovery MPSCINTR nodes
> -
> - =A0 Represent the Discovery's MPSC DMA interrupt hardware registers
> - =A0 (SDMA cause and mask registers).
> -
> - =A0 Required properties:
> - =A0 =A0 - reg : Offset and length of the register set for this device
> -
> - =A0 Example Discovery MPSCINTR node:
> - =A0 =A0 mpsintr@b800 {
> - =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xb800 0x100>;
> - =A0 =A0 };
> -
> -
> - =A0 i) Marvell Discovery MPSC nodes
> -
> - =A0 Represent the Discovery's MPSC (Multiprotocol Serial Controller)
> - =A0 serial port.
> -
> - =A0 Required properties:
> - =A0 =A0 - device_type : "serial"
> - =A0 =A0 - compatible : "marvell,mv64360-mpsc"
> - =A0 =A0 - reg : Offset and length of the register set for this device
> - =A0 =A0 - sdma : the phandle for the SDMA node used by this port
> - =A0 =A0 - brg : the phandle for the BRG node used by this port
> - =A0 =A0 - cunit : the phandle for the CUNIT node used by this port
> - =A0 =A0 - mpscrouting : the phandle for the MPSCROUTING node used by th=
is port
> - =A0 =A0 - mpscintr : the phandle for the MPSCINTR node used by this por=
t
> - =A0 =A0 - cell-index : the hardware index of this cell in the MPSC core
> - =A0 =A0 - max_idle : value needed for MPSC CHR3 (Maximum Frame Length)
> - =A0 =A0 =A0 register
> - =A0 =A0 - interrupts : <a> where a is the interrupt number for the MPSC=
.
> - =A0 =A0 - interrupt-parent : the phandle for the interrupt controller
> - =A0 =A0 =A0 that services interrupts for this device.
> -
> - =A0 Example Discovery MPSCINTR node:
> - =A0 =A0 mpsc@8000 {
> - =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "serial";
> - =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-mpsc";
> - =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x8000 0x38>;
> - =A0 =A0 =A0 =A0 =A0 =A0virtual-reg =3D <0xf1008000>;
> - =A0 =A0 =A0 =A0 =A0 =A0sdma =3D <&SDMA0>;
> - =A0 =A0 =A0 =A0 =A0 =A0brg =3D <&BRG0>;
> - =A0 =A0 =A0 =A0 =A0 =A0cunit =3D <&CUNIT>;
> - =A0 =A0 =A0 =A0 =A0 =A0mpscrouting =3D <&MPSCROUTING>;
> - =A0 =A0 =A0 =A0 =A0 =A0mpscintr =3D <&MPSCINTR>;
> - =A0 =A0 =A0 =A0 =A0 =A0cell-index =3D <0>;
> - =A0 =A0 =A0 =A0 =A0 =A0max_idle =3D <40>;
> - =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <40>;
> - =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> - =A0 =A0 };
> -
> -
> - =A0 j) Marvell Discovery Watch Dog Timer nodes
> -
> - =A0 Represent the Discovery's watchdog timer hardware
> -
> - =A0 Required properties:
> - =A0 =A0 - compatible : "marvell,mv64360-wdt"
> - =A0 =A0 - reg : Offset and length of the register set for this device
> -
> - =A0 Example Discovery Watch Dog Timer node:
> - =A0 =A0 wdt@b410 {
> - =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-wdt";
> - =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xb410 0x8>;
> - =A0 =A0 };
> -
> -
> - =A0 k) Marvell Discovery I2C nodes
> -
> - =A0 Represent the Discovery's I2C hardware
> -
> - =A0 Required properties:
> - =A0 =A0 - device_type : "i2c"
> - =A0 =A0 - compatible : "marvell,mv64360-i2c"
> - =A0 =A0 - reg : Offset and length of the register set for this device
> - =A0 =A0 - interrupts : <a> where a is the interrupt number for the I2C.
> - =A0 =A0 - interrupt-parent : the phandle for the interrupt controller
> - =A0 =A0 =A0 that services interrupts for this device.
> -
> - =A0 Example Discovery I2C node:
> - =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-i2c";
> - =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xc000 0x20>;
> - =A0 =A0 =A0 =A0 =A0 =A0virtual-reg =3D <0xf100c000>;
> - =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <37>;
> - =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> - =A0 =A0 };
> -
> -
> - =A0 l) Marvell Discovery PIC (Programmable Interrupt Controller) nodes
> -
> - =A0 Represent the Discovery's PIC hardware
> -
> - =A0 Required properties:
> - =A0 =A0 - #interrupt-cells : <1>
> - =A0 =A0 - #address-cells : <0>
> - =A0 =A0 - compatible : "marvell,mv64360-pic"
> - =A0 =A0 - reg : Offset and length of the register set for this device
> - =A0 =A0 - interrupt-controller
> -
> - =A0 Example Discovery PIC node:
> - =A0 =A0 pic {
> - =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> - =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <0>;
> - =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-pic";
> - =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x0 0x88>;
> - =A0 =A0 =A0 =A0 =A0 =A0interrupt-controller;
> - =A0 =A0 };
> -
> -
> - =A0 m) Marvell Discovery MPP (Multipurpose Pins) multiplexing nodes
> -
> - =A0 Represent the Discovery's MPP hardware
> -
> - =A0 Required properties:
> - =A0 =A0 - compatible : "marvell,mv64360-mpp"
> - =A0 =A0 - reg : Offset and length of the register set for this device
> -
> - =A0 Example Discovery MPP node:
> - =A0 =A0 mpp@f000 {
> - =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-mpp";
> - =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xf000 0x10>;
> - =A0 =A0 };
> -
> -
> - =A0 n) Marvell Discovery GPP (General Purpose Pins) nodes
> -
> - =A0 Represent the Discovery's GPP hardware
> -
> - =A0 Required properties:
> - =A0 =A0 - compatible : "marvell,mv64360-gpp"
> - =A0 =A0 - reg : Offset and length of the register set for this device
> -
> - =A0 Example Discovery GPP node:
> - =A0 =A0 gpp@f000 {
> - =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-gpp";
> - =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xf100 0x20>;
> - =A0 =A0 };
> -
> -
> - =A0 o) Marvell Discovery PCI host bridge node
> -
> - =A0 Represents the Discovery's PCI host bridge device. =A0The propertie=
s
> - =A0 for this node conform to Rev 2.1 of the PCI Bus Binding to IEEE
> - =A0 1275-1994. =A0A typical value for the compatible property is
> - =A0 "marvell,mv64360-pci".
> -
> - =A0 Example Discovery PCI host bridge node
> - =A0 =A0 pci@80000000 {
> - =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <3>;
> - =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <2>;
> - =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> - =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> - =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-pci";
> - =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xcf8 0x8>;
> - =A0 =A0 =A0 =A0 =A0 =A0ranges =3D <0x01000000 0x0 =A0 =A0 =A0 =A00x0
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x88000000 0x0 0=
x01000000
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x02000000 0x0 0x80000000
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x80000000 0x0 0=
x08000000>;
> - =A0 =A0 =A0 =A0 =A0 =A0bus-range =3D <0 255>;
> - =A0 =A0 =A0 =A0 =A0 =A0clock-frequency =3D <66000000>;
> - =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> - =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7>;
> - =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0x0a */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x5000 0 0 1 &PIC 80
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x5000 0 0 2 &PIC 81
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x5000 0 0 3 &PIC 91
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x5000 0 0 4 &PIC 93
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0x0b */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x5800 0 0 1 &PIC 91
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x5800 0 0 2 &PIC 93
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x5800 0 0 3 &PIC 80
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x5800 0 0 4 &PIC 81
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0x0c */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6000 0 0 1 &PIC 91
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6000 0 0 2 &PIC 93
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6000 0 0 3 &PIC 80
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6000 0 0 4 &PIC 81
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0x0d */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6800 0 0 1 &PIC 93
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6800 0 0 2 &PIC 80
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6800 0 0 3 &PIC 81
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6800 0 0 4 &PIC 91
> - =A0 =A0 =A0 =A0 =A0 =A0>;
> - =A0 =A0 };
> -
> -
> - =A0 p) Marvell Discovery CPU Error nodes
> -
> - =A0 Represent the Discovery's CPU error handler device.
> -
> - =A0 Required properties:
> - =A0 =A0 - compatible : "marvell,mv64360-cpu-error"
> - =A0 =A0 - reg : Offset and length of the register set for this device
> - =A0 =A0 - interrupts : the interrupt number for this device
> - =A0 =A0 - interrupt-parent : the phandle for the interrupt controller
> - =A0 =A0 =A0 that services interrupts for this device.
> -
> - =A0 Example Discovery CPU Error node:
> - =A0 =A0 cpu-error@0070 {
> - =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-cpu-error";
> - =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x70 0x10 0x128 0x28>;
> - =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <3>;
> - =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> - =A0 =A0 };
> -
> -
> - =A0 q) Marvell Discovery SRAM Controller nodes
> -
> - =A0 Represent the Discovery's SRAM controller device.
> -
> - =A0 Required properties:
> - =A0 =A0 - compatible : "marvell,mv64360-sram-ctrl"
> - =A0 =A0 - reg : Offset and length of the register set for this device
> - =A0 =A0 - interrupts : the interrupt number for this device
> - =A0 =A0 - interrupt-parent : the phandle for the interrupt controller
> - =A0 =A0 =A0 that services interrupts for this device.
> -
> - =A0 Example Discovery SRAM Controller node:
> - =A0 =A0 sram-ctrl@0380 {
> - =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-sram-ctrl";
> - =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x380 0x80>;
> - =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <13>;
> - =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> - =A0 =A0 };
> -
> -
> - =A0 r) Marvell Discovery PCI Error Handler nodes
> -
> - =A0 Represent the Discovery's PCI error handler device.
> -
> - =A0 Required properties:
> - =A0 =A0 - compatible : "marvell,mv64360-pci-error"
> - =A0 =A0 - reg : Offset and length of the register set for this device
> - =A0 =A0 - interrupts : the interrupt number for this device
> - =A0 =A0 - interrupt-parent : the phandle for the interrupt controller
> - =A0 =A0 =A0 that services interrupts for this device.
> -
> - =A0 Example Discovery PCI Error Handler node:
> - =A0 =A0 pci-error@1d40 {
> - =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-pci-error";
> - =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x1d40 0x40 0xc28 0x4>;
> - =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <12>;
> - =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> - =A0 =A0 };
> -
> -
> - =A0 s) Marvell Discovery Memory Controller nodes
> -
> - =A0 Represent the Discovery's memory controller device.
> -
> - =A0 Required properties:
> - =A0 =A0 - compatible : "marvell,mv64360-mem-ctrl"
> - =A0 =A0 - reg : Offset and length of the register set for this device
> - =A0 =A0 - interrupts : the interrupt number for this device
> - =A0 =A0 - interrupt-parent : the phandle for the interrupt controller
> - =A0 =A0 =A0 that services interrupts for this device.
> -
> - =A0 Example Discovery Memory Controller node:
> - =A0 =A0 mem-ctrl@1400 {
> - =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-mem-ctrl";
> - =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x1400 0x60>;
> - =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <17>;
> - =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> - =A0 =A0 };
> -
> -
> -VIII - Specifying interrupt information for devices
> +VII - Specifying interrupt information for devices
> =A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
> =A0The device tree represents the busses and devices of a hardware
> @@ -2439,56 +1324,7 @@ encodings listed below:
> =A0 =A0 =A0 =A02 =3D =A0high to low edge sensitive type enabled
> =A0 =A0 =A0 =A03 =3D =A0low to high edge sensitive type enabled
>
> -IX - Specifying GPIO information for devices
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -1) gpios property
> ------------------
> -
> -Nodes that makes use of GPIOs should define them using `gpios' property,
> -format of which is: <&gpio-controller1-phandle gpio1-specifier
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&gpio-controller2-phandle gpio2-=
specifier
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 /* holes are permitted, means =
no GPIO 3 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&gpio-controller4-phandle gpio4-=
specifier
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...>;
> -
> -Note that gpio-specifier length is controller dependent.
> -
> -gpio-specifier may encode: bank, pin position inside the bank,
> -whether pin is open-drain and whether pin is logically inverted.
> -
> -Example of the node using GPIOs:
> -
> - =A0 =A0 =A0 node {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpios =3D <&qe_pio_e 18 0>;
> - =A0 =A0 =A0 };
> -
> -In this example gpio-specifier is "18 0" and encodes GPIO pin number,
> -and empty GPIO flags as accepted by the "qe_pio_e" gpio-controller.
> -
> -2) gpio-controller nodes
> -------------------------
> -
> -Every GPIO controller node must have #gpio-cells property defined,
> -this information will be used to translate gpio-specifiers.
> -
> -Example of two SOC GPIO banks defined as gpio-controller nodes:
> -
> - =A0 =A0 =A0 qe_pio_a: gpio-controller@1400 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 #gpio-cells =3D <2>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,qe-pario-bank-a", "fsl,=
qe-pario-bank";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1400 0x18>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio-controller;
> - =A0 =A0 =A0 };
> -
> - =A0 =A0 =A0 qe_pio_e: gpio-controller@1460 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 #gpio-cells =3D <2>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,qe-pario-bank-e", "fsl,=
qe-pario-bank";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1460 0x18>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio-controller;
> - =A0 =A0 =A0 };
> -
> -X - Specifying Device Power Management Information (sleep property)
> +VIII - Specifying Device Power Management Information (sleep property)
> =A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> =A0Devices on SOCs often have mechanisms for placing devices into low-pow=
er
> diff --git a/Documentation/powerpc/dts-bindings/4xx/emac.txt b/Documentat=
ion/powerpc/dts-bindings/4xx/emac.txt
> new file mode 100644
> index 0000000..2161334
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/4xx/emac.txt
> @@ -0,0 +1,148 @@
> + =A0 =A04xx/Axon EMAC ethernet nodes
> +
> + =A0 =A0The EMAC ethernet controller in IBM and AMCC 4xx chips, and also
> + =A0 =A0the Axon bridge. =A0To operate this needs to interact with a ths
> + =A0 =A0special McMAL DMA controller, and sometimes an RGMII or ZMII
> + =A0 =A0interface. =A0In addition to the nodes and properties described
> + =A0 =A0below, the node for the OPB bus on which the EMAC sits must have=
 a
> + =A0 =A0correct clock-frequency property.
> +
> + =A0 =A0 =A0i) The EMAC node itself
> +
> + =A0 =A0Required properties:
> + =A0 =A0- device_type =A0 =A0 =A0 : "network"
> +
> + =A0 =A0- compatible =A0 =A0 =A0 =A0: compatible list, contains 2 entrie=
s, first is
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ibm,emac-CHIP" where C=
HIP is the host ASIC (440gx,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 405gp, Axon) and second=
 is either "ibm,emac" or
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ibm,emac4". =A0For Axo=
n, thus, we have: "ibm,emac-axon",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ibm,emac4"
> + =A0 =A0- interrupts =A0 =A0 =A0 =A0: <interrupt mapping for EMAC IRQ an=
d WOL IRQ>
> + =A0 =A0- interrupt-parent =A0: optional, if needed for interrupt mappin=
g
> + =A0 =A0- reg =A0 =A0 =A0 =A0 =A0 =A0 =A0 : <registers mapping>
> + =A0 =A0- local-mac-address : 6 bytes, MAC address
> + =A0 =A0- mal-device =A0 =A0 =A0 =A0: phandle of the associated McMAL no=
de
> + =A0 =A0- mal-tx-channel =A0 =A0: 1 cell, index of the tx channel on McM=
AL associated
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 with this EMAC
> + =A0 =A0- mal-rx-channel =A0 =A0: 1 cell, index of the rx channel on McM=
AL associated
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 with this EMAC
> + =A0 =A0- cell-index =A0 =A0 =A0 =A0: 1 cell, hardware index of the EMAC=
 cell on a given
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ASIC (typically 0x0 and=
 0x1 for EMAC0 and EMAC1 on
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 each Axon chip)
> + =A0 =A0- max-frame-size =A0 =A0: 1 cell, maximum frame size supported i=
n bytes
> + =A0 =A0- rx-fifo-size =A0 =A0 =A0: 1 cell, Rx fifo size in bytes for 10=
 and 100 Mb/sec
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 operations.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 For Axon, 2048
> + =A0 =A0- tx-fifo-size =A0 =A0 =A0: 1 cell, Tx fifo size in bytes for 10=
 and 100 Mb/sec
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 operations.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 For Axon, 2048.
> + =A0 =A0- fifo-entry-size =A0 : 1 cell, size of a fifo entry (used to ca=
lculate
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thresholds).
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 For Axon, 0x00000010
> + =A0 =A0- mal-burst-size =A0 =A0: 1 cell, MAL burst size (used to calcul=
ate thresholds)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in bytes.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 For Axon, 0x00000100 (I=
 think ...)
> + =A0 =A0- phy-mode =A0 =A0 =A0 =A0 =A0: string, mode of operations of th=
e PHY interface.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Supported values are: "=
mii", "rmii", "smii", "rgmii",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "tbi", "gmii", rtbi", "=
sgmii".
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 For Axon on CAB, it is =
"rgmii"
> + =A0 =A0- mdio-device =A0 =A0 =A0 : 1 cell, required iff using shared MD=
IO registers
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (440EP). =A0phandle of =
the EMAC to use to drive the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MDIO lines for the PHY =
used by this EMAC.
> + =A0 =A0- zmii-device =A0 =A0 =A0 : 1 cell, required iff connected to a =
ZMII. =A0phandle of
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 the ZMII device node
> + =A0 =A0- zmii-channel =A0 =A0 =A0: 1 cell, required iff connected to a =
ZMII. =A0Which ZMII
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 channel or 0xffffffff i=
f ZMII is only used for MDIO.
> + =A0 =A0- rgmii-device =A0 =A0 =A0: 1 cell, required iff connected to an=
 RGMII. phandle
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of the RGMII device nod=
e.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 For Axon: phandle of pl=
b5/plb4/opb/rgmii
> + =A0 =A0- rgmii-channel =A0 =A0 : 1 cell, required iff connected to an R=
GMII. =A0Which
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RGMII channel is used b=
y this EMAC.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Fox Axon: present, what=
ever value is appropriate for each
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EMAC, that is the conte=
nt of the current (bogus) "phy-port"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 property.
> +
> + =A0 =A0Optional properties:
> + =A0 =A0- phy-address =A0 =A0 =A0 : 1 cell, optional, MDIO address of th=
e PHY. If absent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a search is performed.
> + =A0 =A0- phy-map =A0 =A0 =A0 =A0 =A0 : 1 cell, optional, bitmap of addr=
esses to probe the PHY
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for, used if phy-addres=
s is absent. bit 0x00000001 is
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MDIO address 0.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 For Axon it can be abse=
nt, though my current driver
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 doesn't handle phy-addr=
ess yet so for now, keep
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x00ffffff in it.
> + =A0 =A0- rx-fifo-size-gige : 1 cell, Rx fifo size in bytes for 1000 Mb/=
sec
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 operations (if absent t=
he value is the same as
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx-fifo-size). =A0For A=
xon, either absent or 2048.
> + =A0 =A0- tx-fifo-size-gige : 1 cell, Tx fifo size in bytes for 1000 Mb/=
sec
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 operations (if absent t=
he value is the same as
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx-fifo-size). For Axon=
, either absent or 2048.
> + =A0 =A0- tah-device =A0 =A0 =A0 =A0: 1 cell, optional. If connected to =
a TAH engine for
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 offload, phandle of the=
 TAH device node.
> + =A0 =A0- tah-channel =A0 =A0 =A0 : 1 cell, optional. If appropriate, ch=
annel used on the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TAH engine.
> +
> + =A0 =A0Example:
> +
> + =A0 =A0 =A0 EMAC0: ethernet@40000800 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "network";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ibm,emac-440gp", "ibm,emac"=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&UIC1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <1c 4 1d 4>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <40000800 70>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 local-mac-address =3D [00 04 AC E3 1B 1E];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mal-device =3D <&MAL0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mal-tx-channel =3D <0 1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mal-rx-channel =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max-frame-size =3D <5dc>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx-fifo-size =3D <1000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx-fifo-size =3D <800>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy-mode =3D "rmii";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy-map =3D <00000001>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 zmii-device =3D <&ZMII0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 zmii-channel =3D <0>;
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0ii) McMAL node
> +
> + =A0 =A0Required properties:
> + =A0 =A0- device_type =A0 =A0 =A0 =A0: "dma-controller"
> + =A0 =A0- compatible =A0 =A0 =A0 =A0 : compatible list, containing 2 ent=
ries, first is
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"ibm,mcmal-CHIP" whe=
re CHIP is the host ASIC (like
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0emac) and the second=
 is either "ibm,mcmal" or
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"ibm,mcmal2".
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0For Axon, "ibm,mcmal=
-axon","ibm,mcmal2"
> + =A0 =A0- interrupts =A0 =A0 =A0 =A0 : <interrupt mapping for the MAL in=
terrupts sources:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 5 sources: tx_eob, =
rx_eob, serr, txde, rxde>.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 For Axon: This is _=
different_ from the current
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0firmware. =A0We use =
the "delayed" interrupts for txeob
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0and rxeob. Thus we e=
nd up with mapping those 5 MPIC
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts, all leve=
l positive sensitive: 10, 11, 32,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A033, 34 (in decimal)
> + =A0 =A0- dcr-reg =A0 =A0 =A0 =A0 =A0 =A0: < DCR registers range >
> + =A0 =A0- dcr-parent =A0 =A0 =A0 =A0 : if needed for dcr-reg
> + =A0 =A0- num-tx-chans =A0 =A0 =A0 : 1 cell, number of Tx channels
> + =A0 =A0- num-rx-chans =A0 =A0 =A0 : 1 cell, number of Rx channels
> +
> + =A0 =A0 =A0iii) ZMII node
> +
> + =A0 =A0Required properties:
> + =A0 =A0- compatible =A0 =A0 =A0 =A0 : compatible list, containing 2 ent=
ries, first is
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"ibm,zmii-CHIP" wher=
e CHIP is the host ASIC (like
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EMAC) and the second=
 is "ibm,zmii".
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0For Axon, there is n=
o ZMII node.
> + =A0 =A0- reg =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: <registers mapping>
> +
> + =A0 =A0 =A0iv) RGMII node
> +
> + =A0 =A0Required properties:
> + =A0 =A0- compatible =A0 =A0 =A0 =A0 : compatible list, containing 2 ent=
ries, first is
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"ibm,rgmii-CHIP" whe=
re CHIP is the host ASIC (like
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EMAC) and the second=
 is "ibm,rgmii".
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 For Axon, "ibm,rgmi=
i-axon","ibm,rgmii"
> + =A0 =A0- reg =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: <registers mapping>
> + =A0 =A0- revision =A0 =A0 =A0 =A0 =A0 : as provided by the RGMII new ve=
rsion register if
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0available.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0For Axon: 0x0000012a
> +
> diff --git a/Documentation/powerpc/dts-bindings/gpio/gpio.txt b/Documenta=
tion/powerpc/dts-bindings/gpio/gpio.txt
> new file mode 100644
> index 0000000..edaa84d
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/gpio/gpio.txt
> @@ -0,0 +1,50 @@
> +Specifying GPIO information for devices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +1) gpios property
> +-----------------
> +
> +Nodes that makes use of GPIOs should define them using `gpios' property,
> +format of which is: <&gpio-controller1-phandle gpio1-specifier
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&gpio-controller2-phandle gpio2-=
specifier
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 /* holes are permitted, means =
no GPIO 3 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&gpio-controller4-phandle gpio4-=
specifier
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...>;
> +
> +Note that gpio-specifier length is controller dependent.
> +
> +gpio-specifier may encode: bank, pin position inside the bank,
> +whether pin is open-drain and whether pin is logically inverted.
> +
> +Example of the node using GPIOs:
> +
> + =A0 =A0 =A0 node {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpios =3D <&qe_pio_e 18 0>;
> + =A0 =A0 =A0 };
> +
> +In this example gpio-specifier is "18 0" and encodes GPIO pin number,
> +and empty GPIO flags as accepted by the "qe_pio_e" gpio-controller.
> +
> +2) gpio-controller nodes
> +------------------------
> +
> +Every GPIO controller node must have #gpio-cells property defined,
> +this information will be used to translate gpio-specifiers.
> +
> +Example of two SOC GPIO banks defined as gpio-controller nodes:
> +
> + =A0 =A0 =A0 qe_pio_a: gpio-controller@1400 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #gpio-cells =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,qe-pario-bank-a", "fsl,=
qe-pario-bank";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1400 0x18>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio-controller;
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 qe_pio_e: gpio-controller@1460 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #gpio-cells =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,qe-pario-bank-e", "fsl,=
qe-pario-bank";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1460 0x18>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio-controller;
> + =A0 =A0 =A0 };
> +
> +
> diff --git a/Documentation/powerpc/dts-bindings/gpio/mdio.txt b/Documenta=
tion/powerpc/dts-bindings/gpio/mdio.txt
> new file mode 100644
> index 0000000..bc95495
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/gpio/mdio.txt
> @@ -0,0 +1,19 @@
> +MDIO on GPIOs
> +
> +Currently defined compatibles:
> +- virtual,gpio-mdio
> +
> +MDC and MDIO lines connected to GPIO controllers are listed in the
> +gpios property as described in section VIII.1 in the following order:
> +
> +MDC, MDIO.
> +
> +Example:
> +
> +mdio {
> + =A0 =A0 =A0 compatible =3D "virtual,mdio-gpio";
> + =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 #size-cells =3D <0>;
> + =A0 =A0 =A0 gpios =3D <&qe_pio_a 11
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&qe_pio_c 6>;
> +};
> diff --git a/Documentation/powerpc/dts-bindings/marvell.txt b/Documentati=
on/powerpc/dts-bindings/marvell.txt
> new file mode 100644
> index 0000000..3708a2f
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/marvell.txt
> @@ -0,0 +1,521 @@
> +Marvell Discovery mv64[345]6x System Controller chips
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Marvell mv64[345]60 series of system controller chips contain
> +many of the peripherals needed to implement a complete computer
> +system. =A0In this section, we define device tree nodes to describe
> +the system controller chip itself and each of the peripherals
> +which it contains. =A0Compatible string values for each node are
> +prefixed with the string "marvell,", for Marvell Technology Group Ltd.
> +
> +1) The /system-controller node
> +
> + =A0This node is used to represent the system-controller and must be
> + =A0present when the system uses a system controller chip. The top-level
> + =A0system-controller node contains information that is global to all
> + =A0devices within the system controller chip. The node name begins
> + =A0with "system-controller" followed by the unit address, which is
> + =A0the base address of the memory-mapped register set for the system
> + =A0controller chip.
> +
> + =A0Required properties:
> +
> + =A0 =A0- ranges : Describes the translation of system controller addres=
ses
> + =A0 =A0 =A0for memory mapped registers.
> + =A0 =A0- clock-frequency: Contains the main clock frequency for the sys=
tem
> + =A0 =A0 =A0controller chip.
> + =A0 =A0- reg : This property defines the address and size of the
> + =A0 =A0 =A0memory-mapped registers contained within the system controll=
er
> + =A0 =A0 =A0chip. =A0The address specified in the "reg" property should =
match
> + =A0 =A0 =A0the unit address of the system-controller node.
> + =A0 =A0- #address-cells : Address representation for system controller
> + =A0 =A0 =A0devices. =A0This field represents the number of cells needed=
 to
> + =A0 =A0 =A0represent the address of the memory-mapped registers of devi=
ces
> + =A0 =A0 =A0within the system controller chip.
> + =A0 =A0- #size-cells : Size representation for for the memory-mapped
> + =A0 =A0 =A0registers within the system controller chip.
> + =A0 =A0- #interrupt-cells : Defines the width of cells used to represen=
t
> + =A0 =A0 =A0interrupts.
> +
> + =A0Optional properties:
> +
> + =A0 =A0- model : The specific model of the system controller chip. =A0S=
uch
> + =A0 =A0 =A0as, "mv64360", "mv64460", or "mv64560".
> + =A0 =A0- compatible : A string identifying the compatibility identifier=
s
> + =A0 =A0 =A0of the system controller chip.
> +
> + =A0The system-controller node contains child nodes for each system
> + =A0controller device that the platform uses. =A0Nodes should not be cre=
ated
> + =A0for devices which exist on the system controller chip but are not us=
ed
> +
> + =A0Example Marvell Discovery mv64360 system-controller node:
> +
> + =A0 =A0system-controller@f1000000 { /* Marvell Discovery mv64360 */
> + =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 model =3D "mv64360"; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0/* Default */
> + =A0 =A0 =A0 =A0 =A0 compatible =3D "marvell,mv64360";
> + =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <133333333>;
> + =A0 =A0 =A0 =A0 =A0 reg =3D <0xf1000000 0x10000>;
> + =A0 =A0 =A0 =A0 =A0 virtual-reg =3D <0xf1000000>;
> + =A0 =A0 =A0 =A0 =A0 ranges =3D <0x88000000 0x88000000 0x1000000 /* PCI =
0 I/O Space */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x80000000 0x80000000 0x8000000 /* =
PCI 0 MEM Space */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xa0000000 0xa0000000 0x4000000 /* =
User FLASH */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x00000000 0xf1000000 0x0010000 /* =
Bridge's regs */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xf2000000 0xf2000000 0x0040000>;/*=
 Integrated SRAM */
> +
> + =A0 =A0 =A0 =A0 =A0 [ child node definitions... ]
> + =A0 =A0}
> +
> +2) Child nodes of /system-controller
> +
> + =A0 a) Marvell Discovery MDIO bus
> +
> + =A0 The MDIO is a bus to which the PHY devices are connected. =A0For ea=
ch
> + =A0 device that exists on this bus, a child node should be created. =A0=
See
> + =A0 the definition of the PHY node below for an example of how to defin=
e
> + =A0 a PHY.
> +
> + =A0 Required properties:
> + =A0 =A0 - #address-cells : Should be <1>
> + =A0 =A0 - #size-cells : Should be <0>
> + =A0 =A0 - device_type : Should be "mdio"
> + =A0 =A0 - compatible : Should be "marvell,mv64360-mdio"
> +
> + =A0 Example:
> +
> + =A0 =A0 mdio {
> + =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "mdio";
> + =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-mdio";
> +
> + =A0 =A0 =A0 =A0 =A0 =A0ethernet-phy@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0......
> + =A0 =A0 =A0 =A0 =A0 =A0};
> + =A0 =A0 };
> +
> +
> + =A0 b) Marvell Discovery ethernet controller
> +
> + =A0 The Discover ethernet controller is described with two levels
> + =A0 of nodes. =A0The first level describes an ethernet silicon block
> + =A0 and the second level describes up to 3 ethernet nodes within
> + =A0 that block. =A0The reason for the multiple levels is that the
> + =A0 registers for the node are interleaved within a single set
> + =A0 of registers. =A0The "ethernet-block" level describes the
> + =A0 shared register set, and the "ethernet" nodes describe ethernet
> + =A0 port-specific properties.
> +
> + =A0 Ethernet block node
> +
> + =A0 Required properties:
> + =A0 =A0 - #address-cells : <1>
> + =A0 =A0 - #size-cells : <0>
> + =A0 =A0 - compatible : "marvell,mv64360-eth-block"
> + =A0 =A0 - reg : Offset and length of the register set for this block
> +
> + =A0 Example Discovery Ethernet block node:
> + =A0 =A0 ethernet-block@2000 {
> + =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-eth-block";
> + =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x2000 0x2000>;
> + =A0 =A0 =A0 =A0 =A0 =A0ethernet@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.......
> + =A0 =A0 =A0 =A0 =A0 =A0};
> + =A0 =A0 };
> +
> + =A0 Ethernet port node
> +
> + =A0 Required properties:
> + =A0 =A0 - device_type : Should be "network".
> + =A0 =A0 - compatible : Should be "marvell,mv64360-eth".
> + =A0 =A0 - reg : Should be <0>, <1>, or <2>, according to which register=
s
> + =A0 =A0 =A0 within the silicon block the device uses.
> + =A0 =A0 - interrupts : <a> where a is the interrupt number for the port=
.
> + =A0 =A0 - interrupt-parent : the phandle for the interrupt controller
> + =A0 =A0 =A0 that services interrupts for this device.
> + =A0 =A0 - phy : the phandle for the PHY connected to this ethernet
> + =A0 =A0 =A0 controller.
> + =A0 =A0 - local-mac-address : 6 bytes, MAC address
> +
> + =A0 Example Discovery Ethernet port node:
> + =A0 =A0 ethernet@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "network";
> + =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-eth";
> + =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <32>;
> + =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> + =A0 =A0 =A0 =A0 =A0 =A0phy =3D <&PHY0>;
> + =A0 =A0 =A0 =A0 =A0 =A0local-mac-address =3D [ 00 00 00 00 00 00 ];
> + =A0 =A0 };
> +
> +
> +
> + =A0 c) Marvell Discovery PHY nodes
> +
> + =A0 Required properties:
> + =A0 =A0 - device_type : Should be "ethernet-phy"
> + =A0 =A0 - interrupts : <a> where a is the interrupt number for this phy=
.
> + =A0 =A0 - interrupt-parent : the phandle for the interrupt controller t=
hat
> + =A0 =A0 =A0 services interrupts for this device.
> + =A0 =A0 - reg : The ID number for the phy, usually a small integer
> +
> + =A0 Example Discovery PHY node:
> + =A0 =A0 ethernet-phy@1 {
> + =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "ethernet-phy";
> + =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "broadcom,bcm5421";
> + =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <76>; =A0 =A0 =A0/* GPP 12 */
> + =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> + =A0 =A0 =A0 =A0 =A0 =A0reg =3D <1>;
> + =A0 =A0 };
> +
> +
> + =A0 d) Marvell Discovery SDMA nodes
> +
> + =A0 Represent DMA hardware associated with the MPSC (multiprotocol
> + =A0 serial controllers).
> +
> + =A0 Required properties:
> + =A0 =A0 - compatible : "marvell,mv64360-sdma"
> + =A0 =A0 - reg : Offset and length of the register set for this device
> + =A0 =A0 - interrupts : <a> where a is the interrupt number for the DMA
> + =A0 =A0 =A0 device.
> + =A0 =A0 - interrupt-parent : the phandle for the interrupt controller
> + =A0 =A0 =A0 that services interrupts for this device.
> +
> + =A0 Example Discovery SDMA node:
> + =A0 =A0 sdma@4000 {
> + =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-sdma";
> + =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x4000 0xc18>;
> + =A0 =A0 =A0 =A0 =A0 =A0virtual-reg =3D <0xf1004000>;
> + =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <36>;
> + =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> + =A0 =A0 };
> +
> +
> + =A0 e) Marvell Discovery BRG nodes
> +
> + =A0 Represent baud rate generator hardware associated with the MPSC
> + =A0 (multiprotocol serial controllers).
> +
> + =A0 Required properties:
> + =A0 =A0 - compatible : "marvell,mv64360-brg"
> + =A0 =A0 - reg : Offset and length of the register set for this device
> + =A0 =A0 - clock-src : A value from 0 to 15 which selects the clock
> + =A0 =A0 =A0 source for the baud rate generator. =A0This value correspon=
ds
> + =A0 =A0 =A0 to the CLKS value in the BRGx configuration register. =A0Se=
e
> + =A0 =A0 =A0 the mv64x60 User's Manual.
> + =A0 =A0 - clock-frequence : The frequency (in Hz) of the baud rate
> + =A0 =A0 =A0 generator's input clock.
> + =A0 =A0 - current-speed : The current speed setting (presumably by
> + =A0 =A0 =A0 firmware) of the baud rate generator.
> +
> + =A0 Example Discovery BRG node:
> + =A0 =A0 brg@b200 {
> + =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-brg";
> + =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xb200 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0clock-src =3D <8>;
> + =A0 =A0 =A0 =A0 =A0 =A0clock-frequency =3D <133333333>;
> + =A0 =A0 =A0 =A0 =A0 =A0current-speed =3D <9600>;
> + =A0 =A0 };
> +
> +
> + =A0 f) Marvell Discovery CUNIT nodes
> +
> + =A0 Represent the Serial Communications Unit device hardware.
> +
> + =A0 Required properties:
> + =A0 =A0 - reg : Offset and length of the register set for this device
> +
> + =A0 Example Discovery CUNIT node:
> + =A0 =A0 cunit@f200 {
> + =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xf200 0x200>;
> + =A0 =A0 };
> +
> +
> + =A0 g) Marvell Discovery MPSCROUTING nodes
> +
> + =A0 Represent the Discovery's MPSC routing hardware
> +
> + =A0 Required properties:
> + =A0 =A0 - reg : Offset and length of the register set for this device
> +
> + =A0 Example Discovery CUNIT node:
> + =A0 =A0 mpscrouting@b500 {
> + =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xb400 0xc>;
> + =A0 =A0 };
> +
> +
> + =A0 h) Marvell Discovery MPSCINTR nodes
> +
> + =A0 Represent the Discovery's MPSC DMA interrupt hardware registers
> + =A0 (SDMA cause and mask registers).
> +
> + =A0 Required properties:
> + =A0 =A0 - reg : Offset and length of the register set for this device
> +
> + =A0 Example Discovery MPSCINTR node:
> + =A0 =A0 mpsintr@b800 {
> + =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xb800 0x100>;
> + =A0 =A0 };
> +
> +
> + =A0 i) Marvell Discovery MPSC nodes
> +
> + =A0 Represent the Discovery's MPSC (Multiprotocol Serial Controller)
> + =A0 serial port.
> +
> + =A0 Required properties:
> + =A0 =A0 - device_type : "serial"
> + =A0 =A0 - compatible : "marvell,mv64360-mpsc"
> + =A0 =A0 - reg : Offset and length of the register set for this device
> + =A0 =A0 - sdma : the phandle for the SDMA node used by this port
> + =A0 =A0 - brg : the phandle for the BRG node used by this port
> + =A0 =A0 - cunit : the phandle for the CUNIT node used by this port
> + =A0 =A0 - mpscrouting : the phandle for the MPSCROUTING node used by th=
is port
> + =A0 =A0 - mpscintr : the phandle for the MPSCINTR node used by this por=
t
> + =A0 =A0 - cell-index : the hardware index of this cell in the MPSC core
> + =A0 =A0 - max_idle : value needed for MPSC CHR3 (Maximum Frame Length)
> + =A0 =A0 =A0 register
> + =A0 =A0 - interrupts : <a> where a is the interrupt number for the MPSC=
.
> + =A0 =A0 - interrupt-parent : the phandle for the interrupt controller
> + =A0 =A0 =A0 that services interrupts for this device.
> +
> + =A0 Example Discovery MPSCINTR node:
> + =A0 =A0 mpsc@8000 {
> + =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "serial";
> + =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-mpsc";
> + =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x8000 0x38>;
> + =A0 =A0 =A0 =A0 =A0 =A0virtual-reg =3D <0xf1008000>;
> + =A0 =A0 =A0 =A0 =A0 =A0sdma =3D <&SDMA0>;
> + =A0 =A0 =A0 =A0 =A0 =A0brg =3D <&BRG0>;
> + =A0 =A0 =A0 =A0 =A0 =A0cunit =3D <&CUNIT>;
> + =A0 =A0 =A0 =A0 =A0 =A0mpscrouting =3D <&MPSCROUTING>;
> + =A0 =A0 =A0 =A0 =A0 =A0mpscintr =3D <&MPSCINTR>;
> + =A0 =A0 =A0 =A0 =A0 =A0cell-index =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0max_idle =3D <40>;
> + =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <40>;
> + =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> + =A0 =A0 };
> +
> +
> + =A0 j) Marvell Discovery Watch Dog Timer nodes
> +
> + =A0 Represent the Discovery's watchdog timer hardware
> +
> + =A0 Required properties:
> + =A0 =A0 - compatible : "marvell,mv64360-wdt"
> + =A0 =A0 - reg : Offset and length of the register set for this device
> +
> + =A0 Example Discovery Watch Dog Timer node:
> + =A0 =A0 wdt@b410 {
> + =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-wdt";
> + =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xb410 0x8>;
> + =A0 =A0 };
> +
> +
> + =A0 k) Marvell Discovery I2C nodes
> +
> + =A0 Represent the Discovery's I2C hardware
> +
> + =A0 Required properties:
> + =A0 =A0 - device_type : "i2c"
> + =A0 =A0 - compatible : "marvell,mv64360-i2c"
> + =A0 =A0 - reg : Offset and length of the register set for this device
> + =A0 =A0 - interrupts : <a> where a is the interrupt number for the I2C.
> + =A0 =A0 - interrupt-parent : the phandle for the interrupt controller
> + =A0 =A0 =A0 that services interrupts for this device.
> +
> + =A0 Example Discovery I2C node:
> + =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-i2c";
> + =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xc000 0x20>;
> + =A0 =A0 =A0 =A0 =A0 =A0virtual-reg =3D <0xf100c000>;
> + =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <37>;
> + =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> + =A0 =A0 };
> +
> +
> + =A0 l) Marvell Discovery PIC (Programmable Interrupt Controller) nodes
> +
> + =A0 Represent the Discovery's PIC hardware
> +
> + =A0 Required properties:
> + =A0 =A0 - #interrupt-cells : <1>
> + =A0 =A0 - #address-cells : <0>
> + =A0 =A0 - compatible : "marvell,mv64360-pic"
> + =A0 =A0 - reg : Offset and length of the register set for this device
> + =A0 =A0 - interrupt-controller
> +
> + =A0 Example Discovery PIC node:
> + =A0 =A0 pic {
> + =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-pic";
> + =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x0 0x88>;
> + =A0 =A0 =A0 =A0 =A0 =A0interrupt-controller;
> + =A0 =A0 };
> +
> +
> + =A0 m) Marvell Discovery MPP (Multipurpose Pins) multiplexing nodes
> +
> + =A0 Represent the Discovery's MPP hardware
> +
> + =A0 Required properties:
> + =A0 =A0 - compatible : "marvell,mv64360-mpp"
> + =A0 =A0 - reg : Offset and length of the register set for this device
> +
> + =A0 Example Discovery MPP node:
> + =A0 =A0 mpp@f000 {
> + =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-mpp";
> + =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xf000 0x10>;
> + =A0 =A0 };
> +
> +
> + =A0 n) Marvell Discovery GPP (General Purpose Pins) nodes
> +
> + =A0 Represent the Discovery's GPP hardware
> +
> + =A0 Required properties:
> + =A0 =A0 - compatible : "marvell,mv64360-gpp"
> + =A0 =A0 - reg : Offset and length of the register set for this device
> +
> + =A0 Example Discovery GPP node:
> + =A0 =A0 gpp@f000 {
> + =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-gpp";
> + =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xf100 0x20>;
> + =A0 =A0 };
> +
> +
> + =A0 o) Marvell Discovery PCI host bridge node
> +
> + =A0 Represents the Discovery's PCI host bridge device. =A0The propertie=
s
> + =A0 for this node conform to Rev 2.1 of the PCI Bus Binding to IEEE
> + =A0 1275-1994. =A0A typical value for the compatible property is
> + =A0 "marvell,mv64360-pci".
> +
> + =A0 Example Discovery PCI host bridge node
> + =A0 =A0 pci@80000000 {
> + =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <3>;
> + =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> + =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-pci";
> + =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xcf8 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0ranges =3D <0x01000000 0x0 =A0 =A0 =A0 =A00x0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x88000000 0x0 0=
x01000000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x02000000 0x0 0x80000000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x80000000 0x0 0=
x08000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0bus-range =3D <0 255>;
> + =A0 =A0 =A0 =A0 =A0 =A0clock-frequency =3D <66000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> + =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7>;
> + =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0x0a */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x5000 0 0 1 &PIC 80
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x5000 0 0 2 &PIC 81
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x5000 0 0 3 &PIC 91
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x5000 0 0 4 &PIC 93
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0x0b */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x5800 0 0 1 &PIC 91
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x5800 0 0 2 &PIC 93
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x5800 0 0 3 &PIC 80
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x5800 0 0 4 &PIC 81
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0x0c */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6000 0 0 1 &PIC 91
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6000 0 0 2 &PIC 93
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6000 0 0 3 &PIC 80
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6000 0 0 4 &PIC 81
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0x0d */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6800 0 0 1 &PIC 93
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6800 0 0 2 &PIC 80
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6800 0 0 3 &PIC 81
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6800 0 0 4 &PIC 91
> + =A0 =A0 =A0 =A0 =A0 =A0>;
> + =A0 =A0 };
> +
> +
> + =A0 p) Marvell Discovery CPU Error nodes
> +
> + =A0 Represent the Discovery's CPU error handler device.
> +
> + =A0 Required properties:
> + =A0 =A0 - compatible : "marvell,mv64360-cpu-error"
> + =A0 =A0 - reg : Offset and length of the register set for this device
> + =A0 =A0 - interrupts : the interrupt number for this device
> + =A0 =A0 - interrupt-parent : the phandle for the interrupt controller
> + =A0 =A0 =A0 that services interrupts for this device.
> +
> + =A0 Example Discovery CPU Error node:
> + =A0 =A0 cpu-error@0070 {
> + =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-cpu-error";
> + =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x70 0x10 0x128 0x28>;
> + =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <3>;
> + =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> + =A0 =A0 };
> +
> +
> + =A0 q) Marvell Discovery SRAM Controller nodes
> +
> + =A0 Represent the Discovery's SRAM controller device.
> +
> + =A0 Required properties:
> + =A0 =A0 - compatible : "marvell,mv64360-sram-ctrl"
> + =A0 =A0 - reg : Offset and length of the register set for this device
> + =A0 =A0 - interrupts : the interrupt number for this device
> + =A0 =A0 - interrupt-parent : the phandle for the interrupt controller
> + =A0 =A0 =A0 that services interrupts for this device.
> +
> + =A0 Example Discovery SRAM Controller node:
> + =A0 =A0 sram-ctrl@0380 {
> + =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-sram-ctrl";
> + =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x380 0x80>;
> + =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <13>;
> + =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> + =A0 =A0 };
> +
> +
> + =A0 r) Marvell Discovery PCI Error Handler nodes
> +
> + =A0 Represent the Discovery's PCI error handler device.
> +
> + =A0 Required properties:
> + =A0 =A0 - compatible : "marvell,mv64360-pci-error"
> + =A0 =A0 - reg : Offset and length of the register set for this device
> + =A0 =A0 - interrupts : the interrupt number for this device
> + =A0 =A0 - interrupt-parent : the phandle for the interrupt controller
> + =A0 =A0 =A0 that services interrupts for this device.
> +
> + =A0 Example Discovery PCI Error Handler node:
> + =A0 =A0 pci-error@1d40 {
> + =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-pci-error";
> + =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x1d40 0x40 0xc28 0x4>;
> + =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <12>;
> + =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> + =A0 =A0 };
> +
> +
> + =A0 s) Marvell Discovery Memory Controller nodes
> +
> + =A0 Represent the Discovery's memory controller device.
> +
> + =A0 Required properties:
> + =A0 =A0 - compatible : "marvell,mv64360-mem-ctrl"
> + =A0 =A0 - reg : Offset and length of the register set for this device
> + =A0 =A0 - interrupts : the interrupt number for this device
> + =A0 =A0 - interrupt-parent : the phandle for the interrupt controller
> + =A0 =A0 =A0 that services interrupts for this device.
> +
> + =A0 Example Discovery Memory Controller node:
> + =A0 =A0 mem-ctrl@1400 {
> + =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,mv64360-mem-ctrl";
> + =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x1400 0x60>;
> + =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <17>;
> + =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> + =A0 =A0 };
> +
> +
> diff --git a/Documentation/powerpc/dts-bindings/phy.txt b/Documentation/p=
owerpc/dts-bindings/phy.txt
> new file mode 100644
> index 0000000..bb8c742
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/phy.txt
> @@ -0,0 +1,25 @@
> +PHY nodes
> +
> +Required properties:
> +
> + - device_type : Should be "ethernet-phy"
> + - interrupts : <a b> where a is the interrupt number and b is a
> + =A0 field that represents an encoding of the sense and level
> + =A0 information for the interrupt. =A0This should be encoded based on
> + =A0 the information in section 2) depending on the type of interrupt
> + =A0 controller you have.
> + - interrupt-parent : the phandle for the interrupt controller that
> + =A0 services interrupts for this device.
> + - reg : The ID number for the phy, usually a small integer
> + - linux,phandle : =A0phandle for this node; likely referenced by an
> + =A0 ethernet controller node.
> +
> +Example:
> +
> +ethernet-phy@0 {
> + =A0 =A0 =A0 linux,phandle =3D <2452000>
> + =A0 =A0 =A0 interrupt-parent =3D <40000>;
> + =A0 =A0 =A0 interrupts =3D <35 1>;
> + =A0 =A0 =A0 reg =3D <0>;
> + =A0 =A0 =A0 device_type =3D "ethernet-phy";
> +};
> diff --git a/Documentation/powerpc/dts-bindings/spi-bus.txt b/Documentati=
on/powerpc/dts-bindings/spi-bus.txt
> new file mode 100644
> index 0000000..e782add
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/spi-bus.txt
> @@ -0,0 +1,57 @@
> +SPI (Serial Peripheral Interface) busses
> +
> +SPI busses can be described with a node for the SPI master device
> +and a set of child nodes for each SPI slave on the bus. =A0For this
> +discussion, it is assumed that the system's SPI controller is in
> +SPI master mode. =A0This binding does not describe SPI controllers
> +in slave mode.
> +
> +The SPI master node requires the following properties:
> +- #address-cells =A0- number of cells required to define a chip select
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 address on the SPI bus.
> +- #size-cells =A0 =A0 - should be zero.
> +- compatible =A0 =A0 =A0- name of SPI bus controller following generic n=
ames
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 recommended practice.
> +No other properties are required in the SPI bus node. =A0It is assumed
> +that a driver for an SPI bus device will understand that it is an SPI bu=
s.
> +However, the binding does not attempt to define the specific method for
> +assigning chip select numbers. =A0Since SPI chip select configuration is
> +flexible and non-standardized, it is left out of this binding with the
> +assumption that board specific platform code will be used to manage
> +chip selects. =A0Individual drivers can define additional properties to
> +support describing the chip select layout.
> +
> +SPI slave nodes must be children of the SPI master node and can
> +contain the following properties.
> +- reg =A0 =A0 =A0 =A0 =A0 =A0 - (required) chip select address of device=
.
> +- compatible =A0 =A0 =A0- (required) name of SPI device following generi=
c names
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 recommended practice
> +- spi-max-frequency - (required) Maximum SPI clocking speed of device in=
 Hz
> +- spi-cpol =A0 =A0 =A0 =A0- (optional) Empty property indicating device =
requires
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 inverse clock polarity (CPOL) mode
> +- spi-cpha =A0 =A0 =A0 =A0- (optional) Empty property indicating device =
requires
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 shifted clock phase (CPHA) mode
> +- spi-cs-high =A0 =A0 - (optional) Empty property indicating device requ=
ires
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip select active high
> +
> +SPI example for an MPC5200 SPI bus:
> + =A0 =A0 =A0 spi@f00 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5200b-spi","fsl,mpc5=
200-spi";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0xf00 0x20>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <2 13 0 2 14 0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&mpc5200_pic>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ethernet-switch@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "micrel,ks89=
95m";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi-max-frequency =3D <1000=
000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 codec@1 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,tlv320ai=
c26";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi-max-frequency =3D <1000=
00>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> diff --git a/Documentation/powerpc/dts-bindings/usb-ehci.txt b/Documentat=
ion/powerpc/dts-bindings/usb-ehci.txt
> new file mode 100644
> index 0000000..fa18612
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/usb-ehci.txt
> @@ -0,0 +1,25 @@
> +USB EHCI controllers
> +
> +Required properties:
> + =A0- compatible : should be "usb-ehci".
> + =A0- reg : should contain at least address and length of the standard E=
HCI
> + =A0 =A0register set for the device. Optional platform-dependent registe=
rs
> + =A0 =A0(debug-port or other) can be also specified here, but only after
> + =A0 =A0definition of standard EHCI registers.
> + =A0- interrupts : one EHCI interrupt should be described here.
> +If device registers are implemented in big endian mode, the device
> +node should have "big-endian-regs" property.
> +If controller implementation operates with big endian descriptors,
> +"big-endian-desc" property should be specified.
> +If both big endian registers and descriptors are used by the controller
> +implementation, "big-endian" property can be specified instead of having
> +both "big-endian-regs" and "big-endian-desc".
> +
> +Example (Sequoia 440EPx):
> + =A0 =A0ehci@e0000300 {
> + =A0 =A0 =A0 =A0 =A0compatible =3D "ibm,usb-ehci-440epx", "usb-ehci";
> + =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&UIC0>;
> + =A0 =A0 =A0 =A0 =A0interrupts =3D <1a 4>;
> + =A0 =A0 =A0 =A0 =A0reg =3D <0 e0000300 90 0 e0000390 70>;
> + =A0 =A0 =A0 =A0 =A0big-endian;
> + =A0 };
> diff --git a/Documentation/powerpc/dts-bindings/xilinx.txt b/Documentatio=
n/powerpc/dts-bindings/xilinx.txt
> new file mode 100644
> index 0000000..80339fe
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/xilinx.txt
> @@ -0,0 +1,295 @@
> + =A0 d) Xilinx IP cores
> +
> + =A0 The Xilinx EDK toolchain ships with a set of IP cores (devices) for=
 use
> + =A0 in Xilinx Spartan and Virtex FPGAs. =A0The devices cover the whole =
range
> + =A0 of standard device types (network, serial, etc.) and miscellaneous
> + =A0 devices (gpio, LCD, spi, etc). =A0Also, since these devices are
> + =A0 implemented within the fpga fabric every instance of the device can=
 be
> + =A0 synthesised with different options that change the behaviour.
> +
> + =A0 Each IP-core has a set of parameters which the FPGA designer can us=
e to
> + =A0 control how the core is synthesized. =A0Historically, the EDK tool =
would
> + =A0 extract the device parameters relevant to device drivers and copy t=
hem
> + =A0 into an 'xparameters.h' in the form of #define symbols. =A0This tel=
ls the
> + =A0 device drivers how the IP cores are configured, but it requres the =
kernel
> + =A0 to be recompiled every time the FPGA bitstream is resynthesized.
> +
> + =A0 The new approach is to export the parameters into the device tree a=
nd
> + =A0 generate a new device tree each time the FPGA bitstream changes. =
=A0The
> + =A0 parameters which used to be exported as #defines will now become
> + =A0 properties of the device node. =A0In general, device nodes for IP-c=
ores
> + =A0 will take the following form:
> +
> + =A0 =A0 =A0 (name): (generic-name)@(base-address) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,(ip-core-name)-(HW_VER=
)"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[, (list of comp=
atible devices), ...];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <(baseaddr) (size)>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&interrupt-controller=
-phandle>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D < ... >;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,(parameter1) =3D "(string-value)";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,(parameter2) =3D <(int-value)>;
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 (generic-name): =A0 an open firmware-style name that descri=
bes the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 generic class of device. =
=A0Preferably, this is one word, such
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 as 'serial' or 'ethernet'.
> + =A0 =A0 =A0 (ip-core-name): the name of the ip block (given after the B=
EGIN
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 directive in system.mhs). =
=A0Should be in lowercase
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 and all underscores '_' con=
verted to dashes '-'.
> + =A0 =A0 =A0 (name): =A0 =A0 =A0 =A0 is derived from the "PARAMETER INST=
ANCE" value.
> + =A0 =A0 =A0 (parameter#): =A0 C_* parameters from system.mhs. =A0The C_=
 prefix is
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dropped from the parameter =
name, the name is converted
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 to lowercase and all unders=
core '_' characters are
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 converted to dashes '-'.
> + =A0 =A0 =A0 (baseaddr): =A0 =A0 the baseaddr parameter value (often nam=
ed C_BASEADDR).
> + =A0 =A0 =A0 (HW_VER): =A0 =A0 =A0 from the HW_VER parameter.
> + =A0 =A0 =A0 (size): =A0 =A0 =A0 =A0 the address range size (often C_HIG=
HADDR - C_BASEADDR + 1).
> +
> + =A0 Typically, the compatible list will include the exact IP core versi=
on
> + =A0 followed by an older IP core version which implements the same
> + =A0 interface or any other device with the same interface.
> +
> + =A0 'reg', 'interrupt-parent' and 'interrupts' are all optional propert=
ies.
> +
> + =A0 For example, the following block from system.mhs:
> +
> + =A0 =A0 =A0 BEGIN opb_uartlite
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER INSTANCE =3D opb_uartlite_0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER HW_VER =3D 1.00.b
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_BAUDRATE =3D 115200
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_DATA_BITS =3D 8
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_ODD_PARITY =3D 0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_USE_PARITY =3D 0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_CLK_FREQ =3D 50000000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_BASEADDR =3D 0xEC100000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_HIGHADDR =3D 0xEC10FFFF
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUS_INTERFACE SOPB =3D opb_7
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT OPB_Clk =3D CLK_50MHz
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Interrupt =3D opb_uartlite_0_Interrupt
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT RX =3D opb_uartlite_0_RX
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT TX =3D opb_uartlite_0_TX
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT OPB_Rst =3D sys_bus_reset_0
> + =A0 =A0 =A0 END
> +
> + =A0 becomes the following device tree node:
> +
> + =A0 =A0 =A0 opb_uartlite_0: serial@ec100000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "serial";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,opb-uartlite-1.00.b";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <ec100000 10000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&opb_intc_0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <1 0>; // got this from the =
opb_intc parameters
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 current-speed =3D <d#115200>; =A0 =A0 // st=
andard serial device prop
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <d#50000000>; // standa=
rd serial device prop
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,data-bits =3D <8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,odd-parity =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,use-parity =3D <0>;
> + =A0 =A0 =A0 };
> +
> + =A0 Some IP cores actually implement 2 or more logical devices. =A0In
> + =A0 this case, the device should still describe the whole IP core with
> + =A0 a single node and add a child node for each logical device. =A0The
> + =A0 ranges property can be used to translate from parent IP-core to the
> + =A0 registers of each device. =A0In addition, the parent node should be
> + =A0 compatible with the bus type 'xlnx,compound', and should contain
> + =A0 #address-cells and #size-cells, as with any other bus. =A0(Note: th=
is
> + =A0 makes the assumption that both logical devices have the same bus
> + =A0 binding. =A0If this is not true, then separate nodes should be used
> + =A0 for each logical device). =A0The 'cell-index' property can be used =
to
> + =A0 enumerate logical devices within an IP core. =A0For example, the
> + =A0 following is the system.mhs entry for the dual ps2 controller found
> + =A0 on the ml403 reference design.
> +
> + =A0 =A0 =A0 BEGIN opb_ps2_dual_ref
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER INSTANCE =3D opb_ps2_dual_ref_0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER HW_VER =3D 1.00.a
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_BASEADDR =3D 0xA9000000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_HIGHADDR =3D 0xA9001FFF
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUS_INTERFACE SOPB =3D opb_v20_0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Sys_Intr1 =3D ps2_1_intr
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Sys_Intr2 =3D ps2_2_intr
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Clkin1 =3D ps2_clk_rx_1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Clkin2 =3D ps2_clk_rx_2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Clkpd1 =3D ps2_clk_tx_1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Clkpd2 =3D ps2_clk_tx_2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Rx1 =3D ps2_d_rx_1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Rx2 =3D ps2_d_rx_2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Txpd1 =3D ps2_d_tx_1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT Txpd2 =3D ps2_d_tx_2
> + =A0 =A0 =A0 END
> +
> + =A0 It would result in the following device tree nodes:
> +
> + =A0 =A0 =A0 opb_ps2_dual_ref_0: opb-ps2-dual-ref@a9000000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,compound";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0 a9000000 2000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // If this device had extra parameters, the=
n they would
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // go here.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ps2@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,opb-ps=
2-dual-ref-1.00.a";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0 40>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&opb_=
intc_0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <3 0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ps2@1000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,opb-ps=
2-dual-ref-1.00.a";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <1000 40>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&opb_=
intc_0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <3 0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> +
> + =A0 Also, the system.mhs file defines bus attachments from the processo=
r
> + =A0 to the devices. =A0The device tree structure should reflect the bus
> + =A0 attachments. =A0Again an example; this system.mhs fragment:
> +
> + =A0 =A0 =A0 BEGIN ppc405_virtex4
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER INSTANCE =3D ppc405_0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER HW_VER =3D 1.01.a
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUS_INTERFACE DPLB =3D plb_v34_0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUS_INTERFACE IPLB =3D plb_v34_0
> + =A0 =A0 =A0 END
> +
> + =A0 =A0 =A0 BEGIN opb_intc
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER INSTANCE =3D opb_intc_0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER HW_VER =3D 1.00.c
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_BASEADDR =3D 0xD1000FC0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_HIGHADDR =3D 0xD1000FDF
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUS_INTERFACE SOPB =3D opb_v20_0
> + =A0 =A0 =A0 END
> +
> + =A0 =A0 =A0 BEGIN opb_uart16550
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER INSTANCE =3D opb_uart16550_0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER HW_VER =3D 1.00.d
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_BASEADDR =3D 0xa0000000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_HIGHADDR =3D 0xa0001FFF
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUS_INTERFACE SOPB =3D opb_v20_0
> + =A0 =A0 =A0 END
> +
> + =A0 =A0 =A0 BEGIN plb_v34
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER INSTANCE =3D plb_v34_0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER HW_VER =3D 1.02.a
> + =A0 =A0 =A0 END
> +
> + =A0 =A0 =A0 BEGIN plb_bram_if_cntlr
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER INSTANCE =3D plb_bram_if_cntlr_0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER HW_VER =3D 1.00.b
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_BASEADDR =3D 0xFFFF0000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_HIGHADDR =3D 0xFFFFFFFF
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUS_INTERFACE SPLB =3D plb_v34_0
> + =A0 =A0 =A0 END
> +
> + =A0 =A0 =A0 BEGIN plb2opb_bridge
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER INSTANCE =3D plb2opb_bridge_0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER HW_VER =3D 1.01.a
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_RNG0_BASEADDR =3D 0x20000000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_RNG0_HIGHADDR =3D 0x3FFFFFFF
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_RNG1_BASEADDR =3D 0x60000000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_RNG1_HIGHADDR =3D 0x7FFFFFFF
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_RNG2_BASEADDR =3D 0x80000000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_RNG2_HIGHADDR =3D 0xBFFFFFFF
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_RNG3_BASEADDR =3D 0xC0000000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARAMETER C_RNG3_HIGHADDR =3D 0xDFFFFFFF
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUS_INTERFACE SPLB =3D plb_v34_0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUS_INTERFACE MOPB =3D opb_v20_0
> + =A0 =A0 =A0 END
> +
> + =A0 Gives this device tree (some properties removed for clarity):
> +
> + =A0 =A0 =A0 plb@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,plb-v34-1.02.a";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "ibm,plb";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges; // 1:1 translation
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 plb_bram_if_cntrl_0: bram@ffff0000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <ffff0000 10000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 opb@20000000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <20000000 200000=
00 20000000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 6000000=
0 60000000 20000000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 8000000=
0 80000000 40000000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c000000=
0 c0000000 20000000>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 opb_uart16550_0: serial@a00=
00000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <a0=
0000000 2000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 opb_intc_0: interrupt-contr=
oller@d1000fc0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <d1=
000fc0 20>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> +
> + =A0 That covers the general approach to binding xilinx IP cores into th=
e
> + =A0 device tree. =A0The following are bindings for specific devices:
> +
> + =A0 =A0 =A0i) Xilinx ML300 Framebuffer
> +
> + =A0 =A0 =A0Simple framebuffer device from the ML300 reference design (a=
lso on the
> + =A0 =A0 =A0ML403 reference design as well as others).
> +
> + =A0 =A0 =A0Optional properties:
> + =A0 =A0 =A0 - resolution =3D <xres yres> : pixel resolution of framebuf=
fer. =A0Some
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
implementations use a different resolution.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
Default is <d#640 d#480>
> + =A0 =A0 =A0 - virt-resolution =3D <xvirt yvirt> : Size of framebuffer i=
n memory.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 Default is <d#1024 d#480>.
> + =A0 =A0 =A0 - rotate-display (empty) : rotate display 180 degrees.
> +
> + =A0 =A0 =A0ii) Xilinx SystemACE
> +
> + =A0 =A0 =A0The Xilinx SystemACE device is used to program FPGAs from an=
 FPGA
> + =A0 =A0 =A0bitstream stored on a CF card. =A0It can also be used as a g=
eneric CF
> + =A0 =A0 =A0interface device.
> +
> + =A0 =A0 =A0Optional properties:
> + =A0 =A0 =A0 - 8-bit (empty) : Set this property for SystemACE in 8 bit =
mode
> +
> + =A0 =A0 =A0iii) Xilinx EMAC and Xilinx TEMAC
> +
> + =A0 =A0 =A0Xilinx Ethernet devices. =A0In addition to general xilinx pr=
operties
> + =A0 =A0 =A0listed above, nodes for these devices should include a phy-h=
andle
> + =A0 =A0 =A0property, and may include other common network device proper=
ties
> + =A0 =A0 =A0like local-mac-address.
> +
> + =A0 =A0 =A0iv) Xilinx Uartlite
> +
> + =A0 =A0 =A0Xilinx uartlite devices are simple fixed speed serial ports.
> +
> + =A0 =A0 =A0Required properties:
> + =A0 =A0 =A0 - current-speed : Baud rate of uartlite
> +
> + =A0 =A0 =A0v) Xilinx hwicap
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 Xilinx hwicap devices provide access to the=
 configuration logic
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of the FPGA through the Internal Configurat=
ion Access Port
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ICAP). =A0The ICAP enables partial reconfi=
guration of the FPGA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 readback of the configuration information, =
and some control over
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 'warm boots' of the FPGA fabric.
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 Required properties:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 - xlnx,family : The family of the FPGA, nec=
essary since the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0capabilities of the underlyi=
ng ICAP hardware
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0differ between different fam=
ilies. =A0May be
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0'virtex2p', 'virtex4', or 'v=
irtex5'.
> +
> + =A0 =A0 =A0vi) Xilinx Uart 16550
> +
> + =A0 =A0 =A0Xilinx UART 16550 devices are very similar to the NS16550 bu=
t with
> + =A0 =A0 =A0different register spacing and an offset from the base addre=
ss.
> +
> + =A0 =A0 =A0Required properties:
> + =A0 =A0 =A0 - clock-frequency : Frequency of the clock input
> + =A0 =A0 =A0 - reg-offset : A value of 3 is required
> + =A0 =A0 =A0 - reg-shift : A value of 2 is required
> +
> +
> --
> 1.6.0.6
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
