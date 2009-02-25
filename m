Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (unknown [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 748DFDDEEF
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 03:10:23 +1100 (EST)
Message-ID: <49A56D68.5040406@mlbassoc.com>
Date: Wed, 25 Feb 2009 09:10:16 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: MPC834x PCI problem
References: <49A56163.5060400@mlbassoc.com>
In-Reply-To: <49A56163.5060400@mlbassoc.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gary Thomas wrote:
> I have two [internal] boards with MPC8347.  Both have a PCI
> bus, slightly different set of "wired" peripherals.
> 
> On one board, the PCI seems to be working fine.  I can talk
> to all of my wired devices, plus one in a plugin slot.  The
> [PCI portion] DTS for this board looks like this:
> 	pci0: pci@ff008500 {
> 		cell-index = <1>;
> 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
> 		interrupt-map = <
> 				/* IDSEL 0x0A (External slot) */
> 				 0x5000 0x0 0x0 0x1 &fpga_ic 0
> 				 0x5000 0x0 0x0 0x2 &fpga_ic 1
> 				 0x5000 0x0 0x0 0x3 &fpga_ic 2
> 				 0x5000 0x0 0x0 0x4 &fpga_ic 3
> 
> 				/* IDSEL 0x0B (Promise SATA) */
> 				 0x5800 0x0 0x0 0x1 &fpga_ic 5
> 				 0x5800 0x0 0x0 0x2 &fpga_ic 5
> 				 0x5800 0x0 0x0 0x3 &fpga_ic 5
> 				 0x5800 0x0 0x0 0x4 &fpga_ic 5
> 
> 				/* IDSEL 0x0C (Fujitsu Coral-P) */
> 				 0x6000 0x0 0x0 0x1 &fpga_ic 4
> 				 0x6000 0x0 0x0 0x2 &fpga_ic 4
> 				 0x6000 0x0 0x0 0x3 &fpga_ic 4
> 				 0x6000 0x0 0x0 0x4 &fpga_ic 4
> 
> 				/* IDSEL 0x0D (Philips USB) */
> 				 0x6800 0x0 0x0 0x1 &fpga_ic 12
> 				 0x6800 0x0 0x0 0x2 &fpga_ic 12
> 				 0x6800 0x0 0x0 0x3 &fpga_ic 12
> 				 0x6800 0x0 0x0 0x4 &fpga_ic 12
> 
> 				/* IDSEL 0x1F (External slot) */
> 				 0xF800 0x0 0x0 0x1 &fpga_ic 0
> 				 0xF800 0x0 0x0 0x2 &fpga_ic 1
> 				 0xF800 0x0 0x0 0x3 &fpga_ic 2
> 				 0xF800 0x0 0x0 0x4 &fpga_ic 3
>                                 >;
> 		interrupt-parent = <&ipic>;
> 		interrupts = <0x13 0x8
>                               0x14 0x8>;
> 		bus-range = <0 0>;
> 		ranges = <0x02000000 0x0 0xC0000000 0xC0000000 0x0 0x10000000
> 			  0x01000000 0x0 0x00000000 0xB8000000 0x0 0x00100000>;
> 		clock-frequency = <33333333>;
> 		#interrupt-cells = <1>;
> 		#size-cells = <2>;
> 		#address-cells = <3>;
> 		reg = <0xff008500 0x100		/* Internal registers */
> 		       0xff008300 0x8>;         /* Config Space registers */
> 		compatible = "fsl,mpc8349-pci";
> 		device_type = "pci";
> 	};
> This board has a Promise SATA controller in slot 11 (drivers/ata/sata_promise.c)
> 
> The second board uses a DTS derived from the first.  In fact, the
> *only* difference is in the PCI layout:
> 	pci0: pci@ff008500 {
> 		cell-index = <1>;
> 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
> 		interrupt-map = <
> 				/* IDSEL 0x0B (Promise SATA) */
> 				 0x5800 0x0 0x0 0x1 &ipic 0x13 8
> 				 0x5800 0x0 0x0 0x2 &ipic 0x13 8
> 				 0x5800 0x0 0x0 0x3 &ipic 0x13 8
> 				 0x5800 0x0 0x0 0x4 &ipic 0x13 8
>                                 >;
> 		interrupt-parent = <&ipic>;
> 		interrupts = <0x13 0x8>;
> 		bus-range = <0 0>;
> 		ranges = <0x02000000 0x0 0xC0000000 0xC0000000 0x0 0x10000000
> 			  0x01000000 0x0 0x00000000 0xB8000000 0x0 0x00100000>;
> 		clock-frequency = <33333333>;
> 		#interrupt-cells = <1>;
> 		#size-cells = <2>;
> 		#address-cells = <3>;
> 		reg = <0xff008500 0x100		/* Internal registers */
> 		       0xff008300 0x8>;         /* Config Space registers */
> 		compatible = "fsl,mpc8349-pci";
> 		device_type = "pci";
> 	};
> This board has a slightly different Promise controller (drivers/ata/pata_pdc2027x.c)
> The basic PCI access code in both drivers is the same.
> 
> As mentioned, the first board works fine.  The second board
> falls apart on PCI access.  It's obvious that the PDC2027x
> driver is having access problems.  Here are some clues from
> the boot log (PCI related items only):
> 
>   Found FSL PCI host bridge at 0x00000000ff008500. Firmware bus number: 0->0
>   PCI host bridge /pci@ff008500 (primary) ranges:
>    MEM 0x00000000c0000000..0x00000000cfffffff -> 0x00000000c0000000
>     IO 0x00000000b8000000..0x00000000b80fffff -> 0x0000000000000000
>   PCI: Probing PCI hardware
>   PCI: Cannot allocate resource region 5 of device 0000:00:0b.0, will remap
>   bus: 00 index 0 io port: [0x00-0xfffff]
>   bus: 00 index 1 mmio: [0xc0000000-0xcfffffff]
>   pdc_detect_pll_input_clock: scr[FFFFFFFF]
>   pdc_read_counter: bccrh [7FFF] bccrl [7FFF]
>   pdc_read_counter: bccrhv[7FFF] bccrlv[7FFF]
>   pdc_read_counter: bccrh [7FFF] bccrl [7FFF]
>   pdc_read_counter: bccrhv[7FFF] bccrlv[7FFF]
>   pdc_detect_pll_input_clock: scr[FFFFFFFF]
>   pdc_detect_pll_input_clock: start[1073741823] end[1073741823]
>   pdc_detect_pll_input_clock: PLL input clock[0]Hz
> 
> It's pretty obvious that the PDC driver is having troubles.
> The system seems happy otherwise:
> 
>   root@ppc_target:~ lspci -v
>   00:00.0 Bridge: Unknown device 1957:0085 (rev 11)
>         Flags: bus master, 66MHz, fast devsel, latency 248
>         Memory at <unassigned> (64-bit, prefetchable)
>         Memory at <unassigned> (64-bit, non-prefetchable)
>         Capabilities: [48] #06 [0000]
> 
>   00:0b.0 Mass storage controller: Promise Technology, Inc. 20275 (rev 01) (prog-if 85)
>         Subsystem: Promise Technology, Inc. 20275
>         Flags: bus master, 66MHz, slow devsel, latency 0, IRQ 19
>         I/O ports at 1000 [size=8]
>         I/O ports at 1008 [size=4]
>         I/O ports at 1010 [size=8]
>         I/O ports at 1018 [size=4]
>         I/O ports at 1020 [size=16]
>         [virtual] Memory at c0000000 (32-bit, non-prefetchable) [size=16K]
>         Capabilities: [60] Power Management version 1
> 
> 
> Any ideas what might be going [wrong] here?  I did notice that
> both RedBoot [my boot environment] and an older kernel (2.6.20)
> on this board assigned a non-zero offset in the PCI space for
> this device:
>   Bus: 0, PCI Device: 11, PCI Func: 0
>     Vendor Id: 0x105A, Device Id: 0x1275, Command: 0x0007, IRQ: 1
>     BAR[0]    0x00001001 / probed size 0x00000000 / CPU addr 0xb8001000
>     BAR[1]    0x00001009 / probed size 0x00000000 / CPU addr 0xb8001008
>     BAR[2]    0x00001011 / probed size 0x00000000 / CPU addr 0xb8001010
>     BAR[3]    0x00001019 / probed size 0x00000000 / CPU addr 0xb8001018
>     BAR[4]    0x00001021 / probed size 0x00000000 / CPU addr 0xb8001020
>     BAR[5]    0x00100000 / probed size 0x00000000 / CPU addr 0xc0100000
> 
> Could this be a possible problem (maybe the device doesn't like it)?

Answering my own question; I changed the PCI range to not start
at offset zero:
		ranges = <0x02000000 0x0 0xC0100000 0xC0100000 0x0 0x10000000
			  0x01000000 0x0 0x00000000 0xB8000000 0x0 0x00100000>;

The PDC driver now talks to the device :-)

I'm still having troubles with the PCI interrupt, but progress nonetheless.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
