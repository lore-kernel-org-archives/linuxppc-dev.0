Return-Path: <nadav.sharabi@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by ozlabs.org (Postfix) with ESMTP id 77EFDDDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Jul 2008 00:21:47 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so4453661wfg.15
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 Jul 2008 07:21:46 -0700 (PDT)
Message-ID: <45f00deb0807130721l66c6b496h1e2a239535bf6805@mail.gmail.com>
Date: Sun, 13 Jul 2008 17:21:45 +0300
From: "Nadav Sharabi" <nadav.sharabi@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: EXT2-fs error when trying to work with highmem
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_27146_11013974.1215958905731"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_27146_11013974.1215958905731
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

I have built a 2.6.14 image and Ramdisk for my board witch has a ppc 8349
processor with 1G DDR. The system works file if I build it without highmem
support but if I try to add highmem support to the system, witch I need in
order to expand my memory to 2G, I get the following error:

EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #2:
directory entry across blocks - offset=0, inode=2147614725, rec_len=1152,
name_len=8

This is my console output:

==== Booting kernel ====
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.14.7-saline
   Image Type:   PowerPC Linux Kernel Image (grip compressed)
   Data Size:    1658344 Bytes =  1.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAM Disk Image at 01000000 ...
   Image Name:   Corrigent_ignited_fess
   Image Type:   PowerPC Linux RAM Disk Image (grip compressed)
   Data Size:    13721548 Bytes = 13.1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 0b2ea000, end 0bffffcc ... OK
Linux version 2.6.14.7-saline (nadavs@nadavs_l.corrigent.com) (gcc version
3.4.4 (Wind River Linux)) #50 PREEMPT Sun Jul 13 11:04:30 IDT 2008
Built 1 zonelists
Kernel command line: root=/dev/ram0 rw ramdisk_size=300000 mem=1008M
ip=192.168.10.50:192.168.10.1:192.168.10.1:255.255.255.0:SBC8349:eth0:off
console=ttyS1,115200,115200 debug_flag=no msm_standalone=no oper_mode=normal
bootdir=msm_images vlan= sd=
LTT : ltt-base init
IPIC (128 IRQ sources, 8 External IRQs) at fe000700
PID hash table entries: 4096 (order: 12, 65536 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1005368k available (2612k kernel code, 960k data, 124k init, 114688k
highmem)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
checking if image is initramfs...softlockup thread 0 started up.
it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 13399k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 0000:00:00.0
PCI: Cannot allocate resource region 2 of device 0000:00:00.0
PCI: Failed to allocate mem resource #2:80000000@0 for 0000:00:00.0
Generic PHY: Registered new driver
LTT : ltt-facilities init
LTT : ltt-core init as module
Registering GDB sysrq handler
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
LTT : ltt-facility-core init in kernel
LTT : ltt-facility-fs init in kernel
LTT : ltt-facility-ipc init in kernel
LTT : ltt-facility-kernel_arch init in kernel
LTT : ltt-facility-kernel init in kernel
LTT : ltt-facility-memory init in kernel
LTT : ltt-facility-network init in kernel
LTT : ltt-facility-process init in kernel
LTT : ltt-facility-socket init in kernel
LTT : ltt-facility-timer init in kernel
LTT : ltt-facility-statedump init in kernel
Software Watchdog Timer: 0.07 initialized. soft_noboot=1 soft_margin=10 sec
(nowayout= 1)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at MMIO map 0xe0004500 mem 0xfe004500 (irq = 9) is a 16550A
ttyS1 at MMIO map 0xe0004600 mem 0xfe004600 (irq = 10) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 1 RAM disks of 300000K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
eth0: Gianfar Ethernet Controller Version 1.1, 40:08:db:00:00:01
eth0: Running with NAPI disabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.1, 40:08:db:00:10:00
eth1: Running with NAPI disabled
eth1: 256/256 RX/TX BD ring size
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: W7NCF01GH20IS4BG, CFA DISK drive
ide0 at 0xf9002000-0xf9002007,0xf900208c on irq 21
hda: max request size: 128KiB
hda: 2046240 sectors (1047 MB) w/0KiB Cache, CHS=2030/16/63
hda: cache flushes not supported
 hda: hda1 hda2
physmap flash device: 800000 at ff800000
phys_mapped_flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
RedBoot partition parsing not available
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
ip_conntrack version 2.3 (8064 buckets, 64512 max) - 236 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
eth0: PHY is Marvell 88E6046 (1410c89)
IP-Config: Complete:
      device=eth0, addr=192.168.10.50, mask=255.255.255.0, gw=192.168.10.1,
     host=SBC8349, domain=, nis-domain=(none),
     bootserver=192.168.10.1, rootserver=192.168.10.1, rootpath=
RAMDISK: Compressed image found at block 0
eth0: Full Duplex
eth0: Speed 1000BT
eth0: Link is up
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 124k init
EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #2:
directory entry across blocks - offset=0, inode=2147614725, rec_len=1152,
name_len=8
Warning: unable to open an initial console.
Kernel panic - not syncing: No init found.  Try passing init= option to
kernel.
 <0>Rebooting in 180 seconds

Thanks,
Nadav

------=_Part_27146_11013974.1215958905731
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><span class="947154513-13072008"><font face="Arial" size="2">Hi All,</font></span></div>
<div><span class="947154513-13072008"><font face="Arial" size="2"></font></span>&nbsp;</div>
<div><span class="947154513-13072008"><font face="Arial" size="2">I have built a 2.6.14 image and Ramdisk for my board witch has a ppc 8349 processor with 1G DDR. The system works file if I build it without highmem support but if I try to add highmem support to the system, witch I need in order to expand my memory to 2G, I get the following error:</font></span></div>

<div><span class="947154513-13072008"><font face="Arial" size="2"></font></span>&nbsp;</div>
<div><span class="947154513-13072008"><font face="Arial" size="2">EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #2: directory entry across blocks - offset=0, inode=2147614725, rec_len=1152, name_len=8</font></span><span class="947154513-13072008"></span></div>

<div><span class="947154513-13072008"><font face="Arial" size="2"></font></span>&nbsp;</div>
<div><span class="947154513-13072008"><font face="Arial" size="2">This is my console output:</font></span></div>
<div><span class="947154513-13072008"><font face="Arial" size="2"></font></span>&nbsp;</div>
<div><span class="947154513-13072008"><font face="Arial" size="2">==== Booting kernel ====<br>## Booting image at 00200000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.14.7-saline<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (grip compressed)<br>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1658344 Bytes =&nbsp; 1.6 MB<br>&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>&nbsp;&nbsp; Uncompressing Kernel Image ... OK<br>## Loading RAM Disk Image at 01000000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Corrigent_ignited_fess<br>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux RAM Disk Image (grip compressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 13721548 Bytes = 13.1 MB<br>&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>&nbsp;&nbsp; Loading Ramdisk to 0b2ea000, end 0bffffcc ... OK<br>
Linux version 2.6.14.7-saline (<a title="blocked::mailto:nadavs@nadavs_l.corrigent.com" href="mailto:nadavs@nadavs_l.corrigent.com">nadavs@nadavs_l.corrigent.com</a>) (gcc version 3.4.4 (Wind River Linux)) #50 PREEMPT Sun Jul 13 11:04:30 IDT 2008<br>
Built 1 zonelists</font></span></div>
<div><span class="947154513-13072008"><font face="Arial" size="2">Kernel command line: root=/dev/ram0 rw ramdisk_size=300000 mem=1008M ip=192.168.10.50:192.168.10.1:192.168.10.1:255.255.255.0:SBC8349:eth0:off console=ttyS1,115200,115200 debug_flag=no msm_standalone=no oper_mode=normal bootdir=msm_images vlan= sd=<br>
LTT : ltt-base init<br>IPIC (128 IRQ sources, 8 External IRQs) at fe000700<br>PID hash table entries: 4096 (order: 12, 65536 bytes)<br>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)<br>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)<br>
Memory: 1005368k available (2612k kernel code, 960k data, 124k init, 114688k highmem)<br>Security Framework v1.0.0 initialized<br>Capability LSM initialized<br>Mount-cache hash table entries: 512<br>checking if image is initramfs...softlockup thread 0 started up.<br>
it isn&#39;t (no cpio magic); looks like an initrd<br>Freeing initrd memory: 13399k freed<br>NET: Registered protocol family 16<br>PCI: Probing PCI hardware<br>PCI: Cannot allocate resource region 0 of device 0000:00:00.0<br>
PCI: Cannot allocate resource region 2 of device 0000:00:00.0<br>PCI: Failed to allocate mem resource #2:80000000@0 for 0000:00:00.0<br>Generic PHY: Registered new driver<br>LTT : ltt-facilities init<br>LTT : ltt-core init as module<br>
Registering GDB sysrq handler<br>highmem bounce pool size: 64 pages<br>Installing knfsd (copyright (C) 1996 <a title="blocked::mailto:okir@monad.swb.de" href="mailto:okir@monad.swb.de">okir@monad.swb.de</a>).<br>Initializing Cryptographic API<br>
LTT : ltt-facility-core init in kernel<br>LTT : ltt-facility-fs init in kernel<br>LTT : ltt-facility-ipc init in kernel<br>LTT : ltt-facility-kernel_arch init in kernel<br>LTT : ltt-facility-kernel init in kernel<br>LTT : ltt-facility-memory init in kernel<br>
LTT : ltt-facility-network init in kernel<br>LTT : ltt-facility-process init in kernel<br>LTT : ltt-facility-socket init in kernel<br>LTT : ltt-facility-timer init in kernel<br>LTT : ltt-facility-statedump init in kernel<br>
Software Watchdog Timer: 0.07 initialized. soft_noboot=1 soft_margin=10 sec (nowayout= 1)<br>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled<br>ttyS0 at MMIO map 0xe0004500 mem 0xfe004500 (irq = 9) is a 16550A<br>
ttyS1 at MMIO map 0xe0004600 mem 0xfe004600 (irq = 10) is a 16550A<br>io scheduler noop registered<br>io scheduler anticipatory registered<br>io scheduler deadline registered<br>io scheduler cfq registered<br>RAMDISK driver initialized: 1 RAM disks of 300000K size 1024 blocksize<br>
loop: loaded (max 8 devices)<br>nbd: registered device at major 43<br>eth0: Gianfar Ethernet Controller Version 1.1, 40:08:db:00:00:01 <br>eth0: Running with NAPI disabled<br>eth0: 256/256 RX/TX BD ring size<br>eth1: Gianfar Ethernet Controller Version 1.1, 40:08:db:00:10:00 <br>
eth1: Running with NAPI disabled<br>eth1: 256/256 RX/TX BD ring size<br>netconsole: not configured, aborting<br>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2<br>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx<br>
hda: W7NCF01GH20IS4BG, CFA DISK drive<br>ide0 at 0xf9002000-0xf9002007,0xf900208c on irq 21<br>hda: max request size: 128KiB<br>hda: 2046240 sectors (1047 MB) w/0KiB Cache, CHS=2030/16/63<br>hda: cache flushes not supported<br>
&nbsp;hda: hda1 hda2<br>physmap flash device: 800000 at ff800000<br>phys_mapped_flash: Found 1 x16 devices at 0x0 in 16-bit bank<br>&nbsp;Amd/Fujitsu Extended Query Table at 0x0040<br>number of CFI chips: 1<br>cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.<br>
RedBoot partition parsing not available<br>NET: Registered protocol family 2<br>IP route cache hash table entries: 32768 (order: 5, 131072 bytes)<br>TCP established hash table entries: 131072 (order: 7, 524288 bytes)<br>TCP bind hash table entries: 65536 (order: 6, 262144 bytes)<br>
TCP: Hash tables configured (established 131072 bind 65536)<br>TCP reno registered<br>ip_conntrack version 2.3 (8064 buckets, 64512 max) - 236 bytes per conntrack<br>ip_tables: (C) 2000-2002 Netfilter core team<br>arp_tables: (C) 2002 David S. Miller<br>
TCP bic registered<br>Initializing XFRM netlink socket<br>NET: Registered protocol family 1<br>NET: Registered protocol family 17<br>NET: Registered protocol family 15<br>802.1Q VLAN Support v1.8 Ben Greear &lt;<a title="blocked::mailto:greearb@candelatech.com" href="mailto:greearb@candelatech.com">greearb@candelatech.com</a>&gt;<br>
All bugs added by David S. Miller &lt;<a title="blocked::mailto:davem@redhat.com" href="mailto:davem@redhat.com">davem@redhat.com</a>&gt;<br>eth0: PHY is Marvell 88E6046 (1410c89)<br>IP-Config: Complete:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=eth0, addr=<a href="http://192.168.10.50">192.168.10.50</a>, mask=<a href="http://255.255.255.0">255.255.255.0</a>, gw=<a href="http://192.168.10.1">192.168.10.1</a>,<br>
&nbsp;&nbsp;&nbsp;&nbsp; host=SBC8349, domain=, nis-domain=(none),<br>&nbsp;&nbsp;&nbsp;&nbsp; bootserver=<a href="http://192.168.10.1">192.168.10.1</a>, rootserver=<a href="http://192.168.10.1">192.168.10.1</a>, rootpath=<br>RAMDISK: Compressed image found at block 0<br>
eth0: Full Duplex<br>eth0: Speed 1000BT<br>eth0: Link is up<br>VFS: Mounted root (ext2 filesystem).<br>Freeing unused kernel memory: 124k init<br>EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #2: directory entry across blocks - offset=0, inode=2147614725, rec_len=1152, name_len=8<br>
Warning: unable to open an initial console.<br>Kernel panic - not syncing: No init found.&nbsp; Try passing init= option to kernel.<br>&nbsp;&lt;0&gt;Rebooting in 180 seconds</font></span></div>
<div><span class="947154513-13072008"><font face="Arial" size="2"></font></span>&nbsp;</div>
<div><span class="947154513-13072008"><font face="Arial" size="2">Thanks,</font></span></div>
<div><span class="947154513-13072008"><font face="Arial" size="2">Nadav</font></span></div>

------=_Part_27146_11013974.1215958905731--
