Return-Path: <mh@omnisys.se>
Received: from mail.omnisys.se (static-213-115-84-26.sme.bredbandsbolaget.se
	[213.115.84.26]) by ozlabs.org (Postfix) with ESMTP id F2CDADDF3F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Jan 2007 00:14:53 +1100 (EST)
Received: from mail.omnisys.se (localhost.localdomain [127.0.0.1])
	by local.omnisys.se (Postfix) with ESMTP id 53E1E2C4CB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Jan 2007 13:45:00 +0100 (CET)
Received: from [192.168.168.19] (dynamic019.omnisys.se [192.168.168.19])
	by mail.omnisys.se (Postfix) with ESMTP id 4EF482C4BD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Jan 2007 13:45:00 +0100 (CET)
Message-ID: <45B8A64C.4050505@omnisys.se>
Date: Thu, 25 Jan 2007 13:45:00 +0100
From: Magnus Hjorth <mh@omnisys.se>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: ML403 hard Ethernet under Linux 2.6.18
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm trying to get Linux 2.6.18.6 working on an ML403 board with a basic 
EDK design with a hard_temac and uart. I've generated the BSP for 
linux_2_6, copied the drivers and twiddled a little to make it all compile.

The TEMAC driver seems to find the hardware, but the speed negotiation 
seems not to work. I can see the speed LEDs first go to 100 Mbit, then 
100 MBit again, and then 10 MBit. Since it's connected to a 10/100 
switch, the speed negotiation actually looks like it's working. Could 
anyone give me a clue to what's wrong? I would be thankful for any advice.

The output is given below:

loaded at:     00400000 004B713C
board data at: 004B5124 004B513C
relocated to:  00404094 004040AC
zimage at:     00404EA7 004B43E2
avail ram:     004B8000 03D09000

Linux/PPC load: console=ttyS0,9600 ip=on
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.6.18.6mh1 (labb@dynamic035.omnisys.se) (gcc version 
3.4.1) #10 7
Xilinx ML403 Reference System (Virtex-4 FX)
Built 1 zonelists.  Total pages: 15625
Kernel command line: console=ttyS0,9600 ip=on
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000
PID hash table entries: 256 (order: 8, 1024 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 60184k available (1152k kernel code, 452k data, 68k init, 0k 
highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
NET: Registered protocol family 2
IP route cache hash table entries: 512 (order: -1, 2048 bytes)
TCP established hash table entries: 2048 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 2048 bind 1024)
TCP reno registered
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x40401003 (irq = 1) is a 16550A
XTemac: using FIFO direct interrupt driven mode.
eth0: Xilinx TEMAC #0 at 0x81200000 mapped to 0xC4000000, irq=0
eth0: XTemac id 1.0f, block id 5, type 8
TCP bic registered
NET: Registered protocol family 1
eth0: XTemac: Options: 0xb8f2
eth0: XTemac: Not able to set the speed to 1000 (status: 0x148)
eth0: XTemac: Not able to set the speed to 100 (status: 0x148)
eth0: XTemac: Not able to set the speed to 10 (status: 0x148)
eth0: XTemac: could not negotiate speed
Sending DHCP requests .<6>eth0: XTemac: PHY Link carrier lost.
..... timed out!
IP-Config: Reopening network devices...
eth0: XTemac: Options: 0xb8f2
eth0: XTemac: Not able to set the speed to 1000 (status: 0x148)
eth0: XTemac: Not able to set the speed to 100 (status: 0x148)
eth0: XTemac: Not able to set the speed to 10 (status: 0x148)
eth0: XTemac: could not negotiate speed
Sending DHCP requests ...... timed out!
IP-Config: Reopening network devices...
[...looping over and over...]



-- 

Magnus Hjorth, M.Sc.
Omnisys Instruments AB
Gruvgatan 8
SE-421 30  Västra Frölunda, SWEDEN
Phone: +46 31 734 34 09
Fax: +46 31 734 34 29
http://www.omnisys.se 
