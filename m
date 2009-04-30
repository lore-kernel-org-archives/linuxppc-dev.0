Return-Path: <dgaur@cdotd.ernet.in>
Received: from sandesh.cdotd.ernet.in (sandesh.cdotd.ernet.in [196.1.105.47])
	by ozlabs.org (Postfix) with ESMTP id D7BAEDDEDA
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 16:43:47 +1000 (EST)
Received: from sandesh.cdotd.ernet.in (localhost [127.0.0.1])
	by localhost.cdotd.ernet.in (Postfix) with ESMTP id 40250CFD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 12:11:55 +0530 (IST)
Received: from mail1.cdotd.ernet.in (mail1.cdotd.ernet.in [196.1.105.196])by
	sandesh.cdotd.ernet.in (Postfix) with ESMTP id 130EDCFCFBfor
	<linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 12:11:55 +0530 (IST)
Received: from cdotd.ernet.in (localhost.localdomain [127.0.0.1])by
	mail1.cdotd.ernet.in (8.12.5/8.12.5) with ESMTP id n3U6pgSL025825for
	<linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 12:21:42 +0530
From: "Deepak Gaur" <dgaur@cdotd.ernet.in>
To: linuxppc-dev@ozlabs.org
Subject: [2.6.29] MPC8560 Powerpc Port linux-2.6.29 
Date: Thu, 30 Apr 2009 12:21:42 +0530
Message-Id: <20090430065054.M32339@cdotd.ernet.in>
In-Reply-To: <20090430032937.M98987@cdotd.ernet.in>
References: <20090429110648.M98089@cdotd.ernet.in>
	<20090430032937.M98987@cdotd.ernet.in>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all

I have a custom board with MPC8560 and 1GB DDR SDRAM. I am trying to port linux - 2.6.29
on this board. The U-BOOT is already ported on the board and is working.

The OS uImage is stored in code flash at address 0xe0000000 and OS is booted by U-BOOT 
While OS do boot but after some prints weired errors start showing up. Rootfile system
is NFS based . I have checked the register values with Hardware person using Trace32
emulator and they are as expected.

----------------------------------------------------------------------------------------
FLASH: 32.5 MB
L2:    256 KB enabled
In:    serial
Out:   serial
Err:   serial
Net:   TSEC1, TSEC2
Hit any key to stop autoboot:  0
WARNING: adjusting available memory to 30000000
## Booting kernel from Legacy Image at e0000000 ...
   Image Name:   Linux-2.6.29
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1451400 Bytes =  1.4 MB
   Load Address: 00400000
   Entry Point:  004005a8
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Using MPC85xx ADS machine description
Memory CAM mapping: CAM0=256Mb, CAM1=256Mb, CAM2=256Mb residual: 256Mb
Linux version 2.6.29 (deepak@Localhost) (gcc version 3.4.3 (MontaVista
3.4.3-25.0.96.0600665 2006-05-179Found FSL PCI host bridge at 0x00000000a0008000.
Firmware bus number: 0->0
PCI host bridge /pci@a0008000 (primary) ranges:
 MEM 0x0000000080000000..0x000000009fffffff -> 0x0000000080000000
  IO 0x00000000a2000000..0x00000000a2ffffff -> 0x0000000000000000
Zone PFN ranges:
  DMA      0x00000000 -> 0x00030000
  Normal   0x00030000 -> 0x00030000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00030000
MMU: Allocated 1088 bytes of context maps for 255 contexts
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 195072
Kernel command line: console=ttyCPM0,9600 root=/dev/nfs rw nfsroot=rootpath ip=dhcp
mpic: Setting up MPIC " OpenPIC  " version 1.2 at a0040000, max 1 CPUs
mpic: ISU size: 56, shift: 6, mask: 3f
mpic: Initializing for 56 sources
PID hash table entries: 4096 (order: 12, 16384 bytes)
clocksource: timebase mult[79364d9] shift[22] registered
console [ttyCPM0] enabled
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
BUG: Bad page state in process swapper  pfn:2fc69
page:c0d0ed20 flags:(null) count:0 mapcount:-524288 mapping:(null) index:0
Call Trace:
[c02dbef0] [c0007a84] show_stack+0x48/0x174 (unreliable)
[c02dbf20] [c006fa14] bad_page+0x9c/0x160
[c02dbf40] [c0071564] __free_pages_ok+0x2c8/0x3a8
[c02dbf70] [c02a9788] free_all_bootmem_core+0x1a4/0x240
[c02dbfa0] [c02a4544] mem_init+0x64/0x178
[c02dbfc0] [c029a67c] start_kernel+0x1d0/0x2a8
[c02dbff0] [c00003b4] skpinv+0x2dc/0x318
BUG: Bad page state in process swapper  pfn:2fc8f
page:c0d0f1e0 flags:(null) count:0 mapcount:7799008 mapping:(null) index:0
Call Trace:
[c02dbef0] [c0007a84] show_stack+0x48/0x174 (unreliable)
[c02dbf20] [c006fa14] bad_page+0x9c/0x160
[c02dbf40] [c0071564] __free_pages_ok+0x2c8/0x3a8
[c02dbf70] [c02a9788] free_all_bootmem_core+0x1a4/0x240
[c02dbfa0] [c02a4544] mem_init+0x64/0x178
[c02dbfc0] [c029a67c] start_kernel+0x1d0/0x2a8
[c02dbff0] [c00003b4] skpinv+0x2dc/0x318
BUG: Bad page state in process swapper  pfn:2fcc4
page:c0d0f880 flags:(null) count:0 mapcount:7799040 mapping:(null) index:0
Call Trace:
[c02dbef0] [c0007a84] show_stack+0x48/0x174 (unreliable)
[c02dbf20] [c006fa14] bad_page+0x9c/0x160
[c02dbf40] [c0071564] __free_pages_ok+0x2c8/0x3a8
[c02dbf70] [c02a9788] free_all_bootmem_core+0x1a4/0x240
[c02dbfa0] [c02a4544] mem_init+0x64/0x178
[c02dbfc0] [c029a67c] start_kernel+0x1d0/0x2a8
[c02dbff0] [c00003b4] skpinv+0x2dc/0x318
BUG: Bad page state in process swapper  pfn:2fce8
--------------------------------------------------------------------------------------

Can anyone kindly help me in understanding the issue.

with regards,

Deepak Gaur
------- End of Forwarded Message -------


Deepak Gaur
