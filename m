Return-Path: <Mark.Pearson@bladenetwork.net>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 63877B70A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Dec 2010 07:45:31 +1100 (EST)
Received: from mail182-tx2 (localhost.localdomain [127.0.0.1])	by
	mail182-tx2-R.bigfish.com (Postfix) with ESMTP id 5C46213680E5	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  9 Dec 2010 20:45:20 +0000 (UTC)
Received: from TX2EHSMHS006.bigfish.com (unknown [10.9.14.245])	by
	mail182-tx2.bigfish.com (Postfix) with ESMTP id 9C5891270046	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  9 Dec 2010 20:45:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB97E2.00A7E2B4"
Subject: Problem with MPC8536 and external IRQs when using a loadable kernel
	module
Date: Thu, 9 Dec 2010 12:45:15 -0800
Message-ID: <11BA25866A2E3A45A797B469B2344B3901554D3D@blademail.bladenetwork.net>
From: Mark Pearson <Mark.Pearson@bladenetwork.net>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------_=_NextPart_001_01CB97E2.00A7E2B4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I have a curious problem. This is on a MPC8636 based platform with
36-bit address space (that may or may not be important).

 =


I have a very simple driver that registers for one of the external IRQs
with a trivial interrupt handler. It works great when built in as part
of the kernel.

 =


However, if I make it a loadable module I get the crash shown below
(blade_irq is my IRQ handler).

 =


-----Console capture ----------------------------------------

Unable to handle kernel paging request for instruction fetch

Faulting instruction address: 0xf31200f8

Oops: Kernel access of bad area, sig: 11 [#1]

COMPASS

Modules linked in: blade_pnic blade_irq_drv blade_cpld_mmap_drv

NIP: f31200f8 LR: c006a26c CTR: f31200f8

REGS: c057bdd0 TRAP: 0400   Not tainted  (2.6.32.12-131)

MSR: 00029000 <EE,ME,CE>  CR: 24024048  XER: 00000000

TASK =3D c0544318[0] 'swapper' THREAD: c057a000

GPR00: 00000000 c057be80 c0544318 00000012 00000000 08f9cac0 c058177c
ef820000 =


GPR08: 00000200 c04a0000 f31200f8 c058a368 2dc6c000 1012b250 3ffbd200
00000000 =


GPR16: 3ff91140 3ffb22f8 00000000 00000000 00000000 00000000 00000000
00000000 =


GPR24: 00000000 00000000 00001600 c049fe4c 00000000 00000000 00000012
ea7975c0 =


NIP [f31200f8] blade_irq+0x0/0x110 [blade_irq_drv]

LR [c006a26c] handle_IRQ_event+0x64/0x13c

Call Trace:

[c057be80] [c0547b80] 0xc0547b80 (unreliable)

[c057bea0] [c006c41c] handle_fasteoi_irq+0x68/0xf4

[c057beb0] [c0004da0] do_IRQ+0x98/0xb4

[c057bed0] [c000fe0c] ret_from_except+0x0/0x18

[c057bf90] [c0008168] cpu_idle+0x50/0xd8

[c057bfb0] [c000237c] rest_init+0x5c/0x70

[c057bfc0] [c0516850] start_kernel+0x238/0x2c4

[c057bff0] [c000039c] skpinv+0x2b4/0x2f0

Instruction dump:

7d6903a6 4e800420 3d60c007 396bb59c 7d6903a6 4e800420 38000000 38600000 =


90040068 4e800020 38600000 4e800020 <9421fff0> 7c0802a6 3d20f312
bfc10008 =


Kernel panic - not syncing: Fatal exception in interrupt

Rebooting in 180 seconds..

----- End of Console capture --------------------------------

 =


I've done a few things

 =


-          Verified the symbol address and the NIP match. They seem
correct

-          Removed all code from the IRQ handler and just return
IRQ_HANDLED. Still crashes

-          Put an infinite loop at the start of the IRQ handler - loop
isn't hit and still crashes so I assume the handler itself is never run.

-          I'm able to call my IRQ handler from the module init code and
it runs successfully. The problem is only when running in an interrupt
context.

-          I also as a somewhat stupid test passed the physical address
rather than the virtual address when registering the handler. Still
crashes (not sure if that's a valid thing to do to be honest, but I
figured it might be a virtual memory paging issue...grasping at
straws.....).

 =


I do have a ticket in with Freescale support but they suggested I post
here for quicker and wider responses and if there are any ideas out
there I'd really appreciate them. Any chance anyone else has hit this
and knows a workaround or solution? Are there any examples of working
driver modules that use interrupts on the 8536 out there in case I've
done something really goofy in my code? Any suggestions of things to
try?

 =


Thanks in advance =


 =


Mark

 =


 =


 =




Confidentiality Notice: This message and any attachments may contain  privi=
leged and confidential information. If you have reason to believe that you =
are not the intended recipient or a person responsible for delivering this =
information to an intended recipient, you are hereby notified that any revi=
ew, dissemination, distribution, or copying of this message is strictly pro=
hibited. Please contact the sender immediately by reply mail and destroy al=
l copies of the original message.


------_=_NextPart_001_01CB97E2.00A7E2B4
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><META HTTP-EQUIV=3D"Content-Type" CONTENT=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 14 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1466847642;
	mso-list-type:hybrid;
	mso-list-template-ids:-2129755730 -634858350 67698691 67698693 67698689 67=
698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:3;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:20.25pt;
	text-indent:-.25in;
	font-family:"Calibri","sans-serif";
	mso-fareast-font-family:Calibri;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:56.25pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:92.25pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:128.25pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:164.25pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:200.25pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:236.25pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:272.25pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:308.25pt;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>I have a curious=
 problem. This is on a MPC8636 based platform with 36-bit address space (th=
at may or may not be important).<o:p></o:p></p><p class=3DMsoNormal><o:p>&n=
bsp;</o:p></p><p class=3DMsoNormal>I have a very simple driver that registe=
rs for one of the external IRQs with a trivial interrupt handler. It works =
great when built in as part of the kernel.<o:p></o:p></p><p class=3DMsoNorm=
al><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>However, if I make it a loadab=
le module I get the crash shown below (blade_irq is my IRQ handler).<o:p></=
o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>----=
-Console capture ----------------------------------------<o:p></o:p></p><p =
class=3DMsoNormal>Unable to handle kernel paging request for instruction fe=
tch<o:p></o:p></p><p class=3DMsoNormal>Faulting instruction address: 0xf312=
00f8<o:p></o:p></p><p class=3DMsoNormal>Oops: Kernel access of bad area, si=
g: 11 [#1]<o:p></o:p></p><p class=3DMsoNormal>COMPASS<o:p></o:p></p><p clas=
s=3DMsoNormal>Modules linked in: blade_pnic blade_irq_drv blade_cpld_mmap_d=
rv<o:p></o:p></p><p class=3DMsoNormal>NIP: f31200f8 LR: c006a26c CTR: f3120=
0f8<o:p></o:p></p><p class=3DMsoNormal>REGS: c057bdd0 TRAP: 0400&nbsp;&nbsp=
; Not tainted&nbsp; (2.6.32.12-131)<o:p></o:p></p><p class=3DMsoNormal>MSR:=
 00029000 &lt;EE,ME,CE&gt;&nbsp; CR: 24024048&nbsp; XER: 00000000<o:p></o:p=
></p><p class=3DMsoNormal>TASK =3D c0544318[0] 'swapper' THREAD: c057a000<o=
:p></o:p></p><p class=3DMsoNormal>GPR00: 00000000 c057be80 c0544318 0000001=
2 00000000 08f9cac0 c058177c ef820000 <o:p></o:p></p><p class=3DMsoNormal>G=
PR08: 00000200 c04a0000 f31200f8 c058a368 2dc6c000 1012b250 3ffbd200 000000=
00 <o:p></o:p></p><p class=3DMsoNormal>GPR16: 3ff91140 3ffb22f8 00000000 00=
000000 00000000 00000000 00000000 00000000 <o:p></o:p></p><p class=3DMsoNor=
mal>GPR24: 00000000 00000000 00001600 c049fe4c 00000000 00000000 00000012 e=
a7975c0 <o:p></o:p></p><p class=3DMsoNormal>NIP [f31200f8] blade_irq+0x0/0x=
110 [blade_irq_drv]<o:p></o:p></p><p class=3DMsoNormal>LR [c006a26c] handle=
_IRQ_event+0x64/0x13c<o:p></o:p></p><p class=3DMsoNormal>Call Trace:<o:p></=
o:p></p><p class=3DMsoNormal>[c057be80] [c0547b80] 0xc0547b80 (unreliable)<=
o:p></o:p></p><p class=3DMsoNormal>[c057bea0] [c006c41c] handle_fasteoi_irq=
+0x68/0xf4<o:p></o:p></p><p class=3DMsoNormal>[c057beb0] [c0004da0] do_IRQ+=
0x98/0xb4<o:p></o:p></p><p class=3DMsoNormal>[c057bed0] [c000fe0c] ret_from=
_except+0x0/0x18<o:p></o:p></p><p class=3DMsoNormal>[c057bf90] [c0008168] c=
pu_idle+0x50/0xd8<o:p></o:p></p><p class=3DMsoNormal>[c057bfb0] [c000237c] =
rest_init+0x5c/0x70<o:p></o:p></p><p class=3DMsoNormal>[c057bfc0] [c0516850=
] start_kernel+0x238/0x2c4<o:p></o:p></p><p class=3DMsoNormal>[c057bff0] [c=
000039c] skpinv+0x2b4/0x2f0<o:p></o:p></p><p class=3DMsoNormal>Instruction =
dump:<o:p></o:p></p><p class=3DMsoNormal>7d6903a6 4e800420 3d60c007 396bb59=
c 7d6903a6 4e800420 38000000 38600000 <o:p></o:p></p><p class=3DMsoNormal>9=
0040068 4e800020 38600000 4e800020 &lt;9421fff0&gt; 7c0802a6 3d20f312 bfc10=
008 <o:p></o:p></p><p class=3DMsoNormal>Kernel panic - not syncing: Fatal e=
xception in interrupt<o:p></o:p></p><p class=3DMsoNormal>Rebooting in 180 s=
econds..<o:p></o:p></p><p class=3DMsoNormal>----- End of Console capture --=
------------------------------<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbs=
p;</o:p></p><p class=3DMsoNormal>I&#8217;ve done a few things<o:p></o:p></p=
><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoListParagraph styl=
e=3D'margin-left:20.25pt;text-indent:-.25in;mso-list:l0 level1 lfo1'><![if =
!supportLists]><span style=3D'mso-list:Ignore'>-<span style=3D'font:7.0pt "=
Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </=
span></span><![endif]>Verified the symbol address and the NIP match. They s=
eem correct<o:p></o:p></p><p class=3DMsoListParagraph style=3D'margin-left:=
20.25pt;text-indent:-.25in;mso-list:l0 level1 lfo1'><![if !supportLists]><s=
pan style=3D'mso-list:Ignore'>-<span style=3D'font:7.0pt "Times New Roman"'=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><![en=
dif]>Removed all code from the IRQ handler and just return IRQ_HANDLED. Sti=
ll crashes<o:p></o:p></p><p class=3DMsoListParagraph style=3D'margin-left:2=
0.25pt;text-indent:-.25in;mso-list:l0 level1 lfo1'><![if !supportLists]><sp=
an style=3D'mso-list:Ignore'>-<span style=3D'font:7.0pt "Times New Roman"'>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><![end=
if]>Put an infinite loop at the start of the IRQ handler &#8211; loop isn&#=
8217;t hit and still crashes so I assume the handler itself is never run.<o=
:p></o:p></p><p class=3DMsoListParagraph style=3D'margin-left:20.25pt;text-=
indent:-.25in;mso-list:l0 level1 lfo1'><![if !supportLists]><span style=3D'=
mso-list:Ignore'>-<span style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><![endif]>I&#8217;=
m able to call my IRQ handler from the module init code and it runs success=
fully. The problem is only when running in an interrupt context.<o:p></o:p>=
</p><p class=3DMsoListParagraph style=3D'margin-left:20.25pt;text-indent:-.=
25in;mso-list:l0 level1 lfo1'><![if !supportLists]><span style=3D'mso-list:=
Ignore'>-<span style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><![endif]>I also as a somew=
hat stupid test passed the physical address rather than the virtual address=
 when registering the handler. Still crashes (not sure if that&#8217;s a va=
lid thing to do to be honest, but I figured it might be a virtual memory pa=
ging issue&#8230;grasping at straws&#8230;..).<o:p></o:p></p><p class=3DMso=
ListParagraph style=3D'margin-left:20.25pt'><o:p>&nbsp;</o:p></p><p class=
=3DMsoNormal>I do have a ticket in with Freescale support but they suggeste=
d I post here for quicker and wider responses and if there are any ideas ou=
t there I&#8217;d really appreciate them. Any chance anyone else has hit th=
is and knows a workaround or solution? Are there any examples of working dr=
iver modules that use interrupts on the 8536 out there in case I&#8217;ve d=
one something really goofy in my code? Any suggestions of things to try?<o:=
p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>=
Thanks in advance <o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p>=
<p class=3DMsoNormal>Mark<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o=
:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><o:p>=
&nbsp;</o:p></p></div><br clear=3Dall> Confidentiality Notice: This message=
 and any attachments may contain  privileged and confidential information. =
If you have reason to believe that you are not the intended recipient or a =
person responsible for delivering this information to an intended recipient=
, you are hereby notified that any review, dissemination, distribution, or =
copying of this message is strictly prohibited. Please contact the sender i=
mmediately by reply mail and destroy all copies of the original message.
</body></html>


------_=_NextPart_001_01CB97E2.00A7E2B4--
