Message-ID: <3E9E9C88.C30C6841@doremilabs.com>
Date: Thu, 17 Apr 2003 12:22:32 +0000
From: Jeff H Zhong <jeff@doremilabs.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Ebony -- NFS mount issue when use bootm
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The whole story is as,

If I use "bootp" or "tftp" to load kernel image(linuxppc_2_4_devel from
BK) at address 0x01000000 and then issue "bootm", everything works fine.
I have also programmed the image into flash at 0xffe00000, but each time
when I issue "bootm 0xffe00000", it will get stuck at when trying to
mount NFS.

Below are the output log,

1. bootp or tftp boot, it is working

U-Boot 0.3.0 (Apr 16 2003 - 13:44:01)

IBM PowerPC 440 Rev. C
Board: IBM 440GP Evaluation Board (Ebony)
        VCO: 800 MHz
        CPU: 400 MHz
        PLB: 133 MHz
        OPB: 66 MHz
        EPB: 66 MHz
I2C:   ready
DRAM:  I2c read: failed 4
I2c read: failed 4
128 MB
FLASH:  4.5 MB
PCI:   Bus Dev VenId DevId Class Int
        00  04  1095  0680  0104  00
In:    serial
Out:   serial
Err:   serial
KGDB:  kgdb ready
ready
BEDBUG:ready
=> bootp
ENET Speed is 100 Mbps - FULL duplex connection
BOOTP broadcast 1
DHCP client bound to address 7.1.1.6
ARP broadcast 1
TFTP from server 7.1.1.4; our IP address is 7.1.1.6
Filename '/tftpboot/vmlinux.PPCBoot'.
Load address: 0x1000000
Loading:
#################################################################

#################################################################
         ###########
done
Bytes transferred = 718054 (af4e6 hex)
=> bootm
## Booting image at 01000000 ...
   Image Name:   Linux-2.4.21-pre7-big
   Created:      2003-04-16  18:38:20 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    717990 Bytes = 701.2 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.21-pre7-big (root@Jeff) (gcc version 2.95.2 19991024
(release)
) #77 Wed Apr 16 18:38:13 UTC 2003
IBM Ebony port (C) 2002 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw console=ttyS0,9600
ip=7.1.1.6:::255.255.25
5.0:ppclinux:eth0 nfsroot=7.1.1.4:/exports/eldk/ppc_4xx
Calibrating delay loop... 599.65 BogoMIPS
Memory: 127432k available (1176k kernel code, 424k data, 224k init, 0k
highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI en
abled
ttyS00 at 0xfdfea200 (irq = 0) is a 16550A
ttyS01 at 0xfdfe9300 (irq = 1) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Zmii bridge in RMII mode
eth0: Phy @ 0x8, type Am79c875A (0x00225541)
Reset ethernet interfaces
Zmii bridge in RMII mode
eth1: Phy @ 0x9, type Am79c875A (0x00225541)
Reset ethernet interfaces
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
SiI680: IDE controller at PCI slot 00:04.0
SiI680: chipset revision 1
SiI680: not 100% native mode: will probe irqs later
SiI680: BASE CLOCK == 133
    ide0: MMIO-DMA at 0xc900ef00-0xc900ef07, BIOS settings: hda:pio,
hdb:pio
    ide1: MMIO-DMA at 0xc900ef08-0xc900ef0f, BIOS settings: hdc:pio,
hdd:pio
Probing IDE interface ide0...
hda: IBM-DTLA-307015, ATA DISK drive
blk: queue c01c2150, I/O limit 4095Mb (mask 0xffffffff)
Probing IDE interface ide1...
ide0 at 0xc900ef80-0xc900ef87,0xc900ef8a on irq 26
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 30003120 sectors (15362 MB) w/1916KiB Cache, CHS=29765/16/63,
UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: [PTBL] [1867/255/63] p1
IBM IIC driver
i2c-dev.o: Registered 'IBM IIC adapter' as minor 0
i2c-core.o: adapter IBM IIC adapter registered as adapter 0.
i2c-dev.o: Registered 'IBM IIC adapter' as minor 1
i2c-core.o: adapter IBM IIC adapter registered as adapter 1.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
eth0: IBM EMAC: link up, 100 Mbps Full Duplex, auto-negotiation
complete.
eth0: IBM EMAC: MAC 00:04:ac:e3:1d:62.
eth0: IBM EMAC: open completed

IP-Config: Complete:
      device=eth0, addr=7.1.1.6, mask=255.255.255.0, gw=255.255.255.255,
     host=ppclinux, domain=, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=7.1.1.4, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 7.1.1.4
Looking up port of RPC 100005/1 on 7.1.1.4
VFS: Mounted root (nfs filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 224k init
INIT: version 2.78 booting
Remounting the root filesystem read-write.
Cleaning: /tmp /var/lock /var/run.
Mong local file systems...
none on /dev/pts type devpts (rw,gid=5,mode=620)
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces: done.
Starting portmap daemon: portmap.
Initializing random number generator... done.
INIT: Entering runlevel: 2
Starting system logger: Done
Starting kernel logger: Done
Starting xinetd: Done

Welcome to DoReMi Labs. Inc.
ppclinux login: root
Linux ppclinux 2.4.21-pre7-big #77 Wed Apr 16 18:38:13 UTC 2003 ppc
unknown
bash-2.05#


2. bootm 0xffe00000, not working

U-Boot 0.3.0 (Apr 16 2003 - 13:44:01)

IBM PowerPC 440 Rev. C
Board: IBM 440GP Evaluation Board (Ebony)
        VCO: 800 MHz
        CPU: 400 MHz
        PLB: 133 MHz
        OPB: 66 MHz
        EPB: 66 MHz
I2C:   ready
DRAM:  I2c read: failed 4
I2c read: failed 4
128 MB
FLASH:  4.5 MB
PCI:   Bus Dev VenId DevId Class Int
        00  04  1095  0680  0104  00
In:    serial
Out:   serial
Err:   serial
KGDB:  kgdb ready
ready
BEDBUG:ready
=> bootm 0xffe00000
## Booting image at ffe00000 ...
   Image Name:   Linux-2.4.21-pre7-big
   Created:      2003-04-16  18:38:20 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    717990 Bytes = 701.2 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.21-pre7-big (root@Jeff) (gcc version 2.95.2 19991024
(release)
) #77 Wed Apr 16 18:38:13 UTC 2003
IBM Ebony port (C) 2002 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw console=ttyS0,9600
ip=7.1.1.6:::255.255.25
5.0:ppclinux:eth0 nfsroot=7.1.1.4:/exports/eldk/ppc_4xx
Calibrating delay loop... 599.65 BogoMIPS
Memory: 127432k available (1176k kernel code, 424k data, 224k init, 0k
highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI en
abled
ttyS00 at 0xfdfea200 (irq = 0) is a 16550A
ttyS01 at 0xfdfe9300 (irq = 1) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Zmii bridge in MII mode
eth0: Phy @ 0x8, type Am79c875A (0x00225541)
Reset ethernet interfaces
Zmii bridge in MII mode
eth1: Phy @ 0x9, type Am79c875A (0x00225541)
Reset ethernet interfaces
eth1: Cannot open interface without Link
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
SiI680: IDE controller at PCI slot 00:04.0
SiI680: chipset revision 1
SiI680: not 100% native mode: will probe irqs later
SiI680: BASE CLOCK == 133
    ide0: MMIO-DMA at 0xc900ef00-0xc900ef07, BIOS settings: hda:pio,
hdb:pio
    ide1: MMIO-DMA at 0xc900ef08-0xc900ef0f, BIOS settings: hdc:pio,
hdd:pio
Probing IDE interface ide0...
hda: IBM-DTLA-307015, ATA DISK drive
blk: queue c01c2150, I/O limit 4095Mb (mask 0xffffffff)
Probing IDE interface ide1...
ide0 at 0xc900ef80-0xc900ef87,0xc900ef8a on irq 26
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 30003120 sectors (15362 MB) w/1916KiB Cache, CHS=29765/16/63,
UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: [PTBL] [1867/255/63] p1
IBM IIC driver
i2c-dev.o: Registered 'IBM IIC adapter' as minor 0
i2c-core.o: adapter IBM IIC adapter registered as adapter 0.
i2c-dev.o: Registered 'IBM IIC adapter' as minor 1
i2c-core.o: adapter IBM IIC adapter registered as adapter 1.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
eth0: IBM EMAC: link up, 100 Mbps Full Duplex, auto-negotiation
complete.
eth0: IBM EMAC: MAC 00:04:ac:e3:1d:62.
eth0: IBM EMAC: open completed

IP-Config: Complete:
      device=eth0, addr=7.1.1.6, mask=255.255.255.0, gw=255.255.255.255,
     host=ppclinux, domain=, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=7.1.1.4, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 7.1.1.4


It stucks at here and will eventully tell that it gonna to try reboot.

Is there anyone had the similar problem before? Please give me a hand.
All my settings are:

=> printenv
baudrate=9600
loads_echo=1
loadaddr=0x01000000
bootfile=vmlinux.PPCBoot
ethaddr=00:04:ac:e3:1d:62
filesize=af4b2
netmask=255.255.255.0
ipaddr=7.1.1.6
serverip=7.1.1.4
bootargs=root=/dev/nfs rw console=ttyS0,9600
ip=7.1.1.6:::255.255.255.0:ppclinux
:eth0 nfsroot=7.1.1.4:/exports/eldk/ppc_4xx
stdin=serial
stdout=serial
stderr=serial

Environment size: 332/4092 bytes



NFS config file (/etc/exports):

/exports/eldk/ppc_4xx 7.1.1.6(rw,no_root_squash)


Many Thanks,
--Jeff


--
Jeff H. Zhong
-------------
Doremi Labs, Inc.
306 East Alameda Avenue
Burbank, CA 91502
Tel : (818) 562 1101
Fax : (818) 562 1109

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
