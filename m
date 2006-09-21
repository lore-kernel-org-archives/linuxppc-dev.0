Return-Path: <roubert@df.lth.se>
Received: from df.lth.se (mail.df.lth.se [194.47.250.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DB4AF67BC8
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Sep 2006 02:08:15 +1000 (EST)
Received: from igloo.df.lth.se (localhost [127.0.0.1])
	by df.lth.se (8.13.1/8.13.1) with ESMTP id k8LG89c9006065
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Sep 2006 18:08:09 +0200 (CEST)
Received: (from roubert@localhost)
	by igloo.df.lth.se (8.13.1/8.13.1/Submit) id k8LG89B1006063
	for linuxppc-embedded@ozlabs.org; Thu, 21 Sep 2006 18:08:09 +0200 (CEST)
Date: Thu, 21 Sep 2006 18:08:08 +0200
From: Fredrik Roubert <roubert@df.lth.se>
To: linuxppc-embedded@ozlabs.org
Subject: Re: How to move from /ppc/ to /powerpc/
Message-ID: <20060921160808.GB4828@igloo.df.lth.se>
References: <20060912153316.GC16340@igloo.df.lth.se>
	<20060912105830.3923d537.kim.phillips@freescale.com>
	<20060913132817.GD18263@igloo.df.lth.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
In-Reply-To: <20060913132817.GD18263@igloo.df.lth.se>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--1LKvkjL3sHcu1TtY
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Now I've written an adapted DTS (see attachment) for my custom board,
based on the mpc8349emds.dts from the kernel source. I use Matthew
McClintock's patches to U-Boot to load the kernel with the DTD.

I compile the DTS using the following command line:

dtc -V 16 -I dts -O dtb px5500.dts > px5500.dtb

I've compiled an unmodified 2.6.18 kernel configured for powerpc and the
MPC834x SYS platform. The system boots OK and I can log in using SSH.
However, I have problems with the serial console. During boot, I get the
following printout:

Booting using flat device tree at 0x400000
Using MPC834x SYS machine description
Linux version 2.6.18 (frer@milou) (gcc version 4.1.1) #1 PREEMPT Thu Sep 21=
 17:31:30 CEST 2006
setup_arch: bootmem
mpc834x_sys_setup_arch()
Found MPC83xx PCI host bridge at 0x00000000ff408500. Firmware bus number: 0=
->0
arch: exit
Built 1 zonelists.  Total pages: 32768
Kernel command line: root=3D/dev/nfs rw nfsroot=3D150.158.215.227:/home/roo=
tfs/dev-ds ip=3D150.158.211.83:150.158.215.227:150.158.212.1:255.255.248.0:=
dev-ds:eth0:off console=3DttyS0,115200 console=3DttyS0,115200 rtc-x1205.for=
ce=3D0,0x6f
IPIC (128 IRQ sources) at fdefc700
PID hash table entries: 1024 (order: 10, 4096 bytes)

The serial console stops working after the call to console_init().

Except for the serial console, the system seems to be running fine. Does
anyone have any ideas about what might be wrong and how I could try to
track this problem down?

Cheers // Fredrik Roubert

--=20
Visserij 192  |  +32 473 344527 / +46 708 776974
BE-9000 Gent  |  http://www.df.lth.se/~roubert/

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="px5500.dts"


/ {
	model = "PX5500";
	#address-cells = <1>;
	#size-cells = <1>;

	cpus {
		#cpus = <1>;
		#address-cells = <1>;
		#size-cells = <0>;

		PowerPC,8349@0 {
			device_type = "cpu";
			reg = <0>;
			d-cache-line-size = <20>;	// 32 bytes
			i-cache-line-size = <20>;	// 32 bytes
			d-cache-size = <8000>;		// L1, 32K
			i-cache-size = <8000>;		// L1, 32K
			timebase-frequency = <0>;	// from bootloader
			bus-frequency = <0>;		// from bootloader
			clock-frequency = <0>;		// from bootloader
			32-bit;
			linux,boot-cpu;
		};
	};

	memory {
		device_type = "memory";
		reg = <00000000 08000000>;		// 128MB at 0
	};

	chosen {
		name = "chosen";
		linux,platform = <00000600>;
		linux,stdout-path = "/soc8349@ff400000/serial@4500";
		bootargs = "root=/dev/nfs rw nfsroot=150.158.215.227:/home/rootfs/dev-ds ip=150.158.211.83:150.158.215.227:150.158.212.1:255.255.248.0:dev-ds:eth0:off console=ttyS0,115200 console=ttyS0,115200 rtc-x1205.force=0,0x6f";
	};

	soc8349@ff400000 {
		#address-cells = <1>;
		#size-cells = <1>;
		#interrupt-cells = <2>;
		device_type = "soc";
		ranges = <0 ff400000 00100000>;
		reg = <ff400000 00000200>;
		bus-frequency = <0>;

		i2c@3000 {
			device_type = "i2c";
			compatible = "fsl-i2c";
			reg = <3000 100>;
			interrupts = <e 8>;
			interrupt-parent = <700>;
			dfsrr;
		};

		mdio@24520 {
			device_type = "mdio";
			compatible = "gianfar";
			reg = <24520 20>;
			#address-cells = <1>;
			#size-cells = <0>;
			linux,phandle = <24520>;
			ethernet-phy@0 {
				linux,phandle = <2452000>;
				interrupt-parent = <700>;
				interrupts = <11 2>;
				reg = <1>;
				device_type = "ethernet-phy";
			};
			ethernet-phy@1 {
				linux,phandle = <2452001>;
				interrupt-parent = <700>;
				interrupts = <12 2>;
				reg = <3>;
				device_type = "ethernet-phy";
			};
		};

		ethernet@24000 {
			device_type = "network";
			model = "TSEC";
			compatible = "gianfar";
			reg = <24000 1000>;
			address = [ 00 00 00 00 00 00 ];
			local-mac-address = [ 00 11 00 11 ff a1 ];
			interrupts = <20 8 21 8 22 8>;
			interrupt-parent = <700>;
			phy-handle = <2452000>;
		};

		ethernet@25000 {
			#address-cells = <1>;
			#size-cells = <0>;
			device_type = "network";
			model = "TSEC";
			compatible = "gianfar";
			reg = <25000 1000>;
			address = [ 00 00 00 00 00 00 ];
			local-mac-address = [ 00 11 00 11 ff a2 ];
			interrupts = <23 8 24 8 25 8>;
			interrupt-parent = <700>;
			phy-handle = <2452001>;
		};

		serial@4500 {
			device_type = "serial";
			compatible = "ns16550";
			reg = <4500 100>;
			clock-frequency = <0>;
			interrupts = <9 8>;
			interrupt-parent = <700>;
		};

		serial@4600 {
			device_type = "serial";
			compatible = "ns16550";
			reg = <4600 100>;
			clock-frequency = <0>;
			interrupts = <a 8>;
			interrupt-parent = <700>;
		};

		pci@8500 {
			interrupt-map-mask = <f800 0 0 7>;
			interrupt-map = <
					/* IDSEL 0x0e */
					 7000 0 0 1 700 17 8
					 7000 0 0 2 700 00 8
					 7000 0 0 3 700 00 8
					 7000 0 0 4 700 00 8>;
			interrupt-parent = <700>;
			interrupts = <42 8>;
			bus-range = <0 0>;
			ranges = <02000000 0 a0000000 a0000000 0 10000000
				  42000000 0 80000000 80000000 0 10000000
				  01000000 0 00000000 e2000000 0 00100000>;
			clock-frequency = <3f940aa>;
			#interrupt-cells = <1>;
			#size-cells = <2>;
			#address-cells = <3>;
			reg = <8500 100>;
			compatible = "83xx";
			device_type = "pci";
		};

		/* IPIC
		 * interrupts cell = <intr #, sense>
		 * sense values match linux IORESOURCE_IRQ_* defines:
		 * sense == 8: Level, low assertion
		 * sense == 2: Edge, high-to-low change
		 */
		pic@700 {
			linux,phandle = <700>;
			interrupt-controller;
			#address-cells = <0>;
			#interrupt-cells = <2>;
			reg = <700 100>;
			built-in;
			device_type = "ipic";
		};
	};
};


--gKMricLos+KVdGMg--

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (SunOS)

iQCVAwUBRRK46MRKuLhQMn35AQJvVAP/XeGaHCVeTEhTRDE/zoUg1D3iou1Cnbbt
3MvFxitVohZZvZPAOPfkEFZbrMdHuEe07Nfc0XDaG11HmtT/ytuf+ieuLi7Pm+I0
ZUUnUI1DFFHlSsOJ9Tv+vjOTrmau+3UJX0S+e830ifDRHO4LS/y/uzo7k+tFWv5I
iFUn6yuf3tY=
=36TN
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
