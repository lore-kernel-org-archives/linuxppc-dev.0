Return-Path: <bingquan.hu@nsn.com>
Received: from demumfd001.nsn-inter.net (demumfd001.nsn-inter.net
	[93.183.12.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "demumfd001.nsn-inter.net",
	Issuer "VeriSign Class 3 Secure Server CA - G2" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A742FB7D96
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 28 Feb 2010 11:19:55 +1100 (EST)
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
	by demumfd001.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id
	o1RNxXl2003215
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Feb 2010 00:59:33 +0100
Received: from demuexc022.nsn-intra.net (demuexc022.nsn-intra.net
	[10.150.128.35])
	by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP
	id o1RNxWCo012970
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Feb 2010 00:59:33 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: PCIe switch driver in Linux 2.6.29
Date: Sun, 28 Feb 2010 07:59:29 +0800
Message-ID: <797F7FD014326E46BA47ECF3EB7131DBFC196C@CNBEEXC007.nsn-intra.net>
From: "Hu, Bingquan (NSN - CN/Shanghai)" <bingquan.hu@nsn.com>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I am new to this mail list and this is my first post, I apologize if I =
break some rules.

Description of the problem:
We incorporated Freescale MPC8548E CPU, PLX PEX8648 PCIe switch and =
Altera FPGA into our solution.
FPGA has one prefetchable 64-bit BAR 0 and 32-bit non-prefetchable =
Bar2.It was recognized successfully,as well as the PCIe switch.
But there are resources collisions on the upstream bridge and the =
downstream bridge connected to FPGA.
the startup log, as well the device tree, is shown below.

My question is:=20
am I missing something in the device tree that standa for the PCIe =
switch?
Do I need to code in the Linux kernel to fix this problem?

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D startup log =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
pci 0000:01:00.0: device not available because of BAR 0 =
[0xb0000000-0xb001ffff] collisions
pci 0000:01:00.0: device not available because of BAR 8 =
[0xb0000000-0xb00fffff] collisions
pci 0000:01:00.0: device not available because of BAR 9 =
[0xa0000000-0xa0ffffff] collisions
pci 0000:02:08.0: device not available because of BAR 8 =
[0xb0000000-0xb00fffff] collisions
pci 0000:02:08.0: device not available because of BAR 9 =
[0xa0000000-0xa0ffffff] collisions=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D device tree regarding PCIe =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	pci2: pcie@e000a000 {
		cell-index =3D <2>;
		interrupt-map-mask =3D <0xf800 0x0 0x0 0x7>;
		interrupt-map =3D <

			/* IDSEL 0x0 (PEX) */
			00000 0x0 0x0 0x1 &mpic 0x0 0x1
			00000 0x0 0x0 0x2 &mpic 0x1 0x1
			00000 0x0 0x0 0x3 &mpic 0x2 0x1
			00000 0x0 0x0 0x4 &mpic 0x3 0x1>;

		interrupt-parent =3D <&mpic>;
		interrupts =3D <26 2>;
		bus-range =3D <0 255>;
		ranges =3D <0x2000000 0x0 0x10000000 0xb0000000 0x0 0x10000000
		        0x43000000 0x0 0x0 0xa0000000 0x0 0x10000000
			  0x1000000 0x0 0x0 0xe3000000 0x0 0x100000>;

	      //ranges =3D empty;
		clock-frequency =3D <33333333>;
		#interrupt-cells =3D <1>;
		#size-cells =3D <2>;
		#address-cells =3D <3>;
		reg =3D <0xe000a000 0x1000>;
		compatible =3D "fsl,mpc8548-pcie";
		device_type =3D "pci";
		pcie@0 {
			reg =3D <0x0 0x0 0x0 0x0 0x0>;
			#size-cells =3D <2>;
			#address-cells =3D <3>;
			device_type =3D "pci";
			//ranges =3D empty;
			ranges =3D <0x2000000 0x0 0x10000000
				  0x20000000 0x0 0x0
				  0x0 0x10000000

                            0x43000000 0x0 0xa0000000
				  0x43000000 0x0 0xa0000000
				  0x0 0x10000000

				  0x1000000 0x0 0x0
				  0x1000000 0x0 0x0
				  0x0 0x100000>;
				 =20
		};
	};
