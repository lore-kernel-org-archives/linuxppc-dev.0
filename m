Return-Path: <fabien.fb@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.190])
	by ozlabs.org (Postfix) with ESMTP id 9D2F5DDE04
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Nov 2007 22:05:01 +1100 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so1921416fkz
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Nov 2007 03:05:00 -0800 (PST)
Message-ID: <f8f856500711130304o5c5b6b1fwa73608fd9711fcfc@mail.gmail.com>
Date: Tue, 13 Nov 2007 12:04:59 +0100
From: fabien <fabien.fb@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: (beginner) Kernel fail during local_irq_enable()
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I work on a custom board based on MPC8xx.

The bootloader on it is a ppcboot 1.1.5. I'm a beginner with Linux port

and ppc.
 I'm trying to pass the board working with a 2.4.4 kernel to a 2.6.19 kernel

from denx.
 The kernel hang when trying to enable interrupt in local_irq_enable()

in init/main.c.
 Nothing happened after. Look at the printk log dumped from __log_buf
adresse with md ppcboot command.





PPCBoot 1.1.5 (May  3 2002 - 10:26:09)



CPU:   PPC860TZPnnE0 at 50 MHz: 4 kB I-Cache 4 kB D-Cache FEC present

Board: FAST2100
DRAM:  (16 MB SDRAM) 16 MB

FLASH:  4 MB

In:    serial

Out:   serial

Err:   serial

Hit any key to stop autoboot:  0

=>bdinfo

memstart    = 0x00000000

memsize     = 0x01000000

flashstart  = 0x02800000

flashsize   = 0x00400000

flashoffset = 0x00020000

sramstart   = 0x00000000

sramsize    = 0x00000000

immr_base   = 0xFF000000

bootflags   = 0x00000001

intfreq     =     50 MHz

busfreq     =     50 MHz

ethaddr     = 00:60:4C:08:21:FF

IP addr     = 10.0.0.148

baudrate    =   9600 bps

=>tftpboot 0x400000

ARP broadcast 1

TFTP from server 10.0.0.147; our IP address is 10.0.0.148

Filename 'uImage'.

Load address: 0x400000

Loading: #################################################################

         #############################################

done

Bytes transferred = 561058 (88fa2 hex)

=>bootm 0x400000

## Booting image at 00400000 ...

   Image Name:   Linux-2.6.19.2

   Created:      2007-11-12  15:08:44 UTC

   Image Type:   PowerPC Linux Kernel Image (gzip compressed)

   Data Size:    560994 Bytes = 547 kB = 0 MB

   Load Address: 00000000

   Entry Point:  00000000

   Verifying Checksum ... OK

   Uncompressing Kernel Image ... OK



=>md 1273c4

001273c4: 3c353e4c 696e7578 20766572 73696f6e    <5>Linux version

001273d4: 20322e36 2e31392e 32202866 61626965     2.6.19.2 (fabie

001273e4: 6e406c6f 63616c68 6f737429 20286763    n@localhost) (gc

001273f4: 63207665 7273696f 6e20342e 302e3020    c version 4.0.0

00127404: 2844454e 5820454c 444b2034 2e312034    (DENX ELDK 4.1 4

00127414: 2e302e30 29292023 3135204d 6f6e204e    .0.0)) #15 Mon N

00127424: 6f762031 32203136 3a32323a 30382043    ov 12 16:22:08 C

00127434: 45542032 3030370a 3c373e45 6e746572    ET 2007.<7>Enter

00127444: 696e6720 6164645f 61637469 76655f72    ing add_active_r

00127454: 616e6765 28302c20 302c2034 30393629    ange(0, 0, 4096)

00127464: 20302065 6e747269 6573206f 66203235     0 entries of 25

00127474: 36207573 65640a3c 343e5a6f 6e652050    6 used.<4>Zone P

00127484: 464e2072 616e6765 733a0a3c 343e2020    FN ranges:.<4>

00127494: 444d4120 20202020 20202020 20202020    DMA

001274a4: 30202d3e 20202020 20343039 360a3c34    0 ->     4096.<4

001274b4: 3e20204e 6f726d61 6c202020 20202020    >  Normal

=>

001274c4: 34303936 202d3e20 20202020 34303936    4096 ->     4096

001274d4: 0a3c343e 6561726c 795f6e6f 64655f6d    .<4>early_node_m

001274e4: 61705b31 5d206163 74697665 2050464e    ap[1] active PFN

001274f4: 2072616e 6765730a 3c343e20 20202030     ranges.<4>    0

00127504: 3a202020 20202020 2030202d 3e202020    :        0 ->

00127514: 20203430 39360a3c 373e4f6e 206e6f64      4096.<7>On nod

00127524: 65203020 746f7461 6c706167 65733a20    e 0 totalpages:

00127534: 34303936 0a3c373e 2020444d 41207a6f    4096.<7>  DMA zo

00127544: 6e653a20 33322070 61676573 20757365    ne: 32 pages use

00127554: 6420666f 72206d65 6d6d6170 0a3c373e    d for memmap.<7>

00127564: 2020444d 41207a6f 6e653a20 30207061      DMA zone: 0 pa

00127574: 67657320 72657365 72766564 0a3c373e    ges reserved.<7>

00127584: 2020444d 41207a6f 6e653a20 34303634      DMA zone: 4064

00127594: 20706167 65732c20 4c49464f 20626174     pages, LIFO bat

001275a4: 63683a30 0a3c373e 20204e6f 726d616c    ch:0.<7>  Normal

001275b4: 207a6f6e 653a2030 20706167 65732075     zone: 0 pages u

=>

001275c4: 73656420 666f7220 6d656d6d 61700a3c    sed for memmap.<

001275d4: 343e4275 696c7420 31207a6f 6e656c69    4>Built 1 zoneli

001275e4: 7374732e 2020546f 74616c20 70616765    sts.  Total page

001275f4: 733a2034 3036340a 3c353e4b 65726e65    s: 4064.<5>Kerne

00127604: 6c20636f 6d6d616e 64206c69 6e653a20    l command line:

00127614: 0a3c343e 50494420 68617368 20746162    .<4>PID hash tab

00127624: 6c652065 6e747269 65733a20 36342028    le entries: 64 (

00127634: 6f726465 723a2036 2c203235 36206279    order: 6, 256 by

00127644: 74657329 0a3c343e 44656372 656d656e    tes).<4>Decremen

00127654: 74657220 46726571 75656e63 79203d20    ter Frequency =

00127664: 3138302f 36300a3c 343e2046 41425f44    180/60.<4> FAB_D

00127674: 45425547 20414654 45522045 41524c59    EBUG AFTER EARLY

00127684: 5f424f4f 545f4952 51535f4f 4e282920    _BOOT_IRQS_ON()

00127694: 00000000 00000000 00000000 00000000    ................

001276a4: 00000000 00000000 00000000 00000000    ................

001276b4: 00000000 00000000 00000000 00000000    ...............





Could someone give me some help about where to seek for isolate the problem ?
