Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id C0E8DDDE32
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Nov 2007 04:20:15 +1100 (EST)
Message-ID: <473C7FCC.7050307@anagramm.de>
Date: Thu, 15 Nov 2007 18:20:12 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Latest paulus.git PCI broken on mpc8540?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi there!

I try to use the latest Linux-2.6.24-rc2-ge6a5c27f from paulus.git
for my mpc8540ads compatible board.

$ dmesg contains some nasty messages, which look like something is wrong.

PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 0000:00:12.0
PCI: Cannot allocate resource region 1 of device 0000:00:12.0
PCI: Cannot allocate resource region 2 of device 0000:00:12.0
PCI: Cannot allocate resource region 3 of device 0000:00:12.0
PCI: Cannot allocate resource region 4 of device 0000:00:12.0
PCI: Cannot allocate resource region 0 of device 0000:00:14.0
PCI: Cannot allocate resource region 2 of device 0000:00:14.0

However, the PCI devices just work fine - machine boots and:

$ lspci -vv
00:12.0 Mass storage controller: Promise Technology, Inc. 20269 (rev 02) (prog-if 85)
         Subsystem: Promise Technology, Inc. Ultra133TX2
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <-
         Latency: 128 (1000ns min, 4500ns max), Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at 1000 [size=8]
         Region 1: I/O ports at 1008 [size=4]
         Region 2: I/O ports at 1010 [size=8]
         Region 3: I/O ports at 100c [size=4]
         Region 4: I/O ports at 1020 [size=16]
         Region 5: Memory at 80000000 (32-bit, non-prefetchable) [size=16K]
         Expansion ROM at 000dc000 [disabled] [size=16K]
         Capabilities: [60] Power Management version 1
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Kernel driver in use: pata_pdc2027x

00:14.0 Mass storage controller: Promise Technology, Inc. PDC40775 (SATA 300 TX2plus) (rev 02)
         Subsystem: Promise Technology, Inc. PDC40775 (SATA 300 TX2plus)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR--
         Latency: 128 (1000ns min, 4500ns max), Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 19
         Region 0: I/O ports at 1080 [size=128]
         Region 2: I/O ports at 1400 [size=256]
         Region 3: Memory at 80004000 (32-bit, non-prefetchable) [size=4K]
         Region 4: Memory at 80020000 (32-bit, non-prefetchable) [size=128K]
         Expansion ROM at 00080000 [disabled] [size=32K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Kernel driver in use: sata_promise


Hmm...
I suspect a wrong kernel config or problems with the device tree
(I'm using an unchanged arch/powerpc/boot/dts/mpc8540ads.dts).
My .config is based on the mpc8540_ads_defconfig was attached:
http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20071114/2567627a/attachment-0001.txt

Any ideas?

Thank you,

-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
