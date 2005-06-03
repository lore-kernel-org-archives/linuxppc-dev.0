Return-Path: <edward.qin.hong@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.206])
	by ozlabs.org (Postfix) with ESMTP id 653F8679E2
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 09:17:33 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id 16so1015186nzp
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 03 Jun 2005 16:17:31 -0700 (PDT)
Message-ID: <21fb73bc05060316102325f94d@mail.gmail.com>
Date: Fri, 3 Jun 2005 17:10:51 -0600
From: Edward Hong <edward.qin.hong@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: kernel ported from ELDK 3.0 hangs (loops in idled()) on my custom
	MPC870 Board
Reply-To: Edward Hong <edward.qin.hong@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am trying to bring up Linux on a custom MPC870 Board using ELDK 3.0.=20

The ported kernel from ELDK 3.0 hangs (loops in idled()) and the kernel_thr=
ead=20
init never gets started!???

The board boots with the following messages:

U-Boot 1.0.2 (May 12 2005 - 15:05:46)

CPU:   MPC885ZPnn at 132 MHz: 8 kB I-Cache 8 kB D-Cache FEC present
Board: Custom MPC870
I2C:   ready
DRAM:  64 MB
FLASH: 64 MB
In:    serial
Out:   serial
Err:   serial
Net:   FEC ETHERNET, FEC2 ETHERNET


Hit any key to stop autoboot:  0=20
=3D> run net_nfs
Using FEC ETHERNET device
TFTP from server 10.15.10.170; our IP address is 10.15.2.101
Filename 'vmlinux.UBoot'.
Load address: 0x200000
Loading: #################################################################
         #################################################################
         ######
done
Bytes transferred =3D 691764 (a8e34 hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.4.24-pre2
   Created:      2005-06-03  16:17:44 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    691700 Bytes =3D 675.5 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.24-pre2 (ehong@chico) (gcc version 3.2.2 20030217 (Yellow=
=20
Dog Linux 3.0 3.2.2-2a_1)) #8 Fri Jun 3 10:13:10 MDT 2005 On node 0=20
totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=3D/dev/nfs rw nfsroot=3D10.15.10.170:/opt/eldk/pp=
c_8xx=20
ip=3D10.15.2.101:10.15.10.170::::eth0:off panic=3D1
Decrementer Frequency =3D 495000000/60
Calibrating delay loop... 131.48 BogoMIPS
Memory: 63132k available (1204k kernel code, 360k data, 60k init, 0k highme=
m)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX


(kernel loops in idled() after kernel_thread(init, ...) in rest_init().)=20

Here is the board info printed under u-boot:
=3D> bdinfo
memstart    =3D 0x00000000
memsize     =3D 0x04000000
flashstart  =3D 0xF0000000
flashsize   =3D 0x04000000
flashoffset =3D 0x0001F100
sramstart   =3D 0x00000000
sramsize    =3D 0x00000000
immr_base   =3D 0xFFF00000
bootflags   =3D 0x00000001
intfreq     =3D    132 MHz
busfreq     =3D     66 MHz
ethaddr     =3D 00:D0:1C:01:02:00
IP addr     =3D 10.15.2.101
baudrate    =3D  38400 bps

The bd_info of kernel is copied from u-boot. The IMAP_ADDR of kernel uses=
=20
the same value as the U-Boot CFG_IMMR.=20


Thanks in advance for your help!

Edward
