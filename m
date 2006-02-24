Return-Path: <jcrigby@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.204])
	by ozlabs.org (Postfix) with ESMTP id 80EC567A41
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Feb 2006 04:17:19 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id i29so260588wxd
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Feb 2006 09:17:17 -0800 (PST)
Message-ID: <4b73d43f0602240917h1d80bcf8ycc87086305434304@mail.gmail.com>
Date: Fri, 24 Feb 2006 10:17:16 -0700
From: "John Rigby" <jcrigby@gmail.com>
To: "#LI JIANGGAN#" <lijianggan@pmail.ntu.edu.sg>
Subject: Re: boot failure on lite5200b board
In-Reply-To: <84A109BF918D934CB46ACF33BCE187C002D54D7B@mail02.student.main.ntu.edu.sg>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <84A109BF918D934CB46ACF33BCE187C002D54D71@mail02.student.main.ntu.edu.sg>
	<43FD6669.9090405@246tNt.com>
	<84A109BF918D934CB46ACF33BCE187C002D54D7A@mail02.student.main.ntu.edu.sg>
	<4b73d43f0602230818w63423513n817d9ec7eb580d2c@mail.gmail.com>
	<84A109BF918D934CB46ACF33BCE187C002D54D7B@mail02.student.main.ntu.edu.sg>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I don't think your syntax for appending to an env variable is correct:

try:
set bootargs $(bootargs) ...appended stuff...
instead of:
set bootargs env bootargs ...appended stuff....

Also to see what bootargs is actually set to after all the nested
commands, add a printenv just before the bootm

On 2/23/06, #LI JIANGGAN# <lijianggan@pmail.ntu.edu.sg> wrote:
>
>
> I have actually tried both kernel with both console configurations. It ga=
ve
> the same output, thus I presume that the problem lies somewhere else. I
> attached the log to this email.
>
>  the board is Lite5200B Version 1.0. Which .config file do you want?
>
>  Sylvain, we have ordered a debugging set but we are still waiting for
> delivery, the leaking time is said to be one month, tant pis. And the log=
 I
> attached here are booting from a higher address (0x500000).
>
>  My current u-boot args:
>  Autostarting. Press any key to abort..
>
>  Hit any key to stop autoboot:  0
>  =3D> printenv
>  baudrate=3D115200
>  autoload=3Dno
>  ethact=3DFEC ETHERNET
>  flshroot=3Droot=3D/dev/mtdblock2 rw
>  ethaddr=3D00:01:9F:00:27:2F
>  preboot=3Decho; echo Autostarting. Press any key to abort..; echo
>  bootdelay=3D5
>  hostname=3Dicecube
>  bootfile=3DMPC5200/uImage
>  nv=3Dnfsroot root=3D/dev/nfs rw nfsroot=3D10.190.3.113:/opt/eldk/rootfs
>  ip=3Dip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::=
off
>  nfsroot=3Droot=3D/dev/nfs rw nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs
>  bootcmd=3Drun net_nfs
>  filesize=3D546
>  fileaddr=3D500000
>  netmask=3D255.255.240.0
>  ipaddr=3D10.190.3.144
>  serverip=3D10.190.3.103
>  setconsole=3Dsetenv bootargs console=3DttyPSC0, 115200n8 console=3Dtty1
>  rootfs=3Droot=3D/dev/nfs rw nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs
>  bootargs=3Denv bootargs root=3D/dev/nfs rw
> nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs
> ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::off
>  flash_nfs=3Drun setconsole nfsargs addip;bootm
>  net_nfs=3Dtftp 500000 MPC5200/uImage;run setconsole nfsargs addip;bootm
>  nfsargs=3Dsetenv bootargs env bootargs root=3D/dev/nfs rw
> nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs
> ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::offroo=
t=3D/dev/nfs
> rw
>  addip=3Dsetenv bootargs env bootargs root=3D/dev/nfs rw
> nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs
> ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::off
>  ramargs=3Dsetenv bootargs root=3D/dev/ram rw
>  console=3Dconsole=3DttyS0,115200n8 console=3Dtty1
>  stdin=3Dserial
>  stdout=3Dserial
>  stderr=3Dserial
>
>  Environment size: 1472/65532 bytes
>  =3D>
>
>
>
>
>  USING Sylvain's KERNEL:
>
>  U-Boot 1.1.3 (Feb  6 2006 - 09:56:46)
>
>  CPU:   MPC5200 v2.2 at 462 MHz
>         Bus 132 MHz, IPB 132 MHz, PCI 33 MHz
>  Board: Freescale MPC5200 (Lite5200B)
>  I2C:   85 kHz, ready
>  DRAM:  256 MB
>  FLASH: 32 MB
>  PCI:   Bus Dev VenId DevId Class Int
>          00  1a  1057  5809  0680  00
>  In:    serial
>  Out:   serial
>  Err:   serial
>  Net:   FEC ETHERNET
>  IDE:   Bus 0: OK
>    Device 0: not available
>    Device 1: not available
>
>  Autostarting. Press any key to abort..
>
>  Hit any key to stop autoboot:  0
>  Using FEC ETHERNET device
>  TFTP from server 10.190.3.103; our IP address is 10.190.3.144
>  Filename 'MPC5200/uImage'.
>  Load address: 0x500000
>  Loading: ###############################################################=
##
>           ###############################################################=
#
>  done
>  Bytes transferred =3D 658114 (a0ac2 hex)
>  ## Booting image at 00500000 ...
>     Image Name:   Linux-2.6.16-rc1
>     Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>     Data Size:    658050 Bytes =3D 642.6 kB
>     Load Address: 00000000
>     Entry Point:  00000000
>     Verifying Checksum ... OK
>     Uncompressing Kernel Image ... OK
>  id mach(): done
>  MMU:enter
>  MMU:hw init
>  MMU:mapin
>  MMU:setio
>  MMU:exit
>  setup_arch: enter
>  setup_arch: bootmem
>  arch: exit
>
>
>
>  USING KERNEL FROM Freescale:
>
>  U-Boot 1.1.3 (Feb  6 2006 - 09:56:46)
>
>  CPU:   MPC5200 v2.2 at 462 MHz
>         Bus 132 MHz, IPB 132 MHz, PCI 33 MHz
>  Board: Freescale MPC5200 (Lite5200B)
>  I2C:   85 kHz, ready
>  DRAM:  256 MB
>  FLASH: 32 MB
>  PCI:   Bus Dev VenId DevId Class Int
>          00  1a  1057  5809  0680  00
>  In:    serial
>  Out:   serial
>  Err:   serial
>  Net:   FEC ETHERNET
>  IDE:   Bus 0: OK
>    Device 0: not available
>    Device 1: not available
>
>  Autostarting. Press any key to abort..
>
>  Hit any key to stop autoboot:  0
>  Using FEC ETHERNET device
>  TFTP from server 10.190.3.103; our IP address is 10.190.3.144
>  Filename 'MPC5200/uImage'.
>  Load address: 0x500000
>  Loading: ###############################################################=
##
>           ###############################################################=
##
>           ###############################################################=
##
>           ###############################################################=
##
>           ###################################
>  done
>  Bytes transferred =3D 1510143 (170aff hex)
>  ## Booting image at 00500000 ...
>     Image Name:   Linux-2.6.11.7
>     Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>     Data Size:    1510079 Bytes =3D  1.4 MB
>     Load Address: 00000000
>     Entry Point:  00000000
>     Verifying Checksum ... OK
>     Uncompressing Kernel Image ... OK
>  id mach(): done
>  MMU:enter
>  MMU:hw init
>  MMU:mapin
>  MMU:setio
>  MMU:exit
>  setup_arch: enter
>  setup_arch: bootmem
>  ocp: exit
>  arch: exit
>
>
>
>
>  -----Original Message-----
>  From: John Rigby [mailto:jcrigby@gmail.com]
>  Sent: Fri 2/24/2006 0:18
>  To: #LI JIANGGAN#
>  Subject: Re: boot failure on lite5200b board
>
>  If you are using Sylvain's kernel you need to set console=3DttyPSC0.  If=
 you
> are
>  using a kernel from Freescale then you need to set console=3DttyS0.
>
>  Also what rev of the board do you have?
>
>
>
>  On 2/23/06, #LI JIANGGAN# <lijianggan@pmail.ntu.edu.sg> wrote:
>  >
>  >
>  > Thank you Jos=E9 Mar=EDa and Andrey for your advices, however the prob=
lem
>  > remains. I've tried setting the console (though I remember that our
> previous
>  > lite5200 board was working fine on kernel 2.4 without setting the
> console);
>  > meantime, I've set the booting image to 0x500000; I have also tried us=
ing
>  > the kernel image come together with the BSP, it's always the same erro=
r.
>  >
>  >  Sylvain, I've actually using your kernel source, the compiled image i=
s
>  > around 700k (compared to the 1.4M image from the BSP), but it doesn't
> solve
>  > the problem. So I presume that the problem is lying somewhere else.
>  >
>  >  A SNAPSHOT OF THE BOOTING MESSAGES:
>  >
>  >
>  >  U-Boot 1.1.3 (Feb  6 2006 - 09:56:46)
>  >
>  >  CPU:   MPC5200 v2.2 at 462 MHz
>  >         Bus 132 MHz, IPB 132 MHz, PCI 33 MHz
>  >  Board: Freescale MPC5200 (Lite5200B)
>  >  I2C:   85 kHz, ready
>  >  DRAM:  256 MB
>  >  FLASH: 32 MB
>  >  PCI:   Bus Dev VenId DevId Class Int
>  >          00  1a  1057  5809  0680  00
>  >  In:    serial
>  >  Out:   serial
>  >  Err:   serial
>  >  Net:   FEC ETHERNET
>  >  IDE:   Bus 0: OK
>  >    Device 0: not available
>  >    Device 1: not available
>  >
>  >  Autostarting. Press any key to abort..
>  >
>  >  Hit any key to stop autoboot:  0
>  >  Using FEC ETHERNET device
>  >  TFTP from server 10.190.3.103; our IP address is 10.190.3.144
>  >  Filename 'MPC5200/uImage'.
>  >  Load address: 0x100000
>  >  Loading:
>  > #################################################################
>  >
>  > ################################################################
>  >  done
>  >  Bytes transferred =3D 658114 (a0ac2 hex)
>  >  ## Booting image at 00100000 ...
>  >     Image Name:   Linux-2.6.16-rc1
>  >     Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>  >     Data Size:    658050 Bytes =3D 642.6 kB
>  >     Load Address: 00000000
>  >     Entry Point:  00000000
>  >     Verifying Checksum ... OK
>  >     Uncompressing Kernel Image ... OK
>  >  id mach(): done
>  >  MMU:enter
>  >  MMU:hw init
>  >  MMU:mapin
>  >  MMU:setio
>  >  MMU:exit
>  >  setup_arch: enter
>  >  setup_arch: bootmem
>  >  arch: exit
>  >
>  >
>  >  I am wondering whether it's a kernel problem or more likely to be a
> problem
>  > lying with the U-boot. It seems to hang when executing setup_arch()
>  > function, or maybe there is sth else behind the wall?
>  >
>  >  Regards,
>  >  Jianggan LI
>  >
>  >
>  >
>  >
>  >  -----Original Message-----
>  >  From: Sylvain Munaut [mailto:tnt@246tNt.com]
>  >  Sent: Thu 2/23/2006 15:38
>  >  To: #LI JIANGGAN#
>  >  Cc: linuxppc-embedded@ozlabs.org
>  >  Subject: Re: boot failure on lite5200b board
>  >
>  >  #LI JIANGGAN# wrote:
>  >  > Hello all,
>  >  >
>  >  > For my end-of-study project, I am working on an embedded system wit=
h
>  >  > reference of freescale's lite5200b reference board. I was trying to
> boot
>  >  > Linux 2.6.15 on the board (with the fec and bestcomm corrected).
> however
>  >  > the booting was stuck at the following stage:
>  >
>  >  In addition to what has already been said (use a higher address for t=
he
>  >  image and don't forget console=3DttyPSC0 in kernel command line), mak=
e
>  >  sure you use the kernel from my git tree, it contains a few patches f=
rom
>  >  John Rigby to add support for the lite5200b.
>  >
>  >  Please report if it works, I've not been able to test those myself si=
nce
>  >  i'm still on lite5200.
>  >
>  >
>  >          Sylvain
>  >
>  >
>  >
>  >
>  >
>  >
>  > _______________________________________________
>  > Linuxppc-embedded mailing list
>  > Linuxppc-embedded@ozlabs.org
>  > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>  >
>  >
>
>
>
>
>
