Message-ID: <20040717224206.48256.qmail@web15202.mail.bjs.yahoo.com>
Date: Sun, 18 Jul 2004 06:42:06 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: 2.6.7 kernel still cannot boot via NFS on RPXlite DW
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20040709215108.5DC7DC109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Following is the boot message on RPXlite board with
2.6.7+NFS.One week ago,there was CONFIG_ROOT_NFS in
Kconfig in bk linuxppc-2.5 tree but didn't
work--kernel Oops.Now it seemed removing from config
list.Why is that?

U-Boot 1.1.2 (Jul 15 2004 - 17:26:45)

CPU:   PPC823EZTnnB2 at 48 MHz: 16 kB I-Cache 8 kB
D-Cache
Board: RPXlite_DW
DRAM:  64 MB
FLASH: 16 MB
In:    serial
Out:   serial
Err:   serial
Net:   SCC ETHERNET
u-boot>pri
bootcmd=run flash_self
baudrate=9600
loads_echo=1
ethaddr=00:10:EC:00:37:5B
netdev=eth0
addip=setenv bootargs $(bootargs)
ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname):$(netdev):off
panic=1
flash_nfs=run nfsargs addip;bootm $(kernel_addr)
flash_self=run ramargs addip;bootm $(kernel_addr)
$(ramdisk_addr)
net_nfs=tftp 200000 $(bootfile);run nfsargs
addip;bootm
ethact=SCC ETHERNET
rootpath=/eldk/ppc_8xx/
ramargs=setenv bootargs root=/dev/ram rw
ramdisk_addr=ff900000
bootargs=root=/dev/nfs rw
nfsroot=172.16.115.3:/eldk/ppc_8xx/
ip=172.16.115.7:172.16.115.3:172.16.115.254:255.255.255.0::eth0:off
panic=1
filesize=b8cbd
fileaddr=100000
gatewayip=172.16.115.254
netmask=255.255.255.0
ipaddr=172.16.115.7
serverip=172.16.115.3
kernel_addr=ff600000
bootfile=uImage.rpx2618
nfsargs=setenv root=/dev/nfs rw
rootpath=:/eldk/ppc_8xx/
severip=172.16.115.3
stdin=serial
stdout=serial
stderr=serial

Environment size: 905/32764 bytes
u-boot>run net_nfs
Using SCC ETHERNET device
TFTP from server 172.16.115.3; our IP address is
172.16.115.7
Filename 'uImage.rpx2618'.
Load address: 0x200000
Loading:
#################################################################

#################################################################
         ####################
done
Bytes transferred = 767258 (bb51a hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.7
   Image Type:   PowerPC Linux Kernel Image (gzip
compressed)
   Data Size:    767194 Bytes = 749.2 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.6.7 (root@localhost.localdomain) (gcc
version 3.2.2 20030217 (Yellow Dog Linux 3.0
3.2.2-2a_1)) #1 Sun Jul 18 03:48:35 CST 2004
On node 0 totalpages: 16384
  DMA zone: 16384 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: root=/dev/nfs rw
nfsroot=172.16.115.3:/eldk/ppc_8xx/
ip=172.16.115.7:172.16.115.3:172.16.115.254:255.255.255.0::eth0:off
panic=1
ip=172.16.115.7:172.16.115.3:172.16.115.254:255.255.255.0::eth0:off
panic=1
PID hash table entries: 512 (order 9: 4096 bytes)
Decrementer Frequency = 180000000/60
Dentry cache hash table entries: 16384 (order: 4,
65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768
bytes)
Memory: 63008k available (1368k kernel code, 300k
data, 60k init, 0k highmem)
Calibrating delay loop... 47.10 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096
bytes)
NET: Registered protocol family 16
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Generic RTC Driver v1.07
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xfa200a80 (irq = 20) is a CPM UART
ttyCPM1 at MMIO 0xfa200a00 (irq = 46) is a CPM UART
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
loop: loaded (max 8 devices)
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind
8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
VFS: Cannot open root device "nfs" or
unknown-block(0,255)
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on
unknown-block(0,255)
 <0>Rebooting in 1 seconds..

U-Boot 1.1.2 (Jul 15 2004 - 17:26:45)

CPU:   PPC823EZTnnB2 at 48 MHz: 16 kB I-Cache 8 kB
D-Cache
Board: RPXlite_DW
DRAM:  64 MB
FLASH: 16 MB
In:    serial
Out:   serial
Err:   serial
Net:   SCC ETHERNET
u-boot>

---------------------------------------------

Best regards,

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
