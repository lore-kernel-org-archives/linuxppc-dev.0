Return-Path: <ravi.rao@rflelect.com>
Received: from noteshub1.teal.com (mail.teal.com [67.155.213.211])
	by ozlabs.org (Postfix) with ESMTP id 81F67DDE10
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Dec 2007 00:26:46 +1100 (EST)
In-Reply-To: <BLU106-W420C40497B4E7C784AC4B6CA5C0@phx.gbl>
To: carcadiz@hotmail.com
Subject: RE: Getting this error when mounting the jffs2 partition created	using
	mkImage..
MIME-Version: 1.0
Message-ID: <OF34CAF9D6.42FCCF0E-ON852573B6.004903E5-852573B6.0049E457@RFLELECT.COM>
From: ravi.rao@rflelect.com
Date: Wed, 19 Dec 2007 08:27:01 -0500
Content-Type: multipart/alternative;
	boundary="=_alternative 0049E451852573B6_="
Cc: linuxppc-embedded-bounces+ravi.rao=rflelect.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 0049E451852573B6_=
Content-Type: text/plain; charset="US-ASCII"

Hi,
   The flash I am using on this board has 512 sectors each of 64kilobytes 
so the erase block size should be 64kb=0x10000.
I also have boards which use spansion flash which has 256 sectors each of 
128kilo bytes. Erase block for them is 128kb=0x20000.
Both of the flashes behave the same way. I get the same error..
I noticed one thing. If I do memorydump of the sectors which donot have 
the jffs2 image I see the begining of the sector as 19852003 0000000c 
f060dc98
=>md FE7A0000
fe7a0000: 19852003 0000000c f060dc98 ffffffff    .. ......`......
fe7a0010: ffffffff ffffffff ffffffff ffffffff    ................
fe7a0020: ffffffff ffffffff ffffffff ffffffff    ................
fe7a0030: ffffffff ffffffff ffffffff ffffffff    ................
fe7a0040: ffffffff ffffffff ffffffff ffffffff    ................
fe7a0050: ffffffff ffffffff ffffffff ffffffff    ................
fe7a0060: ffffffff ffffffff ffffffff ffffffff    ................
fe7a0070: ffffffff ffffffff ffffffff ffffffff    ................
fe7a0080: ffffffff ffffffff ffffffff ffffffff    ................
fe7a0090: ffffffff ffffffff ffffffff ffffffff    ................

But If I do a md of a sector which has the contents of jffs2 image then I 
do not see the header. 
=>md fc020000
fc020000: b58dc90c 0ce12b39 6c6a38a3 f40a3819    ......+9lj8...8.
fc020010: 1a1c9a18 78807e51 700008a0 79ff2580    ....x.~Qp...y.%.
fc020020: 7682ec63 04d50b40 bbf240f6 ccbe0310    v..c...@..@.....
fc020030: 40203180 00030081 c9b057ff ffffffff    @ 1.......W.....
fc020040: 19852003 0000000c f060dc98 1985e002    .. ......`......
fc020050: 00000625 c800d476 00000009 0000003a    ...%...v.......:
fc020060: 000081ed 00000000 000cecf3 47681135    ............Gh.5
fc020070: 47681135 47681135 0003878e 000005e1    Gh.5Gh.5........
fc020080: 00000872 06000000 c54a53f1 9b07730a    ...r.....JS...s.
fc020090: 785e7455 516c5365 143e775b 9a966de1    x^tUQlSe.>w[..m.

So I am not sure if this is normal.. Any help or pointers to solve this 
will be of great help.

Strange thing is everything works fine except I get these message printed. 
I can access the jffs2 partition i.e read/write/execute files from it.
Thanks,
Ravishankar Govindarao
RFL Electronics Inc.
E-mail : Ravi.Rao@rflelect.com
Voice: 973.334.3100 Ext. 233
Fax: 973.334.3863
 
CONFIDENTIALITY NOTE
This e-mail, including any attachments, may contain confidential and/or 
legally privileged information.  The Information is intended only for the 
use of the individual or entity named on this e-mail .  If you are not the 
intended recipient, you are hereby notified that any disclosure, copying, 
distribution, or the taking of any action in reliance on the contents of 
this transmitted Information is strictly prohibited.  Further, if you are 
not the intended recipient, please notify us by return e-mail and delete 
the Information promptly.
 
 
 



"Pedro Luis D. L." <carcadiz@hotmail.com> 
Sent by: linuxppc-embedded-bounces+ravi.rao=rflelect.com@ozlabs.org
12/19/2007 04:38 AM

To
<linuxppc-embedded@ozlabs.org>
cc

Subject
RE: Getting this error when mounting the jffs2 partition created using 
mkImage..







Ravi wrote:
>
> Hi All,
>       I have u-boot based bootloader on our custom board based on 
ppc405EP.
> Various partitions are..
> Amd/Fujitsu Extended Query Table at 0x0040
> RoadRunner: CFI does not contain boot bank location. Assuming top.
> number of CFI chips: 2
> cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
> Creating 5 MTD partitions on "RoadRunner":
> 0x03fc0000-0x04000000 : "U-Boot based RR Boot loader"
> 0x03fa0000-0x03fc0000 : "U-Boot Env Storage"
> 0x03f80000-0x03fa0000 : "U-Boot Redundant Env Storage"
> 0x027c0000-0x03f80000 : "Kernel Image"
> 0x00000000-0x027c0000 : "JFFS2 Linux FS"
>
> I have used the following command to create the jffs2 file system image.
> $BLDTOOLS/mkfs.jffs2 -b -e 0x10000 -d $JFFS2 -p 0x27c0000 -o 
rr-app_64.img
> ${MKIMAGE} -T filesystem -n 'RR App Image for AMD' -d rr-app_64.img 
uRR-app_64

Hi,
I'm not using that board so I can not tell which is the correct value, but 
looking at the output you send it looks like the erase size you passed 
when creating the image file is wrong. I suggest you to find the 
appropiate value and create the image. For an mpc5200b it happened to be 
0x20000. May this would help.

Good luck.

Pedro.

_________________________________________________________________
La vida de los famosos al desnudo en MSN Entretenimiento
http://entretenimiento.es.msn.com/
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


--=_alternative 0049E451852573B6_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi,</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;The flash I am using on
this board has 512 sectors each of 64kilobytes so the erase block size
should be 64kb=0x10000.</font>
<br><font size=2 face="sans-serif">I also have boards which use spansion
flash which has 256 sectors each of 128kilo bytes. Erase block for them
is 128kb=0x20000.</font>
<br><font size=2 face="sans-serif">Both of the flashes behave the same
way. I get the same error..</font>
<br><font size=2 face="sans-serif">I noticed one thing. If I do memorydump
of the sectors which donot have the jffs2 image I see the begining of the
sector as </font><font size=2 face="Courier New">19852003 0000000c f060dc98</font>
<br><font size=2 face="Courier New">=&gt;md FE7A0000</font>
<br><font size=2 face="Courier New">fe7a0000: 19852003 0000000c f060dc98
ffffffff &nbsp; &nbsp;.. ......`......</font>
<br><font size=2 face="Courier New">fe7a0010: ffffffff ffffffff ffffffff
ffffffff &nbsp; &nbsp;................</font>
<br><font size=2 face="Courier New">fe7a0020: ffffffff ffffffff ffffffff
ffffffff &nbsp; &nbsp;................</font>
<br><font size=2 face="Courier New">fe7a0030: ffffffff ffffffff ffffffff
ffffffff &nbsp; &nbsp;................</font>
<br><font size=2 face="Courier New">fe7a0040: ffffffff ffffffff ffffffff
ffffffff &nbsp; &nbsp;................</font>
<br><font size=2 face="Courier New">fe7a0050: ffffffff ffffffff ffffffff
ffffffff &nbsp; &nbsp;................</font>
<br><font size=2 face="Courier New">fe7a0060: ffffffff ffffffff ffffffff
ffffffff &nbsp; &nbsp;................</font>
<br><font size=2 face="Courier New">fe7a0070: ffffffff ffffffff ffffffff
ffffffff &nbsp; &nbsp;................</font>
<br><font size=2 face="Courier New">fe7a0080: ffffffff ffffffff ffffffff
ffffffff &nbsp; &nbsp;................</font>
<br><font size=2 face="Courier New">fe7a0090: ffffffff ffffffff ffffffff
ffffffff &nbsp; &nbsp;................</font>
<br>
<br><font size=2 face="sans-serif">But If I do a md of a sector which has
the contents of jffs2 image then I do not see the header. </font>
<br><font size=2 face="Courier New">=&gt;md fc020000</font>
<br><font size=2 face="Courier New">fc020000: b58dc90c 0ce12b39 6c6a38a3
f40a3819 &nbsp; &nbsp;......+9lj8...8.</font>
<br><font size=2 face="Courier New">fc020010: 1a1c9a18 78807e51 700008a0
79ff2580 &nbsp; &nbsp;....x.~Qp...y.%.</font>
<br><font size=2 face="Courier New">fc020020: 7682ec63 04d50b40 bbf240f6
ccbe0310 &nbsp; &nbsp;v..c...@..@.....</font>
<br><font size=2 face="Courier New">fc020030: 40203180 00030081 c9b057ff
ffffffff &nbsp; &nbsp;@ 1.......W.....</font>
<br><font size=2 face="Courier New">fc020040: 19852003 0000000c f060dc98
1985e002 &nbsp; &nbsp;.. ......`......</font>
<br><font size=2 face="Courier New">fc020050: 00000625 c800d476 00000009
0000003a &nbsp; &nbsp;...%...v.......:</font>
<br><font size=2 face="Courier New">fc020060: 000081ed 00000000 000cecf3
47681135 &nbsp; &nbsp;............Gh.5</font>
<br><font size=2 face="Courier New">fc020070: 47681135 47681135 0003878e
000005e1 &nbsp; &nbsp;Gh.5Gh.5........</font>
<br><font size=2 face="Courier New">fc020080: 00000872 06000000 c54a53f1
9b07730a &nbsp; &nbsp;...r.....JS...s.</font>
<br><font size=2 face="Courier New">fc020090: 785e7455 516c5365 143e775b
9a966de1 &nbsp; &nbsp;x^tUQlSe.&gt;w[..m.</font>
<br>
<br><font size=2 face="sans-serif">So I am not sure if this is normal..
Any help or pointers to solve this will be of great help.</font>
<br>
<br><font size=2 face="sans-serif">Strange thing is everything works fine
except I get these message printed. I can access the jffs2 partition i.e
read/write/execute files from it.</font>
<br><font size=2 face="sans-serif">Thanks,<br>
</font><font size=2 face="Tms Rmn">Ravishankar Govindarao<br>
RFL Electronics Inc.<br>
E-mail</font><font size=1 face="Tms Rmn"> </font><font size=2 face="Tms Rmn">:
</font><a href=mailto:Ravi.Rao@rflelect.com><font size=2 color=blue face="Tms Rmn"><u>Ravi.Rao@rflelect.com</u></font></a>
<br><font size=2 face="Tms Rmn">Voice: 973.334.3100 Ext. 233<br>
Fax: 973.334.3863</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<div align=center>
<br><font size=2 color=blue face="Tms Rmn"><u>CONFIDENTIALITY NOTE</u></font></div>
<br><font size=1 face="Tms Rmn">This e-mail, including any attachments,
may contain confidential and/or legally privileged information.&nbsp; The
Information is intended only for the use of the individual or entity named
on this e-mail</font><font size=1 face="Tms Rmn"> </font><font size=1 face="Tms Rmn">.&nbsp;
If you are not the intended recipient, you are hereby notified that any
disclosure, copying, distribution, or the taking of any action in reliance
on the contents of this transmitted Information is strictly prohibited.&nbsp;
Further, if you are not the intended recipient, please notify us by return
e-mail and delete the Information promptly.</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<p><font size=3>&nbsp;</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>&quot;Pedro Luis D. L.&quot;
&lt;carcadiz@hotmail.com&gt;</b> </font>
<br><font size=1 face="sans-serif">Sent by: linuxppc-embedded-bounces+ravi.rao=rflelect.com@ozlabs.org</font>
<p><font size=1 face="sans-serif">12/19/2007 04:38 AM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">&lt;linuxppc-embedded@ozlabs.org&gt;</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">RE: Getting this error when mounting
the jffs2 partition created &nbsp; &nbsp; &nbsp; &nbsp;using &nbsp;
&nbsp; &nbsp; &nbsp;mkImage..</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><font size=2><tt><br>
Ravi wrote:<br>
&gt;<br>
&gt; Hi All,<br>
&gt; &nbsp; &nbsp; &nbsp; I have u-boot based bootloader on our custom
board based on ppc405EP.<br>
&gt; Various partitions are..<br>
&gt; Amd/Fujitsu Extended Query Table at 0x0040<br>
&gt; RoadRunner: CFI does not contain boot bank location. Assuming top.<br>
&gt; number of CFI chips: 2<br>
&gt; cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.<br>
&gt; Creating 5 MTD partitions on &quot;RoadRunner&quot;:<br>
&gt; 0x03fc0000-0x04000000 : &quot;U-Boot based RR Boot loader&quot;<br>
&gt; 0x03fa0000-0x03fc0000 : &quot;U-Boot Env Storage&quot;<br>
&gt; 0x03f80000-0x03fa0000 : &quot;U-Boot Redundant Env Storage&quot;<br>
&gt; 0x027c0000-0x03f80000 : &quot;Kernel Image&quot;<br>
&gt; 0x00000000-0x027c0000 : &quot;JFFS2 Linux FS&quot;<br>
&gt;<br>
&gt; I have used the following command to create the jffs2 file system
image.<br>
&gt; $BLDTOOLS/mkfs.jffs2 -b -e 0x10000 -d $JFFS2 -p 0x27c0000 -o rr-app_64.img<br>
&gt; ${MKIMAGE} -T filesystem -n 'RR App Image for AMD' -d rr-app_64.img
uRR-app_64<br>
<br>
Hi,<br>
I'm not using that board so I can not tell which is the correct value,
but looking at the output you send it looks like the erase size you passed
when creating the image file is wrong. I suggest you to find the appropiate
value and create the image. For an mpc5200b it happened to be 0x20000.
May this would help.<br>
<br>
Good luck.<br>
<br>
Pedro.<br>
<br>
_________________________________________________________________<br>
La vida de los famosos al desnudo en MSN Entretenimiento<br>
http://entretenimiento.es.msn.com/<br>
_______________________________________________<br>
Linuxppc-embedded mailing list<br>
Linuxppc-embedded@ozlabs.org<br>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded<br>
</tt></font>
<br>
--=_alternative 0049E451852573B6_=--
