Return-Path: <apoorvsangal@gmail.com>
Message-ID: <a7966936050726231628bb1c77@mail.gmail.com>
Date: Wed, 27 Jul 2005 11:46:05 +0530
From: apoorv sangal <apoorvsangal@gmail.com>
To: Alex Zeffertt <ajz@cambridgebroadband.com>, Linuxppc-embedded@ozlabs.org
In-Reply-To: <20050707101239.1389b917.ajz@cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <a796693605070621187c9394d5@mail.gmail.com>
	<20050707101239.1389b917.ajz@cambridgebroadband.com>
Cc: vikrant_basotra@satyam.com, nishant_galange@satyam.com,
	apoorv sangal <apoorv_sangal@satyam.com>
Subject: Re: Porting Linux On MPC8266 custom board
Reply-To: apoorv sangal <apoorvsangal@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Alex,
Thanks a lot for your reply.
I have been able to procedd further and now I am facing problem in
mounting root file system.
As suggested by you in earlier mail about the following :-
"=20
1.      linux/init/main.c
=20
 (which contains the following code
         #endif
 #ifdef CONFIG_MTD
         { "mtdblock", 0x1f00 },
 #endif
         { NULL, 0 }
 };
 )
"
I am not able to find the above mention code snippet in the linux/init/main=
.c.
I am using Linux Kerne 2.4.24 which came with eldk.
Does that mean that i have to deifne CONFIG_MTD myself as i am trying
to JFFS2 file system ?

The output captured on the hyperterminal is as following :-

bootm 02000000 ## Booting image at 02000000 ...
   Image Name:   2.4.24 MPC8260ADS
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    714527 Bytes =3D 697.8 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory BAT mapping: BAT2=3D128Mb, BAT3=3D0Mb, residual: 0Mb

Linux version 2.4.24-pre2 (satyam@pmcserver) (gcc version 3.2.2
20030217 (Yellow Dog Linux 3.0 3.2.2-2a_1)) #13 Tue Jul 19 12:55:18
IST 2005

On node 0 totalpages: 32768

zone(0): 32768 pages.

zone(1): 0 pages.

zone(2): 0 pages.

Kernel command line: console=3DttyS0,115200 root=3D/dev/ram

Warning: real time clock seems stuck!

Calibrating delay loop... 131.89 BogoMIPS

Memory: 127816k available (1232k kernel code, 408k data, 64k init, 0k highm=
em)

Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)

Inode cache hash table entries: 8192 (order: 4, 65536 bytes)

Mount cache hash table entries: 512 (order: 0, 4096 bytes)

Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)

Page-cache hash table entries: 32768 (order: 5, 131072 bytes)

POSIX conformance testing by UNIFIX

Linux NET4.0 for Linux 2.4

Based upon Swansea University Computer Society NET3.039

Initializing RT netlink socket

Starting kswapd

JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications =
AB.

Inside Chr_dev_init

i2c-core.o: i2c core module version 2.6.1 (20010830)

i2c-dev.o: i2c /dev entries driver module version 2.6.1 (20010830)

CPM UART driver version 0.01

ttyS0 on SMC1 at 0x0000, BRG7

ttyS1 on SMC2 at 0x0040, BRG8

ttyS2 on SCC1 at 0x8000, BRG1

ttyS3 on SCC2 at 0x8100, BRG2

Before return statement

 Pty initialisation is complete

End of tty_init

After tty_init

Before misc_init

Inside misc_init b4 create_proc_read_entry

Inside misc_init after create_proc_read_entry

End of misc_init before return 0=20

After misc_init

End of Chr_dev_init b4 return statement

Inside rd_init=20

RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize

PPP generic driver version 2.4.2

PPP Deflate Compression module registered

PPP BSD Compression module registered

NET4: Linux TCP/IP 1.0 for NET4.0

IP Protocols: ICMP, UDP, TCP, IGMP

IP: routing cache hash table of 1024 buckets, 8Kbytes

TCP: Hash tables configured (established 8192 bind 16384)

ip_conntrack version 2.1 (1024 buckets, 8192 max) - 292 bytes per conntrack

ip_tables: (C) 2000-2002 Netfilter core team

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

NET4: Ethernet Bridge 008 for NET4.0

*****

VFS:test name =3D /dev/root

VFS:fs_name =3D jffs2=20

VFS:root name =3D 01:00

 ****=20

VFS:tried fs_name =3D jffs2 err =3D -22

Kernel panic: VFS: Unable to mount root fs on 01:00

 <0>Rebooting in 180 seconds..


Thanks and Regards,
Apoorv Sangal

***************************************************************************=
*************
On 7/7/05, Alex Zeffertt <ajz@cambridgebroadband.com> wrote:
> Apoorv,
>=20
> You need to look in two places:
>=20
> 1.      linux/init/main.c
>=20
> (which contains the following code
>         #endif
> #ifdef CONFIG_MTD
>         { "mtdblock", 0x1f00 },
> #endif
>         { NULL, 0 }
> };
> )
>=20
> and
>=20
> 2.      http://www.denx.de/twiki/bin/view/DULG/LinuxKernelArgs
>=20
> It looks to me that you're trying to use an mtdblock device for your root
> filesystem.  For this to work you need CONFIG_MTD defined and - obviously=
 - a
> root file system image in the appropriate place in your flash.
>=20
> It also appears that you are losing output shortly after the ttyS0 driver=
s are
> created.  Maybe the problem is that your serial console program (e.g. min=
icom)
> is not configured for 11520 .. or for some reason the driver is selecting
> another rate.  Strangely, on my 82xx board I don't need the console argum=
ent on
> the kernel command line, it just automatically uses ttyS0@9600.  Probably=
 this
> is because it detects u-boot is also using this, but I don't know.
>=20
> Alex
>=20
>=20
> On Thu, 7 Jul 2005 09:48:53 +0530
> apoorv sangal <apoorvsangal@gmail.com> wrote:
>=20
> > Hi All,
> >               I am porting Linux on MPC8266 custom board, after getting=
 in to
> > Linux the system seems to be struck at a point.
> > Saved Environment variable:-
> >       bootargs console=3DttyS0,11520 root=3D1f00 and downloaded the Ker=
nel
> > image at address 0x02000000 in the RAM.
> > From the u-boot prompt the bootm command is invoked as:-
> >       bootm 0x02000000
> >
> > After that what I get on the terminal is pasted below for your referenc=
e.
> > I couldn't make out any thing from the output, can any body tell me
> > where I am doing wrong, and also I don't have any idea about the
> > bootargs argument "root". Can any body give the precise description of
> > this argument?
> >
> >
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
> > =3D> bootm 02000000 ## Booting image at 02000000...
> >    Image Name:   2.4.24 MPC8260ADS
> >    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> >    Data Size:    725838 Bytes =3D 708.8 kB
> >    Load Address: 00000000
> >    Entry Point:  00000000
> >    Verifying Checksum ... OK
> >    Uncompressing Kernel Image ... OK
> > Memory BAT mapping: BAT2=3D128Mb, BAT3=3D0Mb, residual: 0Mb
> >
> > Linux version 2.4.24-pre2 (root@pmcserver) (gcc version 3.3.4) #2 Tue
> > Jul 5 15:05:10 IST 2005
> >
> > On node 0 totalpages: 32768
> >
> > zone(0): 32768 pages.
> >
> > zone(1): 0 pages.
> >
> > zone(2): 0 pages.
> >
> > Kernel command line: console=3DttyS0,115200 root=3D1f00
> >
> > Warning: real time clock seems stuck!
> >
> > Calibrating delay loop... 131.89 BogoMIPS
> >
> > Memory: 127812k available (1232k kernel code, 412k data, 64k init, 0k h=
ighmem)
> >
> > Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
> >
> > Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
> >
> > Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> >
> > Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
> >
> > Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
> >
> > POSIX conformance testing by UNIFIX
> >
> > Linux NET4.0 for Linux 2.4
> >
> > Based upon Swansea University Computer Society NET3.039
> >
> > Initializing RT netlink socket
> >
> > Starting kswapd
> >
> > JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communicati=
ons AB.
> >
> > i2c-core.o: i2c core module version 2.6.1 (20010830)
> >
> > i2c-dev.o: i2c /dev entries driver module version 2.6.1 (20010830)
> >
> > CPM UART driver version 0.01
> >
> > ttyS0 on SMC1 at 0x0000, BRG7
> >
> > ttyS1 on SMC2 at 0x0040, BRG8
> >
> > ttyS2 on SCC1 at 0x8000, BRG1
> >
> > ttyS3 on SCC2 at 0x8100, BRG2
> >
> > pty: 256 Unix98 ptys configured
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+
> >
> > Waiting eagerly,
> > Regards,
> > VB
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
