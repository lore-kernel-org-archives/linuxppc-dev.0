Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id A8EEDDDE03
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 00:28:51 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Booting the board using NFS on AMCC PPC 405EP
Date: Fri, 28 Mar 2008 14:28:40 +0100
References: <413023.21903.qm@web15205.mail.cnb.yahoo.com>
In-Reply-To: <413023.21903.qm@web15205.mail.cnb.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803281428.40461.sr@denx.de>
Cc: zechao wang <wzc0066@yahoo.com.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 28 March 2008, zechao wang wrote:
> I'm failed when booting the board using NFS on AMCC PPC 405EP.
> I think i have read the getting started guide carefully!
> The tftp server and nfs server can works well.
> And the firewall was disabled, too.

<snip>

> U-Boot 1.2.0 (Jan 26 2008 - 18:50:29)
>
> CPU:   AMCC PowerPC 405EP Rev. B at 266.666 MHz (PLB=133, OPB=66, EBC=66
> MHz) I2C boot EEPROM disabled
>        Internal PCI arbiter enabled
>        16 kB I-Cache 16 kB D-Cache
> Board: Bubinga - AMCC PPC405EP Evaluation Board

Is this really an IBM/AMCC Bubinga board?

> I2C:   ready
> DRAM:  64 MB
> FLASH: 512 kB
> NAND:  64 MiB
> In:    serial
> Out:   serial
> Err:   serial
> Net:   VT6122

You are using not the SoC EMAC here. Why not? Is this Via chip connected to 
the PCI bus?

> You are welcom!
>
> Hit any key to stop autoboot:  0
> Link autonegation speed 100M bps full duplex
> Using VT6122 device
> TFTP from server 192.168.1.142; our IP address is 192.168.1.120
> Filename 'uImage'.
> Load address: 0x200000
> Loading: #################################################################
>          #################################################################
>          #################################################################
>          ##################
> done
> Bytes transferred = 1086219 (10930b hex)
> Checking ...
> Check1. Check2. ## Booting image at 00200000 ...
>    Image Name:   Linux-2.6.19.2
>    Created:      2008-03-25  11:15:51 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1086155 Bytes =  1 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> Linux version 2.6.19.2 (zwang@wzc) (gcc version 4.0.0 (DENX ELDK 4.1
> 4.0.0)) #6 Tue Mar 25 19:15:48 CST 2008 IBM Bubinga port (MontaVista
> Software, Inc. <source@mvista.com>)
> Zone PFN ranges:
>   DMA             0 ->    16384
>   Normal      16384 ->    16384
> early_node_map[1] active PFN ranges
>     0:        0 ->    16384
> Built 1 zonelists.  Total pages: 16256
> Kernel command line: root=/dev/nfs rw
> nfsroot=192.168.1.142:/opt/eldk/ppc_4xx
> ip=192.168.1.120:192.168.1.142:192.168.1.1::IOStation:eth0:off p0PID hash
> table entries: 256 (order: 8, 1024 bytes) Warning: real time clock seems
> stuck!
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 62592k available (1764k kernel code, 428k data, 132k init, 0k
> highmem) Mount-cache hash table entries: 512
> NET: Registered protocol family 16
> PCI: Probing PCI hardware
> NET: Registered protocol family 2
> IP route cache hash table entries: 512 (order: -1, 2048 bytes)
> TCP established hash table entries: 2048 (order: 1, 8192 bytes)
> TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
> TCP: Hash tables configured (established 2048 bind 1024)
> TCP reno registered
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> Generic RTC Driver v1.07
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> serial8250: ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
> serial8250: ttyS1 at MMIO 0x0 (irq = 1) is a 16550A
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> VIA Networking Velocity Family Gigabit Ethernet Adapter Driver Ver. 1.14
> Copyright (c) 2002, 2003 VIA Networking Technologies, Inc.
> Copyright (c) 2004 Red Hat Inc.
> eth0: VIA Networking Velocity Family Gigabit Ethernet Adapter
> eth0: Ethernet Address: 00:01:02:03:04:87

Again, not the SoC EMAC here.

> Found: AMD AM29LV040B
> PPC40x-flash: Found 1 x8 devices at 0x0 in 8-bit bank
> number of JEDEC chips: 1
> cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
> Creating 3 MTD partitions on "PPC40x-flash":
> 0x00000000-0x00020000 : "reserved"
> 0x00020000-0x00040000 : "env"
> 0x00040000-0x00080000 : "u-boot"
> TCP cubic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> Velocity is AUTO mode
> IP-Config: Guessing netmask 255.255.255.0
> IP-Config: Complete:
>       device=eth0, addr=192.168.1.120, mask=255.255.255.0, gw=192..168.1.1,
>      host=IOStation, domain=, nis-domain=(none),
>      bootserver=192.168.1.142, rootserver=192.168.1.142, rootpath=
> Looking up port of RPC 100003/2 on 192.168.1.142
> eth0: Link autonegation speed 100M bps full duplex
> TD structure errror TDindex=0

This seems to be an error message from the network driver. I don't know this 
Via driver, so can't help here. But this seems to be the problem.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
