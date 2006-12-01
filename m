Return-Path: <olaf@aepfle.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.189])
	by ozlabs.org (Postfix) with ESMTP id 427B267BCF
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 05:34:21 +1100 (EST)
Date: Fri, 1 Dec 2006 19:34:16 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_sl82c105 can not reserve IO region
Message-ID: <20061201183355.GA9701@aepfle.de>
References: <20061130165202.GA23205@aepfle.de>
	<20061130171049.7b80a40c@localhost.localdomain>
	<20061130184748.GA24071@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20061130184748.GA24071@aepfle.de>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 30, Olaf Hering wrote:

> On Thu, Nov 30, Alan wrote:
> 
> > I/O region #6.
> > 
> > pci_request_regions() and pci_request_selcted_regions() end up in a loop
> > calling pci_request_region with the values 0 to 5. Never 6.
> 
> The printk in pci_request_region has 'bar + 1', so 6 should be possible
> if i becomes 5.

Does the IO region of the last bar look correct?


00:03.1 IDE interface: Symphony Labs SL82c105 (rev 05) (prog-if 8f [Master SecP SecO PriP PriO])
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 86
	Region 0: I/O ports at 3fd3000f000 [size=8]
	Region 1: I/O ports at 3fd3000f010 [size=4]
	Region 2: I/O ports at 3fd3000f020 [size=8]
	Region 3: I/O ports at 3fd3000f030 [size=4]
	Region 4: I/O ports at 3fd3000f040 [size=16]
	Region 5: I/O ports at 3fd30000000 [size=16]
00: ad 10 05 01 41 01 80 02 05 8f 01 01 08 48 80 00
10: 01 f0 00 00 11 f0 00 00 21 f0 00 00 31 f0 00 00
20: 41 f0 00 00 01 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 56 01 02 28
40: b3 08 ff 00 09 09 00 00 09 09 00 00 09 09 00 00
50: 09 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

name             "ide"
linux,phandle    00d5cdc0 (14011840)
assigned-addresses 81001910 00000000 0000f000 00000000 00000008 81001914
		 00000000 0000f010 00000000 00000004 81001918 00000000
		 0000f020 00000000 00000008 8100191c 00000000 0000f030
		 00000000 00000004 81001920 00000000 0000f040 00000000
		 00000010 81001924 00000000 00000000 00000000 00000010
interrupts       00000003
built-in        
#size-cells      00000000
#address-cells   00000001
device_type      "ide"
reg              00001900 00000000 00000000 00000000 00000000
		 41001910 00000000 00000000 00000000 00000008
		 41001914 00000000 00000000 00000000 00000004
		 41001918 00000000 00000000 00000000 00000008
		 4100191c 00000000 00000000 00000000 00000004
		 41001920 00000000 00000000 00000000 00000010
		 41001924 00000000 00000000 00000000 00000010
compatible       "pci10ad,105"
		 "pciclass,01018f"
ibm,fw-slot-number 00000000
fast-back-to-back
devsel-speed     00000001
max-latency      00000028 (40)
min-grant        00000002
class-code       0001018f (65935)
revision-id      00000005
device-id        00000105 (261)
vendor-id        000010ad (4269)
ibm,loc-code     "U0.1-P1/Q6"
