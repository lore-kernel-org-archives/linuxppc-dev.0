Message-ID: <3912AE0C.9C8D096B@mpifr-bonn.mpg.de>
Date: Fri, 05 May 2000 13:18:36 +0200
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: FireWire devel <linux1394-devel@eclipt.uni-klu.ac.at>
CC: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>, tas@mindspring.com
Subject: FireWire on Apple PowerBook PISMO
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

With the information from some people on the LinuxPPC list, I was able to talk
to the FireWire OHCI controller in the new Apple PowerBook (PISMO).  I had to
add the vendor/device id of the chip and (as usual, as OpenFirmware does not do
it) add a few lines to enable the pci device.  The "basic" startup seems to
work, but any further operation (e.g. testlibraw) hangs.  Maybe one of the FW
gurus can tell me from the logs below what is missing?

Thanks, Albrecht.


from lspci:
00:0e.0 FireWire (IEEE 1394): Apple Computer Inc.: Unknown device 0018 (rev 01)
(prog-if 10)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 40
	Region 0: Memory at f5000000 (32-bit, non-prefetchable) [disabled]

from /var/log/messages:
ieee1394: registered ohci1394 driver, initializing now
ohci1394: looking for Ohci1394 cards
ohci1394_0: allocated interrupt 40
ohci1394_0: The 1st byte at offset 0x404 is: 0x31
ohci1394_0: remapped memory spaces reg 0xdc8b1000
ohci1394_0: soft reset finished
ohci1394_0: max packet size = 2048 bytes
ohci1394_0: 4 iso contexts available
ohci1394_0: Receive DMA ctx=2 initialized
ohci1394_0: Receive DMA ctx=0 initialized
ohci1394_0: Receive DMA ctx=1 initialized
ohci1394_0: AT dma ctx=0 initialized
ohci1394_0: AT dma ctx=1 initialized
ohci1394_0: request csr_rom address: D4A8DC00
ohci1394_0: Cancel request received
ohci1394_0: resetting bus on request and attempting to become root
ieee1394: detected 1 ohci1394 adapter
ohci1394_0: SelfID process finished (phyid 1, root)
ohci1394_0: selfid packet 0x807f8494 rcvd
ohci1394_0: selfid packet 0x817f84d2 rcvd
ohci1394_0: This node self-id is 0x817f84d2
ohci1394_0: calling self-id complete


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
