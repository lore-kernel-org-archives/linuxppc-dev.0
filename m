Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 3789267B28
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Jun 2006 11:03:01 +1000 (EST)
To: "Behre, Frederik - LT" <Behre.Frederik@litef.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: AW: MPC8270 on Microsys PM827 Kernel 2.6 Oops: kernel access of
	bad area, sig: 11 [#1]
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 31 May 2006 09:49:58 +0200."
	<CC692F5386B0AA47A62B7484A7CA2B6D02C4CFCC@frmx1.litef.de>
Date: Thu, 01 Jun 2006 03:02:59 +0200
Sender: wd@denx.de
Message-Id: <20060601010259.35A1C353B06@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <CC692F5386B0AA47A62B7484A7CA2B6D02C4CFCC@frmx1.litef.de> you wrote:
> Thanks for answer me. 
> I want to install Xenomai on this mpc8270. Therefor I need 2.6.14
> ,because I need the adeos patch. 

You should be able to use a more recent kenrel tree as well.

Looking closer at your problem, it seems obvious  where  the  problem
is:

...
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize 
> NFTL driver: nftlcore.c $Revision: 1.97 $, nftlmount.c $Revision: 1.40 $
> Oops: kernel access of bad area, sig: 11 [#1]
> NIP: C0107A14 LR: C0106660 SP: C036FE30 REGS: c036fd80 TRAP: 0300    Not
> tainted
...

That's when the kernel attempts to access the flash devices  on  your
board.

Please use a later kernel. I just verified  that  the  2.6.15  kernel
(git tag DENX-v2.6.15 in our repo) works fine:


Linux version 2.6.15-gref: ref (wd@pollux.denx.de) (gcc version 4.0.0 (DENX ELDK 4.0 4.0.0)) #1 Thu Jun 1 02:55:30 MEST 2006
Microsys PM82x PowerPC port
arch/ppc/syslib/m82xx_pci.c: The PCI bus is 37500000 Mhz.
Waiting 0.5 seconds after deasserting RST...
Built 1 zonelists
Kernel command line: root=/dev/nfs rw nfsroot=192.168.1.1:/opt/eldk-4.0-2006-02-19/ppc_6xx ip=192.168.200.5:192.168.1.1::255.255.0.0:pm827:eth0:off panic=1 console=ttyCPM1,9600
PID hash table entries: 1024 (order: 10, 16384 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 127616k available (1592k kernel code, 412k data, 124k init, 0k highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 0000:00:00.0
PCI: Cannot allocate resource region 1 of device 0000:00:00.0
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Generic RTC Driver v1.07
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xf0011a80 (irq = 4) is a CPM UART
ttyCPM1 at MMIO 0xf0011a90 (irq = 5) is a CPM UART
ttyCPM2 at MMIO 0xf0011a00 (irq = 40) is a CPM UART
ttyCPM3 at MMIO 0xf0011a20 (irq = 41) is a CPM UART
ttyCPM4 at MMIO 0xf0011a40 (irq = 42) is a CPM UART
ttyCPM5 at MMIO 0xf0011a60 (irq = 43) is a CPM UART
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
NFTL driver: nftlcore.c $Revision: 1.98 $, nftlmount.c $Revision: 1.41 $
Found: Intel 28F640C3B
PM82x-0: Found 4 x16 devices at 0x0 in 64-bit bank
PM82x flash bank 0: Using static image partition definition
Creating 4 MTD partitions on "PM82x-0":
0x00000000-0x00040000 : "U-Boot"
0x00040000-0x00100000 : "kernel"
0x00100000-0x00400000 : "ramdisk"
0x00400000-0x02000000 : "user"
No valid DiskOnChip devices found
eth0: FCC ENET Version 0.3, 00:40:42:81:27:0d
mii_reg: 608e78e2
eth0: Phy @ 0x1, type LXT971 (0x001378e2)
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
eth0: config: auto-negotiation on, 100HDX, 10HDX.
IP-Config: Complete:
      device=eth0, addr=192.168.200.5, mask=255.255.0.0, gw=255.255.255.255,
     host=pm827, domain=, nis-domain=(none),
     bootserver=192.168.1.1, rootserver=192.168.1.1, rootpath=
Looking up port of RPC 100003/2 on 192.168.1.1
Looking up port of RPC 100005/1 on 192.168.1.1
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 124k init
...


Also, the current  top-of-tree  version  (Linux-2.6.17-rc5-g1d475c9f)
works fine.

Please use current code.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
We are Microsoft. Unix is irrelevant. Openness is futile.  Prepare to
be assimilated.
