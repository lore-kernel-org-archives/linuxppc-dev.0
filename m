Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail82-sin-R.bigfish.com (mail-sin.bigfish.com [207.46.51.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 496EEDE40C
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 06:35:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] [RFC] powerpc: Xilinx: adding virtex5 powerpc 440 support
Date: Mon, 23 Jun 2008 13:35:07 -0700
In-Reply-To: <689CB232690D8D4E97DA6C76DA098E6C0657D53A@XCO-EXCHVS1.xlnx.xilinx.com>
References: <689CB232690D8D4E97DA6C76DA098E6C0657D53A@XCO-EXCHVS1.xlnx.xilinx.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "John Linn" <linnj@xilinx.com>,
	<jwboyer@linux.vnet.ibm.com>
Message-Id: <20080623203508.78B10920058@mail82-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 3934e26..94adfe1 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -483,6 +483,81 @@ config SECCOMP
> >
> >  	  If unsure, say Y. Only embedded should say N here.
> >
> > +config WANT_DEVICE_TREE
> > +	bool
> > +	default n
> =

> Not sure why you added this back.  We removed it entirely recently.

This should go..  Generally speaking, we need to cleanup the 405 and 440
code to play nice with the new boot code structure.
 =

> > +config COMPRESSED_DEVICE_TREE
> > +	bool "Use compressed device tree"
> > +	depends on XILINX_VIRTEX
> > +	depends on WANT_DEVICE_TREE
> > +	help
> > +	  In Xilinx FPGAs, the hardware can change quite dramatically
> > while
> > +	  still running the same kernel.  In this case and other similar
> > +	  ones, it is preferable to associate the device tree with a
> > +	  particular build of the hardware design.  This configuration
> > +	  option assumes that the device tree blob has been compressed
> > and
> > +	  stored in Block RAM in the FPGA design.  Typically, such a
> > block
> > +	  ram is available in order to provide a bootloop or other code
> > +	  close to the reset vector at the top of the address space.  By
> > +	  default, the parameter options associated with this
> > configuration
> > +	  assumes that exactly one block ram (2KB) of storage is
> > available,
> > +	  which should be sufficient for most designs.  If necessary in
> > a
> > +	  particular design, due to boot code requirement or a large
> > number
> > +	  of devices, this address (and the corresponding parameters in
> > the
> > +	  EDK design) must be modified.
> > +
> > +	  Note that in some highly area constrained designs, no block
> > rams
> > +	  may be available in the design, and some other mechanism may
> > be
> > +	  used to hold the processor in reset while external memory is
> > +	  initialized with processor code.  In such cases, that
> > mechanism
> > +	  should also be used to load the device tree at an appropriate
> > +	  location, and the parameters associated with this
> > configuration
> > +	  option should be modified to point to that location in
> > external
> > +	  memory.
> > +
> > +config COMPRESSED_DTB_START
> > +	hex "Start of compressed device tree"
> > +	depends on COMPRESSED_DEVICE_TREE
> > +	default 0xfffff800
> > +
> > +config COMPRESSED_DTB_SIZE
> > +	hex "Size of compressed device tree"
> > +	depends on COMPRESSED_DEVICE_TREE
> > +	default 0x800
> > +
> > +

This needs to get added for 405 too.  More likely its easier to generate
a separate patch for this.

> > +
> > +/ {
> > +	#address-cells =3D <1>;
> =

> This doesn't look right.  440 has 36-bit physical addresses, so
> #address-cells should be <2>.

In Virtex FPGAs, the 440 is only hooked up through a 32-bit bus.

> > +	#size-cells =3D <1>;
> > +	compatible =3D "xlnx,virtex";
> > +	dcr-parent =3D <&ppc440_virtex5_0>;
> > +	model =3D "testing";
> > +	chosen {
> > +		bootargs =3D "console=3DttyS0 ip=3Don root=3D/dev/ram";
> > +		linux,stdout-path =3D "/plb@0/serial@d0000000";
> > +	} ;
> > +	cpus {
> > +		#address-cells =3D <1>;
> > +		#cpus =3D <1>;
> > +		#size-cells =3D <0>;
> > +		ppc440_virtex5_0: cpu@0 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> =

> You don't need those in the cpu node itself.

I'll take care of removing them.

> > +			clock-frequency =3D <17d78400>;
> > +			compatible =3D "PowerPC,440", "ibm,ppc440";
> > +			d-cache-line-size =3D <20>;
> > +			d-cache-size =3D <8000>;
> > +			dcr-access-method =3D "native";
> > +			dcr-controller ;
> > +			device_type =3D "cpu";
> > +			i-cache-line-size =3D <20>;
> > +			i-cache-size =3D <8000>;
> > +			model =3D "PowerPC,440";
> > +			reg =3D <0>;
> > +			timebase-frequency =3D <17d78400>;
> > +			xlnx,apu-control =3D <1>;
> > +			xlnx,apu-udi-0 =3D <c07701>;
> > +			xlnx,apu-udi-1 =3D <c47701>;
> > +			xlnx,apu-udi-10 =3D <0>;
> > +			xlnx,apu-udi-11 =3D <0>;
> > +			xlnx,apu-udi-12 =3D <0>;
> > +			xlnx,apu-udi-13 =3D <0>;
> > +			xlnx,apu-udi-14 =3D <0>;
> > +			xlnx,apu-udi-15 =3D <0>;
> > +			xlnx,apu-udi-2 =3D <0>;
> > +			xlnx,apu-udi-3 =3D <0>;
> > +			xlnx,apu-udi-4 =3D <0>;
> > +			xlnx,apu-udi-5 =3D <0>;
> > +			xlnx,apu-udi-6 =3D <0>;
> > +			xlnx,apu-udi-7 =3D <0>;
> > +			xlnx,apu-udi-8 =3D <0>;
> > +			xlnx,apu-udi-9 =3D <0>;
> > +			xlnx,dcr-autolock-enable =3D <1>;
> > +			xlnx,dcu-rd-ld-cache-plb-prio =3D <0>;
> > +			xlnx,dcu-rd-noncache-plb-prio =3D <0>;
> > +			xlnx,dcu-rd-touch-plb-prio =3D <0>;
> > +			xlnx,dcu-rd-urgent-plb-prio =3D <0>;
> > +			xlnx,dcu-wr-flush-plb-prio =3D <0>;
> > +			xlnx,dcu-wr-store-plb-prio =3D <0>;
> > +			xlnx,dcu-wr-urgent-plb-prio =3D <0>;
> > +			xlnx,dma0-control =3D <0>;
> > +			xlnx,dma0-plb-prio =3D <0>;
> > +			xlnx,dma0-rxchannelctrl =3D <1010000>;
> > +			xlnx,dma0-rxirqtimer =3D <3ff>;
> > +			xlnx,dma0-txchannelctrl =3D <1010000>;
> > +			xlnx,dma0-txirqtimer =3D <3ff>;
> > +			xlnx,dma1-control =3D <0>;
> > +			xlnx,dma1-plb-prio =3D <0>;
> > +			xlnx,dma1-rxchannelctrl =3D <1010000>;
> > +			xlnx,dma1-rxirqtimer =3D <3ff>;
> > +			xlnx,dma1-txchannelctrl =3D <1010000>;
> > +			xlnx,dma1-txirqtimer =3D <3ff>;
> > +			xlnx,dma2-control =3D <0>;
> > +			xlnx,dma2-plb-prio =3D <0>;
> > +			xlnx,dma2-rxchannelctrl =3D <1010000>;
> > +			xlnx,dma2-rxirqtimer =3D <3ff>;
> > +			xlnx,dma2-txchannelctrl =3D <1010000>;
> > +			xlnx,dma2-txirqtimer =3D <3ff>;
> > +			xlnx,dma3-control =3D <0>;
> > +			xlnx,dma3-plb-prio =3D <0>;
> > +			xlnx,dma3-rxchannelctrl =3D <1010000>;
> > +			xlnx,dma3-rxirqtimer =3D <3ff>;
> > +			xlnx,dma3-txchannelctrl =3D <1010000>;
> > +			xlnx,dma3-txirqtimer =3D <3ff>;
> > +			xlnx,endian-reset =3D <0>;
> > +			xlnx,generate-plb-timespecs =3D <1>;
> > +			xlnx,icu-rd-fetch-plb-prio =3D <0>;
> > +			xlnx,icu-rd-spec-plb-prio =3D <0>;
> > +			xlnx,icu-rd-touch-plb-prio =3D <0>;
> > +			xlnx,interconnect-imask =3D <ffffffff>;
> > +			xlnx,mplb-allow-lock-xfer =3D <1>;
> > +			xlnx,mplb-arb-mode =3D <0>;
> > +			xlnx,mplb-awidth =3D <20>;
> > +			xlnx,mplb-counter =3D <500>;
> > +			xlnx,mplb-dwidth =3D <80>;
> > +			xlnx,mplb-max-burst =3D <8>;
> > +			xlnx,mplb-native-dwidth =3D <80>;
> > +			xlnx,mplb-p2p =3D <0>;
> > +			xlnx,mplb-prio-dcur =3D <2>;
> > +			xlnx,mplb-prio-dcuw =3D <3>;
> > +			xlnx,mplb-prio-icu =3D <4>;
> > +			xlnx,mplb-prio-splb0 =3D <1>;
> > +			xlnx,mplb-prio-splb1 =3D <0>;
> > +			xlnx,mplb-read-pipe-enable =3D <1>;
> > +			xlnx,mplb-sync-tattribute =3D <0>;
> > +			xlnx,mplb-wdog-enable =3D <1>;
> > +			xlnx,mplb-write-pipe-enable =3D <1>;
> > +			xlnx,mplb-write-post-enable =3D <1>;
> > +			xlnx,num-dma =3D <1>;
> > +			xlnx,pir =3D <f>;
> > +			xlnx,ppc440mc-addr-base =3D <0>;
> > +			xlnx,ppc440mc-addr-high =3D <1fffffff>;
> > +			xlnx,ppc440mc-arb-mode =3D <0>;
> > +			xlnx,ppc440mc-bank-conflict-mask =3D <c00000>;
> > +			xlnx,ppc440mc-control =3D <f810008f>;
> > +			xlnx,ppc440mc-max-burst =3D <8>;
> > +			xlnx,ppc440mc-prio-dcur =3D <2>;
> > +			xlnx,ppc440mc-prio-dcuw =3D <3>;
> > +			xlnx,ppc440mc-prio-icu =3D <4>;
> > +			xlnx,ppc440mc-prio-splb0 =3D <1>;
> > +			xlnx,ppc440mc-prio-splb1 =3D <0>;
> > +			xlnx,ppc440mc-row-conflict-mask =3D <3ffe00>;
> > +			xlnx,ppcdm-asyncmode =3D <0>;
> > +			xlnx,ppcds-asyncmode =3D <0>;
> > +			xlnx,user-reset =3D <0>;
> =

> All of those seem very odd for being in the cpu node.  Why aren't they
> with the individual nodes in the tree?
> =

> > +			DMA0: sdma@80 {
> > +				compatible =3D "xlnx,ll-dma-1.00.a";
> > +				dcr-reg =3D < 80 11 >;
> > +				interrupt-parent =3D <&opb_intc_0>;
> > +				interrupts =3D < 5 2 6 2 >;
> > +			} ;
> =

> This definitely shouldn't be in the cpu node.

In Virtex 5 FX, the processor block (as represented in all the processor
design tools) is actually a processor block, plus a crossbar switch,
plus dma blocks.  I think there's a tradeoff between modeling this
independently, or modeling it as an FPGA user sees it.  From the
perspective of the FPGA user, this is the way the system looks (although
I agree that it's odd).   What would be even better, is if the processor
block was modeled as a DTS I could write by hand, and to include it into
the generated DTS.  (Another good use for grafting of device trees...)


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
