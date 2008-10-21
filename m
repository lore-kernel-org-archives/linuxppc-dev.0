Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE001.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 051FCDDDF0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Oct 2008 07:08:36 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C933B8.C83B6C24"
Subject: RE: Compile program using XGpio
Date: Tue, 21 Oct 2008 14:08:27 -0600
In-Reply-To: <d43ae5a00810210735k2e2068aew3e67e36bd079805@mail.gmail.com>
References: <d43ae5a00810210735k2e2068aew3e67e36bd079805@mail.gmail.com>
From: John Linn <John.Linn@xilinx.com>
To: "Bruno Monteiro" <bms.monteiro@gmail.com>, <linuxppc-embedded@ozlabs.org>
Message-ID: <20081021200830.436214D8052@mail10-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------_=_NextPart_001_01C933B8.C83B6C24
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Bruno,

 =


I don't think you can do what you're trying to do, unless I'm
misunderstanding or just not smart enough.

 =


The EDK from Xilinx ships with drivers that are not Linux drivers.
Those functions in main below are intended for a standalone (no RTOS)
system such they can't just be called from a user app in Linux.  You are
sort of trying to create a user mode driver with what you are doing.

 =


There is a character mode gpio driver in the Xilinx git tree,
git://git.xilinx.com/linux-2.6-xlnx.git that has been used previously.
I don't currently test that driver as we're in the process of getting a
flattened gpio driver that is not char driver ready for mainline.

 =


I plan to take a look at the char mode gpio driver today as there's
another question regarding it on the list.

 =


Thanks,

John

 =


 =


________________________________

From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On
Behalf Of Bruno Monteiro
Sent: Tuesday, October 21, 2008 8:36 AM
To: linuxppc-embedded@ozlabs.org
Subject: Compile program using XGpio

 =


Hi all,

I'm working with a Virtex2p. I have a running system using:

*	EDK 9.1
*	Crosstool-ng (svn)
*	linux-2.6-xlnx
*	BusyBox 1.12.1

Now, i'm trying to build a small program that turn off leds. I guess it
should be something like this:

void main (void){
    XGpio led;    =

    XGpio_Initialize (&led, XPAR_LEDS_4BIT_DEVICE_ID);
    XGpio_SetDataDirection(&led,1,0);
    XGpio_DiscreteWrite(&led,1,0xf);    =

}


I want to know how to compile it (without EDK). Any suggestion? =



Thanks,
Bruno Monteiro =




This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C933B8.C83B6C24
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1462915472;
	mso-list-template-ids:-2003805244;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Hi Bruno,<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I don&#8217;t think you can do what
you&#8217;re trying to do, unless I&#8217;m misunderstanding or just not sm=
art
enough.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>The EDK from Xilinx ships with drivers=

that are not Linux drivers. &nbsp;Those functions in main below are intende=
d
for a standalone (no RTOS) system such they can&#8217;t just be called from=
 a
user app in Linux.&nbsp; You are sort of trying to create a user mode drive=
r
with what you are doing.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>There is a character mode gpio driver =
in
the Xilinx git tree, git://git.xilinx.com/linux-2.6-xlnx.git that has been =
used
previously.&nbsp; I don&#8217;t currently test that driver as we&#8217;re i=
n
the process of getting a flattened gpio driver that is not char driver read=
y
for mainline.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I plan to take a look at the char mode=

gpio driver today as there&#8217;s another question regarding it on the lis=
t.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>John<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div style=3D'border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt'>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font siz=
e=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span style=3D'font-si=
ze:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> linuxppc=
-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] <b><sp=
an
style=3D'font-weight:bold'>On Behalf Of </span></b>Bruno Monteiro<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Tuesday, October 21, 2=
008
8:36 AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> linuxppc-embedded@ozlabs=
.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Compile program usi=
ng XGpio</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>Hi all,<br>
<br>
I'm working with a Virtex2p. I have a running system using:<o:p></o:p></spa=
n></font></p>

<ul type=3Ddisc>
 <li class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto;
     mso-list:l0 level1 lfo1'><font size=3D3 face=3D"Times New Roman"><span=

     style=3D'font-size:12.0pt'>EDK 9.1<o:p></o:p></span></font></li>
 <li class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto;
     mso-list:l0 level1 lfo1'><font size=3D3 face=3D"Times New Roman"><span=

     style=3D'font-size:12.0pt'>Crosstool-ng (svn)<o:p></o:p></span></font>=
</li>
 <li class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto;
     mso-list:l0 level1 lfo1'><font size=3D3 face=3D"Times New Roman"><span=

     style=3D'font-size:12.0pt'>linux-2.6-xlnx<o:p></o:p></span></font></li=
>
 <li class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto;
     mso-list:l0 level1 lfo1'><font size=3D3 face=3D"Times New Roman"><span=

     style=3D'font-size:12.0pt'>BusyBox 1.12.1<o:p></o:p></span></font></li=
>
</ul>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Now, i'm trying t=
o build
a small program that turn off leds. I guess it should be something like thi=
s:<o:p></o:p></span></font></p>

<div style=3D'margin-left:30.0pt'>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>void main (void){=
<br>
&nbsp;&nbsp;&nbsp; XGpio led;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; XGpio_Initialize (&amp;led, XPAR_LEDS_4BIT_DEVICE_ID);<b=
r>
&nbsp;&nbsp;&nbsp; XGpio_SetDataDirection(&amp;led,1,0);<br>
&nbsp;&nbsp;&nbsp; XGpio_DiscreteWrite(&amp;led,1,0xf);&nbsp;&nbsp;&nbsp; <=
br>
}<o:p></o:p></span></font></p>

</div>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'><br>
I want to know how to compile it (without EDK). Any suggestion? <br>
<br>
<br>
Thanks,<br>
Bruno Monteiro <o:p></o:p></span></font></p>

</div>

</div>

<br clear=3Dall> This email and any attachments are intended for the sole u=
se of the named recipient(s) and contain(s) confidential information that m=
ay be proprietary, privileged or copyrighted under applicable law. If you a=
re not the intended recipient, do not read, copy, or forward this email mes=
sage or any attachments. Delete this email message and any attachments imme=
diately.
</body>

</html>


------_=_NextPart_001_01C933B8.C83B6C24--
