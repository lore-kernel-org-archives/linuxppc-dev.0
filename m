Return-Path: <jeff@theptrgroup.com>
Received: from mail.theptrgroup.com (unknown [209.183.211.17])
	by ozlabs.org (Postfix) with ESMTP id 0D720687DE
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Dec 2005 03:20:55 +1100 (EST)
Received: from [192.168.180.201] ([132.250.144.104])
	by mail.theptrgroup.com (8.11.6/linuxconf) with ESMTP id jB2GFp722745
	for <linuxppc-embedded@ozlabs.org>; Fri, 2 Dec 2005 11:15:53 -0500
From: Jeff Angielski <jeff@theptrgroup.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 11:14:23 -0500
Message-Id: <1133540063.24853.17.camel@nighteyes.site>
Mime-Version: 1.0
Subject: ieee1394, Denx 3.1 (2.4.25+), PPC
Reply-To: jeff@theptrgroup.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Has anybody out there gotten this combination of hardware and software
to work?  

I am trying to figure out if this is a problem with my particular
system/configuration or inherent in the current software baseline.  The
problem is that while all software loads and runs without error, I am
unable to detect any devices/nodes on the IEEE1394 bus.  


Thanks,
Jeff Angielski
The PTR Group



Some details for those not faint of heart...

Custom MPC826x board
EKF CYMBAL cPCI adapter
LACIE 250GB external HD

u-boot 1.1.3
Denx 3.1 - 2.4.25+
Latest ieee1394 Linux 2.4 SVN snapshot from http://www.linux1394.org/

Command sequence:

insmod ieee1394.o
insmod ohci1394.o
insmod raw1394.o
insmod sbp2.o
testlibraw
rescan-scsi-bus.sh


Output in /var/log/messages

ohci1394: $Rev: 1286 $ Ben Collins <bcollins@debian.org>
ohci1394_0: Remapped memory spaces reg 0xc90a6800
ohci1394_0: Soft reset finished
ohci1394_0: Iso contexts reg: 000000a8 implemented: 0000000f
ohci1394_0: 4 iso receive contexts available
ohci1394_0: Iso contexts reg: 00000098 implemented: 000000ff
ohci1394_0: 8 iso transmit contexts available
ohci1394_0: GUID: 00c08802:00a41ca0
ohci1394_0: Receive DMA ctx=0 initialized
ohci1394_0: Receive DMA ctx=0 initialized
ohci1394_0: Transmit DMA ctx=0 initialized
ohci1394_0: Transmit DMA ctx=1 initialized
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[66]  MMIO=[bffff800-bfffffff]  Max
Packet=[2048]
ohci1394_0: request csr_rom address: c5d78000
ieee1394: CSR: setting expire to 10, HZ=100
ohci1394_0: IntEvent: 00020000
ohci1394_0: irq_handler: Bus reset requested
ohci1394_0: Cancel request received
raw1394: /dev/raw1394 device initialized
ieee1394: sbp2: sbp2_module_init
sbp2: $Rev: 1227 $ Ben Collins <bcollins@debian.org>
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io = 1)
raw1394:write_request called
raw1394:write_request called
scsi singledevice 0 0 0 0
scsi singledevice 0 0 0 1
scsi singledevice 0 0 0 2
scsi singledevice 0 0 0 3
scsi singledevice 0 0 0 4
scsi singledevice 0 0 0 5
scsi singledevice 0 0 0 6
scsi singledevice 0 0 0 7


Output from testlibraw:

successfully got handle
current generation number: 1
1 card(s) found
  nodes on bus:  0, card name: ohci1394
using first card found: 0 nodes on bus, local ID is 0, IRM is 63

doing transactions with custom tag handler

using standard tag handler and synchronous calls

testing FCP monitoring on local node
testing config rom stuff
get_config_rom returned 0, romsize 64, rom_version 1
here are the first 10 quadlets:
0. quadlet: 0x04047381
1. quadlet: 0x31333934
2. quadlet: 0xe000a002
3. quadlet: 0x00c08802
4. quadlet: 0x00a41ca0
5. quadlet: 0x000323fb
6. quadlet: 0x03000000
7. quadlet: 0x81000002
8. quadlet: 0x0c0083c0
9. quadlet: 0x000603ab
update_config_rom returned 0

polling for leftover messages
