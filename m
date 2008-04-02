Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound5-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 39C99DDF35
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Apr 2008 03:35:22 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Virtex V5FX PPC 440 Support In Xilinx Git Tree
Date: Wed, 2 Apr 2008 09:34:12 -0700
In-Reply-To: <689CB232690D8D4E97DA6C76DA098E6C05FC43ED@XCO-EXCHVS1.xlnx.xilinx.com>
References: <20080401234142.41B13191804A@mail111-sin.bigfish.com>
	<87lk3w8u00.fsf@macbook.be.48ers.dk>
	<689CB232690D8D4E97DA6C76DA098E6C05FC43ED@XCO-EXCHVS1.xlnx.xilinx.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "John Linn" <linnj@xilinx.com>, "Peter Korsgaard" <jacmet@sunsite.dk>,
	"Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20080402163414.107D35A8056@mail76-sin.bigfish.com>
Cc: git <git@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I've just pushed support for generating device trees for the ppc440 in
V5FXT up to git.xilinx.com.

The most obvious difference is that the PPC440 block contains not only
the PPC440 core, but also an interconnect block, subsuming part of the
'multi-ported' functionality of the MPMC.  In order to have a relatively
straightforward mapping between blocks in the EDK design and nodes in
the dts, I've represented this as shown below.  Note that unlike the
MPMC, the dma ports are controlled through DCR (which is part of the
point of the recent dcr patches).  I've done some preliminary testing
using some hacked together platform support code and we'll update this
based on the 405 code soon.

Steve

/ {
	#address-cells =3D <1>;
	#size-cells =3D <1>;
	compatible =3D "xlnx,virtex";
	dcr-parent =3D <&ppc440_virtex5_0>;
	model =3D "testing";
	chosen {
		bootargs =3D "root=3D/dev/xsysace/disc0/part2";
	} ;
	cpus {
		#address-cells =3D <1>;
		#cpus =3D <1>;
		#size-cells =3D <0>;
		ppc440_virtex5_0: cpu@0 {
			#address-cells =3D <1>;
			#size-cells =3D <1>;
			clock-frequency =3D <17d78400>;
			compatible =3D "PowerPC,440", "ibm,ppc440";
			d-cache-line-size =3D <20>;
			d-cache-line-size =3D <20>;
			d-cache-size =3D <8000>;
			dcr-access-method =3D "native";
			dcr-controller ;
			device_type =3D "cpu";
			i-cache-line-size =3D <20>;
			i-cache-size =3D <8000>;
			model =3D "PowerPC,440";
			reg =3D <0>;
			timebase-frequency =3D <17d78400>;
			DMA0: sdma@1010000 {
				compatible =3D "xlnx,ll-dma-1.00.a";
				dcr-reg =3D < 1010000 11 >;
				interrupt-parent =3D <&opb_intc_0>;
				interrupts =3D < 5 2 6 2 >;
			} ;
			DMA1: sdma@1010000 {
				compatible =3D "xlnx,ll-dma-1.00.a";
				dcr-reg =3D < 1010000 11 >;
			} ;
			DMA2: sdma@1010000 {
				compatible =3D "xlnx,ll-dma-1.00.a";
				dcr-reg =3D < 1010000 11 >;
			} ;
			DMA3: sdma@1010000 {
				compatible =3D "xlnx,ll-dma-1.00.a";
				dcr-reg =3D < 1010000 11 >;
			} ;
		} ;
	} ;
	plb_v46_cfb_0: plb@0 {
		#address-cells =3D <1>;
		#size-cells =3D <1>;
		compatible =3D "xlnx,plb-v46-1.00.a";
		ranges ;
		iic_bus: i2c@d0020000 {
			compatible =3D "xlnx,xps-iic-1.00.a";
			interrupt-parent =3D <&opb_intc_0>;
			interrupts =3D < 7 2 >;
			reg =3D < d0020000 200 >;
			xlnx,clk-freq =3D <5f5e100>;
			xlnx,family =3D "virtex5";
			xlnx,gpo-width =3D <1>;
			xlnx,iic-freq =3D <186a0>;
			xlnx,ten-bit-adr =3D <0>;
		} ;
		leds_8bit: gpio@d0010200 {
			compatible =3D "xlnx,xps-gpio-1.00.a";
			interrupt-parent =3D <&opb_intc_0>;
			interrupts =3D < 1 2 >;
			reg =3D < d0010200 200 >;
			xlnx,all-inputs =3D <0>;
			xlnx,all-inputs-2 =3D <0>;
			xlnx,dout-default =3D <0>;
			xlnx,dout-default-2 =3D <0>;
			xlnx,family =3D "virtex5";
			xlnx,gpio-width =3D <8>;
			xlnx,interrupt-present =3D <1>;
			xlnx,is-bidir =3D <1>;
			xlnx,is-bidir-2 =3D <1>;
			xlnx,is-dual =3D <0>;
			xlnx,tri-default =3D <ffffffff>;
			xlnx,tri-default-2 =3D <ffffffff>;
		} ;
		ll_temac_0: xps-ll-temac@91200000 {
			#address-cells =3D <1>;
			#size-cells =3D <1>;
			compatible =3D "xlnx,compound";
			ethernet@91200000 {
				compatible =3D "xlnx,xps-ll-temac-1.00.b";
				device_type =3D "network";
				interrupt-parent =3D <&opb_intc_0>;
				interrupts =3D < 4 2 >;
				llink-connected =3D <&DMA0>;
				local-mac-address =3D [ 00 00 00 00 00 00
];
				reg =3D < 91200000 40 >;
				xlnx,bus2core-clk-ratio =3D <1>;
				xlnx,phy-type =3D <1>;
				xlnx,phyaddr =3D <1>;
				xlnx,rxcsum =3D <0>;
				xlnx,rxfifo =3D <4000>;
				xlnx,temac-type =3D <0>;
				xlnx,txcsum =3D <0>;
				xlnx,txfifo =3D <4000>;
			} ;
		} ;
		opb_intc_0: interrupt-controller@d0020200 {
			#interrupt-cells =3D <2>;
			compatible =3D "xlnx,xps-intc-1.00.a";
			interrupt-controller ;
			reg =3D < d0020200 20 >;
			xlnx,num-intr-inputs =3D <8>;
		} ;
		plb_bram_if_cntlr_0: xps-bram-if-cntlr@ffff0000 {
			compatible =3D "xlnx,xps-bram-if-cntlr-1.00.a";
			reg =3D < ffff0000 10000 >;
			xlnx,family =3D "virtex5";
		} ;
		plb_bram_if_cntlr_1: xps-bram-if-cntlr@eee00000 {
			compatible =3D "xlnx,xps-bram-if-cntlr-1.00.a";
			reg =3D < eee00000 2000 >;
			xlnx,family =3D "virtex5";
		} ;
		rs232_uart_0: serial@d0000000 {
			clock-frequency =3D "";
			compatible =3D "xlnx,xps-uart16550-1.00.a";
			current-speed =3D <2580>;
			device_type =3D "serial";
			interrupt-parent =3D <&opb_intc_0>;
			interrupts =3D < 0 2 >;
			reg =3D < d0000000 2000 >;
			reg-offset =3D <3>;
			reg-shift =3D <2>;
			xlnx,family =3D "virtex5";
			xlnx,has-external-rclk =3D <0>;
			xlnx,has-external-xin =3D <1>;
			xlnx,is-a-16550 =3D <1>;
		} ;
		sysace_compactflash: sysace@d0030100 {
			compatible =3D "xlnx,xps-sysace-1.00.a";
			reg =3D < d0030100 80 >;
			xlnx,family =3D "virtex5";
			xlnx,mem-width =3D <10>;
		} ;
	} ;
	ppc440mc_ddr2_0: memory@0 {
		device_type =3D "memory";
		reg =3D < 0 20000000 >;
	} ;
}  ;

> -----Original Message-----
> From: John Linn
> Sent: Wednesday, April 02, 2008 8:24 AM
> To: Peter Korsgaard
> Cc: linuxppc-embedded@ozlabs.org; git
> Subject: RE: Virtex V5FX PPC 440 Support In Xilinx Git Tree
>=20
> Hi Peter,
>=20
> We added arch/ppc support because it was the easiest path for us.  We
realize it's going away soon in
> the mainline.
>=20
> We are working on getting arch/powerpc more mature for both the 405
and the 440 as we do believe this
> is the future for powerpc.
>=20
> Thanks,
> John
>=20
>=20
>=20
> -----Original Message-----
> From: Peter Korsgaard [mailto:jacmet@gmail.com] On Behalf Of Peter
Korsgaard
> Sent: Wednesday, April 02, 2008 3:51 AM
> To: John Linn
> Cc: linuxppc-embedded@ozlabs.org; git
> Subject: Re: Virtex V5FX PPC 440 Support In Xilinx Git Tree
>=20
> >>>>> "John" =3D=3D John Linn <John.Linn@xilinx.com> writes:
>=20
>  John> I pushed PowerPC 440 support to the Xilinx Git server with
>  John> support for ppc arch and with powerpc arch support coming in
>  John> the near future.
>=20
> Neat, but why have you added arch/ppc support? It's supposed to go
> away pretty much by the time the hardware gets in the hand of
> developers.
>=20
> --
> Bye, Peter Korsgaard
