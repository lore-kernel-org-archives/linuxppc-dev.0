Return-Path: <gnathita@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.196])
	by ozlabs.org (Postfix) with ESMTP id 2C0C267B5E
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Mar 2006 18:55:30 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id 14so1176459nzn
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 05 Mar 2006 23:55:29 -0800 (PST)
Message-ID: <259581790603052355t70bfc2ffl52e4d1ebe4cd25c9@mail.gmail.com>
Date: Mon, 6 Mar 2006 08:55:28 +0100
From: Paulinha <gnathita@gmail.com>
To: "Patil, Pankaj P." <Pankaj.Patil@hp.com>, linuxppc-embedded@ozlabs.org
Subject: Re: INIT:
In-Reply-To: <259581790603052341s15f21579yb3870adbde1f075e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5869_20361772.1141631728208"
References: <9B832BEB407A774AA0520CCFC23221970663EA35@CXOEXC11.AMERICAS.CPQCORP.NET>
	<259581790603052341s15f21579yb3870adbde1f075e@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_5869_20361772.1141631728208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

... and TLB support!!

Paula

On 3/3/06, Patil, Pankaj P. <Pankaj.Patil@hp.com> wrote:
> >
> > I do have  /dev/console in my file system. In fact , i used ethereal on
> > the host to see how far the INIT goes.
> > I saw all the usual NFS Lookup calls like /lib, /ld-2.3.1.so .....
> > /libc- 2.31.so
> > The last NFS lookup call looks like DH:0xbea72a4a/tty0
> > There are bunch of read replys after that but no more NFS lookups. Is i=
t
> > normal to see a NFS Lookup that looks like 0xbea72a4a/tty0 ??
> > What should be the next NFS Lookup call?
> > I did some searching from previous posts but haven't found exactly what
> > i am looking for. I am attaching a link to something that looks similar=
 to
> > my problem. Just in case, someone's having trouble understanding my iss=
ue.
> > http://ozlabs.org/pipermail/linuxppc-embedded/2004-August/015250.html
> >
> > Thanks
> > pankaj
> >
> > -----Original Message-----
> > From: atul.sabharwal@exgate.tek.com
> > [mailto:atul.sabharwal@exgate.tek.com]
> > Sent: Tuesday, February 28, 2006 6:03 PM
> > To: Patil, Pankaj P.
> > Cc: linuxppc-embedded@ozlabs.org
> > Subject: RE: INIT:
> >
> >
> > Easy answer is do you have /dev/console in your file system.  Glibc
> > opens
> > /dev/console and the kernel uses /dev/ttyS0 as specified on the command
> > line.  There should not be any app calling uart_close as the console
> > deriver
> > should be opening it.
> >
> > --
> > Atul
> >
> > Hi,
> > I am running u-boot & linux2.6.12 on a custom ppc board(functional HW).
> > I can get to the point where u-boot loads the kernel, kernel does all
> > the initialization,  loads the Root File System over NFS & calls the
> > Init process.
> > Next, i am expecting to see a shell prompt. I am not sure where in the
> > Init process i am failing. I have written my own serial driver(Philips
> > SC28L194 Quad UART--under development-possible culprit). The printks
> > work just fine.
> > All i see is the kernel calling the Init process & after a minute or so
> > i see uart_close call.
> > The kernel runs just fine & responds to ping.
> > What can trigger a uart_close??(tty_release calls release_dev calls
> > uart_close) I have a JTAG debugger. What's the best way to debug once
> > Init process is running??
> >
> >
> >
> > I am attaching a dump of my console:
> > U-Boot 1.1.3 (Dec 16 2005 - 16:00:23), Build: 0.4.1
> >
> > SysClock =3D 120Mhz , TClock =3D 120Mhz
> > CPU:   MPC7447A v1.1 @ 960 MHz
> > CPU bus mode : 60x
> >
> > DRAM:  SPD Checksum ok!
> > -- DIMM1 has 2 banks
> > -- DIMM2 has 0 banks
> > ECC Initialization of Bank 0: Done
> > CAS Latency =3D 2 tRP =3D 3 tRAS =3D 6 tRCD=3D3
> > Total SDRAM memory is 1024 MB
> > Now running in RAM - U-Boot at: 00fc0000
> > Remapped Internal SRAM to 0xf2000000
> > Remapped Flash Card to 0xffc00000
> > FLASH:  4 MB
> > Addresses 32M - 0M are saved for the U-Boot usage.
> > Mem malloc Initialization (32M - 16M): Done
> >
> > Internal SRAM ECC Initialization: Done
> > ***Phy Reset***
> > Phy Auto-Negotiation Bit ReEnabled in SW
> > Net:   , mv_enet1 [PRIME]
> > Hit any key to stop autoboot:  0
> > Ethernet status port 1: Link up, Full Duplex, Speed 100 Mbps
> > Using mv_enet1 device
> > TFTP from server 192.168.1.1; our IP address is 192.168.1.2
> > Filename 'uImage'.
> > Load address: 0x400000
> > Loading:
> > #################################################################
> >
> > #################################################################
> >
> > #################################################################
> >          ########################
> > done
> > Bytes transferred =3D 1119847 (111667 hex)
> >
> > ### Network statistics: ###
> > --------------------------
> > Packets received:              2192
> > Packets send:                  2191
> > Received bytes:                2347583
> > Send bytes:                    100803
> > ## Booting image at 00400000 ...
> >    Image Name:   Linux-2.6.12
> >    Created:      2006-02-14   0:37:17 UTC
> >    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> >    Data Size:    1119783 Bytes =3D   1.1 MB
> >    Load Address: 00000000
> >    Entry Point:  00000000
> >    Verifying Checksum ... OK
> >    Uncompressing Kernel Image ... OK
> > ## cmdline at 0x007FFF00 ... 0x007FFF98
> > memstart    =3D 0x00000000
> > memsize     =3D 0x40000000
> > flashstart  =3D 0xFFC00000
> > flashsize   =3D 0x00400000
> > flashoffset =3D 0x00000000
> > sramstart   =3D 0xF8000000
> > sramsize    =3D 0x00400000
> > bootflags   =3D 0x00000001
> > intfreq     =3D    960 MHz
> > busfreq     =3D    120 MHz
> > ethaddr     =3D 64:00:00:00:00:00
> > IP addr     =3D 192.168.1.2
> > baudrate    =3D 115200 bps
> > tclk        =3D      0 MHz
> > uboot_ver   =3D 0.4.1a
> > L3 was init =3D 0
> > Total memory =3D 768MB; using 2048kB for hash table (at c0400000)
> > Linux version 2.6.12 (root@RHEL40) (gcc version 3.3.3 (DENX ELDK 3.1.1
> > 3.3.3-10)) #154 Mon Feb 13 17:36:35 MST 2006
> > System Identification:
> > Freescale 74XX port
> > Built 1 zonelists
> > Kernel command line: console=3DttyS0,115200 root=3D/dev/nfs rw
> > nfsroot=3D192.168.1.1:/target/chestnut/rootfs
> > ip=3D192.168.1.2:192.168.1.1:192.168.1.1:255.255.255.0:DB64xxx:eth0:non
> > e
> > PID hash table entries: 4096 (order: 12, 65536 bytes)
> > time_init: decrementer frequency =3D 30.000000 MHz
> > Console: colour dummy device 80x25
> > Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> > Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> > Memory: 774400k available (1596k kernel code, 556k data, 344k init, 0k
> > highmem)
> > Mount-cache hash table entries: 512
> >
> > NET: Registered protocol family 16
> > PCI: Probing PCI hardware
> > JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
> > Generic RTC Driver v1.07
> > Serial: SC28L194 driver 4 ports
> > ttyS0 at MMIO 0x0 (irq =3D 17) is a PHILIPS SC28L194
> > ttyS1 at MMIO 0x0 (irq =3D 17) is a PHILIPS SC28L194
> > ttyS2 at MMIO 0x0 (irq =3D 17) is a PHILIPS SC28L194
> > ttyS3 at MMIO 0x0 (irq =3D 17) is a PHILIPS SC28L194
> > io scheduler noop registered
> > io scheduler anticipatory registered
> > io scheduler deadline registered
> > io scheduler cfq registered
> > RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> > loop: loaded (max 8 devices)
> > MV-643xx 10/100/1000 Ethernet Driver
> > eth0: port 1 with MAC address 00:11:85:da:0b:02
> > eth0: RX NAPI Enabled
> > physmap flash device: 400000 at ffc00000
> > mice: PS/2 mouse device common for all mice
> > NET: Registered protocol family 2
> > IP: routing cache hash table of 8192 buckets, 64Kbytes
> > TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
> > TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
> > TCP: Hash tables configured (established 131072 bind 65536)
> > NET: Registered protocol family 1
> > NET: Registered protocol family 17
> > IP-Config: Complete:
> >       device=3Deth0, addr=3D192.168.1.2 , mask=3D255.255.255.0, gw=3D19=
2.168.1.1
> > ,
> >      host=3DDB64xxx, domain=3D, nis-domain=3D(none),
> >      bootserver=3D192.168.1.1 , rootserver=3D192.168.1.1, rootpath=3D
> > Looking up port of RPC 100003/2 on 192.168.1.1
> > Looking up port of RPC 100005/1 on 192.168.1.1
> > VFS: Mounted root (nfs filesystem).
> > Freeing unused kernel memory: 344k init
> >
> >
> > Any help appreceated.
> > Thanks
> > pankaj
> >
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
>
>

------=_Part_5869_20361772.1141631728208
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div><div>... and TLB support!!<br>
<br>
Paula <br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div st=
yle=3D"direction: ltr;"><span class=3D"e" id=3D"q_109ce80ff1d4280f_1"><div>=
<span class=3D"gmail_quote">
On 3/3/06, <b class=3D"gmail_sendername">Patil, Pankaj P.</b> &lt;<a href=
=3D"mailto:Pankaj.Patil@hp.com" target=3D"_blank" onclick=3D"return top.js.=
OpenExtLink(window,event,this)">Pankaj.Patil@hp.com</a>&gt; wrote:</span><b=
lockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 20=
4, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

I do have&nbsp;&nbsp;/dev/console in my file system. In fact , i used ether=
eal on the host to see how far the INIT goes.<br>I saw all the usual NFS Lo=
okup calls like /lib, /ld-<a href=3D"http://2.3.1.so" target=3D"_blank" onc=
lick=3D"return top.js.OpenExtLink(window,event,this)">
2.3.1.so</a> ..... /libc-<a href=3D"http://2.31.so" target=3D"_blank" oncli=
ck=3D"return top.js.OpenExtLink(window,event,this)">
2.31.so</a><br>The last NFS lookup call looks like DH:0xbea72a4a/tty0<br>Th=
ere
are bunch of read replys after that but no more NFS lookups. Is it
normal to see a NFS Lookup that looks like 0xbea72a4a/tty0 ??<br>What shoul=
d be the next NFS Lookup call?<br>I
did some searching from previous posts but haven't found exactly what i
am looking for. I am attaching a link to something that looks similar
to my problem. Just in case, someone's having trouble understanding my
issue.<br><a href=3D"http://ozlabs.org/pipermail/linuxppc-embedded/2004-Aug=
ust/015250.html" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(win=
dow,event,this)">http://ozlabs.org/pipermail/linuxppc-embedded/2004-August/=
015250.html
</a><br><br>Thanks<br>pankaj<br><br>-----Original Message-----
<br>From: <a href=3D"mailto:atul.sabharwal@exgate.tek.com" target=3D"_blank=
" onclick=3D"return top.js.OpenExtLink(window,event,this)">atul.sabharwal@e=
xgate.tek.com</a><br>[mailto:<a href=3D"mailto:atul.sabharwal@exgate.tek.co=
m" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this=
)">
atul.sabharwal@exgate.tek.com</a>]<br>Sent: Tuesday, February 28, 2006 6:03=
 PM
<br>To: Patil, Pankaj P.<br>Cc: <a href=3D"mailto:linuxppc-embedded@ozlabs.=
org" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,th=
is)">linuxppc-embedded@ozlabs.org</a><br>Subject: RE: INIT:<br><br><br>Easy=
 answer is do you have /dev/console in your file system.&nbsp;&nbsp;Glibc
<br>opens<br>
/dev/console and the kernel uses /dev/ttyS0 as specified on the command<br>=
line.&nbsp;&nbsp;There should not be any app calling uart_close as the cons=
ole<br>deriver<br>should be opening it.<br><br>--<br>Atul<br><br>Hi,<br>I a=
m running u-boot &amp;=20
linux2.6.12 on a custom ppc board(functional HW).<br>I can get to the point=
 where u-boot loads the kernel, kernel does all<br>the initialization,&nbsp=
;&nbsp;loads the Root File System over NFS &amp; calls the<br>Init process.=
<br>Next, i am expecting to see a shell prompt. I am not sure where in the
<br>Init process i am failing. I have written my own serial driver(Philips<=
br>SC28L194 Quad UART--under development-possible culprit). The printks<br>=
work just fine.<br>All i see is the kernel calling the Init process &amp; a=
fter a minute or so
<br>i see uart_close call.<br>The kernel runs just fine &amp; responds to p=
ing.<br>What can trigger a uart_close??(tty_release calls release_dev calls=
<br>uart_close) I have a JTAG debugger. What's the best way to debug once
<br>Init process is running??<br><br><br><br>I am attaching a dump of my co=
nsole:<br>U-Boot 1.1.3 (Dec 16 2005 - 16:00:23), Build: 0.4.1<br><br>SysClo=
ck =3D 120Mhz , TClock =3D 120Mhz<br>CPU:&nbsp;&nbsp; MPC7447A v1.1 @ 960 M=
Hz<br>CPU bus mode : 60x
<br><br>DRAM:&nbsp;&nbsp;SPD Checksum ok!<br>-- DIMM1 has 2 banks<br>-- DIM=
M2 has 0 banks<br>ECC Initialization of Bank 0: Done<br>CAS Latency =3D 2 t=
RP =3D 3 tRAS =3D 6 tRCD=3D3<br>Total SDRAM memory is 1024 MB<br>Now runnin=
g in RAM - U-Boot at: 00fc0000
<br>Remapped Internal SRAM to 0xf2000000<br>Remapped Flash Card to 0xffc000=
00<br>FLASH:&nbsp;&nbsp;4 MB<br>Addresses 32M - 0M are saved for the U-Boot=
 usage.<br>Mem malloc Initialization (32M - 16M): Done<br><br>Internal SRAM=
 ECC Initialization: Done
<br>***Phy Reset***<br>Phy Auto-Negotiation Bit ReEnabled in SW<br>Net:&nbs=
p;&nbsp; , mv_enet1 [PRIME]<br>Hit any key to stop autoboot:&nbsp;&nbsp;0<b=
r>Ethernet status port 1: Link up, Full Duplex, Speed 100 Mbps<br>Using mv_=
enet1 device<br>

TFTP from server <a href=3D"http://192.168.1.1" target=3D"_blank" onclick=
=3D"return top.js.OpenExtLink(window,event,this)">192.168.1.1</a>; our IP a=
ddress is <a href=3D"http://192.168.1.2" target=3D"_blank" onclick=3D"retur=
n top.js.OpenExtLink(window,event,this)">
192.168.1.2</a><br>Filename 'uImage'.<br>Load address: 0x400000<br>Loading:=
<br>#################################################################
<br><br>#################################################################<b=
r><br>#################################################################<br>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ########################<b=
r>done<br>Bytes transferred =3D 1119847 (111667 hex)
<br><br>### Network statistics: ###<br>--------------------------<br> Packe=
ts received:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;2192<br> Packets send:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;2191<br> Received bytes:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2347583<br>
Send
bytes:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;100803<br>## Booting ima=
ge at 00400000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.12<br>=
&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2006-02-14&nbsp;&n=
bsp; 0:37:17 UTC<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kern=
el Image (gzip compressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp;&nbs=
p;1119783 Bytes =3D&nbsp;&nbsp;
1.1 MB<br>&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&=
nbsp;&nbsp;00000000<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>&nbsp;&nbs=
p; Uncompressing Kernel Image ... OK<br>## cmdline at 0x007FFF00 ... 0x007F=
FF98<br>memstart&nbsp;&nbsp;&nbsp;&nbsp;=3D 0x00000000<br>memsize&nbsp;&nbs=
p;&nbsp;&nbsp; =3D 0x40000000
<br>flashstart&nbsp;&nbsp;=3D 0xFFC00000<br>flashsize&nbsp;&nbsp; =3D 0x004=
00000<br>flashoffset =3D 0x00000000<br>sramstart&nbsp;&nbsp; =3D 0xF8000000=
<br>sramsize&nbsp;&nbsp;&nbsp;&nbsp;=3D 0x00400000<br>bootflags&nbsp;&nbsp;=
 =3D 0x00000001<br>intfreq&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp;&nb=
sp;960 MHz<br>busfreq&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp;&nbsp;12=
0 MHz
<br>ethaddr&nbsp;&nbsp;&nbsp;&nbsp; =3D 64:00:00:00:00:00<br>IP addr&nbsp;&=
nbsp;&nbsp;&nbsp; =3D <a href=3D"http://192.168.1.2" target=3D"_blank" oncl=
ick=3D"return top.js.OpenExtLink(window,event,this)">192.168.1.2</a><br>bau=
drate&nbsp;&nbsp;&nbsp;&nbsp;=3D 115200 bps<br>tclk&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;=3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0 MHz
<br>uboot_ver&nbsp;&nbsp; =3D 0.4.1a<br>L3 was init =3D 0<br>Total memory =
=3D 768MB; using 2048kB for hash table (at c0400000)
<br>Linux version 2.6.12 (root@RHEL40) (gcc version 3.3.3 (DENX ELDK 3.1.1<=
br>3.3.3-10)) #154 Mon Feb 13 17:36:35 MST 2006<br>System Identification:<b=
r>Freescale 74XX port<br>Built 1 zonelists<br>Kernel command line: console=
=3DttyS0,115200 root=3D/dev/nfs rw
<br>nfsroot=3D192.168.1.1:/target/chestnut/rootfs<br>ip=3D<a href=3D"http:/=
/192.168.1.2:192" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(wi=
ndow,event,this)">192.168.1.2:192</a>.168.1.1:<a href=3D"http://192.168.1.1=
:255" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,t=
his)">
192.168.1.1:255</a>.255.255.0:DB64xxx:eth0:non<br>e<br>PID hash table entri=
es: 4096 (order: 12, 65536 bytes)
<br>time_init: decrementer frequency =3D 30.000000 MHz<br>Console: colour d=
ummy device 80x25<br>Dentry cache hash table entries: 131072 (order: 7, 524=
288 bytes)<br>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes=
)
<br>Memory: 774400k available (1596k kernel code, 556k data, 344k init, 0k<=
br>highmem)<br>Mount-cache hash table entries: 512<br><br>NET: Registered p=
rotocol family 16<br>PCI: Probing PCI hardware<br>JFFS2 version 2.2. (C) 20=
01-2003 Red Hat, Inc.
<br>Generic RTC Driver v1.07<br>Serial: SC28L194 driver 4 ports<br>ttyS0 at=
 MMIO 0x0 (irq =3D 17) is a PHILIPS SC28L194<br>ttyS1 at MMIO 0x0 (irq =3D =
17) is a PHILIPS SC28L194<br>ttyS2 at MMIO 0x0 (irq =3D 17) is a PHILIPS SC=
28L194
<br>ttyS3 at MMIO 0x0 (irq =3D 17) is a PHILIPS SC28L194<br>io scheduler no=
op registered<br>io scheduler anticipatory registered<br>io scheduler deadl=
ine registered<br>io scheduler cfq registered<br>RAMDISK driver initialized=
: 16 RAM disks of 4096K size 1024 blocksize
<br>loop: loaded (max 8 devices)<br>MV-643xx 10/100/1000 Ethernet Driver<br=
>eth0: port 1 with MAC address 00:11:85:da:0b:02<br>eth0: RX NAPI Enabled<b=
r>physmap flash device: 400000 at ffc00000<br>mice: PS/2 mouse device commo=
n for all mice
<br>NET: Registered protocol family 2<br>IP: routing cache hash table of 81=
92 buckets, 64Kbytes<br>TCP established hash table entries: 131072 (order: =
8, 1048576 bytes)<br>TCP bind hash table entries: 65536 (order: 6, 262144 b=
ytes)
<br>TCP: Hash tables configured (established 131072 bind 65536)<br>NET: Reg=
istered protocol family 1<br>NET: Registered protocol family 17<br>IP-Confi=
g: Complete:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;device=3Deth0, addr=3D<=
a href=3D"http://192.168.1.2" target=3D"_blank" onclick=3D"return top.js.Op=
enExtLink(window,event,this)">
192.168.1.2
</a>, mask=3D<a href=3D"http://255.255.255.0" target=3D"_blank" onclick=3D"=
return top.js.OpenExtLink(window,event,this)">255.255.255.0</a>, gw=3D<a hr=
ef=3D"http://192.168.1.1" target=3D"_blank" onclick=3D"return top.js.OpenEx=
tLink(window,event,this)">
192.168.1.1</a>,<br>&nbsp;&nbsp;&nbsp;&nbsp; host=3DDB64xxx, domain=3D, nis=
-domain=3D(none),<br>&nbsp;&nbsp;&nbsp;&nbsp; bootserver=3D<a href=3D"http:=
//192.168.1.1" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(windo=
w,event,this)">192.168.1.1</a>
, rootserver=3D<a href=3D"http://192.168.1.1" target=3D"_blank" onclick=3D"=
return top.js.OpenExtLink(window,event,this)">192.168.1.1</a>, rootpath=3D<=
br>Looking up port of RPC 100003/2 on <a href=3D"http://192.168.1.1" target=
=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">
192.168.1.1</a><br>Looking up port of RPC 100005/1 on <a href=3D"http://192=
.168.1.1" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,eve=
nt,this)">192.168.1.1
</a><br>VFS: Mounted root (nfs filesystem).<br>Freeing unused kernel memory=
: 344k init<br><br><br>Any help appreceated.<br>Thanks<br>pankaj<br><br><br=
>_______________________________________________<br>Linuxppc-embedded maili=
ng list
<br><a href=3D"mailto:Linuxppc-embedded@ozlabs.org" target=3D"_blank" oncli=
ck=3D"return top.js.OpenExtLink(window,event,this)">Linuxppc-embedded@ozlab=
s.org</a><br><a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedd=
ed" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,thi=
s)">
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br>______________=
_________________________________
<br>Linuxppc-embedded mailing list<br><a href=3D"mailto:Linuxppc-embedded@o=
zlabs.org" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,ev=
ent,this)">Linuxppc-embedded@ozlabs.org</a><br><a href=3D"https://ozlabs.or=
g/mailman/listinfo/linuxppc-embedded" target=3D"_blank" onclick=3D"return t=
op.js.OpenExtLink(window,event,this)">
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
</a><br></blockquote></div><br>

</span></div></blockquote></div><br>

------=_Part_5869_20361772.1141631728208--
