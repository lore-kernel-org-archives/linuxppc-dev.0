Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 62EBBDDEF6
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 25 Feb 2007 10:26:53 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75869.91A71A0B"
Subject: RE: debugging custom Xilinx boot loader with abatron and
	Montavistadevrocket
Date: Sat, 24 Feb 2007 15:14:44 -0800
Message-ID: <821B2170E9E7F04FA38DF7EC21DE48710657F7F4@VCAEXCH01.hq.corp.viasat.com>
References: <45a1b53e0702230811i79bbc10dqd6e10ac05b06ac16@mail.gmail.com><1172267591.13040.30.camel@jaalaptop>
	<45a1b53e0702241440y76024946w20ba32658460388c@mail.gmail.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: "Wade Maxfield" <wmaxfield@gmail.com>, "ppc" <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C75869.91A71A0B
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> 1) In DevRocket, what kind of project do you choose to debug an
> externally build .elf file?
> MontaVista support engineers had no clue.

Not sure about DevRocket specifically, but in Eclipse you would choose a =
C
application with external makefile.  In Eclipse 3.1 (with CDT) its =
specifically
called a "Standard Make C Project".  There's also something similar in =
the
Xilinx EDK Eclipse-based offering (called Platform Studio SDK).  The =
PS-SDK
defaults to using backend xmd/gdb through the FPGA JTAG port.

My personal preference is to use gdb standalone or ddd/gdb

> 2) How do you use DevRocket to create a cross compiled set of code
> linked to a specific address.
> MontaVista support engineers also had no clue on this one.

Again, not sure in DevRocket.  In general, you will want to use a custom
linker script.  You can tailor a linker script from one of your EDK =
projects.
To pass it into the linker (ld), use the -T option.  Another useful =
option is
-M to create a map file.  If you're calling the linker from gcc, remeber =
to
preface these options with -Wl. man ld and man gcc are your friends.

If you get really stuck, you can look at a the makefile from an example =
EDK
project and see what it is doing.


------_=_NextPart_001_01C75869.91A71A0B
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7650.28">
<TITLE>RE: debugging custom Xilinx boot loader with abatron and =
Montavistadevrocket</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>&gt; 1) In DevRocket, what kind of project do you =
choose to debug an<BR>
&gt; externally build .elf file?<BR>
&gt; MontaVista support engineers had no clue.<BR>
<BR>
Not sure about DevRocket specifically, but in Eclipse you would choose a =
C<BR>
application with external makefile.&nbsp; In Eclipse 3.1 (with CDT) its =
specifically<BR>
called a &quot;Standard Make C Project&quot;.&nbsp; There's also =
something similar in the<BR>
Xilinx EDK Eclipse-based offering (called Platform Studio SDK).&nbsp; =
The PS-SDK<BR>
defaults to using backend xmd/gdb through the FPGA JTAG port.<BR>
<BR>
My personal preference is to use gdb standalone or ddd/gdb<BR>
<BR>
&gt; 2) How do you use DevRocket to create a cross compiled set of =
code<BR>
&gt; linked to a specific address.<BR>
&gt; MontaVista support engineers also had no clue on this one.<BR>
<BR>
Again, not sure in DevRocket.&nbsp; In general, you will want to use a =
custom<BR>
linker script.&nbsp; You can tailor a linker script from one of your EDK =
projects.<BR>
To pass it into the linker (ld), use the -T option.&nbsp; Another useful =
option is<BR>
-M to create a map file.&nbsp; If you're calling the linker from gcc, =
remeber to<BR>
preface these options with -Wl. man ld and man gcc are your friends.<BR>
<BR>
If you get really stuck, you can look at a the makefile from an example =
EDK<BR>
project and see what it is doing.<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C75869.91A71A0B--
