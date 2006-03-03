Return-Path: <lijianggan@pmail.ntu.edu.sg>
Received: from exsmtp1.ntu.edu.sg (exsmtp1.ntu.edu.sg [155.69.5.207])
	by ozlabs.org (Postfix) with ESMTP id 8902C679A6
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Mar 2006 19:11:33 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C63E9A.144C9176"
Subject: RE: boot failure on lite5200b board
Date: Fri, 3 Mar 2006 16:06:40 +0800
Message-ID: <84A109BF918D934CB46ACF33BCE187C002D54D96@mail02.student.main.ntu.edu.sg>
References: <84A109BF918D934CB46ACF33BCE187C002D54D71@mail02.student.main.ntu.edu.sg><43FD6669.9090405@246tNt.com><84A109BF918D934CB46ACF33BCE187C002D54D7A@mail02.student.main.ntu.edu.sg><4b73d43f0602230818w63423513n817d9ec7eb580d2c@mail.gmail.com><84A109BF918D934CB46ACF33BCE187C002D54D7B@mail02.student.main.ntu.edu.sg><4b73d43f0602240917h1d80bcf8ycc87086305434304@mail.gmail.com><84A109BF918D934CB46ACF33BCE187C002D54D94@mail02.student.main.ntu.edu.sg>
	<4b73d43f0603011652w39fb4393x8879891b7538f0b1@mail.gmail.com>
From: "#LI JIANGGAN#" <lijianggan@pmail.ntu.edu.sg>
To: "John Rigby" <jcrigby@gmail.com>
Cc: haidong_feng@126.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C63E9A.144C9176
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks John, the Kernel now boots well. However it gives a kernel panic =
while mounting the root file sysem over NFS:

Looking up port of RPC 100003/2 on 10.190.3.103
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
Root-NFS: Unable to get nfsd port number from server, using default

I couldn't figure out why error 101 /* Network is unreachable */ is =
given. Below is my current U-boot settings and a snapshot of the =
booting:


=3D> printenv
baudrate=3D115200
autoload=3Dno
ethact=3DFEC ETHERNET
ethaddr=3D00:01:9F:00:27:2F
preboot=3Decho; echo Autostarting. Press any key to abort..; echo
bootdelay=3D5
hostname=3Dicecube
bootfile=3DMPC5200/uImage
nv=3Dnfsroot root=3D/dev/nfs rw nfsroot=3D10.190.3.113:/opt/eldk/rootfs
netmask=3D255.255.240.0
ipaddr=3D10.190.3.144
serverip=3D10.190.3.103
bootcmd=3Drun net_nfs
netdev=3Deth0
rootpath=3D/opt/eldk-4-0/rootfs
ramargs=3Dsetenv bootargs root=3D/dev/ram rw
addip=3Dsetenv bootargs =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube:eth0:of=
f panic=3D1
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube:eth0:of=
f
net_nfs=3Dtftp 200000 MPC5200/uImage;run nfsargs;bootm
nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs
rootfs=3D10.190.3.103:/opt/eldk-4-0/rootfs
nfsargs=3Dsetenv bootargs console=3DttyS0,115200 =
nfsroot=3D10.190.3.103:/opt/eldk-4-0/nfs root=3D/dev/nfs rw
stdin=3Dserial
stdout=3Dserial
stderr=3Dserial

Environment size: 882/65532 bytes
=3D> boot
Using FEC ETHERNET device
TFTP from server 10.190.3.103; our IP address is 10.190.3.144
Filename 'MPC5200/uImage'.
Load address: 0x200000
Loading: =
#################################################################
         =
#################################################################
         =
#################################################################
         =
#################################################################
         ###################################
done
Bytes transferred =3D 1510143 (170aff hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.11.7
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1510079 Bytes =3D  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
ocp: exit
arch: exit
Linux version 2.6.11.7 (root@bob) (gcc version 3.3.2) #1 Tue Sep 6 =
22:40:03 UTC 2005
Real-Time Preemption Support (c) Ingo Molnar
Built 1 zonelists
Kernel command line: console=3DttyS0,115200 =
nfsroot=3D10.190.3.103:/opt/eldk-4-0/nfs root=3D/dev/nfs rw
PID hash table entries: 2048 (order: 11, 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 256268k available (2336k kernel code, 896k data, 140k init, 0k =
highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
BUG: scheduling while atomic: swapper/0x00000001/0
caller is schedule+0x50/0xe8
Call trace:
 [c0006bd8] dump_stack+0x18/0x28
 [c0242818] __sched_text_start+0x69c/0x6a0
 [c024286c] schedule+0x50/0xe8
 [c0003f00] syscall_exit_work+0x108/0x10c
 [c030c578] proc_root_init+0x144/0x150
 [c0320000] 0xc0320000
 [c02fe624] start_kernel+0x180/0x1b8
 [000035fc] 0x35fc
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
softirq RT prio: 24.
desched cpu_callback 2/00000000
desched thread 0 started up.
NET: Registered protocol family 16

PCI: Probing PCI hardware
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
ppdev: user-space parallel port driver
Serial: MPC52xx PSC driver
ttyS0 at MMIO 0xf0002000 (irq =3D 39) is a MPC52xx PSC
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx
ipb=3D132MHz, set clock period to 7
GPIO config: 91051024
ATA invalid: 01000000
ATA hostcnf: 03000000
ATA pio1   : 100a0a00
ATA pio2   : 02040600
XLB Arb cnf: 0000a366
mpc52xx_ide: Setting up IDE interface ide0...
flash chip on the Lite5200/Lite5200B: Found 1 x16 devices at 0x0 in =
8-bit bank
flash chip on the Lite5200/Lite5200B: Found 1 x16 devices at 0x1000000 =
in 8-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
flash chip on the Lite5200/Lite5200B: CFI does not contain boot bank =
location. Assuming top.
number of CFI chips: 2
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Creating 7 MTD partitions on "flash chip on the Lite5200/Lite5200B":
0x00000000-0x01000000 : "Filesystem"
0x01000000-0x01040000 : "BootLOW"
0x01040000-0x01060000 : "EnvLOW"
0x01060000-0x01d00000 : "Spare"
0x01d00000-0x01f00000 : "Kernel"
0x01f00000-0x01f40000 : "BootHIGH"
0x01f40000-0x01f60000 : "EnvHIGH"
ocp-ohci 02: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
i2c-algo-52xx.o: scanning bus Lite5200 I2C module #1 interface...
.........................................................................=
.......................................................
i2c-lite5200.o: I2C module #1 installed
i2c-algo-52xx.o: scanning bus Lite5200 I2C module #2 interface...
.........................................................................=
.......(0x50)..............................................(0x7f)
i2c-lite5200.o: I2C module #2 installed
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13 =
09:39:32 2005 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 256 buckets, 16Kbytes
TCP established hash table entries: 16384 (order: 8, 1048576 bytes)
TCP bind hash table entries: 16384 (order: 7, 917504 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
Looking up port of RPC 100003/2 on 10.190.3.103
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 10.190.3.103
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
Root-NFS: Unable to get mountd port number from server, using default
RPC: sendmsg returned error 101
mount: RPC call returned error 101
Root-NFS: Server returned error -101 while mounting /opt/eldk-4-0/nfs
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or unknown-block(2,0)
Please append a correct "root=3D" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on =
unknown-block(2,0)
 <0>Rebooting in 180 seconds..                  =20



regards,
Jianggan



-----Original Message-----
From: John Rigby [mailto:jcrigby@gmail.com]
Sent: Thu 3/2/2006 8:52
To: #LI JIANGGAN#
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: boot failure on lite5200b board
=20
Here is a uboot setup that works with a freescale kernel:
bootdelay=3D5
baudrate=3D115200
preboot=3Decho;echo Type "run flash_nfs" to mount root filesystem over =
NFS;echo
autoload=3Dno
ethact=3DFEC ETHERNET
ramargs=3Dsetenv bootargs root=3D/dev/ram rw
jffs2args=3Dsetenv bootargs root=3D/dev/mtdblock0 rw rootfstype=3Djffs2
addip=3Dsetenv bootargs $(bootargs)
ip=3D$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname):$(netdev):=
off
panic=3D1
flash_nfs=3Drun nfsargs addip;bootm $(kernel_addr)
flash_self=3Drun ramargs addip;bootm $(kernel_addr) $(ramdisk_addr)
flash_jffs2=3Drun jffs2args;bootm $(kernel_addr)
net_nfs=3Dtftp 200000 $(bootfile);run nfsargs addip;bootm
netdev=3Deth0
ethaddr=3D00:04:9f:22:33:44
bootfile=3D/tftpboot/uImage
kernel_addr=3Dffd00000
rootpath=3D/tftpboot/ltib
filesize=3Dc9d700
fileaddr=3D1000000
gatewayip=3D172.27.255.254
netmask=3D255.255.0.0
ipaddr=3D172.27.152.99
serverip=3D172.27.152.5
bootcmd=3Drun net_nfs
nfsargs=3Dsetenv bootargs console=3DttyS0,115200 root=3D/dev/nfs rw
nfsroot=3D$(serverip):$(rootpath)
stdin=3Dserial
stdout=3Dserial
stderr=3Dserial

Change ip info, bootfile, rootpath etc to fit you config.
If you want it to work with Sylvain's kernel then you need to change
ttyS0 to ttyPSC0.

Also add a printenv just before the bootm so you can verify that your
bootargs really are getting set correctly.

On 3/1/06, #LI JIANGGAN# <lijianggan@pmail.ntu.edu.sg> wrote:
>
>
> how about the following U-boot settings:
>
> ..............................
>
>
> Hit any key to stop autoboot:  0
> =3D> printenv
> baudrate=3D115200
> autoload=3Dno
> ethact=3DFEC ETHERNET
> ethaddr=3D00:01:9F:00:27:2F
> preboot=3Decho; echo Autostarting. Press any key to abort..; echo
> bootdelay=3D5
> hostname=3Dicecube
> bootfile=3DMPC5200/uImage
> nv=3Dnfsroot root=3D/dev/nfs rw =
nfsroot=3D10.190.3.113:/opt/eldk/rootfs
> netmask=3D255.255.240.0
> ipaddr=3D10.190.3.144
> serverip=3D10.190.3.103
> bootcmd=3Drun net_nfs
>
> rootfs=3Droot=3D/dev/nfs rw
> netdev=3Deth0
> rootpath=3D/opt/eldk-4-0/rootfs
> nfsargs=3Dsetenv bootargs root=3D/dev/nfs rw
> nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs
>
> ramargs=3Dsetenv bootargs root=3D/dev/ram rw
> addip=3Dsetenv bootargs
> =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube:eth0:of=
f
> panic=3D1
> net_nfs=3Dtftp 200000 MPC5200/uImage;run nfsargs addip;bootm
>
> stdin=3Dserial
> stdout=3Dserial
> stderr=3Dserial
>
> Environment size: 738/65532 bytes
> =3D>                                .
> ................................
>
>
>
> The output is still the same, it hangs after displaying arch:exit
>
> I have also tried the above settings with console set, it gives the =
same
> output
>
> I am really wondering whether the problem is with the kernel. =
Sylvain's
> kernel uImage is only around 600k while the one from freescale is =
1.4M,
> anybody knows where the difference is?
>
> .....................................
>
> Autostarting. Press any key to abort..
>
> Hit any key to stop autoboot:  0
> Using FEC ETHERNET device
> TFTP from server 10.190.3.103; our IP address is 10.190.3.144
> Filename 'MPC5200/uImage'.
> Load address: 0x200000
>
> Loading:
> #################################################################
>
> #################################################################
>
> #################################################################
>
> #################################################################
>          ###################################
> done
> Bytes transferred =3D 1510143 (170aff hex)
> ## Booting image at 00200000 ...
>
>    Image Name:   Linux-2.6.11.7
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1510079 Bytes =3D  1.4 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> id mach(): done
> MMU:enter
> MMU:hw init
> MMU:mapin
> MMU:setio
> MMU:exit
> setup_arch: enter
> setup_arch: bootmem
> ocp: exit
> arch: exit
>
>
>
>
>
> .....................
>
> Regards,
>
> Jianggan LI
>
>  ________________________________
>
> From: John Rigby [mailto:jcrigby@gmail.com]
> Sent: Sat 2/25/2006 1:17
> To: #LI JIANGGAN#
> Cc: tnt@246tnt.com; linuxppc-embedded@ozlabs.org
>
> Subject: Re: boot failure on lite5200b board
>
>
>
>
> I don't think your syntax for appending to an env variable is correct:
>
> try:
> set bootargs $(bootargs) ...appended stuff...
> instead of:
> set bootargs env bootargs ...appended stuff....
>
> Also to see what bootargs is actually set to after all the nested
> commands, add a printenv just before the bootm
>
> On 2/23/06, #LI JIANGGAN# <lijianggan@pmail.ntu.edu.sg> wrote:
> >
> >
> > I have actually tried both kernel with both console configurations. =
It
> gave
> > the same output, thus I presume that the problem lies somewhere =
else. I
> > attached the log to this email.
> >
> >  the board is Lite5200B Version 1.0. Which .config file do you want?
> >
> >  Sylvain, we have ordered a debugging set but we are still waiting =
for
> > delivery, the leaking time is said to be one month, tant pis. And =
the log
> I
> > attached here are booting from a higher address (0x500000).
> >
> >  My current u-boot args:
> >  Autostarting. Press any key to abort..
> >
> >  Hit any key to stop autoboot:  0
> >  =3D> printenv
> >  baudrate=3D115200
> >  autoload=3Dno
> >  ethact=3DFEC ETHERNET
> >  flshroot=3Droot=3D/dev/mtdblock2 rw
> >  ethaddr=3D00:01:9F:00:27:2F
> >  preboot=3Decho; echo Autostarting. Press any key to abort..; echo
> >  bootdelay=3D5
> >  hostname=3Dicecube
> >  bootfile=3DMPC5200/uImage
> >  nv=3Dnfsroot root=3D/dev/nfs rw =
nfsroot=3D10.190.3.113:/opt/eldk/rootfs
> >  =
ip=3Dip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::o=
ff
> >  nfsroot=3Droot=3D/dev/nfs rw
> nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs
> >  bootcmd=3Drun net_nfs
> >  filesize=3D546
> >  fileaddr=3D500000
> >  netmask=3D255.255.240.0
> >  ipaddr=3D10.190.3.144
> >  serverip=3D10.190.3.103
> >  setconsole=3Dsetenv bootargs console=3DttyPSC0, 115200n8 =
console=3Dtty1
> >  rootfs=3Droot=3D/dev/nfs rw
> nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs
> >  bootargs=3Denv bootargs root=3D/dev/nfs rw
> > nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs
> > =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::off
> >  flash_nfs=3Drun setconsole nfsargs addip;bootm
> >  net_nfs=3Dtftp 500000 MPC5200/uImage;run setconsole nfsargs =
addip;bootm
> >  nfsargs=3Dsetenv bootargs env bootargs root=3D/dev/nfs rw
> > nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs
> >
> =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::offroo=
t=3D/dev/nfs
> > rw
> >  addip=3Dsetenv bootargs env bootargs root=3D/dev/nfs rw
> > nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs
> > =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::off
> >  ramargs=3Dsetenv bootargs root=3D/dev/ram rw
> >  console=3Dconsole=3DttyS0,115200n8 console=3Dtty1
> >  stdin=3Dserial
> >  stdout=3Dserial
> >  stderr=3Dserial
> >
> >  Environment size: 1472/65532 bytes
> >  =3D>
> >
> >
> >
> >
> >  USING Sylvain's KERNEL:
> >
> >  U-Boot 1.1.3 (Feb  6 2006 - 09:56:46)
> >
> >  CPU:   MPC5200 v2.2 at 462 MHz
> >         Bus 132 MHz, IPB 132 MHz, PCI 33 MHz
> >  Board: Freescale MPC5200 (Lite5200B)
> >  I2C:   85 kHz, ready
> >  DRAM:  256 MB
> >  FLASH: 32 MB
> >  PCI:   Bus Dev VenId DevId Class Int
> >          00  1a  1057  5809  0680  00
> >  In:    serial
> >  Out:   serial
> >  Err:   serial
> >  Net:   FEC ETHERNET
> >  IDE:   Bus 0: OK
> >    Device 0: not available
> >    Device 1: not available
> >
> >  Autostarting. Press any key to abort..
> >
> >  Hit any key to stop autoboot:  0
> >  Using FEC ETHERNET device
> >  TFTP from server 10.190.3.103; our IP address is 10.190.3.144
> >  Filename 'MPC5200/uImage'.
> >  Load address: 0x500000
> >  Loading:
> #################################################################
> >
> ################################################################
> >  done
> >  Bytes transferred =3D 658114 (a0ac2 hex)
> >  ## Booting image at 00500000 ...
> >     Image Name:   Linux-2.6.16-rc1
> >     Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> >     Data Size:    658050 Bytes =3D 642.6 kB
> >     Load Address: 00000000
> >     Entry Point:  00000000
> >     Verifying Checksum ... OK
> >     Uncompressing Kernel Image ... OK
> >  id mach(): done
> >  MMU:enter
> >  MMU:hw init
> >  MMU:mapin
> >  MMU:setio
> >  MMU:exit
> >  setup_arch: enter
> >  setup_arch: bootmem
> >  arch: exit
> >
> >
> >
> >  USING KERNEL FROM Freescale:
> >
> >  U-Boot 1.1.3 (Feb  6 2006 - 09:56:46)
> >
> >  CPU:   MPC5200 v2.2 at 462 MHz
> >         Bus 132 MHz, IPB 132 MHz, PCI 33 MHz
> >  Board: Freescale MPC5200 (Lite5200B)
> >  I2C:   85 kHz, ready
> >  DRAM:  256 MB
> >  FLASH: 32 MB
> >  PCI:   Bus Dev VenId DevId Class Int
> >          00  1a  1057  5809  0680  00
> >  In:    serial
> >  Out:   serial
> >  Err:   serial
> >  Net:   FEC ETHERNET
> >  IDE:   Bus 0: OK
> >    Device 0: not available
> >    Device 1: not available
> >
> >  Autostarting. Press any key to abort..
> >
> >  Hit any key to stop autoboot:  0
> >  Using FEC ETHERNET device
> >  TFTP from server 10.190.3.103; our IP address is 10.190.3.144
> >  Filename 'MPC5200/uImage'.
> >  Load address: 0x500000
> >  Loading:
> #################################################################
> >
> #################################################################
> >
> #################################################################
> >
> #################################################################
> >           ###################################
> >  done
> >  Bytes transferred =3D 1510143 (170aff hex)
> >  ## Booting image at 00500000 ...
> >     Image Name:   Linux-2.6.11.7
> >     Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> >     Data Size:    1510079 Bytes =3D  1.4 MB
> >     Load Address: 00000000
> >     Entry Point:  00000000
> >     Verifying Checksum ... OK
> >     Uncompressing Kernel Image ... OK
> >  id mach(): done
> >  MMU:enter
> >  MMU:hw init
> >  MMU:mapin
> >  MMU:setio
> >  MMU:exit
> >  setup_arch: enter
> >  setup_arch: bootmem
> >  ocp: exit
> >  arch: exit
> >
> >
> >
> >
> >  -----Original Message-----
> >  From: John Rigby [mailto:jcrigby@gmail.com]
> >  Sent: Fri 2/24/2006 0:18
> >  To: #LI JIANGGAN#
> >  Subject: Re: boot failure on lite5200b board
> >
> >  If you are using Sylvain's kernel you need to set =
console=3DttyPSC0.  If
> you
> > are
> >  using a kernel from Freescale then you need to set console=3DttyS0.
> >
> >  Also what rev of the board do you have?
> >
> >
> >
> >  On 2/23/06, #LI JIANGGAN# <lijianggan@pmail.ntu.edu.sg> wrote:
> >  >
> >  >
> >  > Thank you Jos? Mar?a and Andrey for your advices, however the =
problem
>
> >  > remains. I've tried setting the console (though I remember that =
our
> > previous
> >  > lite5200 board was working fine on kernel 2.4 without setting the
> > console);
> >  > meantime, I've set the booting image to 0x500000; I have also =
tried
> using
> >  > the kernel image come together with the BSP, it's always the same
> error.
> >  >
> >  >  Sylvain, I've actually using your kernel source, the compiled =
image is
> >  > around 700k (compared to the 1.4M image from the BSP), but it =
doesn't
> > solve
> >  > the problem. So I presume that the problem is lying somewhere =
else.
> >  >
> >  >  A SNAPSHOT OF THE BOOTING MESSAGES:
> >  >
> >  >
> >  >  U-Boot 1.1.3 (Feb  6 2006 - 09:56:46)
> >  >
> >  >  CPU:   MPC5200 v2.2 at 462 MHz
> >  >         Bus 132 MHz, IPB 132 MHz, PCI 33 MHz
> >  >  Board: Freescale MPC5200 (Lite5200B)
> >  >  I2C:   85 kHz, ready
> >  >  DRAM:  256 MB
> >  >  FLASH: 32 MB
> >  >  PCI:   Bus Dev VenId DevId Class Int
> >  >          00  1a  1057  5809  0680  00
> >  >  In:    serial
> >  >  Out:   serial
> >  >  Err:   serial
> >  >  Net:   FEC ETHERNET
> >  >  IDE:   Bus 0: OK
> >  >    Device 0: not available
> >  >    Device 1: not available
> >  >
> >  >  Autostarting. Press any key to abort..
> >  >
> >  >  Hit any key to stop autoboot:  0
> >  >  Using FEC ETHERNET device
> >  >  TFTP from server 10.190.3.103; our IP address is 10.190.3.144
> >  >  Filename 'MPC5200/uImage'.
> >  >  Load address: 0x100000
> >  >  Loading:
> >  >
> #################################################################
> >  >
> >  >
> ################################################################
> >  >  done
> >  >  Bytes transferred =3D 658114 (a0ac2 hex)
> >  >  ## Booting image at 00100000 ...
> >  >     Image Name:   Linux-2.6.16-rc1
> >  >     Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> >  >     Data Size:    658050 Bytes =3D 642.6 kB
> >  >     Load Address: 00000000
> >  >     Entry Point:  00000000
> >  >     Verifying Checksum ... OK
> >  >     Uncompressing Kernel Image ... OK
> >  >  id mach(): done
> >  >  MMU:enter
> >  >  MMU:hw init
> >  >  MMU:mapin
> >  >  MMU:setio
> >  >  MMU:exit
> >  >  setup_arch: enter
> >  >  setup_arch: bootmem
> >  >  arch: exit
> >  >
> >  >
> >  >  I am wondering whether it's a kernel problem or more likely to =
be a
> > problem
> >  > lying with the U-boot. It seems to hang when executing =
setup_arch()
> >  > function, or maybe there is sth else behind the wall?
> >  >
> >  >  Regards,
> >  >  Jianggan LI
> >  >
> >  >
> >  >
> >  >
> >  >  -----Original Message-----
> >  >  From: Sylvain Munaut [mailto:tnt@246tNt.com]
> >  >  Sent: Thu 2/23/2006 15:38
> >  >  To: #LI JIANGGAN#
> >  >  Cc: linuxppc-embedded@ozlabs.org
> >  >  Subject: Re: boot failure on lite5200b board
> >  >
> >  >  #LI JIANGGAN# wrote:
> >  >  > Hello all,
> >  >  >
> >  >  > For my end-of-study project, I am working on an embedded =
system with
> >  >  > reference of freescale's lite5200b reference board. I was =
trying to
> > boot
> >  >  > Linux 2.6.15 on the board (with the fec and bestcomm =
corrected).
> > however
> >  >  > the booting was stuck at the following stage:
> >  >
> >  >  In addition to what has already been said (use a higher address =
for
> the
> >  >  image and don't forget console=3DttyPSC0 in kernel command =
line), make
> >  >  sure you use the kernel from my git tree, it contains a few =
patches
> from
> >  >  John Rigby to add support for the lite5200b.
> >  >
> >  >  Please report if it works, I've not been able to test those =
myself
> since
> >  >  i'm still on lite5200.
> >  >
> >  >
> >  >          Sylvain
> >  >
> >  >
> >  >
> >  >
> >  >
> >  >
> >  > _______________________________________________
> >  > Linuxppc-embedded mailing list
> >  > Linuxppc-embedded@ozlabs.org
> >  > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >  >
> >  >
> >
> >
> >
> >
> >
>
>
>



------_=_NextPart_001_01C63E9A.144C9176
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>RE: boot failure on lite5200b board</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Thanks John, the Kernel now boots well. However it =
gives a kernel panic while mounting the root file sysem over NFS:<BR>
<BR>
Looking up port of RPC 100003/2 on 10.190.3.103<BR>
RPC: sendmsg returned error 101<BR>
portmap: RPC call returned error 101<BR>
Root-NFS: Unable to get nfsd port number from server, using default<BR>
<BR>
I couldn't figure out why error 101 /* Network is unreachable */ is =
given. Below is my current U-boot settings and a snapshot of the =
booting:<BR>
<BR>
<BR>
=3D&gt; printenv<BR>
baudrate=3D115200<BR>
autoload=3Dno<BR>
ethact=3DFEC ETHERNET<BR>
ethaddr=3D00:01:9F:00:27:2F<BR>
preboot=3Decho; echo Autostarting. Press any key to abort..; echo<BR>
bootdelay=3D5<BR>
hostname=3Dicecube<BR>
bootfile=3DMPC5200/uImage<BR>
nv=3Dnfsroot root=3D/dev/nfs rw =
nfsroot=3D10.190.3.113:/opt/eldk/rootfs<BR>
netmask=3D255.255.240.0<BR>
ipaddr=3D10.190.3.144<BR>
serverip=3D10.190.3.103<BR>
bootcmd=3Drun net_nfs<BR>
netdev=3Deth0<BR>
rootpath=3D/opt/eldk-4-0/rootfs<BR>
ramargs=3Dsetenv bootargs root=3D/dev/ram rw<BR>
addip=3Dsetenv bootargs =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube:eth0:of=
f panic=3D1<BR>
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube:eth0:of=
f<BR>
net_nfs=3Dtftp 200000 MPC5200/uImage;run nfsargs;bootm<BR>
nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs<BR>
rootfs=3D10.190.3.103:/opt/eldk-4-0/rootfs<BR>
nfsargs=3Dsetenv bootargs console=3DttyS0,115200 =
nfsroot=3D10.190.3.103:/opt/eldk-4-0/nfs root=3D/dev/nfs rw<BR>
stdin=3Dserial<BR>
stdout=3Dserial<BR>
stderr=3Dserial<BR>
<BR>
Environment size: 882/65532 bytes<BR>
=3D&gt; boot<BR>
Using FEC ETHERNET device<BR>
TFTP from server 10.190.3.103; our IP address is 10.190.3.144<BR>
Filename 'MPC5200/uImage'.<BR>
Load address: 0x200000<BR>
Loading: =
#################################################################<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
#################################################################<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
#################################################################<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
#################################################################<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
###################################<BR>
done<BR>
Bytes transferred =3D 1510143 (170aff hex)<BR>
## Booting image at 00200000 ...<BR>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.11.7<BR>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)<BR>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1510079 Bytes =3D&nbsp; 1.4 =
MB<BR>
&nbsp;&nbsp; Load Address: 00000000<BR>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>
&nbsp;&nbsp; Verifying Checksum ... OK<BR>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>
id mach(): done<BR>
MMU:enter<BR>
MMU:hw init<BR>
MMU:mapin<BR>
MMU:setio<BR>
MMU:exit<BR>
setup_arch: enter<BR>
setup_arch: bootmem<BR>
ocp: exit<BR>
arch: exit<BR>
Linux version 2.6.11.7 (root@bob) (gcc version 3.3.2) #1 Tue Sep 6 =
22:40:03 UTC 2005<BR>
Real-Time Preemption Support (c) Ingo Molnar<BR>
Built 1 zonelists<BR>
Kernel command line: console=3DttyS0,115200 =
nfsroot=3D10.190.3.103:/opt/eldk-4-0/nfs root=3D/dev/nfs rw<BR>
PID hash table entries: 2048 (order: 11, 32768 bytes)<BR>
Console: colour dummy device 80x25<BR>
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)<BR>
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)<BR>
Memory: 256268k available (2336k kernel code, 896k data, 140k init, 0k =
highmem)<BR>
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)<BR>
BUG: scheduling while atomic: swapper/0x00000001/0<BR>
caller is schedule+0x50/0xe8<BR>
Call trace:<BR>
&nbsp;[c0006bd8] dump_stack+0x18/0x28<BR>
&nbsp;[c0242818] __sched_text_start+0x69c/0x6a0<BR>
&nbsp;[c024286c] schedule+0x50/0xe8<BR>
&nbsp;[c0003f00] syscall_exit_work+0x108/0x10c<BR>
&nbsp;[c030c578] proc_root_init+0x144/0x150<BR>
&nbsp;[c0320000] 0xc0320000<BR>
&nbsp;[c02fe624] start_kernel+0x180/0x1b8<BR>
&nbsp;[000035fc] 0x35fc<BR>
spawn_desched_task(00000000)<BR>
desched cpu_callback 3/00000000<BR>
ksoftirqd started up.<BR>
softirq RT prio: 24.<BR>
desched cpu_callback 2/00000000<BR>
desched thread 0 started up.<BR>
NET: Registered protocol family 16<BR>
<BR>
PCI: Probing PCI hardware<BR>
SCSI subsystem initialized<BR>
usbcore: registered new driver usbfs<BR>
usbcore: registered new driver hub<BR>
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.<BR>
ppdev: user-space parallel port driver<BR>
Serial: MPC52xx PSC driver<BR>
ttyS0 at MMIO 0xf0002000 (irq =3D 39) is a MPC52xx PSC<BR>
io scheduler noop registered<BR>
io scheduler anticipatory registered<BR>
io scheduler deadline registered<BR>
io scheduler cfq registered<BR>
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 =
blocksize<BR>
loop: loaded (max 8 devices)<BR>
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2<BR>
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx<BR>
ipb=3D132MHz, set clock period to 7<BR>
GPIO config: 91051024<BR>
ATA invalid: 01000000<BR>
ATA hostcnf: 03000000<BR>
ATA pio1&nbsp;&nbsp; : 100a0a00<BR>
ATA pio2&nbsp;&nbsp; : 02040600<BR>
XLB Arb cnf: 0000a366<BR>
mpc52xx_ide: Setting up IDE interface ide0...<BR>
flash chip on the Lite5200/Lite5200B: Found 1 x16 devices at 0x0 in =
8-bit bank<BR>
flash chip on the Lite5200/Lite5200B: Found 1 x16 devices at 0x1000000 =
in 8-bit bank<BR>
&nbsp;Amd/Fujitsu Extended Query Table at 0x0040<BR>
flash chip on the Lite5200/Lite5200B: CFI does not contain boot bank =
location. Assuming top.<BR>
number of CFI chips: 2<BR>
cfi_cmdset_0002: Disabling erase-suspend-program due to code =
brokenness.<BR>
Creating 7 MTD partitions on &quot;flash chip on the =
Lite5200/Lite5200B&quot;:<BR>
0x00000000-0x01000000 : &quot;Filesystem&quot;<BR>
0x01000000-0x01040000 : &quot;BootLOW&quot;<BR>
0x01040000-0x01060000 : &quot;EnvLOW&quot;<BR>
0x01060000-0x01d00000 : &quot;Spare&quot;<BR>
0x01d00000-0x01f00000 : &quot;Kernel&quot;<BR>
0x01f00000-0x01f40000 : &quot;BootHIGH&quot;<BR>
0x01f40000-0x01f60000 : &quot;EnvHIGH&quot;<BR>
ocp-ohci 02: new USB bus registered, assigned bus number 1<BR>
hub 1-0:1.0: USB hub found<BR>
hub 1-0:1.0: 2 ports detected<BR>
Initializing USB Mass Storage driver...<BR>
usbcore: registered new driver usb-storage<BR>
USB Mass Storage support registered.<BR>
usbcore: registered new driver usbhid<BR>
drivers/usb/input/hid-core.c: v2.0:USB HID core driver<BR>
mice: PS/2 mouse device common for all mice<BR>
i2c /dev entries driver<BR>
i2c-algo-52xx.o: scanning bus Lite5200 I2C module #1 interface...<BR>
.........................................................................=
.......................................................<BR>
i2c-lite5200.o: I2C module #1 installed<BR>
i2c-algo-52xx.o: scanning bus Lite5200 I2C module #2 interface...<BR>
.........................................................................=
.......(0x50)..............................................(0x7f)<BR>
i2c-lite5200.o: I2C module #2 installed<BR>
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13 =
09:39:32 2005 UTC).<BR>
ALSA device list:<BR>
&nbsp; No soundcards found.<BR>
NET: Registered protocol family 2<BR>
IP: routing cache hash table of 256 buckets, 16Kbytes<BR>
TCP established hash table entries: 16384 (order: 8, 1048576 bytes)<BR>
TCP bind hash table entries: 16384 (order: 7, 917504 bytes)<BR>
TCP: Hash tables configured (established 16384 bind 16384)<BR>
NET: Registered protocol family 1<BR>
NET: Registered protocol family 17<BR>
Looking up port of RPC 100003/2 on 10.190.3.103<BR>
RPC: sendmsg returned error 101<BR>
portmap: RPC call returned error 101<BR>
Root-NFS: Unable to get nfsd port number from server, using default<BR>
Looking up port of RPC 100005/1 on 10.190.3.103<BR>
RPC: sendmsg returned error 101<BR>
portmap: RPC call returned error 101<BR>
Root-NFS: Unable to get mountd port number from server, using =
default<BR>
RPC: sendmsg returned error 101<BR>
mount: RPC call returned error 101<BR>
Root-NFS: Server returned error -101 while mounting =
/opt/eldk-4-0/nfs<BR>
VFS: Unable to mount root fs via NFS, trying floppy.<BR>
VFS: Cannot open root device &quot;nfs&quot; or unknown-block(2,0)<BR>
Please append a correct &quot;root=3D&quot; boot option<BR>
Kernel panic - not syncing: VFS: Unable to mount root fs on =
unknown-block(2,0)<BR>
&nbsp;&lt;0&gt;Rebooting in 180 =
seconds..&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
<BR>
<BR>
<BR>
regards,<BR>
Jianggan<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: John Rigby [<A =
HREF=3D"mailto:jcrigby@gmail.com">mailto:jcrigby@gmail.com</A>]<BR>
Sent: Thu 3/2/2006 8:52<BR>
To: #LI JIANGGAN#<BR>
Cc: linuxppc-embedded@ozlabs.org<BR>
Subject: Re: boot failure on lite5200b board<BR>
<BR>
Here is a uboot setup that works with a freescale kernel:<BR>
bootdelay=3D5<BR>
baudrate=3D115200<BR>
preboot=3Decho;echo Type &quot;run flash_nfs&quot; to mount root =
filesystem over NFS;echo<BR>
autoload=3Dno<BR>
ethact=3DFEC ETHERNET<BR>
ramargs=3Dsetenv bootargs root=3D/dev/ram rw<BR>
jffs2args=3Dsetenv bootargs root=3D/dev/mtdblock0 rw =
rootfstype=3Djffs2<BR>
addip=3Dsetenv bootargs $(bootargs)<BR>
ip=3D$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname):$(netdev):=
off<BR>
panic=3D1<BR>
flash_nfs=3Drun nfsargs addip;bootm $(kernel_addr)<BR>
flash_self=3Drun ramargs addip;bootm $(kernel_addr) $(ramdisk_addr)<BR>
flash_jffs2=3Drun jffs2args;bootm $(kernel_addr)<BR>
net_nfs=3Dtftp 200000 $(bootfile);run nfsargs addip;bootm<BR>
netdev=3Deth0<BR>
ethaddr=3D00:04:9f:22:33:44<BR>
bootfile=3D/tftpboot/uImage<BR>
kernel_addr=3Dffd00000<BR>
rootpath=3D/tftpboot/ltib<BR>
filesize=3Dc9d700<BR>
fileaddr=3D1000000<BR>
gatewayip=3D172.27.255.254<BR>
netmask=3D255.255.0.0<BR>
ipaddr=3D172.27.152.99<BR>
serverip=3D172.27.152.5<BR>
bootcmd=3Drun net_nfs<BR>
nfsargs=3Dsetenv bootargs console=3DttyS0,115200 root=3D/dev/nfs rw<BR>
nfsroot=3D$(serverip):$(rootpath)<BR>
stdin=3Dserial<BR>
stdout=3Dserial<BR>
stderr=3Dserial<BR>
<BR>
Change ip info, bootfile, rootpath etc to fit you config.<BR>
If you want it to work with Sylvain's kernel then you need to change<BR>
ttyS0 to ttyPSC0.<BR>
<BR>
Also add a printenv just before the bootm so you can verify that =
your<BR>
bootargs really are getting set correctly.<BR>
<BR>
On 3/1/06, #LI JIANGGAN# &lt;lijianggan@pmail.ntu.edu.sg&gt; wrote:<BR>
&gt;<BR>
&gt;<BR>
&gt; how about the following U-boot settings:<BR>
&gt;<BR>
&gt; ..............................<BR>
&gt;<BR>
&gt;<BR>
&gt; Hit any key to stop autoboot:&nbsp; 0<BR>
&gt; =3D&gt; printenv<BR>
&gt; baudrate=3D115200<BR>
&gt; autoload=3Dno<BR>
&gt; ethact=3DFEC ETHERNET<BR>
&gt; ethaddr=3D00:01:9F:00:27:2F<BR>
&gt; preboot=3Decho; echo Autostarting. Press any key to abort..; =
echo<BR>
&gt; bootdelay=3D5<BR>
&gt; hostname=3Dicecube<BR>
&gt; bootfile=3DMPC5200/uImage<BR>
&gt; nv=3Dnfsroot root=3D/dev/nfs rw =
nfsroot=3D10.190.3.113:/opt/eldk/rootfs<BR>
&gt; netmask=3D255.255.240.0<BR>
&gt; ipaddr=3D10.190.3.144<BR>
&gt; serverip=3D10.190.3.103<BR>
&gt; bootcmd=3Drun net_nfs<BR>
&gt;<BR>
&gt; rootfs=3Droot=3D/dev/nfs rw<BR>
&gt; netdev=3Deth0<BR>
&gt; rootpath=3D/opt/eldk-4-0/rootfs<BR>
&gt; nfsargs=3Dsetenv bootargs root=3D/dev/nfs rw<BR>
&gt; nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs<BR>
&gt;<BR>
&gt; ramargs=3Dsetenv bootargs root=3D/dev/ram rw<BR>
&gt; addip=3Dsetenv bootargs<BR>
&gt; =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube:eth0:of=
f<BR>
&gt; panic=3D1<BR>
&gt; net_nfs=3Dtftp 200000 MPC5200/uImage;run nfsargs addip;bootm<BR>
&gt;<BR>
&gt; stdin=3Dserial<BR>
&gt; stdout=3Dserial<BR>
&gt; stderr=3Dserial<BR>
&gt;<BR>
&gt; Environment size: 738/65532 bytes<BR>
&gt; =
=3D&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .<BR>
&gt; ................................<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; The output is still the same, it hangs after displaying =
arch:exit<BR>
&gt;<BR>
&gt; I have also tried the above settings with console set, it gives the =
same<BR>
&gt; output<BR>
&gt;<BR>
&gt; I am really wondering whether the problem is with the kernel. =
Sylvain's<BR>
&gt; kernel uImage is only around 600k while the one from freescale is =
1.4M,<BR>
&gt; anybody knows where the difference is?<BR>
&gt;<BR>
&gt; .....................................<BR>
&gt;<BR>
&gt; Autostarting. Press any key to abort..<BR>
&gt;<BR>
&gt; Hit any key to stop autoboot:&nbsp; 0<BR>
&gt; Using FEC ETHERNET device<BR>
&gt; TFTP from server 10.190.3.103; our IP address is 10.190.3.144<BR>
&gt; Filename 'MPC5200/uImage'.<BR>
&gt; Load address: 0x200000<BR>
&gt;<BR>
&gt; Loading:<BR>
&gt; =
#################################################################<BR>
&gt;<BR>
&gt; =
#################################################################<BR>
&gt;<BR>
&gt; =
#################################################################<BR>
&gt;<BR>
&gt; =
#################################################################<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
###################################<BR>
&gt; done<BR>
&gt; Bytes transferred =3D 1510143 (170aff hex)<BR>
&gt; ## Booting image at 00200000 ...<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.11.7<BR>
&gt;&nbsp;&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel =
Image (gzip compressed)<BR>
&gt;&nbsp;&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1510079 Bytes =
=3D&nbsp; 1.4 MB<BR>
&gt;&nbsp;&nbsp;&nbsp; Load Address: 00000000<BR>
&gt;&nbsp;&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>
&gt;&nbsp;&nbsp;&nbsp; Verifying Checksum ... OK<BR>
&gt;&nbsp;&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>
&gt; id mach(): done<BR>
&gt; MMU:enter<BR>
&gt; MMU:hw init<BR>
&gt; MMU:mapin<BR>
&gt; MMU:setio<BR>
&gt; MMU:exit<BR>
&gt; setup_arch: enter<BR>
&gt; setup_arch: bootmem<BR>
&gt; ocp: exit<BR>
&gt; arch: exit<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; .....................<BR>
&gt;<BR>
&gt; Regards,<BR>
&gt;<BR>
&gt; Jianggan LI<BR>
&gt;<BR>
&gt;&nbsp; ________________________________<BR>
&gt;<BR>
&gt; From: John Rigby [<A =
HREF=3D"mailto:jcrigby@gmail.com">mailto:jcrigby@gmail.com</A>]<BR>
&gt; Sent: Sat 2/25/2006 1:17<BR>
&gt; To: #LI JIANGGAN#<BR>
&gt; Cc: tnt@246tnt.com; linuxppc-embedded@ozlabs.org<BR>
&gt;<BR>
&gt; Subject: Re: boot failure on lite5200b board<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; I don't think your syntax for appending to an env variable is =
correct:<BR>
&gt;<BR>
&gt; try:<BR>
&gt; set bootargs $(bootargs) ...appended stuff...<BR>
&gt; instead of:<BR>
&gt; set bootargs env bootargs ...appended stuff....<BR>
&gt;<BR>
&gt; Also to see what bootargs is actually set to after all the =
nested<BR>
&gt; commands, add a printenv just before the bootm<BR>
&gt;<BR>
&gt; On 2/23/06, #LI JIANGGAN# &lt;lijianggan@pmail.ntu.edu.sg&gt; =
wrote:<BR>
&gt; &gt;<BR>
&gt; &gt;<BR>
&gt; &gt; I have actually tried both kernel with both console =
configurations. It<BR>
&gt; gave<BR>
&gt; &gt; the same output, thus I presume that the problem lies =
somewhere else. I<BR>
&gt; &gt; attached the log to this email.<BR>
&gt; &gt;<BR>
&gt; &gt;&nbsp; the board is Lite5200B Version 1.0. Which .config file =
do you want?<BR>
&gt; &gt;<BR>
&gt; &gt;&nbsp; Sylvain, we have ordered a debugging set but we are =
still waiting for<BR>
&gt; &gt; delivery, the leaking time is said to be one month, tant pis. =
And the log<BR>
&gt; I<BR>
&gt; &gt; attached here are booting from a higher address =
(0x500000).<BR>
&gt; &gt;<BR>
&gt; &gt;&nbsp; My current u-boot args:<BR>
&gt; &gt;&nbsp; Autostarting. Press any key to abort..<BR>
&gt; &gt;<BR>
&gt; &gt;&nbsp; Hit any key to stop autoboot:&nbsp; 0<BR>
&gt; &gt;&nbsp; =3D&gt; printenv<BR>
&gt; &gt;&nbsp; baudrate=3D115200<BR>
&gt; &gt;&nbsp; autoload=3Dno<BR>
&gt; &gt;&nbsp; ethact=3DFEC ETHERNET<BR>
&gt; &gt;&nbsp; flshroot=3Droot=3D/dev/mtdblock2 rw<BR>
&gt; &gt;&nbsp; ethaddr=3D00:01:9F:00:27:2F<BR>
&gt; &gt;&nbsp; preboot=3Decho; echo Autostarting. Press any key to =
abort..; echo<BR>
&gt; &gt;&nbsp; bootdelay=3D5<BR>
&gt; &gt;&nbsp; hostname=3Dicecube<BR>
&gt; &gt;&nbsp; bootfile=3DMPC5200/uImage<BR>
&gt; &gt;&nbsp; nv=3Dnfsroot root=3D/dev/nfs rw =
nfsroot=3D10.190.3.113:/opt/eldk/rootfs<BR>
&gt; &gt;&nbsp; =
ip=3Dip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::o=
ff<BR>
&gt; &gt;&nbsp; nfsroot=3Droot=3D/dev/nfs rw<BR>
&gt; nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs<BR>
&gt; &gt;&nbsp; bootcmd=3Drun net_nfs<BR>
&gt; &gt;&nbsp; filesize=3D546<BR>
&gt; &gt;&nbsp; fileaddr=3D500000<BR>
&gt; &gt;&nbsp; netmask=3D255.255.240.0<BR>
&gt; &gt;&nbsp; ipaddr=3D10.190.3.144<BR>
&gt; &gt;&nbsp; serverip=3D10.190.3.103<BR>
&gt; &gt;&nbsp; setconsole=3Dsetenv bootargs console=3DttyPSC0, 115200n8 =
console=3Dtty1<BR>
&gt; &gt;&nbsp; rootfs=3Droot=3D/dev/nfs rw<BR>
&gt; nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs<BR>
&gt; &gt;&nbsp; bootargs=3Denv bootargs root=3D/dev/nfs rw<BR>
&gt; &gt; nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs<BR>
&gt; &gt; =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::off<BR=
>
&gt; &gt;&nbsp; flash_nfs=3Drun setconsole nfsargs addip;bootm<BR>
&gt; &gt;&nbsp; net_nfs=3Dtftp 500000 MPC5200/uImage;run setconsole =
nfsargs addip;bootm<BR>
&gt; &gt;&nbsp; nfsargs=3Dsetenv bootargs env bootargs root=3D/dev/nfs =
rw<BR>
&gt; &gt; nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs<BR>
&gt; &gt;<BR>
&gt; =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::offroo=
t=3D/dev/nfs<BR>
&gt; &gt; rw<BR>
&gt; &gt;&nbsp; addip=3Dsetenv bootargs env bootargs root=3D/dev/nfs =
rw<BR>
&gt; &gt; nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs<BR>
&gt; &gt; =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::off<BR=
>
&gt; &gt;&nbsp; ramargs=3Dsetenv bootargs root=3D/dev/ram rw<BR>
&gt; &gt;&nbsp; console=3Dconsole=3DttyS0,115200n8 console=3Dtty1<BR>
&gt; &gt;&nbsp; stdin=3Dserial<BR>
&gt; &gt;&nbsp; stdout=3Dserial<BR>
&gt; &gt;&nbsp; stderr=3Dserial<BR>
&gt; &gt;<BR>
&gt; &gt;&nbsp; Environment size: 1472/65532 bytes<BR>
&gt; &gt;&nbsp; =3D&gt;<BR>
&gt; &gt;<BR>
&gt; &gt;<BR>
&gt; &gt;<BR>
&gt; &gt;<BR>
&gt; &gt;&nbsp; USING Sylvain's KERNEL:<BR>
&gt; &gt;<BR>
&gt; &gt;&nbsp; U-Boot 1.1.3 (Feb&nbsp; 6 2006 - 09:56:46)<BR>
&gt; &gt;<BR>
&gt; &gt;&nbsp; CPU:&nbsp;&nbsp; MPC5200 v2.2 at 462 MHz<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus 132 MHz, =
IPB 132 MHz, PCI 33 MHz<BR>
&gt; &gt;&nbsp; Board: Freescale MPC5200 (Lite5200B)<BR>
&gt; &gt;&nbsp; I2C:&nbsp;&nbsp; 85 kHz, ready<BR>
&gt; &gt;&nbsp; DRAM:&nbsp; 256 MB<BR>
&gt; &gt;&nbsp; FLASH: 32 MB<BR>
&gt; &gt;&nbsp; PCI:&nbsp;&nbsp; Bus Dev VenId DevId Class Int<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00&nbsp; =
1a&nbsp; 1057&nbsp; 5809&nbsp; 0680&nbsp; 00<BR>
&gt; &gt;&nbsp; In:&nbsp;&nbsp;&nbsp; serial<BR>
&gt; &gt;&nbsp; Out:&nbsp;&nbsp; serial<BR>
&gt; &gt;&nbsp; Err:&nbsp;&nbsp; serial<BR>
&gt; &gt;&nbsp; Net:&nbsp;&nbsp; FEC ETHERNET<BR>
&gt; &gt;&nbsp; IDE:&nbsp;&nbsp; Bus 0: OK<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp; Device 0: not available<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp; Device 1: not available<BR>
&gt; &gt;<BR>
&gt; &gt;&nbsp; Autostarting. Press any key to abort..<BR>
&gt; &gt;<BR>
&gt; &gt;&nbsp; Hit any key to stop autoboot:&nbsp; 0<BR>
&gt; &gt;&nbsp; Using FEC ETHERNET device<BR>
&gt; &gt;&nbsp; TFTP from server 10.190.3.103; our IP address is =
10.190.3.144<BR>
&gt; &gt;&nbsp; Filename 'MPC5200/uImage'.<BR>
&gt; &gt;&nbsp; Load address: 0x500000<BR>
&gt; &gt;&nbsp; Loading:<BR>
&gt; =
#################################################################<BR>
&gt; &gt;<BR>
&gt; =
################################################################<BR>
&gt; &gt;&nbsp; done<BR>
&gt; &gt;&nbsp; Bytes transferred =3D 658114 (a0ac2 hex)<BR>
&gt; &gt;&nbsp; ## Booting image at 00500000 ...<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Image Name:&nbsp;&nbsp; =
Linux-2.6.16-rc1<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux =
Kernel Image (gzip compressed)<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 658050 =
Bytes =3D 642.6 kB<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Load Address: 00000000<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Verifying Checksum ... OK<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>
&gt; &gt;&nbsp; id mach(): done<BR>
&gt; &gt;&nbsp; MMU:enter<BR>
&gt; &gt;&nbsp; MMU:hw init<BR>
&gt; &gt;&nbsp; MMU:mapin<BR>
&gt; &gt;&nbsp; MMU:setio<BR>
&gt; &gt;&nbsp; MMU:exit<BR>
&gt; &gt;&nbsp; setup_arch: enter<BR>
&gt; &gt;&nbsp; setup_arch: bootmem<BR>
&gt; &gt;&nbsp; arch: exit<BR>
&gt; &gt;<BR>
&gt; &gt;<BR>
&gt; &gt;<BR>
&gt; &gt;&nbsp; USING KERNEL FROM Freescale:<BR>
&gt; &gt;<BR>
&gt; &gt;&nbsp; U-Boot 1.1.3 (Feb&nbsp; 6 2006 - 09:56:46)<BR>
&gt; &gt;<BR>
&gt; &gt;&nbsp; CPU:&nbsp;&nbsp; MPC5200 v2.2 at 462 MHz<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus 132 MHz, =
IPB 132 MHz, PCI 33 MHz<BR>
&gt; &gt;&nbsp; Board: Freescale MPC5200 (Lite5200B)<BR>
&gt; &gt;&nbsp; I2C:&nbsp;&nbsp; 85 kHz, ready<BR>
&gt; &gt;&nbsp; DRAM:&nbsp; 256 MB<BR>
&gt; &gt;&nbsp; FLASH: 32 MB<BR>
&gt; &gt;&nbsp; PCI:&nbsp;&nbsp; Bus Dev VenId DevId Class Int<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00&nbsp; =
1a&nbsp; 1057&nbsp; 5809&nbsp; 0680&nbsp; 00<BR>
&gt; &gt;&nbsp; In:&nbsp;&nbsp;&nbsp; serial<BR>
&gt; &gt;&nbsp; Out:&nbsp;&nbsp; serial<BR>
&gt; &gt;&nbsp; Err:&nbsp;&nbsp; serial<BR>
&gt; &gt;&nbsp; Net:&nbsp;&nbsp; FEC ETHERNET<BR>
&gt; &gt;&nbsp; IDE:&nbsp;&nbsp; Bus 0: OK<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp; Device 0: not available<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp; Device 1: not available<BR>
&gt; &gt;<BR>
&gt; &gt;&nbsp; Autostarting. Press any key to abort..<BR>
&gt; &gt;<BR>
&gt; &gt;&nbsp; Hit any key to stop autoboot:&nbsp; 0<BR>
&gt; &gt;&nbsp; Using FEC ETHERNET device<BR>
&gt; &gt;&nbsp; TFTP from server 10.190.3.103; our IP address is =
10.190.3.144<BR>
&gt; &gt;&nbsp; Filename 'MPC5200/uImage'.<BR>
&gt; &gt;&nbsp; Load address: 0x500000<BR>
&gt; &gt;&nbsp; Loading:<BR>
&gt; =
#################################################################<BR>
&gt; &gt;<BR>
&gt; =
#################################################################<BR>
&gt; &gt;<BR>
&gt; =
#################################################################<BR>
&gt; &gt;<BR>
&gt; =
#################################################################<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
###################################<BR>
&gt; &gt;&nbsp; done<BR>
&gt; &gt;&nbsp; Bytes transferred =3D 1510143 (170aff hex)<BR>
&gt; &gt;&nbsp; ## Booting image at 00500000 ...<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Image Name:&nbsp;&nbsp; =
Linux-2.6.11.7<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux =
Kernel Image (gzip compressed)<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1510079 =
Bytes =3D&nbsp; 1.4 MB<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Load Address: 00000000<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Verifying Checksum ... OK<BR>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>
&gt; &gt;&nbsp; id mach(): done<BR>
&gt; &gt;&nbsp; MMU:enter<BR>
&gt; &gt;&nbsp; MMU:hw init<BR>
&gt; &gt;&nbsp; MMU:mapin<BR>
&gt; &gt;&nbsp; MMU:setio<BR>
&gt; &gt;&nbsp; MMU:exit<BR>
&gt; &gt;&nbsp; setup_arch: enter<BR>
&gt; &gt;&nbsp; setup_arch: bootmem<BR>
&gt; &gt;&nbsp; ocp: exit<BR>
&gt; &gt;&nbsp; arch: exit<BR>
&gt; &gt;<BR>
&gt; &gt;<BR>
&gt; &gt;<BR>
&gt; &gt;<BR>
&gt; &gt;&nbsp; -----Original Message-----<BR>
&gt; &gt;&nbsp; From: John Rigby [<A =
HREF=3D"mailto:jcrigby@gmail.com">mailto:jcrigby@gmail.com</A>]<BR>
&gt; &gt;&nbsp; Sent: Fri 2/24/2006 0:18<BR>
&gt; &gt;&nbsp; To: #LI JIANGGAN#<BR>
&gt; &gt;&nbsp; Subject: Re: boot failure on lite5200b board<BR>
&gt; &gt;<BR>
&gt; &gt;&nbsp; If you are using Sylvain's kernel you need to set =
console=3DttyPSC0.&nbsp; If<BR>
&gt; you<BR>
&gt; &gt; are<BR>
&gt; &gt;&nbsp; using a kernel from Freescale then you need to set =
console=3DttyS0.<BR>
&gt; &gt;<BR>
&gt; &gt;&nbsp; Also what rev of the board do you have?<BR>
&gt; &gt;<BR>
&gt; &gt;<BR>
&gt; &gt;<BR>
&gt; &gt;&nbsp; On 2/23/06, #LI JIANGGAN# =
&lt;lijianggan@pmail.ntu.edu.sg&gt; wrote:<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt; Thank you Jos? Mar?a and Andrey for your advices, =
however the problem<BR>
&gt;<BR>
&gt; &gt;&nbsp; &gt; remains. I've tried setting the console (though I =
remember that our<BR>
&gt; &gt; previous<BR>
&gt; &gt;&nbsp; &gt; lite5200 board was working fine on kernel 2.4 =
without setting the<BR>
&gt; &gt; console);<BR>
&gt; &gt;&nbsp; &gt; meantime, I've set the booting image to 0x500000; I =
have also tried<BR>
&gt; using<BR>
&gt; &gt;&nbsp; &gt; the kernel image come together with the BSP, it's =
always the same<BR>
&gt; error.<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;&nbsp; Sylvain, I've actually using your kernel =
source, the compiled image is<BR>
&gt; &gt;&nbsp; &gt; around 700k (compared to the 1.4M image from the =
BSP), but it doesn't<BR>
&gt; &gt; solve<BR>
&gt; &gt;&nbsp; &gt; the problem. So I presume that the problem is lying =
somewhere else.<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;&nbsp; A SNAPSHOT OF THE BOOTING MESSAGES:<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;&nbsp; U-Boot 1.1.3 (Feb&nbsp; 6 2006 - =
09:56:46)<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;&nbsp; CPU:&nbsp;&nbsp; MPC5200 v2.2 at 462 MHz<BR>
&gt; &gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus =
132 MHz, IPB 132 MHz, PCI 33 MHz<BR>
&gt; &gt;&nbsp; &gt;&nbsp; Board: Freescale MPC5200 (Lite5200B)<BR>
&gt; &gt;&nbsp; &gt;&nbsp; I2C:&nbsp;&nbsp; 85 kHz, ready<BR>
&gt; &gt;&nbsp; &gt;&nbsp; DRAM:&nbsp; 256 MB<BR>
&gt; &gt;&nbsp; &gt;&nbsp; FLASH: 32 MB<BR>
&gt; &gt;&nbsp; &gt;&nbsp; PCI:&nbsp;&nbsp; Bus Dev VenId DevId Class =
Int<BR>
&gt; &gt;&nbsp; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00&nbsp; =
1a&nbsp; 1057&nbsp; 5809&nbsp; 0680&nbsp; 00<BR>
&gt; &gt;&nbsp; &gt;&nbsp; In:&nbsp;&nbsp;&nbsp; serial<BR>
&gt; &gt;&nbsp; &gt;&nbsp; Out:&nbsp;&nbsp; serial<BR>
&gt; &gt;&nbsp; &gt;&nbsp; Err:&nbsp;&nbsp; serial<BR>
&gt; &gt;&nbsp; &gt;&nbsp; Net:&nbsp;&nbsp; FEC ETHERNET<BR>
&gt; &gt;&nbsp; &gt;&nbsp; IDE:&nbsp;&nbsp; Bus 0: OK<BR>
&gt; &gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp; Device 0: not available<BR>
&gt; &gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp; Device 1: not available<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;&nbsp; Autostarting. Press any key to abort..<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;&nbsp; Hit any key to stop autoboot:&nbsp; 0<BR>
&gt; &gt;&nbsp; &gt;&nbsp; Using FEC ETHERNET device<BR>
&gt; &gt;&nbsp; &gt;&nbsp; TFTP from server 10.190.3.103; our IP address =
is 10.190.3.144<BR>
&gt; &gt;&nbsp; &gt;&nbsp; Filename 'MPC5200/uImage'.<BR>
&gt; &gt;&nbsp; &gt;&nbsp; Load address: 0x100000<BR>
&gt; &gt;&nbsp; &gt;&nbsp; Loading:<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; =
#################################################################<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; =
################################################################<BR>
&gt; &gt;&nbsp; &gt;&nbsp; done<BR>
&gt; &gt;&nbsp; &gt;&nbsp; Bytes transferred =3D 658114 (a0ac2 hex)<BR>
&gt; &gt;&nbsp; &gt;&nbsp; ## Booting image at 00100000 ...<BR>
&gt; &gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Image Name:&nbsp;&nbsp; =
Linux-2.6.16-rc1<BR>
&gt; &gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Image Type:&nbsp;&nbsp; =
PowerPC Linux Kernel Image (gzip compressed)<BR>
&gt; &gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Data =
Size:&nbsp;&nbsp;&nbsp; 658050 Bytes =3D 642.6 kB<BR>
&gt; &gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Load Address: 00000000<BR>
&gt; &gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Entry Point:&nbsp; =
00000000<BR>
&gt; &gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Verifying Checksum ... =
OK<BR>
&gt; &gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Uncompressing Kernel Image =
... OK<BR>
&gt; &gt;&nbsp; &gt;&nbsp; id mach(): done<BR>
&gt; &gt;&nbsp; &gt;&nbsp; MMU:enter<BR>
&gt; &gt;&nbsp; &gt;&nbsp; MMU:hw init<BR>
&gt; &gt;&nbsp; &gt;&nbsp; MMU:mapin<BR>
&gt; &gt;&nbsp; &gt;&nbsp; MMU:setio<BR>
&gt; &gt;&nbsp; &gt;&nbsp; MMU:exit<BR>
&gt; &gt;&nbsp; &gt;&nbsp; setup_arch: enter<BR>
&gt; &gt;&nbsp; &gt;&nbsp; setup_arch: bootmem<BR>
&gt; &gt;&nbsp; &gt;&nbsp; arch: exit<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;&nbsp; I am wondering whether it's a kernel problem =
or more likely to be a<BR>
&gt; &gt; problem<BR>
&gt; &gt;&nbsp; &gt; lying with the U-boot. It seems to hang when =
executing setup_arch()<BR>
&gt; &gt;&nbsp; &gt; function, or maybe there is sth else behind the =
wall?<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;&nbsp; Regards,<BR>
&gt; &gt;&nbsp; &gt;&nbsp; Jianggan LI<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;&nbsp; -----Original Message-----<BR>
&gt; &gt;&nbsp; &gt;&nbsp; From: Sylvain Munaut [<A =
HREF=3D"mailto:tnt@246tNt.com">mailto:tnt@246tNt.com</A>]<BR>
&gt; &gt;&nbsp; &gt;&nbsp; Sent: Thu 2/23/2006 15:38<BR>
&gt; &gt;&nbsp; &gt;&nbsp; To: #LI JIANGGAN#<BR>
&gt; &gt;&nbsp; &gt;&nbsp; Cc: linuxppc-embedded@ozlabs.org<BR>
&gt; &gt;&nbsp; &gt;&nbsp; Subject: Re: boot failure on lite5200b =
board<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;&nbsp; #LI JIANGGAN# wrote:<BR>
&gt; &gt;&nbsp; &gt;&nbsp; &gt; Hello all,<BR>
&gt; &gt;&nbsp; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;&nbsp; &gt; For my end-of-study project, I am =
working on an embedded system with<BR>
&gt; &gt;&nbsp; &gt;&nbsp; &gt; reference of freescale's lite5200b =
reference board. I was trying to<BR>
&gt; &gt; boot<BR>
&gt; &gt;&nbsp; &gt;&nbsp; &gt; Linux 2.6.15 on the board (with the fec =
and bestcomm corrected).<BR>
&gt; &gt; however<BR>
&gt; &gt;&nbsp; &gt;&nbsp; &gt; the booting was stuck at the following =
stage:<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;&nbsp; In addition to what has already been said =
(use a higher address for<BR>
&gt; the<BR>
&gt; &gt;&nbsp; &gt;&nbsp; image and don't forget console=3DttyPSC0 in =
kernel command line), make<BR>
&gt; &gt;&nbsp; &gt;&nbsp; sure you use the kernel from my git tree, it =
contains a few patches<BR>
&gt; from<BR>
&gt; &gt;&nbsp; &gt;&nbsp; John Rigby to add support for the =
lite5200b.<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;&nbsp; Please report if it works, I've not been able =
to test those myself<BR>
&gt; since<BR>
&gt; &gt;&nbsp; &gt;&nbsp; i'm still on lite5200.<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sylvain<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt; _______________________________________________<BR>
&gt; &gt;&nbsp; &gt; Linuxppc-embedded mailing list<BR>
&gt; &gt;&nbsp; &gt; Linuxppc-embedded@ozlabs.org<BR>
&gt; &gt;&nbsp; &gt; <A =
HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://oz=
labs.org/mailman/listinfo/linuxppc-embedded</A><BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;&nbsp; &gt;<BR>
&gt; &gt;<BR>
&gt; &gt;<BR>
&gt; &gt;<BR>
&gt; &gt;<BR>
&gt; &gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C63E9A.144C9176--
