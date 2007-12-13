Return-Path: <mike.koss@ngc.com>
Received: from xmrm0101.northgrum.com (xmrm0101.northgrum.com
	[155.104.240.104]) by ozlabs.org (Postfix) with ESMTP id 8F8F5DE0B2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Dec 2007 00:49:09 +1100 (EST)
Subject: RE: Xilinx devicetrees
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C83D8E.EB0FFDA3"
Date: Thu, 13 Dec 2007 07:49:01 -0600
Message-ID: <EDAE140DF1B2FC42B5867C22CA0B333F0A590F@XMBIL132.northgrum.com>
In-Reply-To: <20071213045215.DA8BAFB8060@mail11-blu.bigfish.com>
References: <47480CF0.7090105@dlasys.net>	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>	<47493D4F.4070605@dlasys.net><fa686aa40711251421q38f53ee3hb2a308cc5f93183f@mail.gmail.com><4749FD5E.7000408@dlasys.net>
	<20071125235855.95B9999804D@mail138-cpk.bigfish.com>
	<EDAE140DF1B2FC42B5867C22CA0B333F0A58E4@XMBIL132.northgrum.com>
	<20071213045215.DA8BAFB8060@mail11-blu.bigfish.com>
From: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>,
	"David H. Lynch Jr." <dhlii@dlasys.net>,
	"Grant Likely" <grant.likely@secretlab.ca>,
	"linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C83D8E.EB0FFDA3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

________________________________

From: Stephen Neuendorffer [mailto:stephen.neuendorffer@xilinx.com]=20
Sent: Wednesday, December 12, 2007 11:52 PM
To: Koss, Mike (Mission Systems); David H. Lynch Jr.; Grant Likely;
linuxppc-embedded
Subject: RE: Xilinx devicetrees

SN> As Grant says, the dynamic detection doesn't have to be done in the
boot loader, it could be done in the platform code.  You can largely
ignore
SN> the device trees, or always boot with a core device tree and figure
it all out later (perhaps using version registers).  I anticipate that
SN> the 'standard flow' will have standard platform code for any board
that uses a complete device tree.  If you have the need to do something
SN> extraordinary, then you should feel free to hack away...  However,
It doesn't seem to me to be really necessary in your case, assuming that

SN> the device tree is packaged (somehow, TBD) along with the bitstream.

> I don't know if packaging the device tree with the bitstream is the
best
> way to go. It's possible that it could lead to headaches for certain
> systems that have security restrictions. The same could be said for
> using it w/ the SystemACE to load it into RAM after the image. (which
is
> what I'm currently doing for my 2 linux images in lieu of a true
on-chip
> bootloader). I am already taking the security concerns into account
for
> future revisions of the hardware wrt to using a SystemACE, and am
> planning on moving the device trees into NV storage like FLASH.

SN> 'with' not 'in'. either using SystemAce, or a flash image.
=20
Ah! See, I though that there was the mention of trying to put it into
the bitstream and that is what I was worried about since retrieval of
that from the bitstream file is doable but if it was being stored in the
FPGA somehow and being retrieved there (????) that could lead to
problems for some systems.=20

> One solution I've been thinking through (in lieu of direct support
from
> EDK) is to use a tcl script with xps to traverse the hardware tree and
> generate the device tree. It seems like it should be relatively
trivial
> to obtain the information. It's just going to be a pain to write all
the
> handlers for each different linux driver: temac, interrupt controller,
> DMA controller, etc.
> In reality the best way to handle this would be to have EDK generate
the
> device tree as part of the library/bsp build process.
=20
SN> We have a python script to do this.  The main problem with just
looking=20
SN> at the mhs file is that you lose all the defaults for each IP.
Hence, we've=20
SN> also written a BSP generator to do this.  both are at=20
SN> git://git.xilinx.com/gen-mhs-devtree.py
SN> Once I can verify that they work in the mainline tree, I'll be
sending out=20
SN> the patches that make this all work.

> Now, what I'd like
> to see with regards to this is the ability to change the handler for
the
> generating a specific device information. An example could be the
temac.
> If at some point in the future the temac needs new/more information to
> support its configuration/run-time then having to get a patch from
> Xilinx for a EDK is way too slow. The developers should be giving the
> opportunity to inject a new handler into the various parts of the
device
> tree generation. That way when the kernel patch is submitted, an EDK
> device generator patch will be submitted at the same time to keep
> everything in sync.

SN> Interesting idea..  I've been trying to figure out how to architect
this=20
SN> better, but it requires some information passing within EDK that
isnot=20
SN> today supported.  I don't see at all how to synchronize this with=20
SN> patches to the kernel, tho.  My approach is to describe the hardware

SN> as completely and faithfully as we can (given the information in
EDK),=20
SN> and let the drivers do whatever with it that they want to.

You'll have to correct if I'm wrong here, but from what I've been
reading up about EDK and its built-in Tcl interface, one can load their
system.xmp with corresponding mhs and then use Tcl to traverse the
device information to create the same information as found using the
generated BSP. This would allow for a Tcl system that could be setup
such that a main (unchanging, or slowly changing) Tcl script that would
start the EDK definition traversal and upon finding a new device it
would use a registered 'handler' Tcl function. These handlers could be
stored as seperate script/files and would be registered at the start of
the main script either via a config file or by searching a directory and
looking for tags stored at the top of the Tcl files in comments. These
driver handlers would be passed the handle to the system definition and
then know how to gather the information they need to create their entry
in the device tree. This approach gets around the issue of losing
defaults found in the mhs file.

I originally looked at trying to perform the same thing using just
device drivers in EDK, but I think I found some pitfall.  Oh, I think it
was that I would have to choose the OS for the processor and EDK wants
to build the library, but there isn't anything to compile for Linux (or
I wasn't compiling anything for the linux BSP) and that was adding extra
time to the download.bit generation and that is already a long build
process.
=20
-- Mike=20


------_=_NextPart_001_01C83D8E.EB0FFDA3
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>RE: Xilinx devicetrees</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3243" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DTahoma size=3D2><B>From:</B> =
Stephen=20
Neuendorffer [mailto:stephen.neuendorffer@xilinx.com] <BR><B>Sent:</B>=20
Wednesday, December 12, 2007 11:52 PM<BR><B>To:</B> Koss, Mike (Mission=20
Systems); David H. Lynch Jr.; Grant Likely; =
linuxppc-embedded<BR><B>Subject:</B>=20
RE: Xilinx devicetrees<BR></FONT><BR><FONT size=3D2>SN&gt; As Grant =
says, the=20
dynamic detection doesn't have to be done in the<BR>boot loader, it =
could be=20
done in the platform code.&nbsp; You can largely<BR>ignore<BR>SN&gt; the =
device=20
trees, or always boot with a core device tree and figure<BR>it all out =
later=20
(perhaps using version registers).&nbsp; I anticipate that<BR>SN&gt; the =

'standard flow' will have standard platform code for any board<BR>that =
uses a=20
complete device tree.&nbsp; If you have the need to do =
something<BR>SN&gt;=20
extraordinary, then you should feel free to hack away...&nbsp; =
However,<BR>It=20
doesn't seem to me to be really necessary in your case, assuming=20
that<BR><BR>SN&gt; the device tree is packaged (somehow, TBD) along with =
the=20
bitstream.<BR><BR>&gt; I don't know if packaging the device tree with =
the=20
bitstream is the best<BR>&gt; way to go. It's possible that it could =
lead to=20
headaches for certain<BR>&gt; systems that have security restrictions. =
The same=20
could be said for<BR>&gt; using it w/ the SystemACE to load it into RAM =
after=20
the image. (which is<BR>&gt; what I'm currently doing for my 2 linux =
images in=20
lieu of a true on-chip<BR>&gt; bootloader). I am already taking the =
security=20
concerns into account for<BR>&gt; future revisions of the hardware wrt =
to using=20
a SystemACE, and am<BR>&gt; planning on moving the device trees into NV =
storage=20
like FLASH.<BR><BR><SPAN class=3D581320513-13122007><FONT face=3DArial=20
color=3D#0000ff><FONT face=3D"Times New Roman" color=3D#000000>SN&gt;=20
</FONT></FONT></SPAN>'with' not 'in'. either using SystemAce, or a flash =

image.</FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT size=3D2><SPAN =
class=3D581320513-13122007><FONT=20
face=3DArial><FONT color=3D#0000ff>Ah! See, I though that there was the =
mention of=20
trying to put it into the bitstream and that is what I was worried about =
since=20
retrieval of that from the bitstream file is doable but if it was being =
stored=20
in the FPGA somehow and being retrieved there (????) that could lead to =
problems=20
for some systems.</FONT>&nbsp;</FONT></SPAN><BR><BR>&gt; One solution =
I've been=20
thinking through (in lieu of direct support from<BR>&gt; EDK) is to use =
a tcl=20
script with xps to traverse the hardware tree and<BR>&gt; generate the =
device=20
tree. It seems like it should be relatively trivial<BR>&gt; to obtain =
the=20
information. It's just going to be a pain to write all the<BR>&gt; =
handlers for=20
each different linux driver: temac, interrupt controller,<BR>&gt; DMA=20
controller, etc.<BR>&gt; In reality the best way to handle this would be =
to have=20
EDK generate the<BR>&gt; device tree as part of the library/bsp build=20
process.<BR><SPAN class=3D581320513-13122007><FONT face=3DArial=20
color=3D#0000ff>&nbsp;</FONT></SPAN><BR><SPAN =
class=3D581320513-13122007><FONT=20
face=3DArial color=3D#0000ff><FONT face=3D"Times New Roman" =
color=3D#000000>SN&gt;=20
</FONT></FONT></SPAN>We have a python script to do this.&nbsp; The main =
problem=20
with just looking <BR><SPAN class=3D581320513-13122007><FONT =
face=3DArial=20
color=3D#0000ff><FONT face=3D"Times New Roman" color=3D#000000>SN&gt;=20
</FONT></FONT></SPAN>at the mhs file is that you lose all the defaults =
for each=20
IP.&nbsp; Hence, we've <BR><SPAN class=3D581320513-13122007><FONT =
face=3DArial=20
color=3D#0000ff><FONT face=3D"Times New Roman" color=3D#000000>SN&gt;=20
</FONT></FONT></SPAN>also written a BSP generator to do this.&nbsp; both =
are at=20
<BR><SPAN class=3D581320513-13122007><FONT face=3DArial =
color=3D#0000ff><FONT=20
face=3D"Times New Roman" color=3D#000000>SN&gt;=20
</FONT></FONT></SPAN>git://git.xilinx.com/gen-mhs-devtree.py<BR><SPAN=20
class=3D581320513-13122007><FONT face=3DArial color=3D#0000ff><FONT=20
face=3D"Times New Roman" color=3D#000000>SN&gt; =
</FONT></FONT></SPAN>Once I can=20
verify that they work in the mainline tree, I'll be sending out =
<BR><SPAN=20
class=3D581320513-13122007><FONT face=3DArial color=3D#0000ff><FONT=20
face=3D"Times New Roman" color=3D#000000>SN&gt; </FONT></FONT></SPAN>the =
patches=20
that make this all work.<BR><BR>&gt; Now, what I'd like<BR>&gt; to see =
with=20
regards to this is the ability to change the handler for the<BR>&gt; =
generating=20
a specific device information. An example could be the temac.<BR>&gt; If =
at some=20
point in the future the temac needs new/more information to<BR>&gt; =
support its=20
configuration/run-time then having to get a patch from<BR>&gt; Xilinx =
for a EDK=20
is way too slow. The developers should be giving the<BR>&gt; opportunity =
to=20
inject a new handler into the various parts of the device<BR>&gt; tree=20
generation. That way when the kernel patch is submitted, an EDK<BR>&gt; =
device=20
generator patch will be submitted at the same time to keep<BR>&gt; =
everything in=20
sync.<BR><BR><SPAN class=3D581320513-13122007><FONT face=3DArial =
color=3D#0000ff><FONT=20
face=3D"Times New Roman" color=3D#000000>SN&gt; =
</FONT></FONT></SPAN>Interesting=20
idea..&nbsp; I've been trying to figure out how to architect this =
<BR><SPAN=20
class=3D581320513-13122007><FONT face=3DArial color=3D#0000ff><FONT=20
face=3D"Times New Roman" color=3D#000000>SN&gt; =
</FONT></FONT></SPAN>better, but it=20
requires some information passing within EDK that isnot <BR><SPAN=20
class=3D581320513-13122007><FONT face=3DArial color=3D#0000ff><FONT=20
face=3D"Times New Roman" color=3D#000000>SN&gt; =
</FONT></FONT></SPAN>today=20
supported.&nbsp; I don't see at all how to synchronize this with =
<BR><SPAN=20
class=3D581320513-13122007><FONT face=3DArial color=3D#0000ff><FONT=20
face=3D"Times New Roman" color=3D#000000>SN&gt; =
</FONT></FONT></SPAN>patches to the=20
kernel, tho.&nbsp; My approach is to describe the hardware <BR><SPAN=20
class=3D581320513-13122007><FONT face=3DArial color=3D#0000ff><FONT=20
face=3D"Times New Roman" color=3D#000000>SN&gt; </FONT></FONT></SPAN>as =
completely=20
and faithfully as we can (given the information in EDK), <BR><SPAN=20
class=3D581320513-13122007><FONT face=3DArial color=3D#0000ff><FONT=20
face=3D"Times New Roman" color=3D#000000>SN&gt; </FONT></FONT></SPAN>and =
let the=20
drivers do whatever with it that they want to.<BR><BR><SPAN=20
class=3D581320513-13122007><FONT face=3DArial color=3D#0000ff>You'll =
have to correct=20
if I'm wrong here, but from&nbsp;what I've been reading up about EDK and =
its=20
built-in Tcl interface, one can load their system.xmp with corresponding =
mhs and=20
then use Tcl to traverse the device information to create the same =
information=20
as found using the generated BSP. This would allow for a Tcl system that =
could=20
be setup such that a main (unchanging, or slowly changing) Tcl script =
that would=20
start the EDK definition traversal and upon finding a new device it =
would use a=20
registered&nbsp;'handler' Tcl function. These handlers could be stored =
as=20
seperate script/files and would be registered at the start of the main =
script=20
either via a config file or by searching a directory and looking for =
tags stored=20
at the top of the Tcl files in comments. These driver =
handlers&nbsp;would be=20
passed the handle to the system definition and then know how to gather =
the=20
information they need to create their entry in the device tree. This =
approach=20
gets around the issue of losing defaults found in the mhs=20
file.</FONT></SPAN><BR></FONT></DIV><FONT face=3DArial =
color=3D#0000ff></FONT>
<DIV dir=3Dltr align=3Dleft><FONT size=3D2><FONT face=3DArial =
color=3D#0000ff>I originally=20
looked at trying to perform the same thing using just device drivers in =
EDK, but=20
I think I found some pitfall.&nbsp; Oh, I think it was that I would have =
to=20
choose the OS for the processor and EDK wants to build the library, but =
there=20
isn't anything to compile for Linux (or I wasn't compiling anything for =
the=20
linux BSP) and that was adding extra time to the download.bit generation =
and=20
that is already a long build process.</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT size=3D2><FONT face=3DArial =
color=3D#0000ff>-- Mike=20
</FONT><BR></DIV></FONT></BODY></HTML>

------_=_NextPart_001_01C83D8E.EB0FFDA3--
