Return-Path: <mike.koss@ngc.com>
Received: from xmrm0101.northgrum.com (xmrm0101.northgrum.com
	[155.104.240.104]) by ozlabs.org (Postfix) with ESMTP id AFC8DDDF69
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Dec 2007 13:40:15 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C83041.61B9C89B"
Subject: RE: Xilinx devicetrees
Message-ID: <EDAE140DF1B2FC42B5867C22CA0B333F0A58E4@XMBIL132.northgrum.com>
In-Reply-To: <20071125235855.95B9999804D@mail138-cpk.bigfish.com>
References: <47480CF0.7090105@dlasys.net>	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>	<47493D4F.4070605@dlasys.net><fa686aa40711251421q38f53ee3hb2a308cc5f93183f@mail.gmail.com><4749FD5E.7000408@dlasys.net>
	<20071125235855.95B9999804D@mail138-cpk.bigfish.com>
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
Date: Thu, 13 Dec 2007 02:40:17 -0000

This is a multi-part message in MIME format.

------_=_NextPart_001_01C83041.61B9C89B
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Time for my $.02, since I am heavily weighting my future designs on the
use of the device trees. :) (and b/c I don't check my work e-mail from
home ;P)

________________________________

From: Stephen Neuendorffer [mailto:stephen.neuendorffer@xilinx.com]=20
Sent: Sunday, November 25, 2007 6:59 PM
To: David H. Lynch Jr.; Grant Likely; linuxppc-embedded
Subject: RE: Xilinx devicetrees

DL>    I am not expert on this, but at Pico we already store our boot
monitor in the .bit files in BRAM.
DL>     But that is not free.  It is one of the reasons we do not use
u-boot. Our boot monitor must fit into 16K of BRAM.
DL>     Must be able to perform selftests on critical hardware, support
a flash file system, load bit files from flash to the FGA, load and
exectute elf files, allow a small set of user commands,=20
DL>  and handle hosted vs. standalone operation.
DL>     And aparently extract the devicetree from a bit file and pass it
to a linux kernel.

SN> Once you can load a bitstream from flash, loading the device tree
from flash
SN> should be practically free.  In any event, why do you do this rather
than just run out of the flash (or a ram copy of the flash?)
=20
This is the approach that I am currently taking with our future design.
In our system, we actually have 2 physical systems running Linux inside
the V4 (that's why there are 2 PowerPCs :) ). My current plan would be
to have the device trees stored in FLASH along w/ a single linux image.
Our bootloader on the board would then copy that information from FLASH
to RAM for both systems. This allows us to have two physically different
systems setup with different hardware, but have one linux image with two
different device trees. With a standard linux kernel weighing it at ~
3-5MB (including initramfs) that's a hefty savings in FLASH for us. Plus
it can considerably lower boot time instead of having to verify multiple
large images.

DL>  In static or fairly static hardware, that's fine. Even in somewhat
dynamic hardware with large quantities of startup resources - like a PC.
DL>  But in highly dynamic hardware with fairly limited resources it
starts to become an issue.

SN> As Grant says, the dynamic detection doesn't have to be done in the
boot loader, it could be done in the platform code.  You can largely
ignore=20
SN> the device trees, or always boot with a core device tree and figure
it all out later (perhaps using version registers).  I anticipate that=20
SN> the 'standard flow' will have standard platform code for any board
that uses a complete device tree.  If you have the need to do something=20
SN> extraordinary, then you should feel free to hack away...  However,
It doesn't seem to me to be really necessary in your case, assuming that

SN> the device tree is packaged (somehow, TBD) along with the bitstream.
=20
I don't know if packaging the device tree with the bitstream is the best
way to go. It's possible that it could lead to headaches for certain
systems that have security restrictions. The same could be said for
using it w/ the SystemACE to load it into RAM after the image. (which is
what I'm currently doing for my 2 linux images in lieu of a true on-chip
bootloader). I am already taking the security concerns into account for
future revisions of the hardware wrt to using a SystemACE, and am
planning on moving the device trees into NV storage like FLASH.

GL> No, unfortunately they don't deal with the problem you're facing
GL> (which I'm facing also).  But it will be solved if we figure out a
GL> sane way to bind the device tree up with the FPGA bitstream without
GL> consuming FPGA resources.
 =20
DL>    Note to Xilinx:
DL>       There MUST be some way of binding a device description to a
bit file.
DL>    neither building it into the FPGA fabric nor appending it to the
end
DL> of the bit file are perfect solutions,
DL>    The former is more powerfull and flexible but wastes precious
DL> resources. The later is more complex and puts more burdens on
DL>    software developers, and may be completely unfeasible in some
DL> environments - not mine fortunately.

SN> I don't understand the 'burden on software developers'.  The code to
do this will just be standard code.  The worst that one can say is:
SN> 1) I need several KB additional non volatile storage.  Given the
size of the FPGA bitstream, this can't be a huge constraint.
SN> 2) I can't use compile time optimization based on xparameters as
easily.  Anyone want to implement the alternatives mechanism on ppc and
microblaze?
SN> 3) Some additional boot time.  However, again, this seems marginal.
=20
I do agree that using more FPGA resources is not a solution to the
problem. I'm already hitting 80% usage on a FX60 and trying to squeeze
more real estate for storage of the device tree seems silly. Especially
since that would require that every image have this extra hardware built
into it just to support booting a Linux kernel. Why should I have to
have different hardware to boot linux, versus non-kernel, xilkernel, or
other (GHS, LynxOS, etc..)?

DL>    Regardless, something must be done. An odd collection of
devicetree
DL> files co-mingled with a collection of bit files, is little better
than
DL> xparameter files all over the place.

SN> Certainly..  But in a sense, these are all intermediate files on the
path to the image on the board.  That=20
SN> (and how it is interpreted by the platform code) should be generated
in a consistent fashion by EDK. =20
SN> See my other email for some of the possibilities.  Are there
specific reasons why you think those=20
SN> proposals are inadequate?  Now is the time when we can take
criticism, with the goal towards making=20
SN> a good end solution.
=20
One solution I've been thinking through (in lieu of direct support from
EDK) is to use a tcl script with xps to traverse the hardware tree and
generate the device tree. It seems like it should be relatively trivial
to obtain the information. It's just going to be a pain to write all the
handlers for each different linux driver: temac, interrupt controller,
DMA controller, etc.

In reality the best way to handle this would be to have EDK generate the
device tree as part of the library/bsp build process. Now, what I'd like
to see with regards to this is the ability to change the handler for the
generating a specific device information. An example could be the temac.
If at some point in the future the temac needs new/more information to
support its configuration/run-time then having to get a patch from
Xilinx for a EDK is way too slow. The developers should be giving the
opportunity to inject a new handler into the various parts of the device
tree generation. That way when the kernel patch is submitted, an EDK
device generator patch will be submitted at the same time to keep
everything in sync.

DL>    And once again a plea to ALWAYS make version/capabilities
registers
DL> atleast an optional part of every design.
DL>    Embeddeding a device tree into a design might be fairly
expensive. a
DL> pair of read only 32 bit registers is damn near free - basically the
DL> FPGA equivalent of atmost 64 diodes or resistors.

SN> Actually, device trees actually seem to be cheaper (in the whole
system sense) than such registers.  Unless there is something I don't
understand?
=20
The issue here is that the hardware changed and the driver doesn't
support it. I think this would be fixed by having information passed to
the driver in the platform_device struct to specify information, since
its not able to be discerned by the physical hardware information:
version registers, etc.


------_=_NextPart_001_01C83041.61B9C89B
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>RE: Xilinx devicetrees</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3199" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D745091714-26112007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Time for my $.02, since I am heavily weighting =
my future=20
designs on the use of the device trees. :) (and b/c I don't check my =
work e-mail=20
from home ;P)</FONT></SPAN></DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
</DIV>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr =
align=3Dleft><FONT face=3DTahoma=20
size=3D2><B>From:</B> Stephen Neuendorffer=20
[mailto:stephen.neuendorffer@xilinx.com] <BR><B>Sent:</B> Sunday, =
November 25,=20
2007 6:59 PM<BR><B>To:</B> David H. Lynch Jr.; Grant Likely;=20
linuxppc-embedded<BR><B>Subject:</B> RE: Xilinx =
devicetrees<BR></FONT><FONT=20
size=3D2><BR><SPAN =
class=3D745091714-26112007>DL</SPAN>&gt;&nbsp;&nbsp;&nbsp; I am=20
not expert on this, but at Pico we already store our boot<SPAN=20
class=3D745091714-26112007>&nbsp;</SPAN>monitor in the .bit files in=20
BRAM.<BR><SPAN =
class=3D745091714-26112007>DL</SPAN>&gt;&nbsp;&nbsp;&nbsp;&nbsp;=20
But that is not free.&nbsp; It is one of the reasons we do not =
use&nbsp;u-boot.=20
Our boot monitor must fit into 16K of BRAM.<BR><SPAN=20
class=3D745091714-26112007>DL</SPAN>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Must be =
able to=20
perform selftests on critical hardware, support a&nbsp;flash file =
system, load=20
bit files from flash to the FGA, load and&nbsp;exectute elf files, allow =
a small=20
set of user commands,&nbsp;<BR><SPAN=20
class=3D745091714-26112007>DL&gt;&nbsp;&nbsp;</SPAN>and =
handle&nbsp;hosted vs.=20
standalone operation.<BR><SPAN=20
class=3D745091714-26112007>DL</SPAN>&gt;&nbsp;&nbsp;&nbsp;&nbsp; And =
aparently=20
extract the devicetree from a bit file and pass it to&nbsp;a linux=20
kernel.<BR><BR><SPAN class=3D745091714-26112007>SN&gt;&nbsp;</SPAN>Once =
you can=20
load a bitstream from flash, loading the device tree from flash<BR><SPAN =

class=3D745091714-26112007>SN&gt;&nbsp;</SPAN>should be practically =
free.&nbsp; In=20
any event, why do you do this rather than just run out of the flash (or =
a ram=20
copy of the flash?)<BR><SPAN =
class=3D745091714-26112007>&nbsp;</SPAN><BR><SPAN=20
class=3D745091714-26112007>This is the approach that I am currently =
taking with=20
our future design. In our system, we actually have 2 physical systems =
running=20
Linux inside the V4 (that's why there&nbsp;are&nbsp;2 PowerPCs :) =
).&nbsp;My=20
current plan would be to have the device trees stored in FLASH along w/ =
a single=20
linux image. Our bootloader on the board would then copy that =
information from=20
FLASH to RAM for both systems. This allows us to have two physically =
different=20
systems setup with different hardware, but have one linux image with two =

different device trees. With a standard linux kernel weighing it at ~ =
3-5MB=20
(including initramfs) that's a hefty savings in FLASH for us. Plus it =
can=20
considerably lower boot time instead of having to verify multiple large=20
images.</SPAN><BR><BR><SPAN =
class=3D745091714-26112007>DL</SPAN>&gt;&nbsp; In=20
static or fairly static hardware, that's fine. Even in somewhat<SPAN=20
class=3D745091714-26112007>&nbsp;</SPAN>dynamic hardware with large =
quantities of=20
startup resources - like a PC.<BR><SPAN=20
class=3D745091714-26112007>DL</SPAN>&gt;&nbsp; But in highly dynamic =
hardware with=20
fairly limited resources it<SPAN =
class=3D745091714-26112007>&nbsp;</SPAN>starts to=20
become an issue.<BR><BR><SPAN class=3D745091714-26112007>SN&gt; =
</SPAN>As Grant=20
says, the dynamic detection doesn't have to be done in the boot loader, =
it could=20
be done in the platform code.&nbsp; You can largely ignore <BR><SPAN=20
class=3D745091714-26112007>SN&gt; </SPAN>the device trees, or always =
boot with a=20
core device tree and figure it all out later (perhaps using version=20
registers).&nbsp; I anticipate that <BR><SPAN =
class=3D745091714-26112007>SN&gt;=20
</SPAN>the 'standard flow' will have standard platform code for any =
board that=20
uses a complete device tree.&nbsp; If you have the need to do something=20
<BR><SPAN class=3D745091714-26112007>SN&gt; </SPAN>extraordinary, then =
you should=20
feel free to hack away...&nbsp; However, It doesn't seem to me to be =
really=20
necessary in your case, assuming that <BR><SPAN =
class=3D745091714-26112007>SN&gt;=20
</SPAN>the device tree is packaged (somehow, TBD) along with the=20
bitstream.<BR><SPAN class=3D745091714-26112007>&nbsp;</SPAN><BR><SPAN=20
class=3D745091714-26112007>I don't&nbsp;know if packaging the device =
tree with the=20
bitstream is the best way to go. It's possible that it could lead to =
headaches=20
for certain systems that have security restrictions. The same could be =
said for=20
using it w/ the SystemACE to load it into RAM after the image. (which is =
what=20
I'm currently doing for my 2 linux images in lieu of a true on-chip =
bootloader).=20
I am already taking the security concerns into account for future =
revisions of=20
the hardware wrt to using a SystemACE, and am planning on moving the =
device=20
trees into NV storage like FLASH.</SPAN><BR><BR><SPAN=20
class=3D745091714-26112007>GL</SPAN>&gt; No, unfortunately they don't =
deal with=20
the problem you're facing<BR><SPAN =
class=3D745091714-26112007>GL</SPAN>&gt; (which=20
I'm facing also).&nbsp; But it will be solved if we figure out =
a<BR><SPAN=20
class=3D745091714-26112007>GL</SPAN>&gt; sane way to bind the device =
tree up with=20
the FPGA bitstream without<BR><SPAN =
class=3D745091714-26112007>GL</SPAN>&gt;=20
consuming FPGA resources.<BR>&nbsp;&nbsp;<BR><SPAN=20
class=3D745091714-26112007>DL</SPAN>&gt;&nbsp;&nbsp;&nbsp; Note to=20
Xilinx:<BR><SPAN=20
class=3D745091714-26112007>DL</SPAN>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; There=20
MUST be some way of binding a device description to a bit file.<BR><SPAN =

class=3D745091714-26112007>DL</SPAN>&gt;&nbsp;&nbsp;&nbsp; neither =
building it=20
into the FPGA fabric nor appending it to the end<BR><SPAN=20
class=3D745091714-26112007>DL</SPAN>&gt; of the bit file are perfect=20
solutions,<BR><SPAN =
class=3D745091714-26112007>DL</SPAN>&gt;&nbsp;&nbsp;&nbsp; The=20
former is more powerfull and flexible but wastes precious<BR><SPAN=20
class=3D745091714-26112007>DL</SPAN>&gt; resources. The later is more =
complex and=20
puts more burdens on<BR><SPAN=20
class=3D745091714-26112007>DL</SPAN>&gt;&nbsp;&nbsp;&nbsp; software =
developers,=20
and may be completely unfeasible in some<BR><SPAN=20
class=3D745091714-26112007>DL</SPAN>&gt; environments - not mine=20
fortunately.<BR><BR><SPAN class=3D745091714-26112007>SN&gt; </SPAN>I =
don't=20
understand the 'burden on software developers'.&nbsp; The code to do =
this will=20
just be standard code.&nbsp; The worst that one can say is:<BR><SPAN=20
class=3D745091714-26112007>SN&gt; </SPAN>1) I need several KB additional =
non=20
volatile storage.&nbsp; Given the size of the FPGA bitstream, this can't =
be a=20
huge constraint.<BR><SPAN class=3D745091714-26112007>SN&gt; </SPAN>2) I =
can't use=20
compile time optimization based on xparameters as easily.&nbsp; Anyone =
want to=20
implement the alternatives mechanism on ppc and microblaze?<BR><SPAN=20
class=3D745091714-26112007>SN&gt; </SPAN>3) Some additional boot =
time.&nbsp;=20
However, again, this seems marginal.<BR><SPAN=20
class=3D745091714-26112007>&nbsp;</SPAN><BR><SPAN =
class=3D745091714-26112007>I do=20
agree that using more FPGA resources is not a solution to the =
problem.&nbsp;I'm=20
already hitting 80% usage on a FX60 and trying to squeeze&nbsp;more real =
estate=20
for storage of the device tree seems silly. Especially since that would =
require=20
that every image have this extra hardware built into it just to support =
booting=20
a Linux kernel. Why should I have to have different hardware to boot =
linux,=20
versus non-kernel, xilkernel, or other (GHS, LynxOS, =
etc..)?</SPAN><BR><BR><SPAN=20
class=3D745091714-26112007>DL</SPAN>&gt;&nbsp;&nbsp;&nbsp; Regardless, =
something=20
must be done. An odd collection of devicetree<BR><SPAN=20
class=3D745091714-26112007>DL</SPAN>&gt; files co-mingled with a =
collection of bit=20
files, is little better than<BR><SPAN =
class=3D745091714-26112007>DL</SPAN>&gt;=20
xparameter files all over the place.<BR><BR><SPAN=20
class=3D745091714-26112007>SN&gt; </SPAN>Certainly..&nbsp; But in a =
sense, these=20
are all intermediate files on the path to the image on the board.&nbsp; =
That=20
<BR><SPAN class=3D745091714-26112007>SN&gt; </SPAN>(and how it is =
interpreted by=20
the platform code) should be generated in a consistent fashion by =
EDK.&nbsp;=20
<BR><SPAN class=3D745091714-26112007>SN&gt; </SPAN>See my other email =
for some of=20
the possibilities.&nbsp; Are there specific reasons why you think those=20
<BR><SPAN class=3D745091714-26112007>SN&gt; </SPAN>proposals are =
inadequate?&nbsp;=20
Now is the time when we can take criticism, with the goal towards making =

<BR><SPAN class=3D745091714-26112007>SN&gt; </SPAN>a good end =
solution.<BR><SPAN=20
class=3D745091714-26112007>&nbsp;</SPAN><BR><SPAN =
class=3D745091714-26112007>One=20
solution I've been thinking through (in lieu of direct support from EDK) =
is to=20
use a tcl script with xps to traverse the hardware tree and generate the =
device=20
tree. It seems like it should be relatively trivial to obtain the =
information.=20
It's just going to be a pain to write all the handlers for each =
different linux=20
driver: temac, interrupt controller, DMA controller, =
etc.</SPAN></FONT></DIV>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr =
align=3Dleft><SPAN=20
class=3D745091714-26112007></SPAN><BR><FONT size=3D2><SPAN=20
class=3D745091714-26112007>In reality the best way to handle this would =
be to have=20
EDK generate the device tree as part of the library/bsp build process. =
Now, what=20
I'd like to see with regards to this is the ability to change the =
handler for=20
the generating a specific device information. An example could be the =
temac. If=20
at some point in the future the temac needs new/more information to =
support its=20
configuration/run-time then having to get a patch from Xilinx for a EDK =
is way=20
too slow. The developers should be giving the opportunity to inject a =
new=20
handler into the various parts of the device tree generation. That way =
when the=20
kernel patch is submitted, an EDK device generator patch will be =
submitted at=20
the same time to keep everything in sync.</SPAN><BR><BR><SPAN=20
class=3D745091714-26112007>DL</SPAN>&gt;&nbsp;&nbsp;&nbsp; And once =
again a plea=20
to ALWAYS make version/capabilities registers<BR><SPAN=20
class=3D745091714-26112007>DL</SPAN>&gt; atleast an optional part of =
every=20
design.<BR><SPAN =
class=3D745091714-26112007>DL</SPAN>&gt;&nbsp;&nbsp;&nbsp;=20
Embeddeding a device tree into a design might be fairly expensive. =
a<BR><SPAN=20
class=3D745091714-26112007>DL</SPAN>&gt; pair of read only 32 bit =
registers is=20
damn near free - basically the<BR><SPAN =
class=3D745091714-26112007>DL</SPAN>&gt;=20
FPGA equivalent of atmost 64 diodes or resistors.<BR><BR><SPAN=20
class=3D745091714-26112007>SN&gt; </SPAN>Actually, device trees actually =
seem to=20
be cheaper (in the whole system sense) than such registers.&nbsp; Unless =
there=20
is something I don't understand?<BR><SPAN =
class=3D745091714-26112007><FONT=20
face=3DArial color=3D#0000ff>&nbsp;</FONT></SPAN><BR><SPAN=20
class=3D745091714-26112007>The issue here is that the hardware changed =
and the=20
driver doesn't support it. I think this&nbsp;would be fixed =
by&nbsp;having=20
information passed to the driver in the platform_device struct to=20
specify&nbsp;information, since its not able to be discerned by the =
physical=20
hardware information: version registers,=20
etc.</SPAN><BR></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C83041.61B9C89B--
