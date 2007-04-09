Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A7D6DDF06
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Apr 2007 23:13:30 +1000 (EST)
Message-ID: <461A3C10.3050104@genesi-usa.com>
Date: Mon, 09 Apr 2007 14:13:52 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: adding Pegasus IDE quirk for pata_via
References: <20070404111635.GA1855@aepfle.de>
In-Reply-To: <20070404111635.GA1855@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Olaf, IDE guys,

I believe that this quirk is not Pegasos-specific. It will also affect any
Via VT8231 controller (and perhaps any Via IDE, but I can't test that assertion)
which is run in PCI mode.

The basic bug is that in PCI native mode, the chip should use ONE PCI
interrupt and there is logic in the driver to select which channel fired
it. However, if the chip is configured to use two interrupts in the IRQ
steering register, it WILL use two interrupts.

I did write a patch at one time (September last year) but abandoned it as it
would only have had to be rewritten and I did not have the real resources
required to make sure it did not make any other platforms explode.

(Olaf, Peter Czanik may have forwarded you an old version of this patch already)

It basically did the following where the old Pegasos check was:

+	if (vdev->via_config->flags & VIA_NATIVE_TWO_IRQ) {
+		u8 cb;
+
+	    pci_read_config_byte(hwif->pci_dev, PCI_CLASS_PROG, &cb);
+
+		if (cb & 0x5) { /* if controller is configured for pci-native mode for both channels */
+		    	pci_read_config_byte(hwif->pci_dev, PCI_INTERRUPT_PIN, &cb);
+
+	   		if (cb & 0x1) { /* if controller is actually using an interrupt for native mode */
+
+				struct pci_dev *bridge = pci_find_device(PCI_VENDOR_ID_VIA, vdev->via_config->id);
+
+				if (bridge) {
+					u8 iir, irqlist[4] = { 14, 15, 10, 11 };
+
+					pci_read_config_byte(bridge, VIA_IDE_STEERING, &iir);
+
+					hwif->irq = irqlist[hwif->channel ? ((iir & 0xc) >> 2) : (iir & 0x3)];
+				}
+
+			}
+		}
  	}

This basically uses the IRQ that the Via chipset says to use, as it is always programmed into the
chipset, and that value is always correct. Only 14, 15, 10 and 11 are valid according to the
documentation, but in truth only interrupts 14 and 15 actually work. It is possible to set the
interrupts to the same IRQ but this is quite rare and the old via driver did not seem to handle
it correctly, so the firmware leaves the 14/15 combination in there to get a working system.

I tried to keep it as generic as possible. This patch does work on Pegasos.

Either way the steering bits will tell you which it is, rather than a switch between 14 and 15
hardcoded into the system. There is no need to use the device tree and in fact any modification
to the interrupt node would be rather spurious since the device tree can only include one interrupt
value for the PCI device according to the standard, and cannot define which interrupt goes with
which channel (it could be reversed!).

The only safe way is to use the values programmed into the chip. This will also fix any other
architecture where this chipset is used (x86) in this manner. This is 0% of x86 systems with an
Award/AMI BIOS but if the chip is reconfigured in early boot, or if LinuxBIOS or OpenBIOS are
used, this may well change on the author's whim.

Again some comments would be appreciated from anyone who has a better idea on how this controller
works. This simple code addition came out of 2 or 3 days of discussion with the Pegasos designer
based on his experiences with the chip and is so simple there cannot be much wrong with it
apart from coding style and a distinct lack of testing.

Thanks for any input you can give :)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Olaf Hering wrote:
> The pegaos board needs an irq quirk in pata_via.
> Where is the quirk list for libata? I dont see one in pata_via.c
> 
> drivers/ide/pci/via82cxxx.c:init_hwif_via82cxxx()
> 
>     440 #ifdef CONFIG_PPC_CHRP
>     441         if(machine_is(chrp) && _chrp_type == _CHRP_Pegasos) {
>     442                 hwif->irq = hwif->channel ? 15 : 14;
>     443         }
>     444 #endif
> 
> 
> This is in the firmware node. Will a fixup of the 'interrupts' property
> work or does everything poke directly at the PCI registers?
> Should fixup_device_tree_chrp() take care of the 'interrupts' property?
> 
> /proc/device-tree/pci@80000000/ide@C,1:
> name             "ide"
> linux,phandle    0fc5c3a0 (264618912)
> interrupt-parent 0fc5b948 (264616264)
> assigned-addresses 01006110 00000000 fe001000 00000000 00000008
>                  01006114 00000000 fe00100c 00000000 00000004
>                  01006118 00000000 fe001010 00000000 00000008
>                  0100611c 00000000 fe00101c 00000000 00000004
>                  01006120 00000000 fe001020 00000000 00000010
> device_type      "spi"
> reg              00006100 00000000 00000000 00000000 00000000 01006110
>                  00000000 00000000 00000000 00000008 01006114 00000000
>                  00000000 00000000 00000004 01006118 00000000 00000000
>                  00000000 00000008 0100611c 00000000 00000000 00000000
>                  00000004 01006120 00000000 00000000 00000000 00000010
> max-latency      00000000
> min-grant        00000000
> fast-back-to-back
> devsel-speed     00000001
> interrupts       00000014 00000000 00000015 00000000
> .description     "PCI IDE Controller"
> .part-number     "VT82C586/596/686"
> .vendor-name     "VIA"
> subsystem-vendor-id 00000000
> subsystem-id     00000000
> class-code       0001018f (65935)
> revision-id      00000006
> device-id        00000571 (1393)
> vendor-id        00001106 (4358)
> 
> 
> 0000:00:0c.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8f [Master SecP SecO PriP PriO])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 20
>         Region 0: I/O ports at 1000 [size=8]
>         Region 1: I/O ports at 100c [size=4]
>         Region 2: I/O ports at 1010 [size=8]
>         Region 3: I/O ports at 101c [size=4]
>         Region 4: I/O ports at 1020 [size=16]
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
