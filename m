Return-Path: <B32579@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D622FB6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Mar 2011 15:19:07 +1100 (EST)
Received: from mail71-db3 (localhost.localdomain [127.0.0.1])	by
	mail71-db3-R.bigfish.com (Postfix) with ESMTP id D079C1683F4	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2011 04:18:59 +0000 (UTC)
Received: from DB3EHSMHS009.bigfish.com (unknown [10.3.81.245])	by
	mail71-db3.bigfish.com (Postfix) with ESMTP id 803841208052	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2011 04:18:59 +0000 (UTC)
From: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Query: PCIe range entry at pcie@0 in dts files
Date: Tue, 22 Mar 2011 04:18:56 +0000
Message-ID: <071A08F2C6A57E4E94D980ECA553F874150769@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

 I have query about usage of range field at pcie@0 under PCIe controller. P=
lease find snap shot from mpc8536_36.dts..

	pci3: pcie@fffe0b000 {
		compatible =3D "fsl,mpc8548-pcie";
		device_type =3D "pci";
		#interrupt-cells =3D <1>;
		#size-cells =3D <2>;
		#address-cells =3D <3>;
		reg =3D <0xf 0xffe0b000 0 0x1000>;
		bus-range =3D <0 0xff>;
		ranges =3D <0x02000000 0 0xe0000000 0xc 0x20000000 0 0x20000000
			  0x01000000 0 0x00000000 0xf 0xffc30000 0 0x00010000>;
		clock-frequency =3D <33333333>;
		interrupt-parent =3D <&mpic>;
		interrupts =3D <27 0x2>;
		interrupt-map-mask =3D <0xf800 0 0 7>;
		interrupt-map =3D <
			/* IDSEL 0x0 */
			0000 0 0 1 &mpic 8 1
			0000 0 0 2 &mpic 9 1
			0000 0 0 3 &mpic 10 1
			0000 0 0 4 &mpic 11 1
			>;

		pcie@0 {
			reg =3D <0 0 0 0 0>;
			#size-cells =3D <2>;
			#address-cells =3D <3>;
			device_type =3D "pci";
			ranges =3D <0x02000000 0 0xe0000000 --> child/port start address
				  0x02000000 0 0xe0000000 --> Parent bus address
				  0 0x20000000

				  0x01000000 0 0x00000000
				  0x01000000 0 0x00000000
				  0 0x00100000>;
		};
	};

Question:
A) is ranges filed of pcie@0 really required?
	 I just went through the code and found scan_OF_for_pci_dev() called from =
pci_busdev_to_OF_node() touches pcie@0 node. But, It does not even uses ran=
ge filed.=20

	static struct device_node *scan_OF_for_pci_dev(struct device_node *parent,=
unsigned int devfn) {
		 ---
       	---
		for_each_child_of_node(parent, np) {
			reg =3D of_get_property(np, "reg", &psize);=20
     =20
		  ---
		  ---
            	    if (!strcmp(np->name, "multifunc-device")) {=20
	     =20
	}

   I also checked "Power_ePAPR_APPROVED_v1.0.pdf". It never say range filed=
 required for child bus.

B) if range field of pcie@0 required. why does child/port start address sam=
e as Parent bus address?  Range property provides mapping of port address t=
o parent address space.
So the value should be 0x00000000. Means port's address starting from 0x000=
00000 to size 0x20000000 is mapped parent's 0xe0000000.

			ranges =3D <0x02000000 0 0x00000000  --> Child/port's start address
				  0x02000000 0 0xe0000000    --> Parent bus address
				  0 0x20000000

				  0x01000000 0 0x00000000
				  0x01000000 0 0x00000000
				  0 0x00100000>;


--Prabhakar
