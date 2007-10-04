Return-Path: <alan@akb.net>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.227])
	by ozlabs.org (Postfix) with ESMTP id DA4FFDDE32
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2007 04:46:30 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so252134wxd
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Oct 2007 11:46:29 -0700 (PDT)
Message-ID: <bfa0697f0710041146y2c74b9dcy3dd413934680ab10@mail.gmail.com>
Date: Thu, 4 Oct 2007 12:46:28 -0600
From: "Alan Bennett" <embedded@akb.net>
Sender: alan@akb.net
To: "Scott Wood" <scottwood@freescale.com>
Subject: Console handover: tty0 instead of ttyCPM0?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Do you know what would cause this?

I've configured a board to console off of SMC1 (ttyCPM0) and on 1
board it works fine, however a new revision of the board I get the
following result and lose the console.  Both boards have "exact"
versions of the kernel and u-boot.

   BAD: console handover: boot [udbg0] -> real [tty0]
   GOOD: console handover: boot [udbg0] -> real [ttyCPM0]


IMMRBASE is e0000000

CONFIG_PPC_EARLY_DEBUG_CPM=y
CONFIG_PPC_EARLY_DEBUG_CPM_ADDR=0xe0000888



doesn't WORK:
==========================================
zImage starting: loaded at 0x00400000 (sp: 0x07bc19a0)
Allocating 0x309670 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040c000:0x00710448)...done 0x2f0ad4 bytes

Linux/PowerPC load: root=/dev/nfs ip=192.168.10.45:::255.255.255.0::eth0 nfsroow
Finalizing device tree... flat tree at 0x71e3a0
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
Using Embedded Planet EP8248E machine description
Linux version 2.6.23-rc6-VTM-0007-1763 (root@fremont) (gcc version 3.4.5) #5 Th7
console [udbg0] enabled
setup_arch: bootmem
ep8248_setup_arch()
ep8248_setup_arch(), finish
arch: exit
Zone PFN ranges:
  DMA             0 ->    32768
  Normal      32768 ->    32768
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->    32768
Built 1 zonelists in Zone order.  Total pages: 32512
Kernel command line: root=/dev/nfs ip=192.168.10.45:::255.255.255.0::eth0 nfsrow
PID hash table entries: 512 (order: 9, 2048 bytes)
Console: colour dummy device 80x25
console handover: boot [udbg0] -> real [tty0]


BOARD THAT WORKS:
==========================================
zImage starting: loaded at 0x00400000 (sp: 0x07bc19a0)
Allocating 0x309670 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040c000:0x00710448)...done 0x2f0ad4 bytes

Linux/PowerPC load: console=ttyCPM0,38400n8 root=/dev/nfs ip=192.168.10.49:::25
Finalizing device tree... flat tree at 0x71e3a0
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
Using Embedded Planet EP8248E machine description
Linux version 2.6.23-rc6-VTM-0007-1763 (root@fremont) (gcc version 3.4.5) #5 Th7
console [udbg0] enabled
setup_arch: bootmem
ep8248_setup_arch()
ep8248_setup_arch(), finish
arch: exit
Zone PFN ranges:
  DMA             0 ->    32768
  Normal      32768 ->    32768
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->    32768
Built 1 zonelists in Zone order.  Total pages: 32512
Kernel command line: console=ttyCPM0,38400n8 root=/dev/nfs ip=192.168.10.49:::2
PID hash table entries: 512 (order: 9, 2048 bytes)
Console: colour dummy device 80x25Dentry cache hash table entries: 16384 (order)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 126660k/131072k available (2852k kernel code, 4264k reserved, 132k data)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
Generic PHY: Registered new driver
