Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6A988DDE3D
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 21:16:20 +1000 (EST)
Date: Wed, 4 Apr 2007 13:16:35 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Subject: adding Pegasus IDE quirk for pata_via
Message-ID: <20070404111635.GA1855@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The pegaos board needs an irq quirk in pata_via.
Where is the quirk list for libata? I dont see one in pata_via.c

drivers/ide/pci/via82cxxx.c:init_hwif_via82cxxx()

    440 #ifdef CONFIG_PPC_CHRP
    441         if(machine_is(chrp) && _chrp_type == _CHRP_Pegasos) {
    442                 hwif->irq = hwif->channel ? 15 : 14;
    443         }
    444 #endif


This is in the firmware node. Will a fixup of the 'interrupts' property
work or does everything poke directly at the PCI registers?
Should fixup_device_tree_chrp() take care of the 'interrupts' property?

/proc/device-tree/pci@80000000/ide@C,1:
name             "ide"
linux,phandle    0fc5c3a0 (264618912)
interrupt-parent 0fc5b948 (264616264)
assigned-addresses 01006110 00000000 fe001000 00000000 00000008
                 01006114 00000000 fe00100c 00000000 00000004
                 01006118 00000000 fe001010 00000000 00000008
                 0100611c 00000000 fe00101c 00000000 00000004
                 01006120 00000000 fe001020 00000000 00000010
device_type      "spi"
reg              00006100 00000000 00000000 00000000 00000000 01006110
                 00000000 00000000 00000000 00000008 01006114 00000000
                 00000000 00000000 00000004 01006118 00000000 00000000
                 00000000 00000008 0100611c 00000000 00000000 00000000
                 00000004 01006120 00000000 00000000 00000000 00000010
max-latency      00000000
min-grant        00000000
fast-back-to-back
devsel-speed     00000001
interrupts       00000014 00000000 00000015 00000000
.description     "PCI IDE Controller"
.part-number     "VT82C586/596/686"
.vendor-name     "VIA"
subsystem-vendor-id 00000000
subsystem-id     00000000
class-code       0001018f (65935)
revision-id      00000006
device-id        00000571 (1393)
vendor-id        00001106 (4358)


0000:00:0c.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8f [Master SecP SecO PriP PriO])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at 1000 [size=8]
        Region 1: I/O ports at 100c [size=4]
        Region 2: I/O ports at 1010 [size=8]
        Region 3: I/O ports at 101c [size=4]
        Region 4: I/O ports at 1020 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
