Return-Path: <johndavi@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.129])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "e32.co.us.ibm.com",
	Issuer "Network Services" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 09E2F67A93
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 30 Jan 2005 05:20:53 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e31.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j0TIKom4539656
	for <linuxppc-embedded@ozlabs.org>; Sat, 29 Jan 2005 13:20:50 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j0TIKo1r265770
	for <linuxppc-embedded@ozlabs.org>; Sat, 29 Jan 2005 11:20:50 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	j0TIKogt025184
	for <linuxppc-embedded@ozlabs.org>; Sat, 29 Jan 2005 11:20:50 -0700
Received: from d03nm113.boulder.ibm.com (d03nm113.boulder.ibm.com
	[9.17.195.139])
	by d03av01.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	j0TIKn1g025169
	for <linuxppc-embedded@ozlabs.org>; Sat, 29 Jan 2005 11:20:49 -0700
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Message-ID: <OFB9EF8279.6BE326D4-ON87256F98.0064352A-85256F98.00653DBF@us.ibm.com>
From: John F Davis <johndavi@us.ibm.com>
Date: Sat, 29 Jan 2005 13:20:50 -0500
Content-Type: text/plain; charset="US-ASCII"
Subject: IDE DMA info part 2
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello

I almost forgot.  Here is some additional output from the VIA chipset proc 
file and the weirdness as reported by hdparm concerning this disk.


hdparm -i /dev/hda
-------------------------------

/dev/hda:

 Model=FUJITSU MHT2020AT, FwRev=009B, SerialNo=NN11T451AP9S
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39070080
 IORDY=yes, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5 
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a: 

 * signifies the current active mode



What is weird about this is that currently hdparm -d /dev/hda shows this:
---------------------------------------------------------------------------------------------------------
/dev/hda:
 using_dma    =  0 (off)



hdparm -I /dev/hda
----------------------------------

/dev/hda:

ATA device, with non-removable media
powers-up in standby; SET FEATURES subcmd spins-up.

        WARNING: ID response incomplete.
        WARNING: Following data may be incorrect.

        Model Number:       UFIJST UHM2T20A0 T 
        Serial Number:      NN114T15PAS9
        Firmware Revision:  00B9 
Standards:
        Supported: 14 13 12 11 
        Likely used: 14
Configuration:
        Logical         max     current
        cylinders       65343   0
        heads           4096    0
        sectors/track   16128   0
        --
        device size with M = 1024*1024:  2107703808 MBytes
        device size with M = 1000*1000:  2210087628 MBytes (2210087 GB)
Capabilities:
        IORDY(may be)(cannot be disabled)
        Queue depth: 1
        Standby timer values: spec'd by Vendor
        R/W multiple sector transfer: Max = 128 Current = ?
        Advanced power management level: unknown setting (0x8040)
        Recommended acoustic management value: 254, current value: 254
        DMA: not supported
        PIO: unknown
Security: 
        Master password revision code = 65279
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
Checksum: correct


cat /proc/ide/via
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.37
South Bridge:                       VIA vt82c686b
Revision:                           ISA 0x40 IDE 0x6
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xffd0
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:        PIO       PIO       PIO       PIO
Address Setup:       30ns     120ns     120ns     120ns
Cmd Active:          90ns      90ns     480ns     480ns
Cmd Recovery:        30ns      30ns     480ns     480ns
Data Active:         90ns     330ns     330ns     330ns
Data Recovery:       30ns     270ns     270ns     270ns
Cycle Time:         120ns     600ns     600ns     600ns
Transfer Rate:   16.6MB/s   3.3MB/s   3.3MB/s   3.3MB/s



cat /proc/dma
-------------------------
4: cascade
