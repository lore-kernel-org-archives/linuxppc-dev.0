Return-Path: <Christopher.Varlese@keymile.com>
Received: from mail.ch.keymile.com (mail.ch.keymile.com [193.17.201.103])
	by ozlabs.org (Postfix) with SMTP id 19A4EDDE04
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Nov 2008 22:59:37 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Help: NOR flash MTD and JFFS2 rootfs
Date: Wed, 19 Nov 2008 12:48:53 +0100
Message-ID: <D839955AA28B9A42A61B9181506E27C4013A03DC@SRVCHBER1212.ch.keymile.net>
From: "Varlese, Christopher" <Christopher.Varlese@keymile.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm having some trouble booting from a JFFS2 disk partition.
I have a few questions maybe someone can help.


Q1: mtdparts=3Dx not necessary?
U-Boot supports configuring and passing mtdparts=3Dx in the kernel
command line.  But with powerpc the partitions can be defined in
the device tree and the kernel can parse this to discover the MTD
partitions.  So is it right then I don't need to use mtdparts?
ref: drivers/mtd/ofpart.c:of_mtd_parse_partitions()


Q2: /proc/partitions empty?
After (NFS) boot startup I have entries in /proc/mtd but
/proc/partitions is empty (see below).   Is this a problem?
Any ideas what is causing that?

-bash-3.2# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00040000 00020000 "u-boot"
mtd1: 00040000 00020000 "env"
mtd2: 00020000 00020000 "dtb"
mtd3: 00300000 00020000 "kernel"
mtd4: 00800000 00020000 "ramdisk"
mtd5: 01460000 00020000 "user"
-bash-3.2# cat /proc/partitions
major minor  #blocks  name

-bash-3.2#


Q3: JFFS2 booting fails?
I have a JFFS2 root fs disk image burned to a flash mtd partition.
I can manually mount it with NFS/ram boot scenarios, but so far
cannot boot directly from it as rootfs (infos below).   Any
good suggestions what might be wrong?

Manually mounting fine:
-bash-3.2# mount -t jffs2 /dev/mtdblock5 /mnt
-bash-3.2# ls /mnt
bin  cfg  dev  etc  lib  linuxrc  proc  root  sbin  sys  tmp  usr  var

Booting from same not working:
=3D> printenv mtdargs
mtdargs=3Dsetenv bootargs root=3D/dev/mtdblock5 rw rootfstype=3Djffs2
=3D> printenv boot_flash
boot_flash=3Drun mtdargs addip addtty ; bootm $kernel_addr - $fdt_addr
=3D> run boot_flash
...
Kernel command line: root=3D/dev/mtdblock5 rw rootfstype=3Djffs2
ip=3D192.168.33.38:192.168.33.35:192.168.33.35::eter1:eth0:off panic=3D1
con0
IPIC (128 IRQ sources) at fdefc700
PID hash table entries: 1024 (order: 10, 4096 bytes)
clocksource: timebase mult[3c9b26d] shift[22] registered
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256640k/262144k available (2740k kernel code, 5236k reserved,
100k data, 98k bss, 144k init)
SLUB: Genslabs=3D12, HWalign=3D32, Order=3D0-3, MinObjects=3D0, =
CPUs=3D1, Nodes=3D1
Mount-cache hash table entries: 512
net_namespace: 480 bytes
NET: Registered protocol family 16
            =20
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
JFFS2 version 2.2. (NAND) .. 2001-2006 Red Hat, Inc.
msgmni has been set to 501
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq =3D 16) is a 16550A
                                                             console
handover: boot [udbg0] -> real [ttyS0]
brd: module loaded
loop: module loaded
UCC Ethernet Controller MII Bus: probed
ucc_geth: QE UCC Gigabit Ethernet Controller
ucc_geth: UCC4 at 0xe0103200 (irq =3D 35)=20
PPP generic driver version 2.4.2
NET: Registered protocol family 24
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
f0000000.flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
Using auto-unlock on power-up/resume
cfi_cmdset_0001: Erase suspend on write enabled
RedBoot partition parsing not available
Creating 6 MTD partitions on "f0000000.flash":
0x00000000-0x00040000 : "u-boot"
mtd: Giving out device 0 to u-boot
0x00040000-0x00080000 : "env"
mtd: Giving out device 1 to env
0x00080000-0x000a0000 : "dtb"
mtd: Giving out device 2 to dtb
0x000a0000-0x003a0000 : "kernel"
mtd: Giving out device 3 to kernel
0x003a0000-0x00ba0000 : "ramdisk"
mtd: Giving out device 4 to ramdisk
0x00ba0000-0x02000000 : "user"
mtd: Giving out device 5 to user
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
     device=3Deth0, addr=3D192.168.33.38, mask=3D255.255.255.0,
gw=3D192.168.33.35,
     host=3Deter1, domain=3D, nis-domain=3D(none),
     bootserver=3D192.168.33.35, rootserver=3D192.168.33.35, rootpath=3D
Looking up port of RPC 100003/2 on 192.168.33.35
PHY: e0103320:00 - Link is Up - 100/Full
Looking up port of RPC 100005/1 on 192.168.33.35
Root-NFS: Server returned error -13 while mounting /tftpboot/eter1
VFS: Unable to mount root fs via NFS, trying floppy.
MTDSB: dev_name "/dev/root"
MTDSB: path_lookup() returned 0, inode cf400be0
List of all partitions:
No filesystem could mount root, tried:  jffs2
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)


The empty "List of all partitions" looks suspect.  Is this related
to empty /proc/partitions or mtdparts?


Best regards
Christopher Varlese
R&D Software
________________________________________=20
KEYMILE AG
Schwarzenburgstrasse 73
3097 Bern, Switzerland
www.keymile.com=20
