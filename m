Return-Path: <dwilson@dslextreme.com>
Received: from mail9.dslextreme.com (mail9.dslextreme.com [66.51.199.94])
	by ozlabs.org (Postfix) with SMTP id 1224FDDED2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Jan 2007 16:08:48 +1100 (EST)
Message-ID: <200701162102050578.1213ACC0@smtp.dslextreme.com>
Date: Tue, 16 Jan 2007 21:02:05 -0800
From: "Dan Wilson" <dwilson@dslextreme.com>
To: linuxppc-embedded@ozlabs.org
Subject: ram-disk root file system
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We are attempting to use an initrd ram-disk as the permanent root file=
 system for a MPC8541-based system.

We are using ELDK 4 to cross-compile, and are running linux 2.6.15 kernel,=
 with u-boot 1.1.6 as our bootloader.

I built an initrd file system, compressed it, then ran mkimage against it,=
 and it seems to be successfully loaded by u-boot, and linux sees the=
 initrd file and claims to have mounted it.  However, it then reports that=
 it is unable to find any files on the mounted root file system, as shown=
 in the log below.  I added some additional diagnostics to show what the=
 error codes were, and what was happening, but do not understand what I=
 might have done wrong.  If I boot linux from an NFS system or from compact=
 flash, I am able to mount the image and see all the files, so I believe=
 the initrd file system was created correctly.

Here's the trace.  Any help or pointers that anyone can give will be=
 greatly appreciated!

Thanks,
Dan.

Speed: 100, half duplex
Using TSEC0 device
TFTP from server 10.0.80.16; our IP address is 10.0.55.91
Filename 'dw_eldk'.
Load address: 0x4000000
Loading: #################################################################
          #################################################################
          #################################################################
          ###############################
done
Bytes transferred =3D 1154111 (119c3f hex)
Speed: 100, half duplex
Using TSEC0 device
TFTP from server 10.0.80.16; our IP address is 10.0.55.91
Filename 'fm2224ep_initrd.uboot'.
Load address: 0x4200000
Loading: #################################################################
          #################################################################
          #################################################################
          #################################################################
          #################################################################
          #################################################################
          #################################################################
          #################################################################
          #################################################################
          #################################################################
          #################################################################
          #################################################################
          #################################################################
          #################################################################
          #################################################################
          #################################################################
          #################################################################
          ####################################
done
Bytes transferred =3D 5840574 (591ebe hex)
## Booting image at 04000000 ...
    Image Name:   Linux-2.6.15
    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
    Data Size:    1154047 Bytes =3D  1.1 MB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
    Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 04200000 ...
    Image Name:   FM2224EP Ramdisk Image
    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
    Data Size:    5840510 Bytes =3D  5.6 MB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
    Loading Ramdisk to 1f92c000, end 1febde7e ... OK
Memory CAM mapping: CAM0=3D256Mb, CAM1=3D256Mb, CAM2=3D0Mb residual: 0Mb
Linux version 2.6.15 (dwilson@washington) (gcc version 4.0.0 (DENX ELDK 
4.0 4.0.0)) #6 Tue Jan 16 15:00:18 PST 2007
fm2224ep_setup_arch
CDS Version =3D f0 in PCI slot 1
Built 1 zonelists
Kernel command line: root=3D/dev/ram 
ip=3D10.0.55.91:10.0.80.21:10.0.0.254:255.255.0.0:FM2224EP_67:eth0 
console=3DttyS0,9600 
nfsroot=3D10.0.80.21:/vol/local/common/kirkwood/hosts/eldk-test,v3,tcp rw 
init=3D/bin/ash
OpenPIC Version 1.2 (1 CPUs and 60 IRQ sources) at fcfb8000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Warning: real time clock seems stuck!
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 510976k available (1880k kernel code, 512k data, 136k init, 0k 
highmem)
Mount-cache hash table entries: 512
populate_roots calling unpack_to_roots: start =3D c0257000, end=3Dc0257085,=
 
len=3D85
checking if image is initramfs...<3>image check, start=3Ddf92c000, 
end=3Ddfebde7e, err=3Dc01dae84
it isn't (no cpio magic); looks like an initrd
wasn't initramfs (no cpio magic), opening /initrd.image, fd=3D0
Freeing initrd memory: 5703k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
Generic PHY: Registered new driver
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: #1 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq =3D 90) is a 16550A
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq =3D 90) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: loaded (max 8 devices)
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2, 00:15:ed:00:09:41
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2, 07:de:29:00:07:de
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
Marvell 88E1101: Registered new driver
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with=
 idebus=3Dxx
IDE phys mem : f0000000...f001ffff (size 0001ffff)
IDE virt base: 0xe1080000
CSR virt base: 0xe1100000
vector: 0x80c40072
port: 0xe1080002 =3D> 0x00
port: 0xe1080007 =3D> 0x00
port: 0xe108000b =3D> 0x00
port: 0xe108000f =3D> 0x00
port: 0xe1080013 =3D> 0x00
port: 0xe1080017 =3D> 0x00
port: 0xe108001b =3D> 0xE0
port: 0xe108001f =3D> 0x50
port: 0xe109001b =3D> 0x50
port: 0xe1080000 =3D> 0xF0
hda: SanDisk SDCFB-1024, CFA DISK drive
ide0 at 0xe1080002-0xe1080009,0xe109001b on irq 114
hda: max request size: 128KiB
hda: 2001888 sectors (1024 MB) w/1KiB Cache, CHS=3D1986/16/63
hda: cache flushes not supported
  hda: unknown partition table
i2c /dev entries driver
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
IP-Config: Complete:
       device=3Deth0, addr=3D10.0.55.91, mask=3D255.255.0.0,=
 gw=3D10.0.0.254,
      host=3DFM2224EP_67, domain=3D, nis-domain=3D(none),
      bootserver=3D10.0.80.21, rootserver=3D10.0.80.21, rootpath=3D
init: ramdisk_execute_command =3D /init
loading ramdisk image initrd.image
RAMDISK: Compressed image found at block 0
EXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 136k init
run_init_process trying to exec /bin/ash
back from execve, errno=3D2
Failed to execute /bin/ash.  Attempting defaults...
run_init_process trying to exec /sbin/init
back from execve, errno=3D14
run_init_process trying to exec /etc/init
back from execve, errno=3D14
run_init_process trying to exec /bin/init
back from execve, errno=3D14
run_init_process trying to exec /bin/sh
back from execve, errno=3D14
Kernel panic - not syncing: No init found.  Try passing init=3D option to 
kernel.
  <0>Rebooting in 180 seconds..<6>phy0:0: Link is Up - 100/Half
