Return-Path: <dgalari@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.225])
	by ozlabs.org (Postfix) with ESMTP id B4F0ADDE10
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Jan 2007 22:31:15 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so5963035wxd
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 04 Jan 2007 03:31:13 -0800 (PST)
Message-ID: <3184691b0701040331m5bc79cc3vb749f868e252426b@mail.gmail.com>
Date: Thu, 4 Jan 2007 12:31:13 +0100
From: "David Gamez Alari" <dgalari@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: boot problem in a LITE5200B
MIME-Version: 1.0
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

Hello, I have a LITE5200B board and I have a problem when I load the
kernel and the root filesystem image.

In my screen the LITE5200B board post:

=> bootm 0x300000 0x700000
## Booting image at 00300000 ...
  Image Name:   Linux-2.6.16-mpc52xx-gd59bdc6d-d
  Image Type:   PowerPC Linux Kernel Image (gzip compressed)
  Data Size:    668948 Bytes = 653.3 kB
  Load Address: 00000000
  Entry Point:  00000000
  Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 00700000 ...
  Image Name:   RAM disk
  Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
  Data Size:    3510520 Bytes =  3.3 MB
  Load Address: 00000000
  Entry Point:  00000000
  Loading Ramdisk to 0fbf6000, end 0ff4f0f8 ... OK
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
arch: exit
Linux version 2.6.16-mpc52xx-gd59bdc6d-dirty (root@david-pc) (gcc
version 3.4.5) #4 Thu Jan 4 10:10:45 CET 2007
Built 1 zonelists
Kernel command line: root=/dev/ram rw console=ttyPSC0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 254592k available (996k kernel code, 360k data, 80k init, 0k highmem)
Mount-cache hash table entries: 512
checking if image is initramfs...it isn't (bad gzip magic numbers);
looks like an initrd
Freeing initrd memory: 3428k freed

PCI: Probing PCI hardware
DMA: MPC52xx BestComm driver
MPC52xx BestComm inited
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: MPC52xx PSC driver
ttyPSC0 at MMIO 0xf0002000 (irq = 40) is a MPC52xx PSC
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
mice: PS/2 mouse device common for all mice
RAMDISK: Couldn't find valid RAM disk image starting at 0.
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)
 <0>Rebooting in 180 seconds..


Please, Somebody knows to that it must???


My bootlader enviroment variables are:

bootcmd=run flash_self
bootdelay=5
baudrate=115200
preboot=echo;echo Type "run flash_nfs" to mount root filesystem over NFS;echo
skipnetcheck=y
skippcicheck=y
skipidecheck=y
verify=n
netdev=eth0
nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=$(serverip):$(rootpath)
ramargs=setenv bootargs root=/dev/ram rw
addip=setenv bootargs $(bootargs)
ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname):$(netdev):off
panic=1
flash_nfs=run nfsargs addip;bootm $(kernel_addr)
flash_self=run ramargs addip;bootm $(kernel_addr) $(ramdisk_addr)
net_nfs=tftp 200000 $(bootfile);run nfsargs addip;bootm
rootpath=/opt/eldk/ppc_82xx
autoload=no
autostart=no
ethaddr=00:04:9f:00:5b:46
ethact=FEC ETHERNET
bootfile=/tftpboot/MPC5200/uImage
gatewayip=10.48.142.1
netmask=255.255.255.0
ipaddr=10.48.142.23
serverip=10.48.142.19
stdin=serial
stdout=serial
stderr=serial
bootargs=root=/dev/ram rw
ip=10.48.142.23:10.48.142.19:10.48.142.1:255.255.255.0::eth0:off
panic=1
console=ttyPSC0=root=/dev/ram rw


thanks in advance.

David Gamez
