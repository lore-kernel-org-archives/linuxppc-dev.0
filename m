Return-Path: <pankaj.patil@hp.com>
Received: from ccerelbas02.cce.hp.com (ccerelbas02.cce.hp.com [161.114.21.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ccerelbas02.cce.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 387D067A66
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Mar 2006 04:20:05 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C64142.30D5D162"
Subject: RE: INIT:
Date: Mon, 6 Mar 2006 10:19:56 -0700
Message-ID: <9B832BEB407A774AA0520CCFC23221970663EA3A@CXOEXC11.AMERICAS.CPQCORP.NET>
From: "Patil, Pankaj P." <Pankaj.Patil@hp.com>
To: "Paulinha" <gnathita@gmail.com>, <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C64142.30D5D162
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I'll look into those config settings. While we are talking about config =
settings, i noticed i had CONFIG_VT turned on. I do the make ARCH=3Dppc =
xconfig but i cannot find the setting where CONFIG_VT gets turned on. I =
don't want to use the virtual terminal & i believe since the kernel is =
getting configured with CONFIG_VT=3Dy, it is trying to mount tty0 which =
is not part of my root file system. Does that make sense??
Is CONFIG_VT dependent on some other config setting?? How do i get =
CONFIG_VT set to n??
=20
thanks
pankaj
=20
=20

-----Original Message-----
From: Paulinha [mailto:gnathita@gmail.com]
Sent: Monday, March 06, 2006 12:55 AM
To: Patil, Pankaj P.; linuxppc-embedded@ozlabs.org
Subject: Re: INIT:


... and TLB support!!

Paula=20




On 3/3/06, Patil, Pankaj P. < Pankaj.Patil@hp.com> wrote:=20

I do have  /dev/console in my file system. In fact , i used ethereal on =
the host to see how far the INIT goes.
I saw all the usual NFS Lookup calls like /lib, /ld-  <http://2.3.1.so> =
2.3.1.so ..... /libc-  <http://2.31.so> 2.31.so
The last NFS lookup call looks like DH:0xbea72a4a/tty0
There are bunch of read replys after that but no more NFS lookups. Is it =
normal to see a NFS Lookup that looks like 0xbea72a4a/tty0 ??
What should be the next NFS Lookup call?
I did some searching from previous posts but haven't found exactly what =
i am looking for. I am attaching a link to something that looks similar =
to my problem. Just in case, someone's having trouble understanding my =
issue.
http://ozlabs.org/pipermail/linuxppc-embedded/2004-August/015250.html  =
<http://ozlabs.org/pipermail/linuxppc-embedded/2004-August/015250.html>=20

Thanks
pankaj

-----Original Message-----=20
From: atul.sabharwal@exgate.tek.com
[mailto:  <mailto:atul.sabharwal@exgate.tek.com> =
atul.sabharwal@exgate.tek.com]
Sent: Tuesday, February 28, 2006 6:03 PM=20
To: Patil, Pankaj P.
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: INIT:


Easy answer is do you have /dev/console in your file system.  Glibc=20
opens
/dev/console and the kernel uses /dev/ttyS0 as specified on the command
line.  There should not be any app calling uart_close as the console
deriver
should be opening it.

--
Atul

Hi,
I am running u-boot & linux2.6.12 on a custom ppc board(functional HW).
I can get to the point where u-boot loads the kernel, kernel does all
the initialization,  loads the Root File System over NFS & calls the
Init process.
Next, i am expecting to see a shell prompt. I am not sure where in the=20
Init process i am failing. I have written my own serial driver(Philips
SC28L194 Quad UART--under development-possible culprit). The printks
work just fine.
All i see is the kernel calling the Init process & after a minute or so=20
i see uart_close call.
The kernel runs just fine & responds to ping.
What can trigger a uart_close??(tty_release calls release_dev calls
uart_close) I have a JTAG debugger. What's the best way to debug once=20
Init process is running??



I am attaching a dump of my console:
U-Boot 1.1.3 (Dec 16 2005 - 16:00:23), Build: 0.4.1

SysClock =3D 120Mhz , TClock =3D 120Mhz
CPU:   MPC7447A v1.1 @ 960 MHz
CPU bus mode : 60x=20

DRAM:  SPD Checksum ok!
-- DIMM1 has 2 banks
-- DIMM2 has 0 banks
ECC Initialization of Bank 0: Done
CAS Latency =3D 2 tRP =3D 3 tRAS =3D 6 tRCD=3D3
Total SDRAM memory is 1024 MB
Now running in RAM - U-Boot at: 00fc0000=20
Remapped Internal SRAM to 0xf2000000
Remapped Flash Card to 0xffc00000
FLASH:  4 MB
Addresses 32M - 0M are saved for the U-Boot usage.
Mem malloc Initialization (32M - 16M): Done

Internal SRAM ECC Initialization: Done=20
***Phy Reset***
Phy Auto-Negotiation Bit ReEnabled in SW
Net:   , mv_enet1 [PRIME]
Hit any key to stop autoboot:  0
Ethernet status port 1: Link up, Full Duplex, Speed 100 Mbps
Using mv_enet1 device
TFTP from server 192.168.1.1; our IP address is 192.168.1.2
Filename 'uImage'.
Load address: 0x400000
Loading:
#################################################################=20

#################################################################

#################################################################
         ########################
done
Bytes transferred =3D 1119847 (111667 hex)=20

### Network statistics: ###
--------------------------
Packets received:              2192
Packets send:                  2191
Received bytes:                2347583
Send bytes:                    100803
## Booting image at 00400000 ...
   Image Name:   Linux-2.6.12
   Created:      2006-02-14   0:37:17 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1119783 Bytes =3D   1.1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## cmdline at 0x007FFF00 ... 0x007FFF98
memstart    =3D 0x00000000
memsize     =3D 0x40000000=20
flashstart  =3D 0xFFC00000
flashsize   =3D 0x00400000
flashoffset =3D 0x00000000
sramstart   =3D 0xF8000000
sramsize    =3D 0x00400000
bootflags   =3D 0x00000001
intfreq     =3D    960 MHz
busfreq     =3D    120 MHz=20
ethaddr     =3D 64:00:00:00:00:00
IP addr     =3D 192.168.1.2
baudrate    =3D 115200 bps
tclk        =3D      0 MHz=20
uboot_ver   =3D 0.4.1a
L3 was init =3D 0
Total memory =3D 768MB; using 2048kB for hash table (at c0400000)=20
Linux version 2.6.12 (root@RHEL40) (gcc version 3.3.3 (DENX ELDK 3.1.1
3.3.3-10)) #154 Mon Feb 13 17:36:35 MST 2006
System Identification:
Freescale 74XX port
Built 1 zonelists
Kernel command line: console=3DttyS0,115200 root=3D/dev/nfs rw=20
nfsroot=3D192.168.1.1:/target/chestnut/rootfs
ip=3D 192.168.1.2:192.168.1.1:  <http://192.168.1.1:255> =
192.168.1.1:255.255.255.0:DB64xxx:eth0:non
e
PID hash table entries: 4096 (order: 12, 65536 bytes)=20
time_init: decrementer frequency =3D 30.000000 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)=20
Memory: 774400k available (1596k kernel code, 556k data, 344k init, 0k
highmem)
Mount-cache hash table entries: 512

NET: Registered protocol family 16
PCI: Probing PCI hardware
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.=20
Generic RTC Driver v1.07
Serial: SC28L194 driver 4 ports
ttyS0 at MMIO 0x0 (irq =3D 17) is a PHILIPS SC28L194
ttyS1 at MMIO 0x0 (irq =3D 17) is a PHILIPS SC28L194
ttyS2 at MMIO 0x0 (irq =3D 17) is a PHILIPS SC28L194=20
ttyS3 at MMIO 0x0 (irq =3D 17) is a PHILIPS SC28L194
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize=20
loop: loaded (max 8 devices)
MV-643xx 10/100/1000 Ethernet Driver
eth0: port 1 with MAC address 00:11:85:da:0b:02
eth0: RX NAPI Enabled
physmap flash device: 400000 at ffc00000
mice: PS/2 mouse device common for all mice=20
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)=20
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
IP-Config: Complete:
      device=3Deth0, addr=3D  <http://192.168.1.2> 192.168.1.2 , mask=3D =
255.255.255.0, gw=3D  <http://192.168.1.1> 192.168.1.1,
     host=3DDB64xxx, domain=3D, nis-domain=3D(none),
     bootserver=3D 192.168.1.1 , rootserver=3D 192.168.1.1, rootpath=3D
Looking up port of RPC 100003/2 on 192.168.1.1
Looking up port of RPC 100005/1 on 192.168.1.1  <http://192.168.1.1>=20
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 344k init


Any help appreceated.
Thanks
pankaj


_______________________________________________
Linuxppc-embedded mailing list=20
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
_______________________________________________=20
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded  =
<https://ozlabs.org/mailman/listinfo/linuxppc-embedded>=20





------_=_NextPart_001_01C64142.30D5D162
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">


<META content=3D"MSHTML 6.00.2800.1528" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D265191117-06032006><FONT face=3DArial color=3D#0000ff =
size=3D2>I'll=20
look into those config settings. While we are talking about config =
settings, i=20
noticed i had CONFIG_VT turned on. I do the make ARCH=3Dppc xconfig but =
i cannot=20
find the setting where CONFIG_VT gets turned on. I don't want to use the =
virtual=20
terminal &amp; i believe since the kernel is getting configured with=20
CONFIG_VT=3Dy, it is trying to mount tty0 which is not part of my root =
file=20
system. Does that make sense??</FONT></SPAN></DIV>
<DIV><SPAN class=3D265191117-06032006><FONT face=3DArial color=3D#0000ff =
size=3D2>Is=20
CONFIG_VT dependent on some other config setting?? How do i get =
CONFIG_VT set to=20
n??</FONT></SPAN></DIV>
<DIV><SPAN class=3D265191117-06032006><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D265191117-06032006><FONT face=3DArial color=3D#0000ff =

size=3D2>thanks</FONT></SPAN></DIV>
<DIV><SPAN class=3D265191117-06032006><FONT face=3DArial color=3D#0000ff =

size=3D2>pankaj</FONT></SPAN></DIV>
<DIV><SPAN class=3D265191117-06032006><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D265191117-06032006><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<BLOCKQUOTE>
  <DIV class=3DOutlookMessageHeader dir=3Dltr align=3Dleft><FONT =
face=3DTahoma=20
  size=3D2>-----Original Message-----<BR><B>From:</B> Paulinha=20
  [mailto:gnathita@gmail.com]<BR><B>Sent:</B> Monday, March 06, 2006 =
12:55=20
  AM<BR><B>To:</B> Patil, Pankaj P.;=20
  linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> Re: =
INIT:<BR><BR></FONT></DIV>
  <DIV>
  <DIV>... and TLB support!!<BR><BR>Paula <BR></DIV><BR>
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: =
rgb(204,204,204) 1px solid">
    <DIV style=3D"DIRECTION: ltr"><SPAN class=3De =
id=3Dq_109ce80ff1d4280f_1>
    <DIV><SPAN class=3Dgmail_quote>On 3/3/06, <B =
class=3Dgmail_sendername>Patil,=20
    Pankaj P.</B> &lt;<A onclick=3D"return =
top.js.OpenExtLink(window,event,this)"=20
    href=3D"mailto:Pankaj.Patil@hp.com" =
target=3D_blank>Pankaj.Patil@hp.com</A>&gt;=20
    wrote:</SPAN>
    <BLOCKQUOTE class=3Dgmail_quote=20
    style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: =
rgb(204,204,204) 1px solid">I=20
      do have&nbsp;&nbsp;/dev/console in my file system. In fact , i =
used=20
      ethereal on the host to see how far the INIT goes.<BR>I saw all =
the usual=20
      NFS Lookup calls like /lib, /ld-<A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"http://2.3.1.so" target=3D_blank> 2.3.1.so</A> ..... =
/libc-<A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"http://2.31.so" target=3D_blank> 2.31.so</A><BR>The last =
NFS lookup=20
      call looks like DH:0xbea72a4a/tty0<BR>There are bunch of read =
replys after=20
      that but no more NFS lookups. Is it normal to see a NFS Lookup =
that looks=20
      like 0xbea72a4a/tty0 ??<BR>What should be the next NFS Lookup =
call?<BR>I=20
      did some searching from previous posts but haven't found exactly =
what i am=20
      looking for. I am attaching a link to something that looks similar =
to my=20
      problem. Just in case, someone's having trouble understanding my=20
      issue.<BR><A onclick=3D"return =
top.js.OpenExtLink(window,event,this)"=20
      =
href=3D"http://ozlabs.org/pipermail/linuxppc-embedded/2004-August/015250.=
html"=20
      =
target=3D_blank>http://ozlabs.org/pipermail/linuxppc-embedded/2004-August=
/015250.html=20
      </A><BR><BR>Thanks<BR>pankaj<BR><BR>-----Original Message----- =
<BR>From:=20
      <A onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"mailto:atul.sabharwal@exgate.tek.com"=20
      target=3D_blank>atul.sabharwal@exgate.tek.com</A><BR>[mailto:<A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"mailto:atul.sabharwal@exgate.tek.com" target=3D_blank>=20
      atul.sabharwal@exgate.tek.com</A>]<BR>Sent: Tuesday, February 28, =
2006=20
      6:03 PM <BR>To: Patil, Pankaj P.<BR>Cc: <A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"mailto:linuxppc-embedded@ozlabs.org"=20
      target=3D_blank>linuxppc-embedded@ozlabs.org</A><BR>Subject: RE:=20
      INIT:<BR><BR><BR>Easy answer is do you have /dev/console in your =
file=20
      system.&nbsp;&nbsp;Glibc <BR>opens<BR>/dev/console and the kernel =
uses=20
      /dev/ttyS0 as specified on the command<BR>line.&nbsp;&nbsp;There =
should=20
      not be any app calling uart_close as the =
console<BR>deriver<BR>should be=20
      opening it.<BR><BR>--<BR>Atul<BR><BR>Hi,<BR>I am running u-boot =
&amp;=20
      linux2.6.12 on a custom ppc board(functional HW).<BR>I can get to =
the=20
      point where u-boot loads the kernel, kernel does all<BR>the=20
      initialization,&nbsp;&nbsp;loads the Root File System over NFS =
&amp; calls=20
      the<BR>Init process.<BR>Next, i am expecting to see a shell =
prompt. I am=20
      not sure where in the <BR>Init process i am failing. I have =
written my own=20
      serial driver(Philips<BR>SC28L194 Quad UART--under =
development-possible=20
      culprit). The printks<BR>work just fine.<BR>All i see is the =
kernel=20
      calling the Init process &amp; after a minute or so <BR>i see =
uart_close=20
      call.<BR>The kernel runs just fine &amp; responds to ping.<BR>What =
can=20
      trigger a uart_close??(tty_release calls release_dev =
calls<BR>uart_close)=20
      I have a JTAG debugger. What's the best way to debug once <BR>Init =
process=20
      is running??<BR><BR><BR><BR>I am attaching a dump of my =
console:<BR>U-Boot=20
      1.1.3 (Dec 16 2005 - 16:00:23), Build: 0.4.1<BR><BR>SysClock =3D =
120Mhz ,=20
      TClock =3D 120Mhz<BR>CPU:&nbsp;&nbsp; MPC7447A v1.1 @ 960 =
MHz<BR>CPU bus=20
      mode : 60x <BR><BR>DRAM:&nbsp;&nbsp;SPD Checksum ok!<BR>-- DIMM1 =
has 2=20
      banks<BR>-- DIMM2 has 0 banks<BR>ECC Initialization of Bank 0: =
Done<BR>CAS=20
      Latency =3D 2 tRP =3D 3 tRAS =3D 6 tRCD=3D3<BR>Total SDRAM memory =
is 1024=20
      MB<BR>Now running in RAM - U-Boot at: 00fc0000 <BR>Remapped =
Internal SRAM=20
      to 0xf2000000<BR>Remapped Flash Card to =
0xffc00000<BR>FLASH:&nbsp;&nbsp;4=20
      MB<BR>Addresses 32M - 0M are saved for the U-Boot usage.<BR>Mem =
malloc=20
      Initialization (32M - 16M): Done<BR><BR>Internal SRAM ECC =
Initialization:=20
      Done <BR>***Phy Reset***<BR>Phy Auto-Negotiation Bit ReEnabled in=20
      SW<BR>Net:&nbsp;&nbsp; , mv_enet1 [PRIME]<BR>Hit any key to stop=20
      autoboot:&nbsp;&nbsp;0<BR>Ethernet status port 1: Link up, Full =
Duplex,=20
      Speed 100 Mbps<BR>Using mv_enet1 device<BR>TFTP from server <A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"http://192.168.1.1" target=3D_blank>192.168.1.1</A>; our =
IP address is=20
      <A onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"http://192.168.1.2" =
target=3D_blank>192.168.1.2</A><BR>Filename=20
      'uImage'.<BR>Load address:=20
      =
0x400000<BR>Loading:<BR>#################################################=
################=20
      =
<BR><BR>#################################################################=
<BR><BR>#################################################################=
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
      ########################<BR>done<BR>Bytes transferred =3D 1119847 =
(111667=20
      hex) <BR><BR>### Network statistics:=20
      ###<BR>--------------------------<BR>Packets=20
      =
received:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;2192<BR>Packets=20
      =
send:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2191<BR>Received=20
      =
bytes:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2347583<BR>Send=20
      =
bytes:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;100803<BR>##=20
      Booting image at 00400000 ...<BR>&nbsp;&nbsp; Image =
Name:&nbsp;&nbsp;=20
      Linux-2.6.12<BR>&nbsp;&nbsp;=20
      Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2006-02-14&nbsp;&nbsp; =
0:37:17=20
      UTC<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel =
Image=20
      (gzip compressed)<BR>&nbsp;&nbsp; Data=20
      Size:&nbsp;&nbsp;&nbsp;&nbsp;1119783 Bytes =3D&nbsp;&nbsp; 1.1=20
      MB<BR>&nbsp;&nbsp; Load Address: 00000000<BR>&nbsp;&nbsp; Entry=20
      Point:&nbsp;&nbsp;00000000<BR>&nbsp;&nbsp; Verifying Checksum ...=20
      OK<BR>&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>## cmdline =
at=20
      0x007FFF00 ... 0x007FFF98<BR>memstart&nbsp;&nbsp;&nbsp;&nbsp;=3D=20
      0x00000000<BR>memsize&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x40000000=20
      <BR>flashstart&nbsp;&nbsp;=3D 0xFFC00000<BR>flashsize&nbsp;&nbsp; =
=3D=20
      0x00400000<BR>flashoffset =3D 0x00000000<BR>sramstart&nbsp;&nbsp; =
=3D=20
      0xF8000000<BR>sramsize&nbsp;&nbsp;&nbsp;&nbsp;=3D=20
      0x00400000<BR>bootflags&nbsp;&nbsp; =3D=20
      0x00000001<BR>intfreq&nbsp;&nbsp;&nbsp;&nbsp; =
=3D&nbsp;&nbsp;&nbsp;&nbsp;960=20
      MHz<BR>busfreq&nbsp;&nbsp;&nbsp;&nbsp; =
=3D&nbsp;&nbsp;&nbsp;&nbsp;120 MHz=20
      <BR>ethaddr&nbsp;&nbsp;&nbsp;&nbsp; =3D 64:00:00:00:00:00<BR>IP=20
      addr&nbsp;&nbsp;&nbsp;&nbsp; =3D <A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"http://192.168.1.2"=20
      =
target=3D_blank>192.168.1.2</A><BR>baudrate&nbsp;&nbsp;&nbsp;&nbsp;=3D =
115200=20
      =
bps<BR>tclk&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;0=20
      MHz <BR>uboot_ver&nbsp;&nbsp; =3D 0.4.1a<BR>L3 was init =3D =
0<BR>Total memory=20
      =3D 768MB; using 2048kB for hash table (at c0400000) <BR>Linux =
version=20
      2.6.12 (root@RHEL40) (gcc version 3.3.3 (DENX ELDK =
3.1.1<BR>3.3.3-10))=20
      #154 Mon Feb 13 17:36:35 MST 2006<BR>System =
Identification:<BR>Freescale=20
      74XX port<BR>Built 1 zonelists<BR>Kernel command line:=20
      console=3DttyS0,115200 root=3D/dev/nfs rw=20
      <BR>nfsroot=3D192.168.1.1:/target/chestnut/rootfs<BR>ip=3D<A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"http://192.168.1.2:192" =
target=3D_blank>192.168.1.2:192</A>.168.1.1:<A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"http://192.168.1.1:255" target=3D_blank>=20
      192.168.1.1:255</A>.255.255.0:DB64xxx:eth0:non<BR>e<BR>PID hash =
table=20
      entries: 4096 (order: 12, 65536 bytes) <BR>time_init: decrementer=20
      frequency =3D 30.000000 MHz<BR>Console: colour dummy device =
80x25<BR>Dentry=20
      cache hash table entries: 131072 (order: 7, 524288 =
bytes)<BR>Inode-cache=20
      hash table entries: 65536 (order: 6, 262144 bytes) <BR>Memory: =
774400k=20
      available (1596k kernel code, 556k data, 344k init,=20
      0k<BR>highmem)<BR>Mount-cache hash table entries: 512<BR><BR>NET:=20
      Registered protocol family 16<BR>PCI: Probing PCI =
hardware<BR>JFFS2=20
      version 2.2. (C) 2001-2003 Red Hat, Inc. <BR>Generic RTC Driver=20
      v1.07<BR>Serial: SC28L194 driver 4 ports<BR>ttyS0 at MMIO 0x0 (irq =
=3D 17)=20
      is a PHILIPS SC28L194<BR>ttyS1 at MMIO 0x0 (irq =3D 17) is a =
PHILIPS=20
      SC28L194<BR>ttyS2 at MMIO 0x0 (irq =3D 17) is a PHILIPS SC28L194 =
<BR>ttyS3=20
      at MMIO 0x0 (irq =3D 17) is a PHILIPS SC28L194<BR>io scheduler =
noop=20
      registered<BR>io scheduler anticipatory registered<BR>io scheduler =

      deadline registered<BR>io scheduler cfq registered<BR>RAMDISK =
driver=20
      initialized: 16 RAM disks of 4096K size 1024 blocksize <BR>loop: =
loaded=20
      (max 8 devices)<BR>MV-643xx 10/100/1000 Ethernet Driver<BR>eth0: =
port 1=20
      with MAC address 00:11:85:da:0b:02<BR>eth0: RX NAPI =
Enabled<BR>physmap=20
      flash device: 400000 at ffc00000<BR>mice: PS/2 mouse device common =
for all=20
      mice <BR>NET: Registered protocol family 2<BR>IP: routing cache =
hash table=20
      of 8192 buckets, 64Kbytes<BR>TCP established hash table entries: =
131072=20
      (order: 8, 1048576 bytes)<BR>TCP bind hash table entries: 65536 =
(order: 6,=20
      262144 bytes) <BR>TCP: Hash tables configured (established 131072 =
bind=20
      65536)<BR>NET: Registered protocol family 1<BR>NET: Registered =
protocol=20
      family 17<BR>IP-Config:=20
      Complete:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;device=3Deth0, =
addr=3D<A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"http://192.168.1.2" target=3D_blank> 192.168.1.2 </A>, =
mask=3D<A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"http://255.255.255.0" target=3D_blank>255.255.255.0</A>, =
gw=3D<A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"http://192.168.1.1" target=3D_blank>=20
      192.168.1.1</A>,<BR>&nbsp;&nbsp;&nbsp;&nbsp; host=3DDB64xxx, =
domain=3D,=20
      nis-domain=3D(none),<BR>&nbsp;&nbsp;&nbsp;&nbsp; bootserver=3D<A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"http://192.168.1.1" target=3D_blank>192.168.1.1</A> , =
rootserver=3D<A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"http://192.168.1.1" target=3D_blank>192.168.1.1</A>,=20
      rootpath=3D<BR>Looking up port of RPC 100003/2 on <A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"http://192.168.1.1" =
target=3D_blank>192.168.1.1</A><BR>Looking up port=20
      of RPC 100005/1 on <A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"http://192.168.1.1" target=3D_blank>192.168.1.1 =
</A><BR>VFS: Mounted=20
      root (nfs filesystem).<BR>Freeing unused kernel memory: 344k=20
      init<BR><BR><BR>Any help=20
      =
appreceated.<BR>Thanks<BR>pankaj<BR><BR><BR>_____________________________=
__________________<BR>Linuxppc-embedded=20
      mailing list <BR><A onclick=3D"return =
top.js.OpenExtLink(window,event,this)"=20
      href=3D"mailto:Linuxppc-embedded@ozlabs.org"=20
      target=3D_blank>Linuxppc-embedded@ozlabs.org</A><BR><A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded"=20
      =
target=3D_blank>https://ozlabs.org/mailman/listinfo/linuxppc-embedded</A>=
<BR>_______________________________________________=20
      <BR>Linuxppc-embedded mailing list<BR><A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"mailto:Linuxppc-embedded@ozlabs.org"=20
      target=3D_blank>Linuxppc-embedded@ozlabs.org</A><BR><A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded"=20
      =
target=3D_blank>https://ozlabs.org/mailman/listinfo/linuxppc-embedded=20
      =
</A><BR></BLOCKQUOTE></DIV><BR></SPAN></DIV></BLOCKQUOTE></DIV><BR></BLOC=
KQUOTE></BODY></HTML>

------_=_NextPart_001_01C64142.30D5D162--
