Return-Path: <lijianggan@pmail.ntu.edu.sg>
Received: from exsmtp2.ntu.edu.sg (exsmtp2.ntu.edu.sg [155.69.5.9])
	by ozlabs.org (Postfix) with ESMTP id 38D46679E6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Feb 2006 21:16:34 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C63862.37FE594E"
Subject: RE: boot failure on lite5200b board
Date: Thu, 23 Feb 2006 18:13:25 +0800
Message-ID: <84A109BF918D934CB46ACF33BCE187C002D54D7A@mail02.student.main.ntu.edu.sg>
References: <84A109BF918D934CB46ACF33BCE187C002D54D71@mail02.student.main.ntu.edu.sg>
	<43FD6669.9090405@246tNt.com>
From: "#LI JIANGGAN#" <lijianggan@pmail.ntu.edu.sg>
To: "Sylvain Munaut" <tnt@246tNt.com>,
	<linuxppc-embedded@ozlabs.org>
Cc: #WONG CHEE KHIN# <WONG0162@ntu.edu.sg>
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

------_=_NextPart_001_01C63862.37FE594E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thank you Jos=E9 Mar=EDa and Andrey for your advices, however the =
problem remains. I've tried setting the console (though I remember that =
our previous lite5200 board was working fine on kernel 2.4 without =
setting the console); meantime, I've set the booting image to 0x500000; =
I have also tried using the kernel image come together with the BSP, =
it's always the same error.

Sylvain, I've actually using your kernel source, the compiled image is =
around 700k (compared to the 1.4M image from the BSP), but it doesn't =
solve the problem. So I presume that the problem is lying somewhere =
else.

A SNAPSHOT OF THE BOOTING MESSAGES:

U-Boot 1.1.3 (Feb  6 2006 - 09:56:46)

CPU:   MPC5200 v2.2 at 462 MHz
       Bus 132 MHz, IPB 132 MHz, PCI 33 MHz
Board: Freescale MPC5200 (Lite5200B)
I2C:   85 kHz, ready
DRAM:  256 MB
FLASH: 32 MB
PCI:   Bus Dev VenId DevId Class Int
        00  1a  1057  5809  0680  00
In:    serial
Out:   serial
Err:   serial
Net:   FEC ETHERNET
IDE:   Bus 0: OK
  Device 0: not available
  Device 1: not available

Autostarting. Press any key to abort..

Hit any key to stop autoboot:  0
Using FEC ETHERNET device
TFTP from server 10.190.3.103; our IP address is 10.190.3.144
Filename 'MPC5200/uImage'.
Load address: 0x100000
Loading: =
#################################################################
         =
################################################################
done
Bytes transferred =3D 658114 (a0ac2 hex)
## Booting image at 00100000 ...
   Image Name:   Linux-2.6.16-rc1
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    658050 Bytes =3D 642.6 kB
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
arch: exit


I am wondering whether it's a kernel problem or more likely to be a =
problem lying with the U-boot. It seems to hang when executing =
setup_arch() function, or maybe there is sth else behind the wall?

Regards,
Jianggan LI




-----Original Message-----
From: Sylvain Munaut [mailto:tnt@246tNt.com]
Sent: Thu 2/23/2006 15:38
To: #LI JIANGGAN#
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: boot failure on lite5200b board
=20
#LI JIANGGAN# wrote:
> Hello all,
>=20
> For my end-of-study project, I am working on an embedded system with
> reference of freescale's lite5200b reference board. I was trying to =
boot
> Linux 2.6.15 on the board (with the fec and bestcomm corrected). =
however
> the booting was stuck at the following stage:

In addition to what has already been said (use a higher address for the
image and don't forget console=3DttyPSC0 in kernel command line), make
sure you use the kernel from my git tree, it contains a few patches from
John Rigby to add support for the lite5200b.

Please report if it works, I've not been able to test those myself since
i'm still on lite5200.


	Sylvain




------_=_NextPart_001_01C63862.37FE594E
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

<P><FONT SIZE=3D2>Thank you Jos=E9 Mar=EDa and Andrey for your advices, =
however the problem remains. I've tried setting the console (though I =
remember that our previous lite5200 board was working fine on kernel 2.4 =
without setting the console); meantime, I've set the booting image to =
0x500000; I have also tried using the kernel image come together with =
the BSP, it's always the same error.<BR>
<BR>
Sylvain, I've actually using your kernel source, the compiled image is =
around 700k (compared to the 1.4M image from the BSP), but it doesn't =
solve the problem. So I presume that the problem is lying somewhere =
else.<BR>
<BR>
A SNAPSHOT OF THE BOOTING MESSAGES:<BR>
<BR>
U-Boot 1.1.3 (Feb&nbsp; 6 2006 - 09:56:46)<BR>
<BR>
CPU:&nbsp;&nbsp; MPC5200 v2.2 at 462 MHz<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus 132 MHz, IPB 132 MHz, PCI 33 =
MHz<BR>
Board: Freescale MPC5200 (Lite5200B)<BR>
I2C:&nbsp;&nbsp; 85 kHz, ready<BR>
DRAM:&nbsp; 256 MB<BR>
FLASH: 32 MB<BR>
PCI:&nbsp;&nbsp; Bus Dev VenId DevId Class Int<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00&nbsp; 1a&nbsp; 1057&nbsp; =
5809&nbsp; 0680&nbsp; 00<BR>
In:&nbsp;&nbsp;&nbsp; serial<BR>
Out:&nbsp;&nbsp; serial<BR>
Err:&nbsp;&nbsp; serial<BR>
Net:&nbsp;&nbsp; FEC ETHERNET<BR>
IDE:&nbsp;&nbsp; Bus 0: OK<BR>
&nbsp; Device 0: not available<BR>
&nbsp; Device 1: not available<BR>
<BR>
Autostarting. Press any key to abort..<BR>
<BR>
Hit any key to stop autoboot:&nbsp; 0<BR>
Using FEC ETHERNET device<BR>
TFTP from server 10.190.3.103; our IP address is 10.190.3.144<BR>
Filename 'MPC5200/uImage'.<BR>
Load address: 0x100000<BR>
Loading: =
#################################################################<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
################################################################<BR>
done<BR>
Bytes transferred =3D 658114 (a0ac2 hex)<BR>
## Booting image at 00100000 ...<BR>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.16-rc1<BR>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)<BR>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 658050 Bytes =3D 642.6 kB<BR>
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
arch: exit<BR>
<BR>
<BR>
I am wondering whether it's a kernel problem or more likely to be a =
problem lying with the U-boot. It seems to hang when executing =
setup_arch() function, or maybe there is sth else behind the wall?<BR>
<BR>
Regards,<BR>
Jianggan LI<BR>
<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Sylvain Munaut [<A =
HREF=3D"mailto:tnt@246tNt.com">mailto:tnt@246tNt.com</A>]<BR>
Sent: Thu 2/23/2006 15:38<BR>
To: #LI JIANGGAN#<BR>
Cc: linuxppc-embedded@ozlabs.org<BR>
Subject: Re: boot failure on lite5200b board<BR>
<BR>
#LI JIANGGAN# wrote:<BR>
&gt; Hello all,<BR>
&gt;<BR>
&gt; For my end-of-study project, I am working on an embedded system =
with<BR>
&gt; reference of freescale's lite5200b reference board. I was trying to =
boot<BR>
&gt; Linux 2.6.15 on the board (with the fec and bestcomm corrected). =
however<BR>
&gt; the booting was stuck at the following stage:<BR>
<BR>
In addition to what has already been said (use a higher address for =
the<BR>
image and don't forget console=3DttyPSC0 in kernel command line), =
make<BR>
sure you use the kernel from my git tree, it contains a few patches =
from<BR>
John Rigby to add support for the lite5200b.<BR>
<BR>
Please report if it works, I've not been able to test those myself =
since<BR>
i'm still on lite5200.<BR>
<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sylvain<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C63862.37FE594E--
