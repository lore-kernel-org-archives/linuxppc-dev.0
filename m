Return-Path: <JOFT@gmx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9FF5DB709B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 01:34:33 +1000 (EST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 6203BDDD04
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Jun 2009 01:34:31 +1000 (EST)
Subject: SD card over (xilinx_)SPI, timeout error while CID
From: Joachim Foerster <JOFT@gmx.de>
To: linuxppc-dev@ozlabs.org, john.linn@xilinx.com,
	dbrownell@users.sourceforge.net
Content-Type: text/plain
Date: Fri, 05 Jun 2009 17:34:29 +0200
Message-Id: <1244216069.21470.12.camel@localhost>
Mime-Version: 1.0
Cc: lorenz@missinglinkelectronics.com, joachim@missinglinkelectronics.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

we have a very strange problem with SD-card-over-SPI support using
2.6.29.4 on our custom PowerPC 405 (Virtex-4 FX FPGA) based board. To
summarize the problem in one sentence: mmc_spi gets a timeout (error
-110) after sending MMC command "CMD10" (CID, card identification?).

The attached log file shows device registration messages during bootup
and debug/error messages after inserting a SD card.

ATM we are migrating from 2.6.26 (old arch/ppc-based, non-device-tree)
to the already mentioned version 2.6.29.4 (arch/powerpc, device tree).
We use Xilinx' opb_spi core (v1.00.e, EDK 9.1.02i) inside the FPGA,
which is connected to a SD card slot. With our old 2.6.26 kernel, SD
cards _are working fine_!.

To solve the problem, among other things, we tried 2.6.26+arch/powerpc
(applying only necessary patches to support/include SPI, MMC OF
bindings) - but the result is the same (error -110). The same is also
true for
2.6.28+arch/powerpc and Linus-HEAD+arch/powerpc . Then we checked these
patches, which add OF bindings for
SPI/MMC/..., line by line and did not find any hint.
For debugging we added a lot of printks ;-) and noticed that then there
are less timeouts (error -110), but  CRC check errors (-EILSEQ,
mmc_spi.c, mmc_spi_readblock) happen - maybe even signal shifts/sampling
errors?

To complete confusion :-( the same setup (xilinx_spi+opb_spi) using an
ADS7846 touchscreen controller as SPI slave _does work_ correctly

Our current guess is, that it could be a more "basic" (?) error in
arch/powerpc . But we have no lead ATM.

Any hints? Does anybody use SD card support with mmc_spi+xilinx_spi ?

 Joachim

--
for reference: relevant DTS entry:

opb_spi_0: spi@41240000 {
	#address-cells = <1>;
	#size-cells = <0>;

	compatible = "xlnx,opb-spi-1.00.e";
	reg = <0x41240000 0x10000>;
	interrupt-parent = <&opb_intc_0>;
	interrupts = <7 2>;

	xlnx,depth = <0x10>;
	xlnx,dev-blk-id = <0x4>;
	xlnx,dev-mir-enable = <0x0>;
	xlnx,family = "virtex4";
	xlnx,fifo-exist = <0x1>;
	xlnx,interrupt-present = <0x1>;
	xlnx,ip-reg-bar-offset = <0x60>;
	xlnx,num-bits-reg = <0x8>;
	xlnx,num-bits-sr = <0x8>;
	xlnx,num-offchip-ss-bits = <0x0>;
	xlnx,num-ss-bits = <0x1>;
	xlnx,occupancy-num-bits = <0x4>;
	xlnx,spi-slave-only = <0x0>;

	mmc-slot@0 {
		compatible = "mmc-spi-slot";
		reg = <0>;
		gpios = <&opb_gpio_1 0 1>;
		voltage-ranges = <3300 3300>;
		spi-max-frequency = <6250000>;
	};
};

dmesg during boot sequence, messages concerning SPI and MMC/SD only:

[   30.677087] xilinx-xps-spi 41240000.spi: at 0x41240000 mapped to
0xC9040000, irq=18
[   30.875967] mmc_spi spi32766.0: SD/MMC host mmc0, no WP, no poweroff,
cd polling

dmesg after inserting a SD card:

[  105.375146] mmc0: clock 0Hz busmode 2 powermode 1 cs 1 Vdd 21 width 0
timing 0
[  105.381246] mmc_spi spi32766.0: mmc_spi: power up (21)
[  105.388286] mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21
width 0 timing 0
[  105.394839] mmc_spi spi32766.0: mmc_spi: power on (21)
[  105.400197] mmc_spi spi32766.0: xilinx_spi_setup, unsupported mode
bits 4
[  105.406601] mmc_spi spi32766.0: can't change chip-select polarity
[  105.414666] mmc0: starting CMD0 arg 00000000 flags 000000c0
[  105.419176] mmc_spi spi32766.0:   mmc_spi: CMD0, resp R1
[  105.424511] mmc_spi spi32766.0: xilinx_spi_setup, mode 0, 8 bits/w, 0
nsec/bit
[  105.431557] mmc0: req done (CMD0): 0: 00000001 00000000 00000000
00000000
[  105.439251] mmc0: starting CMD8 arg 000001aa flags 000002f5
[  105.443770] mmc_spi spi32766.0:   mmc_spi: CMD8, resp R3/R4/R7
[  105.449740] mmc_spi spi32766.0: xilinx_spi_setup, mode 0, 8 bits/w, 0
nsec/bit
[  105.456789] mmc0: req done (CMD8): 0: 00000001 000001aa 00000000
00000000
[  105.463502] mmc0: starting CMD5 arg 00000000 flags 000002e1
[  105.468999] mmc_spi spi32766.0:   mmc_spi: CMD5, resp R3/R4/R7
[  105.474968] mmc_spi spi32766.0:   ... CMD5 response SPI_R3/R4/R: resp
0005 ffffffff
[  105.482448] mmc_spi spi32766.0: xilinx_spi_setup, mode 0, 8 bits/w, 0
nsec/bit
[  105.489606] mmc0: req done (CMD5): -22: 00000005 ffffffff 00000000
00000000
[  105.496511] mmc0: starting CMD55 arg 00000000 flags 000000f5
[  105.502092] mmc_spi spi32766.0:   mmc_spi: CMD55, resp R1
[  105.507645] mmc_spi spi32766.0: xilinx_spi_setup, mode 0, 8 bits/w, 0
nsec/bit
[  105.514650] mmc0: req done (CMD55): 0: 00000001 00000000 00000000
00000000
[  105.521476] mmc0: starting CMD41 arg 00000000 flags 000000e1
[  105.527055] mmc_spi spi32766.0:   mmc_spi: CMD41, resp R1
[  105.532615] mmc_spi spi32766.0: xilinx_spi_setup, mode 0, 8 bits/w, 0
nsec/bit
[  105.539646] mmc0: req done (CMD41): 0: 00000001 00000000 00000000
00000000
[  105.546424] mmc0: starting CMD0 arg 00000000 flags 000000c0
[  105.551986] mmc_spi spi32766.0:   mmc_spi: CMD0, resp R1
[  105.557387] mmc_spi spi32766.0: xilinx_spi_setup, mode 0, 8 bits/w, 0
nsec/bit
[  105.564440] mmc0: req done (CMD0): 0: 00000001 00000000 00000000
00000000
[  105.572158] mmc0: starting CMD58 arg 00000000 flags 00000280
[  105.576741] mmc_spi spi32766.0:   mmc_spi: CMD58, resp R3/R4/R7
[  105.582795] mmc_spi spi32766.0: xilinx_spi_setup, mode 0, 8 bits/w, 0
nsec/bit
[  105.589846] mmc0: req done (CMD58): 0: 00000001 00ff8000 00000000
00000000
[  105.596650] mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 20
width 0 timing 0
[  105.604258] mmc0: starting CMD0 arg 00000000 flags 000000c0
[  105.609744] mmc_spi spi32766.0:   mmc_spi: CMD0, resp R1
[  105.615214] mmc_spi spi32766.0: xilinx_spi_setup, mode 0, 8 bits/w, 0
nsec/bit
[  105.622217] mmc0: req done (CMD0): 0: 00000001 00000000 00000000
00000000
[  105.629975] mmc0: starting CMD8 arg 000001aa flags 000002f5
[  105.634459] mmc_spi spi32766.0:   mmc_spi: CMD8, resp R3/R4/R7
[  105.640457] mmc_spi spi32766.0: xilinx_spi_setup, mode 0, 8 bits/w, 0
nsec/bit
[  105.647472] mmc0: req done (CMD8): 0: 00000001 000001aa 00000000
00000000
[  105.654162] mmc0: starting CMD55 arg 00000000 flags 000000f5
[  105.659796] mmc_spi spi32766.0:   mmc_spi: CMD55, resp R1
[  105.665301] mmc_spi spi32766.0: xilinx_spi_setup, mode 0, 8 bits/w, 0
nsec/bit
[  105.672372] mmc0: req done (CMD55): 0: 00000001 00000000 00000000
00000000
[  105.679157] mmc0: starting CMD41 arg 40000000 flags 000000e1
[  105.684737] mmc_spi spi32766.0:   mmc_spi: CMD41, resp R1
[  105.690267] mmc_spi spi32766.0: xilinx_spi_setup, mode 0, 8 bits/w, 0
nsec/bit
[  105.697327] mmc0: req done (CMD41): 0: 00000001 00000000 00000000
00000000
...
CMD55 + CMD41 repeated 3 times, same messages as above.
...
[  105.895962] mmc0: starting CMD59 arg 00000001 flags 00000080
[  105.901545] mmc_spi spi32766.0:   mmc_spi: CMD59, resp R1
[  105.907129] mmc_spi spi32766.0: xilinx_spi_setup, mode 0, 8 bits/w, 0
nsec/bit
[  105.914091] mmc0: req done (CMD59): 0: 00000000 00000000 00000000
00000000
[  105.920964] mmc0: starting CMD10 arg 00000000 flags 000000b5
[  105.926517] mmc0:     blksz 16 blocks 1 flags 00000200 tsac 0 ms nsac
64
[  105.933195] mmc_spi spi32766.0:   mmc_spi: CMD10, resp R1
[  105.938693] mmc_spi spi32766.0:     mmc_spi: read block, 16 bytes
[  105.944823] mmc_spi spi32766.0: read error ffffff92 (-110)
[  105.950015] mmc_spi spi32766.0: read status -110
[  105.954579] mmc_spi spi32766.0: xilinx_spi_setup, mode 0, 8 bits/w, 0
nsec/bit
[  105.961806] mmc0: req done (CMD10): 0: 00000000 00000000 00000000
00000000
[  105.968609] mmc0:     0 bytes transferred: -110
[  105.973082] mmc0: clock 0Hz busmode 2 powermode 0 cs 1 Vdd 0 width 0
timing 0
[  105.980189] mmc_spi spi32766.0: mmc_spi: power off (0)
[  105.985254] mmc0: error -110 whilst initialising SD card
