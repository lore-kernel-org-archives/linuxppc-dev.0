Return-Path: <matvejchikov@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id C0575DF349
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jul 2008 05:43:09 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so439857qwb.15
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Jul 2008 12:43:08 -0700 (PDT)
Message-ID: <8496f91a0807281243y2193dad5hc758444fe0a10258@mail.gmail.com>
Date: Mon, 28 Jul 2008 23:43:07 +0400
From: "Matvejchikov Ilya" <matvejchikov@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: No output from SMC1 console with the 2.6.26 kernel (PQ2FADS based
	board)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: matvejchikov@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I'm working with PQ2FADS based board. When I started to use new 2.6.26
kernel my SMC1 console stopped working. I know that the cpm_uart
driver has been changed and the DTS file needs updating. Unfortunately
I failed to get it running. Could somebody help me solve this problem?

====
The cpm node of the DTS file:
.............................................
		cpm@119c0 {
			#address-cells = <1>;
			#size-cells = <1>;
			#interrupt-cells = <2>;
			compatible = "fsl,mpc8280-cpm", "fsl,cpm2";
			reg = <119c0 30>;
			ranges;

			muram {
				#address-cells = <1>;
				#size-cells = <1>;
				ranges = <0 0 10000>;

				data-only@0 {
					compatible = "fsl,cpm-muram-data";
					reg = <0 2000 9800 800>;
				};
			};

			brg@119f0 {
				compatible = "fsl,cpm-brg", "fsl,cpm2-brg";
				reg = <119f0 10 115f0 10>;
			};

			smc1: serial@11a80 {
				device_type = "serial";
				compatible = "fsl,cpm2-smc-uart";
				reg = <11a80 20 87fc 2>;
				interrupts = <4 8>;
				interrupt-parent = <&PIC>;
				fsl,cpm-brg = <7>;
				fsl,cpm-command = <1d000000>;
			};

		};
.............................................
	chosen {
		linux,stdout-path = &smc1;
		bootargs = "console=ttyCPM0";
	};
.............................................

The early debuging output:
Xid mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
Using Electronic Devices SPC826 (M82) machine description
Linux version 2.6.26 (ilya@westend) (gcc version 4.1.2) #83 Thu Jul 24
14:45:07 MSD 2008
console [udbg0] enabled
Entering add_active_range(0, 0, 4096) 0 entries of 256 used
setup_arch: bootmem
spc826_setup_arch()
spc826_setup_arch(), finish
arch: exit
Top of RAM: 0x1000000, Total RAM: 0x1000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->     4096
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->     4096
On node 0 totalpages: 4096
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
Kernel command line: console=ttyCPM0
PID hash table entries: 64 (order: 6, 256 bytes)
time_init: decrementer frequency = 16.500000 MHz
time_init: processor frequency   = 264.000000 MHz
clocksource: timebase mult[f26c9b2] shift[22] registered
clockevent: decrementer mult[439] shift[16] cpu[0]
Console: colour dummy device 80x25
====

Thanks!
