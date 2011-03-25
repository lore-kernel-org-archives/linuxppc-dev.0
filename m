Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C99FFB6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Mar 2011 15:21:06 +1100 (EST)
Subject: Re: Query: PCIe range entry at pcie@0 in dts files
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <071A08F2C6A57E4E94D980ECA553F874154CD3@039-SN1MPN1-004.039d.mgd.msft.net>
Date: Thu, 24 Mar 2011 23:20:56 -0500
Message-Id: <013F9859-851E-4D61-BB7C-F6987DBECFF8@kernel.crashing.org>
References: <071A08F2C6A57E4E94D980ECA553F874154CD3@039-SN1MPN1-004.039d.mgd.msft.net>
To: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 23, 2011, at 10:20 PM, Kushwaha Prabhakar-B32579 wrote:

>=20
> Hi all,
>=20
> I have query about usage of range field at pcie@0 under PCIe =
controller. Please find snap shot from mpc8536_36.dts..
>=20
> 	pci3: pcie@fffe0b000 {
> 		compatible =3D "fsl,mpc8548-pcie";
> 		device_type =3D "pci";
> 		#interrupt-cells =3D <1>;
> 		#size-cells =3D <2>;
> 		#address-cells =3D <3>;
> 		reg =3D <0xf 0xffe0b000 0 0x1000>;
> 		bus-range =3D <0 0xff>;
> 		ranges =3D <0x02000000 0 0xe0000000 0xc 0x20000000 0 =
0x20000000
> 			  0x01000000 0 0x00000000 0xf 0xffc30000 0 =
0x00010000>;
> 		clock-frequency =3D <33333333>;
> 		interrupt-parent =3D <&mpic>;
> 		interrupts =3D <27 0x2>;
> 		interrupt-map-mask =3D <0xf800 0 0 7>;
> 		interrupt-map =3D <
> 			/* IDSEL 0x0 */
> 			0000 0 0 1 &mpic 8 1
> 			0000 0 0 2 &mpic 9 1
> 			0000 0 0 3 &mpic 10 1
> 			0000 0 0 4 &mpic 11 1
> 			>;
>=20
> 		pcie@0 {
> 			reg =3D <0 0 0 0 0>;
> 			#size-cells =3D <2>;
> 			#address-cells =3D <3>;
> 			device_type =3D "pci";
> 			ranges =3D <0x02000000 0 0xe0000000 --> =
child/port start address
> 				  0x02000000 0 0xe0000000 --> Parent bus =
address
> 				  0 0x20000000
>=20
> 				  0x01000000 0 0x00000000
> 				  0x01000000 0 0x00000000
> 				  0 0x00100000>;
> 		};
> 	};
>=20
> Question:
> A) is ranges filed of pcie@0 really required?
> 	 I just went through the code and found scan_OF_for_pci_dev() =
called from pci_busdev_to_OF_node() touches pcie@0 node. But, It does =
not even uses range filed.=20
>=20
> 	static struct device_node *scan_OF_for_pci_dev(struct =
device_node *parent,unsigned int devfn) {
> 		 ---
>       	---
> 		for_each_child_of_node(parent, np) {
> 			reg =3D of_get_property(np, "reg", &psize);=20
>=20
> 		  ---
> 		  ---
>            	    if (!strcmp(np->name, "multifunc-device")) {=20
> 	     =20
> 	}
>=20
>   I also checked "Power_ePAPR_APPROVED_v1.0.pdf". It never say range =
filed required for child bus.

Part of the reason for the range is to match PCIe semantics of RC having =
a transparent bridge.

>=20
> B) if range field of pcie@0 required. why does child/port start =
address same as Parent bus address?  Range property provides mapping of =
port address to parent address space.
> So the value should be 0x00000000. Means port's address starting from =
0x00000000 to size 0x20000000 is mapped parent's 0xe0000000.
>=20
> 			ranges =3D <0x02000000 0 0x00000000  --> =
Child/port's start address
> 				  0x02000000 0 0xe0000000    --> Parent =
bus address
> 				  0 0x20000000
>=20
> 				  0x01000000 0 0x00000000
> 				  0x01000000 0 0x00000000
> 				  0 0x00100000>;


because the bridge is transparent.

- k=
