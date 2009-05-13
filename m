Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from IE1EHSOBE002.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 141FBDDFC8
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 16:58:31 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9D398.34655E0B"
Subject: RE: device trees.
Date: Tue, 12 May 2009 23:58:22 -0700
References: <fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
	<20090511155232.A30671B6005D@mail89-va3.bigfish.com>
	<4A08593C.4010503@dlasys.net>
	<20090511183638.F07C01438054@mail184-wa4.bigfish.com>
	<4A08C599.2030100@dlasys.net>
	<20090512005554.EEE1019D009B@mail129-dub.bigfish.com>
	<4A08E050.9000302@dlasys.net>
	<20090512042733.8D4A21400054@mail184-dub.bigfish.com>
	<fa686aa40905112230ve176b30o25abcdf5c203f6c7@mail.gmail.com>
	<20090513001048.490B533005D@mail141-va3.bigfish.com>
	<20090513023614.GJ24338@yookeroo.seuss>
	<4A0A6495.2050605@dlasys.net>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "David H. Lynch Jr." <dhlii@dlasys.net>, <grant.likely@secretlab.ca>,
	<linuxppc-dev@ozlabs.org>
Message-ID: <20090513065824.25E23AA8054@mail107-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------_=_NextPart_001_01C9D398.34655E0B
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


>> Um.. one thing I'm missing in this discussion of attaching the dtb to
>> the bitstream:  I don't see how the bitstream becomes accessible to
>> the kernel at runtime.  Unless you were exposing the dtb as part of
>> the fpga programming, but I thought you explicitly weren't doing that
>> because of limited bram space.

>    While I am not sure I grasp all of the nuances why, this is NOT the
>scheme Stephen recomends.
>    But it looks to be the most promising for me at Pico.

There is not a general way to pass additional information which does not pr=
ogram configuration bits of the FPGA through
the configuration interface.  There is a mechanism to do this in Virtex 4 a=
nd Virtex 5, but there is no
such mechanism for Spartan 3.  The best option that works for all Xilinx FP=
GAs is to use the initial state of a
BRAM memory block to contain the .dtb, which can then be scavenged and reus=
ed in the system, if necessary, although this
can impact overall system design.

David specifically asked for a mechanism which:
1) works on Spartan 3, in addition to V4 and V5.
2) does not require reserving an initialized BRAM, since BRAM information i=
s very expensive in his system.

The solution is highly specific to the configuration mechanism that David's=
 company uses in their systems, and is not generally applicable
to all board designs.

The main point of all of this is to avoid separating the bitstream from the=
 corresponding .dtb, in order to
avoid consistency issues.  Essentially, the bitstream describes itself usin=
g a .dtb.

Steve



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C9D398.34655E0B
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7654.12"=
>
<TITLE>RE: device trees.</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>&gt;&gt; Um.. one thing I'm missing in this discussion of=
 attaching the dtb to<BR>
&gt;&gt; the bitstream:&nbsp; I don't see how the bitstream becomes accessi=
ble to<BR>
&gt;&gt; the kernel at runtime.&nbsp; Unless you were exposing the dtb as p=
art of<BR>
&gt;&gt; the fpga programming, but I thought you explicitly weren't doing t=
hat<BR>
&gt;&gt; because of limited bram space.<BR>
<BR>
&gt;&nbsp;&nbsp;&nbsp; While I am not sure I grasp all of the nuances why, =
this is NOT the<BR>
&gt;scheme Stephen recomends.<BR>
&gt;&nbsp;&nbsp;&nbsp; But it looks to be the most promising for me at Pico=
.<BR>
<BR>
There is not a general way to pass additional information which does not pr=
ogram configuration bits of the FPGA through<BR>
the configuration interface.&nbsp; There is a mechanism to do this in Virte=
x 4 and Virtex 5, but there is no<BR>
such mechanism for Spartan 3.&nbsp; The best option that works for all Xili=
nx FPGAs is to use the initial state of a<BR>
BRAM memory block to contain the .dtb, which can then be scavenged and reus=
ed in the system, if necessary, although this<BR>
can impact overall system design.<BR>
<BR>
David specifically asked for a mechanism which:<BR>
1) works on Spartan 3, in addition to V4 and V5.<BR>
2) does not require reserving an initialized BRAM, since BRAM information i=
s very expensive in his system.<BR>
<BR>
The solution is highly specific to the configuration mechanism that David's=
 company uses in their systems, and is not generally applicable<BR>
to all board designs.<BR>
<BR>
The main point of all of this is to avoid separating the bitstream from the=
 corresponding .dtb, in order to<BR>
avoid consistency issues.&nbsp; Essentially, the bitstream describes itself=
 using a .dtb.<BR>
<BR>
Steve<BR>
<BR>
</FONT>
</P>

<br clear=3Dall> This email and any attachments are intended for the sole u=
se of the named recipient(s) and contain(s) confidential information that m=
ay be proprietary, privileged or copyrighted under applicable law. If you a=
re not the intended recipient, do not read, copy, or forward this email mes=
sage or any attachments. Delete this email message and any attachments imme=
diately.
</BODY>
</HTML>


------_=_NextPart_001_01C9D398.34655E0B--
