Return-Path: <lijianggan@pmail.ntu.edu.sg>
Received: from exsmtp2.ntu.edu.sg (exsmtp2.ntu.edu.sg [155.69.5.9])
	by ozlabs.org (Postfix) with ESMTP id 9BF0167A00
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Mar 2006 04:16:26 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C63D53.DA3B9BFE"
Subject: RE: boot failure on lite5200b board
Date: Thu, 2 Mar 2006 01:16:17 +0800
Message-ID: <84A109BF918D934CB46ACF33BCE187C002D54D94@mail02.student.main.ntu.edu.sg>
References: <84A109BF918D934CB46ACF33BCE187C002D54D71@mail02.student.main.ntu.edu.sg><43FD6669.9090405@246tNt.com><84A109BF918D934CB46ACF33BCE187C002D54D7A@mail02.student.main.ntu.edu.sg><4b73d43f0602230818w63423513n817d9ec7eb580d2c@mail.gmail.com><84A109BF918D934CB46ACF33BCE187C002D54D7B@mail02.student.main.ntu.edu.sg>
	<4b73d43f0602240917h1d80bcf8ycc87086305434304@mail.gmail.com>
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

------_=_NextPart_001_01C63D53.DA3B9BFE
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

how about the following U-boot settings:

..............................


Hit any key to stop autoboot:  0
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
rootfs=3Droot=3D/dev/nfs rw
netdev=3Deth0
rootpath=3D/opt/eldk-4-0/rootfs
nfsargs=3Dsetenv bootargs root=3D/dev/nfs rw =
nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs
ramargs=3Dsetenv bootargs root=3D/dev/ram rw
addip=3Dsetenv bootargs =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube:eth0:of=
f panic=3D1
net_nfs=3Dtftp 200000 MPC5200/uImage;run nfsargs addip;bootm
stdin=3Dserial
stdout=3Dserial
stderr=3Dserial

Environment size: 738/65532 bytes
=3D>                                .
................................

The output is still the same, it hangs after displaying arch:exit

I have also tried the above settings with console set, it gives the same =
output

I am really wondering whether the problem is with the kernel. Sylvain's =
kernel uImage is only around 600k while the one from freescale is 1.4M, =
anybody knows where the difference is?

.....................................

Autostarting. Press any key to abort..

Hit any key to stop autoboot:  0
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


.....................

Regards,

Jianggan LI


________________________________

From: John Rigby [mailto:jcrigby@gmail.com]
Sent: Sat 2/25/2006 1:17
To: #LI JIANGGAN#
Cc: tnt@246tnt.com; linuxppc-embedded@ozlabs.org
Subject: Re: boot failure on lite5200b board



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
> I have actually tried both kernel with both console configurations. It =
gave
> the same output, thus I presume that the problem lies somewhere else. =
I
> attached the log to this email.
>
>  the board is Lite5200B Version 1.0. Which .config file do you want?
>
>  Sylvain, we have ordered a debugging set but we are still waiting for
> delivery, the leaking time is said to be one month, tant pis. And the =
log I
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
>  nv=3Dnfsroot root=3D/dev/nfs rw =
nfsroot=3D10.190.3.113:/opt/eldk/rootfs
>  =
ip=3Dip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::o=
ff
>  nfsroot=3Droot=3D/dev/nfs rw =
nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs
>  bootcmd=3Drun net_nfs
>  filesize=3D546
>  fileaddr=3D500000
>  netmask=3D255.255.240.0
>  ipaddr=3D10.190.3.144
>  serverip=3D10.190.3.103
>  setconsole=3Dsetenv bootargs console=3DttyPSC0, 115200n8 =
console=3Dtty1
>  rootfs=3Droot=3D/dev/nfs rw =
nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs
>  bootargs=3Denv bootargs root=3D/dev/nfs rw
> nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs
> ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::off
>  flash_nfs=3Drun setconsole nfsargs addip;bootm
>  net_nfs=3Dtftp 500000 MPC5200/uImage;run setconsole nfsargs =
addip;bootm
>  nfsargs=3Dsetenv bootargs env bootargs root=3D/dev/nfs rw
> nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs
> =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::offroo=
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
>  Loading: =
#################################################################
>           =
################################################################
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
>  Loading: =
#################################################################
>           =
#################################################################
>           =
#################################################################
>           =
#################################################################
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
>  If you are using Sylvain's kernel you need to set console=3DttyPSC0.  =
If you
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
>  > Thank you Jos=E9 Mar=EDa and Andrey for your advices, however the =
problem
>  > remains. I've tried setting the console (though I remember that our
> previous
>  > lite5200 board was working fine on kernel 2.4 without setting the
> console);
>  > meantime, I've set the booting image to 0x500000; I have also tried =
using
>  > the kernel image come together with the BSP, it's always the same =
error.
>  >
>  >  Sylvain, I've actually using your kernel source, the compiled =
image is
>  > around 700k (compared to the 1.4M image from the BSP), but it =
doesn't
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
>  >  I am wondering whether it's a kernel problem or more likely to be =
a
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
>  >  > For my end-of-study project, I am working on an embedded system =
with
>  >  > reference of freescale's lite5200b reference board. I was trying =
to
> boot
>  >  > Linux 2.6.15 on the board (with the fec and bestcomm corrected).
> however
>  >  > the booting was stuck at the following stage:
>  >
>  >  In addition to what has already been said (use a higher address =
for the
>  >  image and don't forget console=3DttyPSC0 in kernel command line), =
make
>  >  sure you use the kernel from my git tree, it contains a few =
patches from
>  >  John Rigby to add support for the lite5200b.
>  >
>  >  Please report if it works, I've not been able to test those myself =
since
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



------_=_NextPart_001_01C63D53.DA3B9BFE
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">=0A=
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">=0A=
<HTML>=0A=
<HEAD>=0A=
=0A=
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">=0A=
<TITLE>Re: boot failure on lite5200b board</TITLE>=0A=
</HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText33202 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>how about the =
following =0A=
U-boot settings:</FONT></DIV>=0A=
<DIV dir=3Dltr><BR>..............................<BR>=0A=
<P><FONT size=3D2>Hit any key to stop autoboot:&nbsp; 0<BR>=3D&gt; =0A=
printenv<BR>baudrate=3D115200<BR>autoload=3Dno<BR>ethact=3DFEC =0A=
ETHERNET<BR>ethaddr=3D00:01:9F:00:27:2F<BR>preboot=3Decho; echo =
Autostarting. Press =0A=
any key to abort..; =0A=
echo<BR>bootdelay=3D5<BR>hostname=3Dicecube<BR>bootfile=3DMPC5200/uImage<=
BR>nv=3Dnfsroot =0A=
root=3D/dev/nfs rw =0A=
nfsroot=3D10.190.3.113:/opt/eldk/rootfs<BR>netmask=3D255.255.240.0<BR>ipa=
ddr=3D10.190.3.144<BR>serverip=3D10.190.3.103<BR>bootcmd=3Drun =0A=
net_nfs<BR>rootfs=3Droot=3D/dev/nfs =0A=
rw<BR>netdev=3Deth0<BR>rootpath=3D/opt/eldk-4-0/rootfs<BR>nfsargs=3Dseten=
v bootargs =0A=
root=3D/dev/nfs rw =
nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs<BR>ramargs=3Dsetenv =0A=
bootargs root=3D/dev/ram rw<BR>addip=3Dsetenv bootargs =0A=
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube:eth0:of=
f =0A=
panic=3D1<BR>net_nfs=3Dtftp 200000 MPC5200/uImage;run nfsargs =0A=
addip;bootm<BR>stdin=3Dserial<BR>stdout=3Dserial<BR>stderr=3Dserial<BR><B=
R>Environment =0A=
size: 738/65532 =0A=
bytes<BR>=3D&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.<BR>......=
..........................</FONT></P>=0A=
<P><FONT size=3D2>The output is still the same, it hangs after =
displaying =0A=
arch:exit</FONT></P>=0A=
<P><FONT size=3D2>I have also tried the above settings with console set, =
it =0A=
gives&nbsp;the same output</FONT></P>=0A=
<P><FONT size=3D2>I am really wondering whether the problem is with the =
kernel. =0A=
Sylvain's kernel uImage is only around 600k while the one from freescale =
is =0A=
1.4M, anybody knows where the difference is?</FONT></P>=0A=
<P><FONT size=3D2>.....................................</FONT></P>=0A=
<P><FONT size=3D2>Autostarting. Press any key to abort..<BR><BR>Hit any =
key to =0A=
stop autoboot:&nbsp; 0<BR>Using FEC ETHERNET device<BR>TFTP from server =0A=
10.190.3.103; our IP address is 10.190.3.144<BR>Filename =0A=
'MPC5200/uImage'.<BR>Load address: 0x200000<BR>Loading: =0A=
#################################################################<BR>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
#################################################################<BR>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
#################################################################<BR>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
#################################################################<BR>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
###################################<BR>done<BR>Bytes transferred =3D =
1510143 =0A=
(170aff hex)<BR>## Booting image at 00200000 ...<BR>&nbsp;&nbsp; Image =0A=
Name:&nbsp;&nbsp; Linux-2.6.11.7<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; =
PowerPC =0A=
Linux Kernel Image (gzip compressed)<BR>&nbsp;&nbsp; Data =0A=
Size:&nbsp;&nbsp;&nbsp; 1510079 Bytes =3D&nbsp; 1.4 MB<BR>&nbsp;&nbsp; =
Load =0A=
Address: 00000000<BR>&nbsp;&nbsp; Entry Point:&nbsp; =
00000000<BR>&nbsp;&nbsp; =0A=
Verifying Checksum ... OK<BR>&nbsp;&nbsp; Uncompressing Kernel Image ... =0A=
OK<BR>id mach(): done<BR>MMU:enter<BR>MMU:hw =0A=
init<BR>MMU:mapin<BR>MMU:setio<BR>MMU:exit<BR>setup_arch: =
enter<BR>setup_arch: =0A=
bootmem<BR>ocp: exit<BR>arch: exit</FONT><BR></P>=0A=
<P><FONT size=3D2>.....................</FONT></P>=0A=
<P><FONT size=3D2>Regards,</FONT></P>=0A=
<P><FONT size=3D2>Jianggan LI</P></FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> John Rigby =0A=
[mailto:jcrigby@gmail.com]<BR><B>Sent:</B> Sat 2/25/2006 =
1:17<BR><B>To:</B> #LI =0A=
JIANGGAN#<BR><B>Cc:</B> tnt@246tnt.com; =0A=
linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> Re: boot failure on =
lite5200b =0A=
board<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>I don't think your syntax for appending to an env =
variable is =0A=
correct:<BR><BR>try:<BR>set bootargs $(bootargs) ...appended =
stuff...<BR>instead =0A=
of:<BR>set bootargs env bootargs ...appended stuff....<BR><BR>Also to =
see what =0A=
bootargs is actually set to after all the nested<BR>commands, add a =
printenv =0A=
just before the bootm<BR><BR>On 2/23/06, #LI JIANGGAN# =0A=
&lt;lijianggan@pmail.ntu.edu.sg&gt; wrote:<BR>&gt;<BR>&gt;<BR>&gt; I =
have =0A=
actually tried both kernel with both console configurations. It =
gave<BR>&gt; the =0A=
same output, thus I presume that the problem lies somewhere else. =
I<BR>&gt; =0A=
attached the log to this email.<BR>&gt;<BR>&gt;&nbsp; the board is =
Lite5200B =0A=
Version 1.0. Which .config file do you want?<BR>&gt;<BR>&gt;&nbsp; =
Sylvain, we =0A=
have ordered a debugging set but we are still waiting for<BR>&gt; =
delivery, the =0A=
leaking time is said to be one month, tant pis. And the log I<BR>&gt; =
attached =0A=
here are booting from a higher address (0x500000).<BR>&gt;<BR>&gt;&nbsp; =
My =0A=
current u-boot args:<BR>&gt;&nbsp; Autostarting. Press any key to =0A=
abort..<BR>&gt;<BR>&gt;&nbsp; Hit any key to stop autoboot:&nbsp; =0A=
0<BR>&gt;&nbsp; =3D&gt; printenv<BR>&gt;&nbsp; =
baudrate=3D115200<BR>&gt;&nbsp; =0A=
autoload=3Dno<BR>&gt;&nbsp; ethact=3DFEC ETHERNET<BR>&gt;&nbsp; =0A=
flshroot=3Droot=3D/dev/mtdblock2 rw<BR>&gt;&nbsp; =0A=
ethaddr=3D00:01:9F:00:27:2F<BR>&gt;&nbsp; preboot=3Decho; echo =
Autostarting. Press =0A=
any key to abort..; echo<BR>&gt;&nbsp; bootdelay=3D5<BR>&gt;&nbsp; =0A=
hostname=3Dicecube<BR>&gt;&nbsp; bootfile=3DMPC5200/uImage<BR>&gt;&nbsp; =
nv=3Dnfsroot =0A=
root=3D/dev/nfs rw nfsroot=3D10.190.3.113:/opt/eldk/rootfs<BR>&gt;&nbsp; =0A=
ip=3Dip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::o=
ff<BR>&gt;&nbsp; =0A=
nfsroot=3Droot=3D/dev/nfs rw =
nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs<BR>&gt;&nbsp; =0A=
bootcmd=3Drun net_nfs<BR>&gt;&nbsp; filesize=3D546<BR>&gt;&nbsp; =0A=
fileaddr=3D500000<BR>&gt;&nbsp; netmask=3D255.255.240.0<BR>&gt;&nbsp; =0A=
ipaddr=3D10.190.3.144<BR>&gt;&nbsp; =
serverip=3D10.190.3.103<BR>&gt;&nbsp; =0A=
setconsole=3Dsetenv bootargs console=3DttyPSC0, 115200n8 =
console=3Dtty1<BR>&gt;&nbsp; =0A=
rootfs=3Droot=3D/dev/nfs rw =
nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs<BR>&gt;&nbsp; =0A=
bootargs=3Denv bootargs root=3D/dev/nfs rw<BR>&gt; =0A=
nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs<BR>&gt; =0A=
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::off<BR=
>&gt;&nbsp; =0A=
flash_nfs=3Drun setconsole nfsargs addip;bootm<BR>&gt;&nbsp; =
net_nfs=3Dtftp 500000 =0A=
MPC5200/uImage;run setconsole nfsargs addip;bootm<BR>&gt;&nbsp; =
nfsargs=3Dsetenv =0A=
bootargs env bootargs root=3D/dev/nfs rw<BR>&gt; =0A=
nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs<BR>&gt; =0A=
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::offroo=
t=3D/dev/nfs<BR>&gt; =0A=
rw<BR>&gt;&nbsp; addip=3Dsetenv bootargs env bootargs root=3D/dev/nfs =
rw<BR>&gt; =0A=
nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs<BR>&gt; =0A=
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::off<BR=
>&gt;&nbsp; =0A=
ramargs=3Dsetenv bootargs root=3D/dev/ram rw<BR>&gt;&nbsp; =0A=
console=3Dconsole=3DttyS0,115200n8 console=3Dtty1<BR>&gt;&nbsp; =0A=
stdin=3Dserial<BR>&gt;&nbsp; stdout=3Dserial<BR>&gt;&nbsp; =0A=
stderr=3Dserial<BR>&gt;<BR>&gt;&nbsp; Environment size: 1472/65532 =0A=
bytes<BR>&gt;&nbsp; =
=3D&gt;<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt;&nbsp; USING =0A=
Sylvain's KERNEL:<BR>&gt;<BR>&gt;&nbsp; U-Boot 1.1.3 (Feb&nbsp; 6 2006 - =0A=
09:56:46)<BR>&gt;<BR>&gt;&nbsp; CPU:&nbsp;&nbsp; MPC5200 v2.2 at 462 =0A=
MHz<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus 132 MHz, =
IPB 132 =0A=
MHz, PCI 33 MHz<BR>&gt;&nbsp; Board: Freescale MPC5200 =
(Lite5200B)<BR>&gt;&nbsp; =0A=
I2C:&nbsp;&nbsp; 85 kHz, ready<BR>&gt;&nbsp; DRAM:&nbsp; 256 =
MB<BR>&gt;&nbsp; =0A=
FLASH: 32 MB<BR>&gt;&nbsp; PCI:&nbsp;&nbsp; Bus Dev VenId DevId Class =0A=
Int<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
00&nbsp; =0A=
1a&nbsp; 1057&nbsp; 5809&nbsp; 0680&nbsp; 00<BR>&gt;&nbsp; =
In:&nbsp;&nbsp;&nbsp; =0A=
serial<BR>&gt;&nbsp; Out:&nbsp;&nbsp; serial<BR>&gt;&nbsp; =
Err:&nbsp;&nbsp; =0A=
serial<BR>&gt;&nbsp; Net:&nbsp;&nbsp; FEC ETHERNET<BR>&gt;&nbsp; =0A=
IDE:&nbsp;&nbsp; Bus 0: OK<BR>&gt;&nbsp;&nbsp;&nbsp; Device 0: not =0A=
available<BR>&gt;&nbsp;&nbsp;&nbsp; Device 1: not =0A=
available<BR>&gt;<BR>&gt;&nbsp; Autostarting. Press any key to =0A=
abort..<BR>&gt;<BR>&gt;&nbsp; Hit any key to stop autoboot:&nbsp; =0A=
0<BR>&gt;&nbsp; Using FEC ETHERNET device<BR>&gt;&nbsp; TFTP from server =0A=
10.190.3.103; our IP address is 10.190.3.144<BR>&gt;&nbsp; Filename =0A=
'MPC5200/uImage'.<BR>&gt;&nbsp; Load address: 0x500000<BR>&gt;&nbsp; =
Loading: =0A=
#################################################################<BR>&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
################################################################<BR>&gt;&=
nbsp; =0A=
done<BR>&gt;&nbsp; Bytes transferred =3D 658114 (a0ac2 =
hex)<BR>&gt;&nbsp; ## =0A=
Booting image at 00500000 ...<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Image =0A=
Name:&nbsp;&nbsp; Linux-2.6.16-rc1<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Image =0A=
Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =0A=
compressed)<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; =
658050 =0A=
Bytes =3D 642.6 kB<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Load Address: =0A=
00000000<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Entry Point:&nbsp; =0A=
00000000<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Verifying Checksum ... =0A=
OK<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Uncompressing Kernel Image ... =0A=
OK<BR>&gt;&nbsp; id mach(): done<BR>&gt;&nbsp; MMU:enter<BR>&gt;&nbsp; =
MMU:hw =0A=
init<BR>&gt;&nbsp; MMU:mapin<BR>&gt;&nbsp; MMU:setio<BR>&gt;&nbsp; =0A=
MMU:exit<BR>&gt;&nbsp; setup_arch: enter<BR>&gt;&nbsp; setup_arch: =0A=
bootmem<BR>&gt;&nbsp; arch: exit<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt;&nbsp; =
USING =0A=
KERNEL FROM Freescale:<BR>&gt;<BR>&gt;&nbsp; U-Boot 1.1.3 (Feb&nbsp; 6 =
2006 - =0A=
09:56:46)<BR>&gt;<BR>&gt;&nbsp; CPU:&nbsp;&nbsp; MPC5200 v2.2 at 462 =0A=
MHz<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus 132 MHz, =
IPB 132 =0A=
MHz, PCI 33 MHz<BR>&gt;&nbsp; Board: Freescale MPC5200 =
(Lite5200B)<BR>&gt;&nbsp; =0A=
I2C:&nbsp;&nbsp; 85 kHz, ready<BR>&gt;&nbsp; DRAM:&nbsp; 256 =
MB<BR>&gt;&nbsp; =0A=
FLASH: 32 MB<BR>&gt;&nbsp; PCI:&nbsp;&nbsp; Bus Dev VenId DevId Class =0A=
Int<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
00&nbsp; =0A=
1a&nbsp; 1057&nbsp; 5809&nbsp; 0680&nbsp; 00<BR>&gt;&nbsp; =
In:&nbsp;&nbsp;&nbsp; =0A=
serial<BR>&gt;&nbsp; Out:&nbsp;&nbsp; serial<BR>&gt;&nbsp; =
Err:&nbsp;&nbsp; =0A=
serial<BR>&gt;&nbsp; Net:&nbsp;&nbsp; FEC ETHERNET<BR>&gt;&nbsp; =0A=
IDE:&nbsp;&nbsp; Bus 0: OK<BR>&gt;&nbsp;&nbsp;&nbsp; Device 0: not =0A=
available<BR>&gt;&nbsp;&nbsp;&nbsp; Device 1: not =0A=
available<BR>&gt;<BR>&gt;&nbsp; Autostarting. Press any key to =0A=
abort..<BR>&gt;<BR>&gt;&nbsp; Hit any key to stop autoboot:&nbsp; =0A=
0<BR>&gt;&nbsp; Using FEC ETHERNET device<BR>&gt;&nbsp; TFTP from server =0A=
10.190.3.103; our IP address is 10.190.3.144<BR>&gt;&nbsp; Filename =0A=
'MPC5200/uImage'.<BR>&gt;&nbsp; Load address: 0x500000<BR>&gt;&nbsp; =
Loading: =0A=
#################################################################<BR>&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
#################################################################<BR>&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
#################################################################<BR>&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
#################################################################<BR>&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
###################################<BR>&gt;&nbsp; done<BR>&gt;&nbsp; =
Bytes =0A=
transferred =3D 1510143 (170aff hex)<BR>&gt;&nbsp; ## Booting image at =
00500000 =0A=
...<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Image Name:&nbsp;&nbsp; =0A=
Linux-2.6.11.7<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Image Type:&nbsp;&nbsp; =
PowerPC =0A=
Linux Kernel Image (gzip compressed)<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp; =
Data =0A=
Size:&nbsp;&nbsp;&nbsp; 1510079 Bytes =3D&nbsp; 1.4 =0A=
MB<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Load Address: =0A=
00000000<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Entry Point:&nbsp; =0A=
00000000<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Verifying Checksum ... =0A=
OK<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Uncompressing Kernel Image ... =0A=
OK<BR>&gt;&nbsp; id mach(): done<BR>&gt;&nbsp; MMU:enter<BR>&gt;&nbsp; =
MMU:hw =0A=
init<BR>&gt;&nbsp; MMU:mapin<BR>&gt;&nbsp; MMU:setio<BR>&gt;&nbsp; =0A=
MMU:exit<BR>&gt;&nbsp; setup_arch: enter<BR>&gt;&nbsp; setup_arch: =0A=
bootmem<BR>&gt;&nbsp; ocp: exit<BR>&gt;&nbsp; arch: =0A=
exit<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt;&nbsp; -----Original =0A=
Message-----<BR>&gt;&nbsp; From: John Rigby [<A =0A=
href=3D"mailto:jcrigby@gmail.com">mailto:jcrigby@gmail.com</A>]<BR>&gt;&n=
bsp; =0A=
Sent: Fri 2/24/2006 0:18<BR>&gt;&nbsp; To: #LI JIANGGAN#<BR>&gt;&nbsp; =
Subject: =0A=
Re: boot failure on lite5200b board<BR>&gt;<BR>&gt;&nbsp; If you are =
using =0A=
Sylvain's kernel you need to set console=3DttyPSC0.&nbsp; If you<BR>&gt; =0A=
are<BR>&gt;&nbsp; using a kernel from Freescale then you need to set =0A=
console=3DttyS0.<BR>&gt;<BR>&gt;&nbsp; Also what rev of the board do you =0A=
have?<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt;&nbsp; On 2/23/06, #LI JIANGGAN# =0A=
&lt;lijianggan@pmail.ntu.edu.sg&gt; wrote:<BR>&gt;&nbsp; =
&gt;<BR>&gt;&nbsp; =0A=
&gt;<BR>&gt;&nbsp; &gt; Thank you Jos=E9 Mar=EDa and Andrey for your =
advices, =0A=
however the problem<BR>&gt;&nbsp; &gt; remains. I've tried setting the =
console =0A=
(though I remember that our<BR>&gt; previous<BR>&gt;&nbsp; &gt; lite5200 =
board =0A=
was working fine on kernel 2.4 without setting the<BR>&gt; =0A=
console);<BR>&gt;&nbsp; &gt; meantime, I've set the booting image to =
0x500000; I =0A=
have also tried using<BR>&gt;&nbsp; &gt; the kernel image come together =
with the =0A=
BSP, it's always the same error.<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; =
&gt;&nbsp; =0A=
Sylvain, I've actually using your kernel source, the compiled image =0A=
is<BR>&gt;&nbsp; &gt; around 700k (compared to the 1.4M image from the =
BSP), but =0A=
it doesn't<BR>&gt; solve<BR>&gt;&nbsp; &gt; the problem. So I presume =
that the =0A=
problem is lying somewhere else.<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; =
&gt;&nbsp; A =0A=
SNAPSHOT OF THE BOOTING MESSAGES:<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; =0A=
&gt;<BR>&gt;&nbsp; &gt;&nbsp; U-Boot 1.1.3 (Feb&nbsp; 6 2006 - =0A=
09:56:46)<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; &gt;&nbsp; CPU:&nbsp;&nbsp; =
MPC5200 =0A=
v2.2 at 462 MHz<BR>&gt;&nbsp; =0A=
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus 132 MHz, IPB =
132 MHz, =0A=
PCI 33 MHz<BR>&gt;&nbsp; &gt;&nbsp; Board: Freescale MPC5200 =0A=
(Lite5200B)<BR>&gt;&nbsp; &gt;&nbsp; I2C:&nbsp;&nbsp; 85 kHz, =0A=
ready<BR>&gt;&nbsp; &gt;&nbsp; DRAM:&nbsp; 256 MB<BR>&gt;&nbsp; =
&gt;&nbsp; =0A=
FLASH: 32 MB<BR>&gt;&nbsp; &gt;&nbsp; PCI:&nbsp;&nbsp; Bus Dev VenId =
DevId Class =0A=
Int<BR>&gt;&nbsp; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
00&nbsp; 1a&nbsp; 1057&nbsp; 5809&nbsp; 0680&nbsp; 00<BR>&gt;&nbsp; =
&gt;&nbsp; =0A=
In:&nbsp;&nbsp;&nbsp; serial<BR>&gt;&nbsp; &gt;&nbsp; Out:&nbsp;&nbsp; =0A=
serial<BR>&gt;&nbsp; &gt;&nbsp; Err:&nbsp;&nbsp; serial<BR>&gt;&nbsp; =
&gt;&nbsp; =0A=
Net:&nbsp;&nbsp; FEC ETHERNET<BR>&gt;&nbsp; &gt;&nbsp; IDE:&nbsp;&nbsp; =
Bus 0: =0A=
OK<BR>&gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp; Device 0: not =
available<BR>&gt;&nbsp; =0A=
&gt;&nbsp;&nbsp;&nbsp; Device 1: not available<BR>&gt;&nbsp; =
&gt;<BR>&gt;&nbsp; =0A=
&gt;&nbsp; Autostarting. Press any key to abort..<BR>&gt;&nbsp; =0A=
&gt;<BR>&gt;&nbsp; &gt;&nbsp; Hit any key to stop autoboot:&nbsp; =0A=
0<BR>&gt;&nbsp; &gt;&nbsp; Using FEC ETHERNET device<BR>&gt;&nbsp; =
&gt;&nbsp; =0A=
TFTP from server 10.190.3.103; our IP address is =
10.190.3.144<BR>&gt;&nbsp; =0A=
&gt;&nbsp; Filename 'MPC5200/uImage'.<BR>&gt;&nbsp; &gt;&nbsp; Load =
address: =0A=
0x100000<BR>&gt;&nbsp; &gt;&nbsp; Loading:<BR>&gt;&nbsp; &gt; =0A=
#################################################################<BR>&gt;=
&nbsp; =0A=
&gt;<BR>&gt;&nbsp; &gt; =0A=
################################################################<BR>&gt;&=
nbsp; =0A=
&gt;&nbsp; done<BR>&gt;&nbsp; &gt;&nbsp; Bytes transferred =3D 658114 =
(a0ac2 =0A=
hex)<BR>&gt;&nbsp; &gt;&nbsp; ## Booting image at 00100000 =
...<BR>&gt;&nbsp; =0A=
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Image Name:&nbsp;&nbsp; =0A=
Linux-2.6.16-rc1<BR>&gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Image =0A=
Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)<BR>&gt;&nbsp; =0A=
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 658050 Bytes =
=3D 642.6 =0A=
kB<BR>&gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Load Address: =0A=
00000000<BR>&gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Entry Point:&nbsp; =0A=
00000000<BR>&gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Verifying Checksum =
... =0A=
OK<BR>&gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Uncompressing Kernel Image =
... =0A=
OK<BR>&gt;&nbsp; &gt;&nbsp; id mach(): done<BR>&gt;&nbsp; &gt;&nbsp; =0A=
MMU:enter<BR>&gt;&nbsp; &gt;&nbsp; MMU:hw init<BR>&gt;&nbsp; &gt;&nbsp; =0A=
MMU:mapin<BR>&gt;&nbsp; &gt;&nbsp; MMU:setio<BR>&gt;&nbsp; &gt;&nbsp; =0A=
MMU:exit<BR>&gt;&nbsp; &gt;&nbsp; setup_arch: enter<BR>&gt;&nbsp; =
&gt;&nbsp; =0A=
setup_arch: bootmem<BR>&gt;&nbsp; &gt;&nbsp; arch: exit<BR>&gt;&nbsp; =0A=
&gt;<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; &gt;&nbsp; I am wondering whether =
it's a =0A=
kernel problem or more likely to be a<BR>&gt; problem<BR>&gt;&nbsp; &gt; =
lying =0A=
with the U-boot. It seems to hang when executing =
setup_arch()<BR>&gt;&nbsp; &gt; =0A=
function, or maybe there is sth else behind the wall?<BR>&gt;&nbsp; =0A=
&gt;<BR>&gt;&nbsp; &gt;&nbsp; Regards,<BR>&gt;&nbsp; &gt;&nbsp; Jianggan =0A=
LI<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; =
&gt;<BR>&gt;&nbsp; =0A=
&gt;<BR>&gt;&nbsp; &gt;&nbsp; -----Original Message-----<BR>&gt;&nbsp; =0A=
&gt;&nbsp; From: Sylvain Munaut [<A =0A=
href=3D"mailto:tnt@246tNt.com">mailto:tnt@246tNt.com</A>]<BR>&gt;&nbsp; =
&gt;&nbsp; =0A=
Sent: Thu 2/23/2006 15:38<BR>&gt;&nbsp; &gt;&nbsp; To: #LI =0A=
JIANGGAN#<BR>&gt;&nbsp; &gt;&nbsp; Cc: =0A=
linuxppc-embedded@ozlabs.org<BR>&gt;&nbsp; &gt;&nbsp; Subject: Re: boot =
failure =0A=
on lite5200b board<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; &gt;&nbsp; #LI =
JIANGGAN# =0A=
wrote:<BR>&gt;&nbsp; &gt;&nbsp; &gt; Hello all,<BR>&gt;&nbsp; &gt;&nbsp; =0A=
&gt;<BR>&gt;&nbsp; &gt;&nbsp; &gt; For my end-of-study project, I am =
working on =0A=
an embedded system with<BR>&gt;&nbsp; &gt;&nbsp; &gt; reference of =
freescale's =0A=
lite5200b reference board. I was trying to<BR>&gt; boot<BR>&gt;&nbsp; =
&gt;&nbsp; =0A=
&gt; Linux 2.6.15 on the board (with the fec and bestcomm =
corrected).<BR>&gt; =0A=
however<BR>&gt;&nbsp; &gt;&nbsp; &gt; the booting was stuck at the =
following =0A=
stage:<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; &gt;&nbsp; In addition to what =
has =0A=
already been said (use a higher address for the<BR>&gt;&nbsp; &gt;&nbsp; =
image =0A=
and don't forget console=3DttyPSC0 in kernel command line), =
make<BR>&gt;&nbsp; =0A=
&gt;&nbsp; sure you use the kernel from my git tree, it contains a few =
patches =0A=
from<BR>&gt;&nbsp; &gt;&nbsp; John Rigby to add support for the =0A=
lite5200b.<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; &gt;&nbsp; Please report if =
it =0A=
works, I've not been able to test those myself since<BR>&gt;&nbsp; =
&gt;&nbsp; =0A=
i'm still on lite5200.<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; =
&gt;<BR>&gt;&nbsp; =0A=
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Sylvain<BR>&gt;&nbsp; =0A=
&gt;<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; =
&gt;<BR>&gt;&nbsp; =0A=
&gt;<BR>&gt;&nbsp; &gt;<BR>&gt;&nbsp; &gt; =0A=
_______________________________________________<BR>&gt;&nbsp; &gt; =0A=
Linuxppc-embedded mailing list<BR>&gt;&nbsp; &gt; =0A=
Linuxppc-embedded@ozlabs.org<BR>&gt;&nbsp; &gt; <A =0A=
href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://oz=
labs.org/mailman/listinfo/linuxppc-embedded</A><BR>&gt;&nbsp; =0A=
&gt;<BR>&gt;&nbsp; =0A=
&gt;<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt;<BR></FONT></P></DIV>=0A=
=0A=
</BODY>=0A=
</HTML>
------_=_NextPart_001_01C63D53.DA3B9BFE--
