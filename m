Return-Path: <RichardRetanubun@ruggedcom.com>
Received: from mail.ruggedcom.com (mail.ruggedcom.com [204.50.190.93])
	by bilbo.ozlabs.org (Postfix) with ESMTP id B5FD3B70E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 08:43:54 +1000 (EST)
Received: from rcws-214.eng.lan (unknown [10.128.10.74])
	by rceng01.eng.lan (Postfix) with ESMTP id 2F31614E023
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jul 2009 18:31:41 -0400 (EDT)
Received: from localhost ([127.0.0.1] ident=richardretanubun)
	by rcws-214.eng.lan with esmtp (Exim 4.69)
	(envelope-from <RichardRetanubun@RuggedCom.com>) id 1MM8L6-0000nW-V8
	for linuxppc-dev@lists.ozlabs.org; Wed, 01 Jul 2009 18:31:41 -0400
Message-ID: <4A4BE3CC.3010807@RuggedCom.com>
Date: Wed, 01 Jul 2009 18:31:40 -0400
From: Richard Retanubun <RichardRetanubun@RuggedCom.com>
MIME-Version: 1.0
To: Linuxppc-dev-mList <linuxppc-dev@lists.ozlabs.org>
Subject: [Question] MPC8360: Enabling DMA for CompactFlash in IDE mode
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I am running on an MPC8360 board with u-boot-2009.06 and linux-2.6.26-13.
The board is booting from nor flash and then u-boot configures UPM-A for compact flash in true-IDE mode
(based on the design of the MPC8349ITX eval board). The IRQ used is IRQ6.

I got this setup going fine, but now I wish to enable DMA support to the compact flash to speed it up.

The HW wired the compact flash's DMA_DREQ and DMA_DACK to the CPUs DMA_DREQ3 (PC[17]) and DMA_DACK3 (PC[0]).

I added this in u-boot to configure the pins to their DMA functions:

	/* DMA Controller, channel 3 for compact flash */
  	{2, 0,  1, 0, 1},	/* DMA_DACK3n / PTP_ALARM1 */
	{2, 17, 2, 0, 2},	/* DMA_DREQ3n / PTP_PPS2 */

In the dtb, I added the following for dma and compact flash

		dma@82a8 {
			#address-cells = <1>;
			#size-cells = <1>;
			compatible = "fsl,elo-dma";
			reg = <0x82a8 4>;
			ranges = <0 0x8100 0x1a8>;
			interrupt-parent = <&ipic>;
			interrupts = <0x47 8>;
			cell-index = <0>;
			
			/* The dma-channels are offset from 0x8100 */
			dma-channel@0 {
				compatible = "fsl,elo-dma-channel";
				reg = <0 0x80>;
				interrupt-parent = <&ipic>;
				interrupts = <0x47 8>;
			};
			dma-channel@80 {
				compatible = "fsl,elo-dma-channel";
				reg = <0x80 0x80>;
				interrupt-parent = <&ipic>;
				interrupts = <0x47 8>;
			};
			dma-channel@100 {
				compatible = "fsl,elo-dma-channel";
				reg = <0x100 0x80>;
				interrupt-parent = <&ipic>;
				interrupts = <0x47 8>;
			};
			dma-channel@180 {
				compatible = "fsl,elo-dma-channel";
				reg = <0x180 0x28>;
				interrupt-parent = <&ipic>;
				interrupts = <0x47 8>;
			};
		}; /* dma@82a8 */

		/* CS2 = Compact FLash in PATA/IDE connection */
		pata@2,0 {
			device_type = "ata";
			compatible = "ata-generic";
			reg = <0x2 0x0 0x10 0x2 0x20c 0x4>;
			reg-shift = <0x1>;
			pio-mode = <0x6>;
			interrupts = <0x16 0x8>;
			interrupt-parent = <&ipic>;
		};

I enabled the kernel's CONFIG_ATA, CONFIG_ATA_SFF, CONFIG_PATA_PLATFORM, CONFIG_PATA_OF_PLATFORM for the CF
I also enabled CONFIG_DMADEVICES and CONFIG_FSL_DMA

with all this in place, I got this on boot:

of-fsl-dma e00082a8.dma: Probe the Freescale DMA driver for fsl,elo-dma controller at e00082a8...
of-fsl-dma-channel e0008100.dma-channe: #0 (fsl,elo-dma-channel), irq 71
of-fsl-dma-channel e0008180.dma-channe: #1 (fsl,elo-dma-channel), irq 71
of-fsl-dma-channel e0008200.dma-channe: #2 (fsl,elo-dma-channel), irq 71
of-fsl-dma-channel e0008280.dma-channe: #3 (fsl,elo-dma-channel), irq 71
[snip]
scsi0 : pata_platform
ata1: PATA max PIO6 mmio cmd 0xf8008000 ctl 0xf800820c irq 27
ata1.00: ATA-4: SG9CF1GSME4IRUG, 20071016, max UDMA/100
ata1.00: 1989792 sectors, multi 0: LBA
ata1.00: configured for PIO
scsi 0:0:0:0: Direct-Access     ATA      SG9CF1GSME4IRUG  2007 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 1989792 512-byte hardware sectors (1019 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 1989792 512-byte hardware sectors (1019 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
  sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7
sd 0:0:0:0: [sda] Attached SCSI disk
[snip]

However, I don't think the CPU is using DMA channel 3 to speed up CF access

I tried doing "dd if=/dev/sda5 of=/dev/sda7 bs=4KB"
which copied 493MB at 2.5 MB/s with top showing about 75% CPU usage.

So, what am I missing?
(my guess is the glue between the DMA engine and the Compact flash,
  but I'm not sure how to hook it up).

Thank you very much for everyone's time.


Richard Retanubun
-----------------
RuggedCom
30 Whitmore Road,Woodbdrige
Ontario, Canada
