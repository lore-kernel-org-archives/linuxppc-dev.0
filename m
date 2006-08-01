Return-Path: <kl@jasmine.eu.org>
Received: from riddly.domek.prywatny (arz222.internetdsl.tpnet.pl
	[83.17.211.222]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE22167B61
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Aug 2006 07:09:09 +1000 (EST)
Date: Tue, 1 Aug 2006 22:40:11 +0200
From: Karol Lewandowski <kl@jasmine.eu.org>
To: Eugene Surovegin <ebs@ebshome.net>
Subject: [BUG] ibm_emac: kernel panic with CONFIG_SLOB=y
Message-ID: <20060801204011.GB1754@riddly.domek.prywatny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi,

I'm getting reproductible kernel panic when I use smaller SLOB
allocator (instead of SLAB).  This is reproductible but very randomly
-- sometimes it happens during bootup, sometimes few minutes later.

Hardware is custom board with IBM405EP (very close to Bubingna, just
no RTC):

# cat /proc/cpuinfo
processor	: 0
cpu		: 405EP
clock		: 200MHz
revision	: 9.80 (pvr 5121 0950)
bogomips	: 199.47
machine		: MagicBox
plb bus clock	: 100MHz
pci bus clock	: 25MHz

Enabling SLAB instead of SLOB fixes this, so I assume this is driver
issue.

Full dmesg attached:

Linux version 2.6.17-magicbox2 (builder@riddly) (gcc version 3.4.5) #2 Tue Aug 1 20:58:00 CEST 2006
MagicBox port (C) 2005 Karol Lewandowski <kl@jasmine.eu.org>
Built 1 zonelists
Kernel command line: console=ttyS0,115200 root=/dev/ram rw
PID hash table entries: 256 (order: 8, 1024 bytes)
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 28272k available (1544k kernel code, 508k data, 100k init, 0k highmem)
Mount-cache hash table entries: 512
checking if image is initramfs...it isn't (bad gzip magic numbers); looks like an initrd
Freeing initrd memory: 2020k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
NET: Registered protocol family 
IP route cache hash table entries: 256 (order: -2, 1024 bytes)
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 1024 bind 512)
TCP reno registered
squashfs: version 3.0 (2006/03/15) Phillip Lougher
Initializing Cryptographic API
io scheduler noop registered (default)
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec (nowayout= 0)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
serial8250: ttyS1 at MMIO 0x0 (irq = 1) is a 16550A
RAMDISK driver initialized: 4 RAM disks of 8192K size 1024 blocksize
PPC 4xx OCP EMAC driver, version 3.54
mal0: initialized, 4 TX channels, 2 RX channels
eth0: emac0, MAC 00:50:c2:1e:af:fe
eth0: found Generic MII PHY (0x00)
emac1: reset timeout
emac1: can't find PHY!
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Magically mapped flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
Magically mapped flash: Swapping erase regions for broken CFI table.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Creating 4 MTD partitions on "Magically mapped flash":
0x00000000-0x000e0000 : "kernel"
0x000e0000-0x003a0000 : "ramdisk"
0x003a0000-0x003c0000 : "persistent"
0x003c0000-0x00400000 : "bootloader"
i2c /dev entries driver
IBM IIC driver v2.1
ibm-iic0: using standard (100 kHz) mode
u32 classifier
    Actions configured 
GRE over IPv4 tunneling driver
ip_conntrack version 2.4 (256 buckets, 2048 max) - 236 bytes per conntrack
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Bridge firewalling registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
RAMDISK: squashfs filesystem found at block 0
RAMDISK: Loading 2017KiB [1 disk] into ram disk...
VFS: Mounted root (squashfs filesystem) readonly.
Freeing unused kernel memory: 100k init
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C000BEF8 LR: C00D247C CTR: 00000006
REGS: c1993d80 TRAP: 0300   Not tainted  (2.6.17-magicbox2)
MSR: 00029030 <EE,ME,IR,DR>  CR: 44000024  XER: 20000000
DAR: FFFFFFFE, DSISR: 00000000
TASK = c01ef000[331] 'echo' THREAD: c1992000
GPR00: 00000006 C1993E30 C01EF000 C19D1828 FFFFFFFA 00000026 C19D1824 C19D1866 
GPR08: 00000000 C19D182A 00000001 00000000 42000028 70000000 00000001 10080000 
GPR16: 00000000 30014C34 00000000 30000000 00000000 00000000 00000020 00000000 
GPR24: C1C7D8A4 00000001 0000003C 0000003E 00000008 C19D1770 C1951680 C1C7D800 
NIP [C000BEF8] cacheable_memcpy+0x64/0x108
LR [C00D247C] emac_poll_rx+0x150/0x6e8
Call Trace:
[C1993E30] [C00D244C] emac_poll_rx+0x120/0x6e8 (unreliable)
[C1993E80] [C00D0508] mal_poll+0x90/0x284
[C1993EB0] [C00F9CB0] net_rx_action+0xb4/0x1b0
[C1993EE0] [C001D0C4] __do_softirq+0x64/0xe0
[C1993F00] [C0007AC0] do_softirq+0x50/0x74
[C1993F10] [C001D1E0] irq_exit+0x38/0x48
[C1993F20] [C0007A5C] do_IRQ+0x64/0x78
[C1993F40] [C0003478] ret_from_except+0x0/0x18
Instruction dump:
70080003 7ca02850 7d0903a6 41a20018 89240004 99260004 38840001 38c60001 
4200fff0 5400f0bf 7c0903a6 41820010 <85240004> 95260004 4200fff8 54a0d97f 
Kernel panic - not syncing: Aiee, killing interrupt handler!
 <0>Rebooting in 180 seconds..

thanks
-- 
This signature intentionally says nothing.
