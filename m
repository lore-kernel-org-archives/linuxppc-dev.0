Return-Path: <fabien.oriede@yahoo.fr>
Received: from web27401.mail.ukl.yahoo.com (web27401.mail.ukl.yahoo.com
	[217.146.177.177]) by ozlabs.org (Postfix) with SMTP id C1E2EDDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jul 2008 19:06:21 +1000 (EST)
Date: Wed, 30 Jul 2008 09:06:18 +0000 (GMT)
From: Fabien Oriede <fabien.oriede@yahoo.fr>
Subject: initrd : no cpio magic
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-48438742-1217408778=:66383"
Message-ID: <346247.66383.qm@web27401.mail.ukl.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-48438742-1217408778=:66383
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,=0AI'm working with a custom board (MPC860T, 8MB FLASH, 4MB SDRAM, s=
erial port on SCC1). U-Boot (version 1.3.2)=C2=A0works fine. Now I'm trying=
 to put an initrd image to boot the kernel (version 2.6.24). I have followe=
d this topic=C2=A0:=C2=A0http://www.denx.de/wiki/view/DULG/LinuxRamdiskRoot=
. I have downloaded pRamdisk from ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SE=
LF/images/ppc_8xx/?cf0A21F201=3D2217AE7A!VDAwMjgxMTg6bGRhcDqY+Fsd/NseZr/2SQ=
TpUyuD=C2=A0to test with a correct initrd. Now my uImage is at address 0xFF=
A00000 and the initrd image is at 0xFFC00000. When I use the command "bootm=
 FFA00000 FFC00000", I have the following log on my terminal :=0Abootm ffa0=
0000 ffc00000=0A## Booting image at ffa00000 ...=0AImage Name: Linux-2.6.24=
=0ACreated: 2011-02-14 15:42:10 UTC=0AImage Type: PowerPC Linux Kernel Imag=
e (gzip compressed)=0AData Size: 631621 Bytes =3D 616.8 kB=0ALoad Address: =
00000000=0AEntry Point: 00000000=0AVerifying Checksum ... OK=0AUncompressin=
g Kernel Image ... OK=0A## Current stack ends at 0x003B8D78 =3D> set upper =
limit to 0x003B8570=0A## cmdline at 0x003B8470 ... 0x003B8493=0Abd address =
=3D 0x003B8FC4=0Amemstart =3D 0x00000000=0Amemsize =3D 0x00400000=0Aflashst=
art =3D 0xFF800000=0Aflashsize =3D 0x00800000=0Aflashoffset =3D 0x00000000=
=0Asramstart =3D 0x00000000=0Asramsize =3D 0x00000000=0Aimmr_base =3D 0xFFE=
00000=0Abootflags =3D 0x00000001=0Aintfreq =3D 40 MHz=0Abusfreq =3D 40 MHz=
=0Aethaddr =3D 00:00:00:00:00:00=0AIP addr =3D 0.0.0.0=0Abaudrate =3D 38400=
 bps=0ANot skipping initrd=0A## Loading RAMDisk Image at ffc00000 ...=0AIma=
ge Name: Simple Embedded Linux Framework=0ACreated: 2002-10-24 4:56:06 UTC=
=0AImage Type: PowerPC Linux RAMDisk Image (gzip compressed)=0AData Size: 1=
459535 Bytes =3D 1.4 MB=0ALoad Address: 00000000=0AEntry Point: 00000000=0A=
Verifying Checksum ... OK=0A## initrd at 0xFFC00040 ... 0xFFD6458E (len=3D1=
459535=3D0x16454F)=0ALoading Ramdisk to 00253000, end 003b754f ... OK=0A## =
Transferring control to Linux (at address 00000000) ...=0ALinux version 2.6=
.24 (root@localhost.localdomain) (gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) =
#5 Mon Feb 14 16:42:09 CET 2011=0AZone PFN ranges:=0ADMA 0 -> 1024=0ANormal=
 1024 -> 1024=0AMovable zone start PFN for each node=0Aearly_node_map[1] ac=
tive PFN ranges=0A0: 0 -> 1024=0ABuilt 1 zonelists in Zone order, mobility =
grouping off. Total pages: 1016=0AKernel command line: console=3DttyCPM0,38=
400 root=3D/dev/ram=0APID hash table entries: 16 (order: 4, 64 bytes)=0ADec=
rementer Frequency =3D 150000000/60=0AConsole: colour dummy device 80x25=0A=
cpm_uart: console: compat mode=0Aconsole [ttyCPM0] enabled=0ADentry cache h=
ash table entries: 1024 (order: 0, 4096 bytes)=0AInode-cache hash table ent=
ries: 1024 (order: 0, 4096 bytes)=0AMemory: 1192k available (1088k kernel c=
ode, 260k data, 68k init, 0k highmem)=0ASLUB: Genslabs=3D11, HWalign=3D16, =
Order=3D0-1, MinObjects=3D4, CPUs=3D1, Nodes=3D1=0AMount-cache hash table e=
ntries: 512=0AUnpacking initramfs...<0>Kernel panic - not syncing: no cpio =
magic=0ARebooting in 180 seconds..=0AIt seems that it recognize the initrd,=
 but there is an error on cpio magic, may be the inirtd was not made with c=
pio.=C2=A0Can I add the cpio part in the header of the initrd ? (if I'm not=
 wrong of course)=0AI have seen a lot of topics, tutorials on the web, but =
they don't explain much which files I need to put in my initrd. That's why =
I have downloaded this pRamdisk to test.=0ASomeone can help me with my=C2=
=A0problem please ?=0AThanks.=0AFabien.=0A=0A=0A      _____________________=
________________________________________________________ =0AEnvoyez avec Ya=
hoo! Mail. Une boite mail plus intelligente http://mail.yahoo.fr
--0-48438742-1217408778=:66383
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial, helvetica, sans-serif;font-size:1=
0pt"><DIV>Hi all,</DIV>=0A<DIV>&nbsp;</DIV>=0A<P>I'm working with a custom =
board (MPC860T, 8MB FLASH, 4MB SDRAM, serial port on SCC1). U-Boot (version=
 1.3.2)&nbsp;works fine. Now I'm trying to put an initrd image to boot the =
kernel (version 2.6.24). I have followed this topic&nbsp;:&nbsp;<A href=3D"=
http://www.denx.de/wiki/view/DULG/LinuxRamdiskRoot">http://www.denx.de/wiki=
/view/DULG/LinuxRamdiskRoot</A>. I have downloaded pRamdisk from <A href=3D=
"ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/images/ppc_8xx/?cf0A21F201=3D2=
217AE7A!VDAwMjgxMTg6bGRhcDqY+Fsd/NseZr/2SQTpUyuD">ftp://ftp.denx.de/pub/Lin=
uxPPC/usr/src/SELF/images/ppc_8xx/?cf0A21F201=3D2217AE7A!VDAwMjgxMTg6bGRhcD=
qY+Fsd/NseZr/2SQTpUyuD</A>&nbsp;to test with a correct initrd. Now my uImag=
e is at address 0xFFA00000 and the initrd image is at 0xFFC00000. When I us=
e the command "bootm FFA00000 FFC00000", I have the following log on my ter=
minal :</P>=0A<P>&nbsp;</P>=0A<P>bootm ffa00000 ffc00000</P>=0A<P>## Bootin=
g image at ffa00000 ...</P>=0A<P>Image Name: Linux-2.6.24</P>=0A<P>Created:=
 2011-02-14 15:42:10 UTC</P>=0A<P>Image Type: PowerPC Linux Kernel Image (g=
zip compressed)</P>=0A<P>Data Size: 631621 Bytes =3D 616.8 kB</P>=0A<P>Load=
 Address: 00000000</P>=0A<P>Entry Point: 00000000</P>=0A<P>Verifying Checks=
um ... OK</P>=0A<P>Uncompressing Kernel Image ... OK</P>=0A<P>## Current st=
ack ends at 0x003B8D78 =3D&gt; set upper limit to 0x003B8570</P>=0A<P>## cm=
dline at 0x003B8470 ... 0x003B8493</P>=0A<P>bd address =3D 0x003B8FC4</P>=
=0A<P>memstart =3D 0x00000000</P>=0A<P>memsize =3D 0x00400000</P>=0A<P>flas=
hstart =3D 0xFF800000</P>=0A<P>flashsize =3D 0x00800000</P>=0A<P>flashoffse=
t =3D 0x00000000</P>=0A<P>sramstart =3D 0x00000000</P>=0A<P>sramsize =3D 0x=
00000000</P>=0A<P>immr_base =3D 0xFFE00000</P>=0A<P>bootflags =3D 0x0000000=
1</P>=0A<P>intfreq =3D 40 MHz</P>=0A<P>busfreq =3D 40 MHz</P>=0A<P>ethaddr =
=3D 00:00:00:00:00:00</P>=0A<P>IP addr =3D 0.0.0.0</P>=0A<P>baudrate =3D 38=
400 bps</P>=0A<P>Not skipping initrd</P>=0A<P>## Loading RAMDisk Image at f=
fc00000 ...</P>=0A<P>Image Name: Simple Embedded Linux Framework</P>=0A<P>C=
reated: 2002-10-24 4:56:06 UTC</P>=0A<P>Image Type: PowerPC Linux RAMDisk I=
mage (gzip compressed)</P>=0A<P>Data Size: 1459535 Bytes =3D 1.4 MB</P>=0A<=
P>Load Address: 00000000</P>=0A<P>Entry Point: 00000000</P>=0A<P>Verifying =
Checksum ... OK</P>=0A<P>## initrd at 0xFFC00040 ... 0xFFD6458E (len=3D1459=
535=3D0x16454F)</P>=0A<P>Loading Ramdisk to 00253000, end 003b754f ... OK</=
P>=0A<P>## Transferring control to Linux (at address 00000000) ...</P>=0A<P=
>Linux version 2.6.24 (root@localhost.localdomain) (gcc version 4.0.0 (DENX=
 ELDK 4.1 4.0.0)) #5 Mon Feb 14 16:42:09 CET 2011</P>=0A<P>Zone PFN ranges:=
</P>=0A<P>DMA 0 -&gt; 1024</P>=0A<P>Normal 1024 -&gt; 1024</P>=0A<P>Movable=
 zone start PFN for each node</P>=0A<P>early_node_map[1] active PFN ranges<=
/P>=0A<P>0: 0 -&gt; 1024</P>=0A<P>Built 1 zonelists in Zone order, mobility=
 grouping off. Total pages: 1016</P>=0A<P>Kernel command line: console=3Dtt=
yCPM0,38400 root=3D/dev/ram</P>=0A<P>PID hash table entries: 16 (order: 4, =
64 bytes)</P>=0A<P>Decrementer Frequency =3D 150000000/60</P>=0A<P>Console:=
 colour dummy device 80x25</P>=0A<P>cpm_uart: console: compat mode</P>=0A<P=
>console [ttyCPM0] enabled</P>=0A<P>Dentry cache hash table entries: 1024 (=
order: 0, 4096 bytes)</P>=0A<P>Inode-cache hash table entries: 1024 (order:=
 0, 4096 bytes)</P>=0A<P>Memory: 1192k available (1088k kernel code, 260k d=
ata, 68k init, 0k highmem)</P>=0A<P>SLUB: Genslabs=3D11, HWalign=3D16, Orde=
r=3D0-1, MinObjects=3D4, CPUs=3D1, Nodes=3D1</P>=0A<P>Mount-cache hash tabl=
e entries: 512</P>=0A<P>Unpacking initramfs...&lt;0&gt;Kernel panic - not s=
yncing: no cpio magic</P>=0A<P>Rebooting in 180 seconds..</P>=0A<P>&nbsp;</=
P>=0A<P>It seems that it recognize the initrd, but there is an error on cpi=
o magic, may be the inirtd was not made with cpio.&nbsp;Can I add the cpio =
part in the header of the initrd ? (if I'm not wrong of course)</P>=0A<P>I =
have seen a lot of topics, tutorials on the web, but they don't explain muc=
h which files I need to put in my initrd. That's why I have downloaded this=
 pRamdisk to test.</P>=0A<P>&nbsp;</P>=0A<DIV><SPAN lang=3DEN-GB style=3D"F=
ONT-SIZE: 12pt; FONT-FAMILY: 'Times New Roman'"><SPAN><FONT face=3D"arial, =
helvetica, sans-serif" size=3D2>Someone can help me with my&nbsp;problem pl=
ease ?</FONT></SPAN></SPAN></DIV>=0A<DIV><SPAN lang=3DEN-GB style=3D"FONT-S=
IZE: 12pt; FONT-FAMILY: 'Times New Roman'"><SPAN><FONT face=3D"arial, helve=
tica, sans-serif" size=3D2>Thanks.</FONT></SPAN></SPAN></DIV>=0A<DIV><SPAN =
lang=3DEN-GB style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Times New Roman'"><SPA=
N><FONT face=3DArial size=3D2>Fabien.</FONT></SPAN></SPAN></DIV></div><br>=
=0A=0A=0A      <hr size=3D"1"> =0AEnvoy=C3=A9 avec <a href=3D"http://us.rd.=
yahoo.com/mailuk/taglines/isp/control/*http://us.rd.yahoo.com/evt=3D52423/*=
http://fr.docs.yahoo.com/mail/overview/index.html">Yahoo! Mail</a>.<br>Une =
boite mail plus intelligente. </a></body></html>
--0-48438742-1217408778=:66383--
