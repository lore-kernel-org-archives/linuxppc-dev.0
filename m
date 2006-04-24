Return-Path: <Victor.Krawczuk@gdcanada.com>
Received: from gdcanada.com (smtp1.gdcanada.com [209.29.50.245])
	by ozlabs.org (Postfix) with ESMTP id 5A06667A63
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Apr 2006 07:48:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C667E6.5A736893"
Subject: Rebuilding FS MDS 8349 BSP & JFFS2 integration
Date: Mon, 24 Apr 2006 17:30:48 -0400
Message-ID: <64A27FD84D948C48ABF3250BF78446FD01B7DF5D@OTTSVW100.gdcan.com>
From: "Krawczuk, Victor" <Victor.Krawczuk@gdcanada.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C667E6.5A736893
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I am a newbie to Linux but not to embedded PPC. I was hoping someone
could point me to the direction here. I apologize in advance if this is
kindergarten stuff.

I downloaded the MDS-8349 Linux BSP from FreeScale. I was able to burn
the default prebuilt images "uboot" and "jffs2.img" to my MDS-8349 (PB)
board and have uboot tftp the prebuilt "uImage" to my PB. I used
"tftpboot 200000 uImage" to download and "bootm" to boot.  As per
included instructions, I had "setenv bootargs root=3D/dev/mtdblock1
rootfstype=3Djffs2 rw console=3DttyS0,115200" in uboot, followed by a
"saveenv". The prebuilt Linux (uImage) came up, no problem.

As I need to include USB Host support to the PPC kernel, I used the ltib
tool to reconfigure and rebuild Linux, as well as a matching jffs2 (I
would think). Ltib produced vmlinux.gz.uboot and rootfs.jffs2 for me.
For some reason, rootfs.jffs2 was significantly smaller than the
prebuilt "jffs2.img" (2483184 bytes vs. 4325376 bytes). I'm not sure
why. I then did the following:

bootargs is still set to "root=3D/dev/mtdblock1 rootfstype=3Djffs2 rw
console=3DttyS0,115200"  in uboot:

Using the same (prebuilt) uboot as before:

- tftpboot 400000 rootfs.jffs2 (rebuilt jffs2)
- erase fe020000 fe5fffff
- cp.b 400000 fe020000 25e3f0

- tftpboot 200000 vmlinux.gz.uboot (rebuilt Linux containing USB Host
stuff)
- bootm

Linux could not boot!  I got the following root FS error:

[stuff deleted...]
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: loaded (max 8 devices)
eth0: Gianfar Ethernet Controller Version 1.1, 00:04:9f:00:2d:b7
eth0: Running with NAPI disabled
eth0: 64/64 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.1, 00:04:9f:00:2d:b8
eth1: Running with NAPI disabled
eth1: 64/64 RX/TX BD ring size
i2c /dev entries driver
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "mtdblock1" or unknown-block(2,0)
Please append a correct "root=3D" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)
 <0>Rebooting in 180 seconds..

Would anybody happen to know what is going wrong?  How am I supposed to
know the correct "root=3D" boot option for a rebuilt jffs2 using LTIB, =
if
that is my problem?



Thanks in advance for any hints,


Victor.





The information contained in this e-mail message is PRIVATE. It may =
contain confidential information and may be legally privileged. It is =
intended for the exclusive use of the addressee(s). If you are not the =
intended recipient, you are hereby notified that any dissemination, =
distribution or reproduction of this communication is strictly =
prohibited. If the intended recipient(s) cannot be reached or if a =
transmission problem has occurred, please notify the sender immediately =
by return e-mail and destroy all copies of this message.=20
Thank you.=20


------_=_NextPart_001_01C667E6.5A736893
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7233.28">
<TITLE>Rebuilding FS MDS 8349 BSP &amp; JFFS2 integration</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I am a newbie to Linux but not to =
embedded PPC. I was hoping someone could point me to the direction here. =
I apologize in advance if this is kindergarten stuff.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I downloaded the MDS-8349 Linux BSP =
from FreeScale. I was able to burn the default prebuilt images =
&quot;uboot&quot; and &quot;jffs2.img&quot; to my MDS-8349 (PB) board =
and have uboot tftp the prebuilt &quot;uImage&quot; to my PB. I used =
&quot;tftpboot 200000 uImage&quot; to download and &quot;bootm&quot; to =
boot.&nbsp; As per included instructions, I had &quot;setenv bootargs =
root=3D/dev/mtdblock1 rootfstype=3Djffs2 rw console=3DttyS0,115200&quot; =
in uboot, followed by a &quot;saveenv&quot;. The prebuilt Linux (uImage) =
came up, no problem.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">As I need to include USB Host support =
to the PPC kernel, I used the ltib tool to reconfigure and rebuild =
Linux, as well as a matching jffs2 (I would think). Ltib produced =
vmlinux.gz.uboot and rootfs.jffs2 for me.&nbsp; For some reason, =
rootfs.jffs2 was significantly smaller than the prebuilt =
&quot;jffs2.img&quot; (2483184 bytes vs. 4325376 bytes). I'm not sure =
why. I then did the following:</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">bootargs is still set to =
&quot;root=3D/dev/mtdblock1 rootfstype=3Djffs2 rw =
console=3DttyS0,115200&quot;&nbsp; in uboot:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Using the same (prebuilt) uboot as =
before:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">- tftpboot 400000 rootfs.jffs2 (rebuilt =
jffs2)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">- erase fe020000 fe5fffff</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">- cp.b 400000 fe020000 25e3f0</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">- tftpboot 200000 vmlinux.gz.uboot =
(rebuilt Linux containing USB Host stuff)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">- bootm</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Linux could not boot!&nbsp; I got the =
following root FS error:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">[stuff deleted&#8230;]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">io scheduler deadline =
registered</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">io scheduler cfq registered</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RAMDISK driver initialized: 16 RAM =
disks of 32768K size 1024 blocksize</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">loop: loaded (max 8 devices)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">eth0: Gianfar Ethernet Controller =
Version 1.1, 00:04:9f:00:2d:b7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">eth0: Running with NAPI =
disabled</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">eth0: 64/64 RX/TX BD ring size</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">eth1: Gianfar Ethernet Controller =
Version 1.1, 00:04:9f:00:2d:b8</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">eth1: Running with NAPI =
disabled</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">eth1: 64/64 RX/TX BD ring size</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">i2c /dev entries driver</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">NET: Registered protocol family =
2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">IP: routing cache hash table of 2048 =
buckets, 16Kbytes</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">TCP established hash table entries: =
16384 (order: 5, 131072 bytes)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">TCP bind hash table entries: 16384 =
(order: 4, 65536 bytes)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">TCP: Hash tables configured =
(established 16384 bind 16384)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">NET: Registered protocol family =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">NET: Registered protocol family =
17</FONT>

<BR><B><I><FONT SIZE=3D2 FACE=3D"Arial">Root-NFS: No NFS server =
available, giving up.</FONT></I></B>

<BR><B><I><FONT SIZE=3D2 FACE=3D"Arial">VFS: Unable to mount root fs via =
NFS, trying floppy.</FONT></I></B>

<BR><B><I><FONT SIZE=3D2 FACE=3D"Arial">VFS: Cannot open root device =
&quot;mtdblock1&quot; or unknown-block(2,0)</FONT></I></B>

<BR><B><I><FONT SIZE=3D2 FACE=3D"Arial">Please append a correct =
&quot;root=3D&quot; boot option</FONT></I></B>

<BR><B><I><FONT SIZE=3D2 FACE=3D"Arial">Kernel panic - not syncing: VFS: =
Unable to mount root fs on unknown-block(2,0)</FONT></I></B>

<BR><B><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&lt;0&gt;Rebooting in 180 =
seconds..</FONT></I></B>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Would anybody happen to know what is =
going wrong?&nbsp; How am I supposed to know the correct =
&quot;root=3D&quot; boot option for a rebuilt jffs2 using LTIB, if that =
is my problem?</FONT></P>
<BR>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks in advance for any hints,</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Victor.</FONT>
</P>
<BR>
<BR>
<BR>

</BODY>
<!--[object_id=3D#gdcanada.com#]--><FONT face=3DTahoma><FONT =
color=3D#0000ff><SPAN style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; =
FONT-FAMILY: Arial"><FONT color=3D#000000>
<P align=3Dleft><FONT face=3DTahoma size=3D2><FONT color=3D#0000ff><FONT =
face=3DArial color=3D#000000 size=3D1>The information contained in this =
e-mail message is PRIVATE. It may contain confidential information and =
may be legally privileged. It is intended for the exclusive use of the =
addressee(s). If you are not the intended recipient, you are hereby =
notified that any dissemination, distribution or reproduction of this =
communication is strictly prohibited. If the intended recipient(s) =
cannot be reached or if a transmission problem has occurred, please =
notify the sender immediately by return e-mail and destroy all copies of =
this message. <BR>Thank you.</FONT> =
</FONT></FONT></P></FONT></SPAN><FONT =
size=3D2></FONT></FONT></FONT></HTML>
------_=_NextPart_001_01C667E6.5A736893--
