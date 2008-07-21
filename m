Return-Path: <skaliann@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 8FD24DDEE8
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 05:22:56 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so275285ugf.0
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 12:22:54 -0700 (PDT)
Message-ID: <6acbf80c0807211222i3f0076b9oae036e7a1a0465de@mail.gmail.com>
Date: Mon, 21 Jul 2008 12:22:54 -0700
From: "Sureshkumar Kaliannan" <skaliann@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: using -initrd with qemu-system-ppc
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_26447_30995344.1216668174145"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_26447_30995344.1216668174145
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'm struggling to get initrd working with qemu-system-ppc. The kernel
doesn't seem to be find  initrd image passed to qemu-system-ppc.

I added printfs in qemu, ppc_rom and in the kernel source code..Looks like
qemu is passing the intird to Hackware and hackware rom seems to be setting
the bootinfos structure with the initrd information but when it comes to the
kernel it doesn't seem to get it.

qemu logs show..it read the initrd image

ppc_prep_init: START linux boot
ppc_prep_init: INSIDE linux boot: /tmp/initrd.img
ppc_prep_init: INSIDE INITRD
ppc_prep_init: INSIDE INITRD filename: /tmp/initrd.img size: 31457280

hackware logs i added also shows initrd is read from nvram and its put in
the bootinfos and passed.

bootinfos..initrd: 31457280
bootinfos..memsize:0x2f400000
Boot: 00040000 32eb1500 00000000 00000000
Bootinfos at : 300000

But the kernel didn;t find the BI_INITRD tag (0x1014). But it found the
BI_CMDLINE and BI_MEMSIZE tags but not initrd.

Now booting the kernel
RAMDISK platform_init..calling boot_info
RAMDISK find_bootinfo
RAMDISK parser_booinfo
RAMDISK BI tag: 0x1010
RAMDISK BI tag: 0x1017
RAMDISK memsize: 0x2f400000
RAMDISK BI tag: 0x1012
RAMDISK cmdline: console=ttyS0 ip=dhcp rw netdev=9,0x300,eth0
netdev=10,0x320,eth1 netdev=11,0x340,eth2 netdev=3,0x360,eth3
netdev=4,0x280,eth4 netdev=5,0x380,eth5
RAMDISK parser_booinfo end
....
....
IP-Config: Got DHCP answer from 10.0.2.2, my address is 10.0.2.15
IP-Config: Complete:
      device=eth0, addr=10.0.2.15, mask=255.255.255.0, gw=10.0.2.2,
     host=10.0.2.15, domain=, nis-domain=(none),
     bootserver=10.0.2.2, rootserver=10.0.2.2, rootpath=
RAMDISK: no file foundi
No filesystem could mount root, tried:  ext3 ext2 iso9660


I'm stumped..May be the kernel is reading a different bootinfos..I'm not
sure where the problem is. I made sure the CONFIG_BLK_DEV_INITRD is enabled
and the printfs I added are outside of the CONFIG_BLK_DEV_INITRD check.

I'm using the 0.9.1 version and the kernel is 2.6.18

Please help me figure this out..I have attached the complete log.

thanks
Suresh
[skaliann@sjc-lds-256
~]$/ws/skaliann/opt/qemu-0.9.1/ppc-softmmu/qemu-system-ppc
-L /users/skaliann/qemu/share/qemu -M prep -kernel /tmp/zImage.prep
-nographic  -m 756 -redir tcp:1122::22 -redir tcp:2345::2345 -initrd
/tmp/initrd.img  -append root=/dev/ram

ppc_prep_init: START linux boot
ppc_prep_init: INSIDE linux boot: /tmp/initrd.img
ppc_prep_init: INSIDE INITRD
ppc_prep_init: INSIDE INITRD filename: /tmp/initrd.img size: 31457280
ppc_prep_init: OUTSIDE base=0x1800000 Size: 31457280NVRAM set: base:
0x1800000 size: 31457280
register PCI host 'pci-bridge' 'pci' '<null>' 'PREP Host PCI Bridge -
Motorola Raven'
register 'pci-bridge' 'pci' '<null>' 'PREP Host PCI Bridge - Motorola Raven'
0x80000000 in 'device-tree' 0xffffffff
Done 582a000 582a900
register pci device 'Qemu VGA' 0000000c 'display' 'VGA' 'Qemu VGA'
register 'Qemu VGA' 'display' 'VGA' 'Qemu VGA' 0x0000000c in 'pci-bridge'
0x80000000
Done 582a900 582aa00
PPC Open Hack'Ware BIOS for qemu version 0.4.1
Build 2008-07-18 22:17:00
Copyright 2003-2005 Jocelyn Mayer

Memory size: 756 MB.
Booting from device m
ide0: drive 0: none
ide0: drive 1: CD-ROM
ERROR: OF_property_copy cannot get property 'cd' for aliases
ERROR: ATAPI TEST_UNIT_READY : status 48 != 0x08
ide1: drive 0: none
ide1: drive 1: none
Probe partitions for device m
ERROR: No MSDOS signature (38 0 0 0)
New bootfile
ERROR: OF_property_copy cannot get property 'alias' for <null>
boot device: 5831080 image 1000000 size 1436466
New bootfile
New bootfile
Fix bootfile
boot device: 5831080
ERROR: Found boot partition : 5831200 582d6c0
ERROR: Not a MACH-O file
ERROR: Not an Apple CHRP boot file !
dest 100000 entry 00000200 => 100200
Load raw file into memory at 100000 1436466 (0015eb32) 0 (00000000)
bootinfos..initrd: 31457280
bootinfos..memsize:0x2f400000
Boot: 00040000 32eb1500 00000000 00000000
Bootinfos at : 300000

Now boot it... (0)

stack: 5bfff80 malloc_base: 0 0x05800000 0x06000000
PREP boot... 100200 100000
loaded at:     00100200 00265D4C
relocated to:  00800000 00965B4C
zimage at:     00805F64 0095CC98
avail ram:     00400000 00800000

Linux/PPC load: decompress_kernel:  new cmd_line='console=ttyS0 ip=dhcp rw
netdev=9,0x300,eth0 netdev=10,0x320,eth1 netdev=11,0x340,eth2
netdev=3,0x360,eth3 netdev=4,0x280,eth4 netdev=5,0x380,eth5 root=/dev/ram'
console=ttyS0 ip=dhcp rw netdev=9,0x300,eth0 netdev=10,0x320,eth1
netdev=11,0x340,eth2 netdev=3,0x360,eth3 netdev=4,0x280,eth4
netdev=5,0x380,eth5 root=/dev/ram
Uncompressing Linux...done.
Now booting the kernel
RAMDISK platform_init..calling boot_info
RAMDISK find_bootinfo
RAMDISK parser_booinfo
RAMDISK BI tag: 0x1010
RAMDISK BI tag: 0x1017
RAMDISK memsize: 0x2f400000
RAMDISK BI tag: 0x1012
RAMDISK cmdline: console=ttyS0 ip=dhcp rw netdev=9,0x300,eth0
netdev=10,0x320,eth1 netdev=11,0x340,eth2 netdev=3,0x360,eth3
netdev=4,0x280,eth4 netdev=5,0x380,eth5 root=/dev/ram
RAMDISK parser_booinfo end
Total memory = 756MB; using 2048kB for hash table (at c0400000)
Linux version 2.6.18.8 (skaliann@sjc-lds-256) (gcc version 3.4.2) #25 Fri
Jul 18 15:47:56 PDT 2008PReP architecture
Built 1 zonelists.  Total pages: 193536
Kernel command line: console=ttyS0 ip=dhcp rw netdev=9,0x300,eth0
netdev=10,0x320,eth1 netdev=11,0x340,eth2 netdev=3,0x360,eth3
netdev=4,0x280,eth4 netdev=5,0x380,eth5 root=/dev/ram
PID hash table entries: 4096 (order: 12, 16384 bytes)
time_init: decrementer frequency = 25.000000 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 761600k available (2260k kernel code, 776k data, 156k init, 0k
highmem)
Mount-cache hash table entries: 512
lsmpi_region_init(): 11 pages (6508544 bytes)
NET: Registered protocol family 16
PCI: Probing PCI hardware
Setting PCI interrupts for a "Mesquite cPCI (MCP750)"
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler deadline registered (default)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16450
RAMDISK: wrong blocksize 16384, reverting to defaults
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x300: 52 54 00 12 34 56
eth0: NE2000 found at 0x300, using IRQ 9.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: IRQ probe failed (0x0)
hda: IRQ probe failed (0x0)
hda: IRQ probe failed (0x0)
hda: IRQ probe failed (0x0)
hdb: IRQ probe failed (0x0)
hdb: IRQ probe failed (0x0)
hdb: QEMU CD-ROM, ATAPI CD/DVD-ROM drive
hdb: IRQ probe failed (0x0)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 13
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
input: AT Raw Set 2 keyboard as /class/input/input0
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 10.0.2.2, my address is 10.0.2.15
IP-Config: Complete:
      device=eth0, addr=10.0.2.15, mask=255.255.255.0, gw=10.0.2.2,
     host=10.0.2.15, domain=, nis-domain=(none),
     bootserver=10.0.2.2, rootserver=10.0.2.2, rootpath=
RAMDISK: no file foundi
No filesystem could mount root, tried:  ext3 ext2 iso9660
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(1,0)
 <0>Rebooting in 180 seconds..

------=_Part_26447_30995344.1216668174145
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi,<br><br>I&#39;m struggling to get initrd working with qemu-system-ppc.
The kernel doesn&#39;t seem to be find&nbsp; initrd image passed to
qemu-system-ppc. <br><br>I added printfs in qemu, ppc_rom and in the
kernel source code..Looks like qemu is passing the intird to Hackware
and hackware rom seems to be setting the bootinfos structure with the initrd
information but when it comes to the kernel it doesn&#39;t seem to get it.<br>
<br>qemu logs show..it read the initrd image<br><br>
ppc_prep_init: START linux boot<br>
ppc_prep_init: INSIDE linux boot: /tmp/initrd.img<br>
ppc_prep_init: INSIDE INITRD<br>
ppc_prep_init: INSIDE INITRD filename: /tmp/initrd.img size: 31457280<br><br>hackware logs i added also shows initrd is read from nvram and its put in the bootinfos and passed.<br><br>bootinfos..initrd: 31457280<br>
bootinfos..memsize:0x2f400000<br>
Boot: 00040000 32eb1500 00000000 00000000<br>
Bootinfos at : 300000<br><br>But the kernel didn;t find the BI_INITRD tag (0x1014). But it found the BI_CMDLINE and BI_MEMSIZE tags but not initrd. <br><br>Now booting the kernel<br>
RAMDISK platform_init..calling boot_info<br>
RAMDISK find_bootinfo<br>
RAMDISK parser_booinfo<br>
RAMDISK BI tag: 0x1010<br>
RAMDISK BI tag: 0x1017<br>
RAMDISK memsize: 0x2f400000<br>
RAMDISK BI tag: 0x1012<br>
RAMDISK cmdline: console=ttyS0 ip=dhcp rw netdev=9,0x300,eth0
netdev=10,0x320,eth1 netdev=11,0x340,eth2 netdev=3,0x360,eth3
netdev=4,0x280,eth4 netdev=5,0x380,eth5<br>
RAMDISK parser_booinfo end<br>....<br>....<br>IP-Config: Got DHCP answer from <a href="http://10.0.2.2/" target="_blank">10.0.2.2</a>, my address is <a href="http://10.0.2.15/" target="_blank">10.0.2.15</a><br>
IP-Config: Complete:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=eth0, addr=<a href="http://10.0.2.15/" target="_blank">10.0.2.15</a>, mask=<a href="http://255.255.255.0/" target="_blank">255.255.255.0</a>, gw=<a href="http://10.0.2.2/" target="_blank">10.0.2.2</a>,<br>
&nbsp;&nbsp;&nbsp;&nbsp; host=<a href="http://10.0.2.15/" target="_blank">10.0.2.15</a>, domain=, nis-domain=(none),<br>
&nbsp;&nbsp;&nbsp;&nbsp; bootserver=<a href="http://10.0.2.2/" target="_blank">10.0.2.2</a>, rootserver=<a href="http://10.0.2.2/" target="_blank">10.0.2.2</a>, rootpath=<br>
RAMDISK: no file foundi<br>
No filesystem could mount root, tried:&nbsp; ext3 ext2 iso9660<br><br><br>I&#39;m
stumped..May be the kernel is reading a different bootinfos..I&#39;m not
sure where the problem is. I made sure the CONFIG_BLK_DEV_INITRD is
enabled and the printfs I added are outside of the
CONFIG_BLK_DEV_INITRD check.<br>
<br>I&#39;m using the 0.9.1 version and the kernel is 2.6.18<br><br>Please help me figure this out..I have attached the complete log.<br><br>thanks<br>Suresh<br>[skaliann@sjc-lds-256 ~]$/ws/skaliann/opt/qemu-0.9.<div dir="ltr">
1/ppc-softmmu/qemu-system-ppc -L /users/skaliann/qemu/share/qemu
-M prep -kernel /tmp/zImage.prep -nographic&nbsp; -m 756 -redir tcp:1122::22
-redir tcp:2345::2345 -initrd /tmp/initrd.img&nbsp; -append root=/dev/ram<br>
<br>ppc_prep_init: START linux boot<br>ppc_prep_init: INSIDE linux boot: /tmp/initrd.img<br>ppc_prep_init: INSIDE INITRD<br>ppc_prep_init: INSIDE INITRD filename: /tmp/initrd.img size: 31457280<br>ppc_prep_init: OUTSIDE base=0x1800000 Size: 31457280NVRAM set: base: 0x1800000 size: 31457280<br>

register PCI host &#39;pci-bridge&#39; &#39;pci&#39; &#39;&lt;null&gt;&#39; &#39;PREP Host PCI Bridge - Motorola Raven&#39;<br>register &#39;pci-bridge&#39; &#39;pci&#39; &#39;&lt;null&gt;&#39; &#39;PREP Host PCI Bridge - Motorola Raven&#39; 0x80000000 in &#39;device-tree&#39; 0xffffffff<br>

Done 582a000 582a900<br>register pci device &#39;Qemu VGA&#39; 0000000c &#39;display&#39; &#39;VGA&#39; &#39;Qemu VGA&#39;<br>register &#39;Qemu VGA&#39; &#39;display&#39; &#39;VGA&#39; &#39;Qemu VGA&#39; 0x0000000c in &#39;pci-bridge&#39; 0x80000000<br>

Done 582a900 582aa00<br>PPC Open Hack&#39;Ware BIOS for qemu version 0.4.1<br>Build 2008-07-18 22:17:00<br>Copyright 2003-2005 Jocelyn Mayer<br><br>Memory size: 756 MB.<br>Booting from device m<br>ide0: drive 0: none<br>
ide0: drive 1: CD-ROM<br>
ERROR: OF_property_copy cannot get property &#39;cd&#39; for aliases<br>ERROR: ATAPI TEST_UNIT_READY : status 48 != 0x08<br>ide1: drive 0: none<br>ide1: drive 1: none<br>Probe partitions for device m<br>ERROR: No MSDOS signature (38 0 0 0)<br>

New bootfile<br>ERROR: OF_property_copy cannot get property &#39;alias&#39; for &lt;null&gt;<br>boot device: 5831080 image 1000000 size 1436466<br>New bootfile<br>New bootfile<br>Fix bootfile<br>boot device: 5831080<br>ERROR: Found boot partition : 5831200 582d6c0<br>

ERROR: Not a MACH-O file<br>ERROR: Not an Apple CHRP boot file !<br>dest 100000 entry 00000200 =&gt; 100200<br>Load raw file into memory at 100000 1436466 (0015eb32) 0 (00000000)<br>bootinfos..initrd: 31457280<br>bootinfos..memsize:0x2f400000<br>

Boot: 00040000 32eb1500 00000000 00000000<br>Bootinfos at : 300000<br><br>Now boot it... (0)<br><br>stack: 5bfff80 malloc_base: 0 0x05800000 0x06000000<br>PREP boot... 100200 100000<br>loaded at:&nbsp;&nbsp;&nbsp;&nbsp; 00100200 00265D4C<br>

relocated to:&nbsp; 00800000 00965B4C<br>zimage at:&nbsp;&nbsp;&nbsp;&nbsp; 00805F64 0095CC98<br>avail ram:&nbsp;&nbsp;&nbsp;&nbsp; 00400000 00800000<br><br>Linux/PPC
load: decompress_kernel:&nbsp; new cmd_line=&#39;console=ttyS0 ip=dhcp rw
netdev=9,0x300,eth0 netdev=10,0x320,eth1 netdev=11,0x340,eth2
netdev=3,0x360,eth3 netdev=4,0x280,eth4 netdev=5,0x380,eth5
root=/dev/ram&#39;<br>
console=ttyS0 ip=dhcp rw netdev=9,0x300,eth0 netdev=10,0x320,eth1
netdev=11,0x340,eth2 netdev=3,0x360,eth3 netdev=4,0x280,eth4
netdev=5,0x380,eth5 root=/dev/ram<br>Uncompressing Linux...done.<br>Now booting the kernel<br>
RAMDISK platform_init..calling boot_info<br>RAMDISK find_bootinfo<br>RAMDISK parser_booinfo<br>RAMDISK BI tag: 0x1010<br>RAMDISK BI tag: 0x1017<br>RAMDISK memsize: 0x2f400000<br>RAMDISK BI tag: 0x1012<br>RAMDISK
cmdline: console=ttyS0 ip=dhcp rw netdev=9,0x300,eth0
netdev=10,0x320,eth1 netdev=11,0x340,eth2 netdev=3,0x360,eth3
netdev=4,0x280,eth4 netdev=5,0x380,eth5 root=/dev/ram<br>
RAMDISK parser_booinfo end<br>Total memory = 756MB; using 2048kB for hash table (at c0400000)<br>Linux version <a href="http://2.6.18.8/" target="_blank">2.6.18.8</a> (skaliann@sjc-lds-256) (gcc version 3.4.2) #25 Fri Jul 18 15:47:56 PDT 2008PReP architecture<br>

Built 1 zonelists.&nbsp; Total pages: 193536<br>Kernel
command line: console=ttyS0 ip=dhcp rw netdev=9,0x300,eth0
netdev=10,0x320,eth1 netdev=11,0x340,eth2 netdev=3,0x360,eth3
netdev=4,0x280,eth4 netdev=5,0x380,eth5 root=/dev/ram<br>
PID hash table entries: 4096 (order: 12, 16384 bytes)<br>time_init: decrementer frequency = 25.000000 MHz<br>Console: colour dummy device 80x25<br>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)<br>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)<br>

Memory: 761600k available (2260k kernel code, 776k data, 156k init, 0k highmem)<br>Mount-cache hash table entries: 512<br>lsmpi_region_init(): 11 pages (6508544 bytes)<br>NET: Registered protocol family 16<br>PCI: Probing PCI hardware<br>

Setting PCI interrupts for a &quot;Mesquite cPCI (MCP750)&quot;<br>Linux Plug and Play Support v0.97 (c) Adam Belay<br>SCSI subsystem initialized<br>NET: Registered protocol family 2<br>IP route cache hash table entries: 32768 (order: 5, 131072 bytes)<br>

TCP established hash table entries: 131072 (order: 7, 524288 bytes)<br>TCP bind hash table entries: 65536 (order: 6, 262144 bytes)<br>TCP: Hash tables configured (established 131072 bind 65536)<br>TCP reno registered<br>
VFS: Disk quotas dquot_6.5.1<br>
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)<br>Initializing Cryptographic API<br>io scheduler noop registered<br>io scheduler deadline registered (default)<br>isapnp: Scanning for PnP cards...<br>isapnp: No Plug &amp; Play device found<br>

Generic RTC Driver v1.07<br>Macintosh non-volatile memory driver v1.1<br>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled<br>serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16450<br>RAMDISK: wrong blocksize 16384, reverting to defaults<br>

RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize<br>loop: loaded (max 8 devices)<br>ne.c:v1.10 9/23/94 Donald Becker (<a href="mailto:becker@scyld.com" target="_blank">becker@scyld.com</a>)<br>Last modified Nov 1, 2000 by Paul Gortmaker<br>

NE*000 ethercard probe at 0x300: 52 54 00 12 34 56<br>eth0: NE2000 found at 0x300, using IRQ 9.<br>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2<br>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx<br>

hda: IRQ probe failed (0x0)<br>hda: IRQ probe failed (0x0)<br>hda: IRQ probe failed (0x0)<br>hda: IRQ probe failed (0x0)<br>hdb: IRQ probe failed (0x0)<br>hdb: IRQ probe failed (0x0)<br>hdb: QEMU CD-ROM, ATAPI CD/DVD-ROM drive<br>

hdb: IRQ probe failed (0x0)<br>ide0 at 0x1f0-0x1f7,0x3f6 on irq 13<br>serio: i8042 AUX port at 0x60,0x64 irq 12<br>serio: i8042 KBD port at 0x60,0x64 irq 1<br>mice: PS/2 mouse device common for all mice<br>TCP bic registered<br>

NET: Registered protocol family 1<br>NET: Registered protocol family 17<br>NET: Registered protocol family 15<br>input: AT Raw Set 2 keyboard as /class/input/input0<br>input: ImExPS/2 Generic Explorer Mouse as /class/input/input1<br>

Sending DHCP requests ., OK<br>IP-Config: Got DHCP answer from <a href="http://10.0.2.2/" target="_blank">10.0.2.2</a>, my address is <a href="http://10.0.2.15/" target="_blank">10.0.2.15</a><br>IP-Config: Complete:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=eth0, addr=<a href="http://10.0.2.15/" target="_blank">10.0.2.15</a>, mask=<a href="http://255.255.255.0/" target="_blank">255.255.255.0</a>, gw=<a href="http://10.0.2.2/" target="_blank">10.0.2.2</a>,<br>

&nbsp;&nbsp;&nbsp;&nbsp; host=<a href="http://10.0.2.15/" target="_blank">10.0.2.15</a>, domain=, nis-domain=(none),<br>&nbsp;&nbsp;&nbsp;&nbsp; bootserver=<a href="http://10.0.2.2/" target="_blank">10.0.2.2</a>, rootserver=<a href="http://10.0.2.2/" target="_blank">10.0.2.2</a>, rootpath=<br>
RAMDISK: no file foundi<br>
No filesystem could mount root, tried:&nbsp; ext3 ext2 iso9660<br>Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)<br>&nbsp;&lt;0&gt;Rebooting in 180 seconds..</div></div>

------=_Part_26447_30995344.1216668174145--
