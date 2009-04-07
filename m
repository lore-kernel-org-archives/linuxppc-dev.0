Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 3E775DDFDE
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 01:02:05 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LrCoM-0003wy-LQ
	for linuxppc-dev@ozlabs.org; Tue, 07 Apr 2009 08:02:02 -0700
Message-ID: <22931181.post@talk.nabble.com>
Date: Tue, 7 Apr 2009 08:02:02 -0700 (PDT)
From: "Sauce.Cheng" <chmhou@sina.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: issue at the beginning of kernel booting
In-Reply-To: <20090402161209.GA19088@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <20090327083628.4C3E93EE530@mail2-203.sinamail.sina.com.cn>
	<20090327161522.GA7809@ld0162-tx32.am.freescale.net>
	<22840131.post@talk.nabble.com>
	<20090402161209.GA19088@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


evolution! kernel 2.6.11 has run on the board with u-boot 1.1.4, also, at
early booting time LEDs are disabled due to MMU on and off. so i tried to
turn LEDs on after start_kernel function, wow, blinking! that is before
start_kernel will be done successfully. then i modified registers mapping in
immap_cpm2.h and configure smc1 as serial. console worked normally.
booting info as following
U-Boot 1.1.4 (Apr  2 2009 - 20:05:19)

MPC8272 Reset Status: External Soft, External Hard

MPC8272 Clock Configuration
 - Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq  25-75 , Core Freq 100-300
 - dfbrg 1, corecnf 0x1a, busdf 3, cpmdf 1, plldf 0, pllmf 3
 - vco_out  400000000, scc_clk  100000000, brg_clk   25000000
 - cpu_clk  400000000, cpm_clk  200000000, bus_clk  100000000

Board: Motorola MPC8272ADS
DRAM:  32 MB
FLASH: 512 kB
In:    serial
Out:   serial
Err:   serial
Net:   FCC1 ETHERNET
Hit any key to stop autoboot:  0 
Using FCC1 ETHERNET device
TFTP from server 192.168.0.99; our IP address is 192.168.0.100
Filename 'uImage'.
Load address: 0x400000
Loading: #################################################################
	 #################################################################
	 #######################
done
Bytes transferred = 781091 (beb23 hex)
=> bootm

## Booting image at 00400000 ...
   Image Name:   Linux-2.6.11
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    781027 Bytes = 762.7 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
OK
Linux version 2.6.11 (root@localhost.localdomain) (gcc version 4.0.0 (DENX
ELDK 4.0 4.0.0)) #49 Tue Apr 7 04:11:56 EDT 2009

Motorola PQ2 ADS PowerPC port

Built 1 zonelists

Kernel command line: mem=32M console=ttyCPM0,9600 root=/dev/mtdblock0 rw
rootfstype=jffs2

PID hash table entries: 256 (order: 8, 4096 bytes)

Warning: real time clock seems stuck!

Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)

Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)

Memory: 30728k available (1304k kernel code, 276k data, 104k init, 0k
highmem)

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)

Chengmo : Here will enter rest_init()!

NET: Registered protocol family 16

PCI: Probing PCI hardware

Generic RTC Driver v1.07

Serial: CPM driver $Revision: 0.01 $

ttyCPM0 at MMIO 0xf0011a80 (irq = 4) is a CPM UART

io scheduler noop registered

io scheduler anticipatory registered

io scheduler deadline registered

io scheduler cfq registered

RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize

loop: loaded (max 8 devices)

halt here~
i have tried to build newer kernel and bootloader. but LEDs were not
blinking at start_kernel, i guessed something wrong with dts, i should check
OF doc and dts. 
-- 
View this message in context: http://www.nabble.com/issue-at-the-beginning-of-kernel-booting-tp22741532p22931181.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
