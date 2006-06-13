Return-Path: <AZeffertt@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 875AF67B2C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 03:12:53 +1000 (EST)
Received: from exchange.cbl.local (exchange.cambridgebroadband.com
	[217.204.121.87])
	by cambridgebroadband.com (8.12.8/8.12.8) with ESMTP id k5DGmPl5029763
	for <linuxppc-embedded@ozlabs.org>; Tue, 13 Jun 2006 17:48:25 +0100
Message-ID: <448EEC59.2010201@cambridgebroadband.com>
Date: Tue, 13 Jun 2006 17:48:25 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: No ttyS device at I/O port 0xfe004500 for console
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

Hi list,

I'm trying to boot a linux-2.6.11 kernel on a MPC83xx based board.  Through
some experimentation I have found I need "console=uart,io,0xfe004500"
in the kernel command line in order to get any output over the serial
port.

Half way through initialisation the kernel appears to swap from its "early"
8250 serial driver to a "full" 8250 serial driver.  At this point it prints
"No ttyS device at I/O port 0xfe004500 for console" and there is no
further output.

Does anyone have any idea what I may be doing wrong?

BTW, here's the output that I do get.

-------------------/snip--------------------------
U-Boot 1.1.3 (FSL Development) (Jun 13 2006 - 14:01:25) MPC83XX

Clock configuration:
   Coherent System Bus:  132 MHz
   Core:                 264 MHz
   QE:                   198 MHz
   Local Bus Controller: 132 MHz
   Local Bus:             66 MHz
   DDR:                  264 MHz
   SEC:                  132 MHz
   I2C1:                 132 MHz
CPU: MPC8323E, Rev: 10 at 264 MHz
Board: Freescale MPC832XEPB
I2C:   ready
DRAM:
    DDR RAM: 128 MB
FLASH: 16 MB
In:    serial
Out:   serial
Err:   serial
Net:   FSL GETH0
Hit any key to stop autoboot:  0
geth: PHY is Davicom DM9161A (181b8a0)
FSL GETH0: Full Duplex
FSL GETH0: Speed 100BT
FSL GETH0: Link is up
Using FSL GETH0 device
TFTP from server 10.0.0.107; our IP address is 10.0.6.65
Filename 'uImage'.
Load address: 0x200000
Loading: #################################################################
          #################################################################
          #################################################################
          ##########
done
Bytes transferred = 1046491 (ff7db hex)
## Booting image at 00200000 ...
    Image Name:   Linux-2.6.11
    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
    Data Size:    1046427 Bytes = 1021.9 kB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
    Uncompressing Kernel Image ... OK
Linux version 2.6.11 (ajz@zambia) (gcc version 3.4.3) #5 Tue Jun 13 17:36:46 BST 2006
Built 1 zonelists
Kernel command line: root=/dev/nfs rw nfsroot=10.0.0.107:/opt/eldk/ppc_6xx ip=10.0.6.65:10.0.0.107:10.0.0.1:255.255.0.0:eth0:off console=uart,io,0xfe004500
IPIC (128 IRQ sources, 8 External IRQs) at fe000700
QE IC (64 IRQ sources) at fe100080
PID hash table entries: 1024 (order: 10, 16384 bytes)
Early serial console at I/O port 0xfe004500 (options '134')
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 127488k available (1724k kernel code, 432k data, 100k init, 0k highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
NET: Registered protocol family 16
SCSI subsystem initialized
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: loaded (max 8 devices)
MPC832XE MDS flash device: 1000000 at ff000000 Partition number 5
MPC832XE PB Flash Map Info: Found 1 x16 devices at 0x0 in 16-bit bank
  Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
Creating 5 MTD partitions on "MPC832XE PB Flash Map Info":
0x00000000-0x00020000 : "HRCW"
0x00020000-0x00900000 : "JFFS2"
0x00900000-0x00d00000 : "Ramdisk"
0x00d00000-0x00f00000 : "Kernel"
0x00f00000-0x01000000 : "U-Boot"
MPC832XE MDS flash device initialized
i2c /dev entries driver
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
No ttyS device at I/O port 0xfe004500 for console

-------------------/snip--------------------------



TIA,

Alex
