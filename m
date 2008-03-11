Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 3C942DE0AE
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 01:27:36 +1100 (EST)
Received: from smtp.belgium.cse-semaphore.com (localhost [127.0.0.1])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id F22477093
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 15:27:33 +0100 (CET)
Received: from pclaurent.belgium.cse-semaphore.com
	(pclaurent.belgium.cse-semaphore.com [192.168.1.47])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id D6FDE703A
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 15:27:33 +0100 (CET)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Help needed to describe a custom bus in the device tree
Date: Tue, 11 Mar 2008 15:27:26 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5222330.NYGSOao13k";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803111527.32836.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart5222330.NYGSOao13k
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

the migration process from ARCH=3Dppc to ARCH=3Dpowerpc is easier than I th=
ought=20
in some parts, but a few devices are still giving me headaches. This should=
=20
hopefully be one of my last major requests for help (I'm sure most of you=20
will be happy to see traffic on this list going down when I'll be done :-))

I'm having trouble describing a custom bus named MS bus (completely unrelat=
ed=20
to a well-known software company) in the device tree. The hardware is=20
MPC8248-based and has the following hardware topology.

MPC8248 <-- localbus --> FPGA <-- ms bus --> Custom peripherals

The bus interrupt controller, serial access (SPI) controller and status=20
registers are accessed through memory-mapped registers in the FPGA. Paralle=
l=20
access to the MS bus is handled transparently by the FPGA which handles=20
address mapping.

The FPGA is mapped on the locabus at address 0xf4000000. Bus control regist=
ers=20
are at 0xf4002000 - 0xf4003000. The parallel bus memory window on the=20
localbus is located at 0xf5000000.

My current dts draft describes that topology as follows (unrelated devices =
on=20
the local bus such as flash memory are removed for clarity).

localbus@f0010100 {
	compatible =3D "fsl,pq2-localbus";
	#address-cells =3D <2>;
	#size-cells =3D <1>;
	reg =3D <f0010100 40>;

	ranges =3D <0 0 40000000 01000000
		  2 0 f2000000 00100000
		  3 0 f3000000 00100000
		  4 0 f4000000 00100000
		  5 0 f5000000 00100000>;

	fpga@4,0 {
		#address-cells =3D <1>;
		#size-cells =3D <1>;
		ranges =3D <4 0 0 00010000>;

		msbus-arbitrer@2000 {
			compatible =3D "tbox,cp11-msbus-arbitrer";
			reg =3D <2000 4>;
		};

		msbus_pic: interrupt-controller@2100 {
			compatible =3D "tbox,cp11-msbus-pic";
			reg =3D <2100 8>;
			interrupts =3D <17 2>;
			interrupt-parent =3D <&cpm_pic>;
			#interrupt-cells =3D <1>;
			interrupt-controller;
		};

		msbus-spi@2200 {
			compatible =3D "tbox,cp11-msbus-spi";
			reg =3D <2200 100>;
			interrupts =3D <18 8>;
			interrupt-parent =3D <&cpm_pic>;
		};

		sdhc@5000 {
			compatible =3D "tbox,sdhci";
			reg =3D <5000 1000>;
			interrupts =3D <16 8>;
			interrupt-parent =3D <&cpm_pic>;
		};
	};

	msbus@5,0 {
		compatible =3D "tbox,cp11-msbus";
		#address-cells =3D <1>;
		#size-cells =3D <1>;
		#interrupt-cells =3D <1>;
		reg =3D <5 0 0 00000400>;
		interrupt-parent =3D <&msbus_pic>;
	};
};

The device tree reflects the physical topology but makes driver access to t=
he=20
bus quite complex. An OF platform device driver matching on compatible=20
=3D "tbox,cp11-msbus" will not have the bus FPGA registers described in its=
=20
device node.

Having a look at the various device trees included in the kernel sources, i=
t=20
seems platforms with a PCI bus experience a similar problem. To solve it th=
e=20
PCI bus node address and registers describe the configuration registers, an=
d=20
the memory window to access PCI devices is described by the ranges property=
=2E=20
Applying that to my custom bus would lead to the following tree.

localbus@f0010100 {
	compatible =3D "fsl,pq2-localbus";
	#address-cells =3D <2>;
	#size-cells =3D <1>;
	reg =3D <f0010100 40>;

	ranges =3D <0 0 40000000 01000000
		  2 0 f2000000 00100000
		  3 0 f3000000 00100000
		  4 0 f4000000 00100000
		  4 1 f4002000 00000100
		  5 0 f5000000 00100000>;

	fpga@4,0 {
		#address-cells =3D <1>;
		#size-cells =3D <1>;
		ranges =3D <4 0 0 00010000>;

		msbus_pic: interrupt-controller@2100 {
			compatible =3D "tbox,cp11-msbus-pic";
			reg =3D <2100 8>;
			interrupts =3D <17 2>;
			interrupt-parent =3D <&cpm_pic>;
			#interrupt-cells =3D <1>;
			interrupt-controller;
		};

		msbus-spi@2200 {
			compatible =3D "tbox,cp11-msbus-spi";
			reg =3D <2200 100>;
			interrupts =3D <18 8>;
			interrupt-parent =3D <&cpm_pic>;
		};

		sdhc@5000 {
			compatible =3D "tbox,sdhci";
			reg =3D <5000 1000>;
			interrupts =3D <16 8>;
			interrupt-parent =3D <&cpm_pic>;
		};
	};

	msbus@4,1 {
		compatible =3D "tbox,cp11-msbus";
		#address-cells =3D <1>;
		#size-cells =3D <1>;
		#interrupt-cells =3D <1>;
		reg =3D <4 1 4>;
		interrupt-parent =3D <&msbus_pic>;
		ranges =3D <5 0 0 00000400>;
	};
};

Is this correct ? Is that the best way to describe my custom bus in the dev=
ice=20
tree ? How would the relationships between the bus and its PIC and SPI=20
controller be handled in the drivers ? I also don't understand how interrup=
t=20
mappings are supposed to be handled. PCI busses have two CPM interrupt line=
s,=20
one for the PCI PIC and one for the PCI bus, with the PCI bus having the CP=
M=20
PIC as its interrupt controller. My bus PIC uses a single interrupt line. I=
s=20
there some documentation explaining how PICs and interrupt mappings should =
be=20
described ?

Thanks in advance for any help you can provide.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart5222330.NYGSOao13k
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH1pbU8y9gWxC9vpcRAgWuAKDABsDgCo5K2XHsdU7AKGVx7rq5CQCdF8cS
r90dK/xaulXGQ8bjvXV+niU=
=Fd8u
-----END PGP SIGNATURE-----

--nextPart5222330.NYGSOao13k--
