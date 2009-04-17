Return-Path: <John.Linn@xilinx.com>
Received: from WA4EHSOBE005.bigfish.com (wa4ehsobe005.messaging.microsoft.com
	[216.32.181.15]) by ozlabs.org (Postfix) with ESMTP id 5DEBFDDF71
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 01:46:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9BF73.A1F60AA8"
Subject: RE: Question about DBCR0 initialization for 440
Date: Fri, 17 Apr 2009 09:46:11 -0600
In-Reply-To: <AC5E1C3367E37D44970B81A6ADD1DA2C0729E57E@SDCEXCHANGE01.ad.amcc.com>
References: <20090414203313.8D8F11BE8056@mail209-sin.bigfish.com>
	<AC5E1C3367E37D44970B81A6ADD1DA2C0729E57E@SDCEXCHANGE01.ad.amcc.com>
From: John Linn <John.Linn@xilinx.com>
To: "Tirumala Reddy Marri" <tmarri@amcc.com>, <jwboyer@linux.vnet.ibm.com>,
	<grant.likely@secretlab.ca>, <linuxppc-dev@ozlabs.org>
Message-ID: <20090417154628.43F859D0055@mail178-wa4.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------_=_NextPart_001_01C9BF73.A1F60AA8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Josh, any thoughts on putting this into head_44x.S?

 =


Thanks,

John

 =


________________________________

From: linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf
Of Tirumala Reddy Marri
Sent: Wednesday, April 15, 2009 10:24 AM
To: John Linn; jwboyer@linux.vnet.ibm.com; grant.likely@secretlab.ca;
linuxppc-dev@ozlabs.org
Subject: RE: Question about DBCR0 initialization for 440

 =


Some debuggers like BDI(Abatron) they setup the debug registers. If you
have different debugger which doesn't support configuring debug
registers I suggest you to program then in the head_44x.S file.

 =


From: linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org
[mailto:linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org] On Behalf Of
John Linn
Sent: Tuesday, April 14, 2009 1:33 PM
To: jwboyer@linux.vnet.ibm.com; grant.likely@secretlab.ca;
linuxppc-dev@ozlabs.org
Subject: Question about DBCR0 initialization for 440

 =


The kernel does not initialize the PPC440 DBCR0 register. This prevents
(among other things) the use of software breakpoints with GDB.  I
realize that boot loaders probably do initialize this but we run a lot
without a boot loader and so do our customers.

 =


The file, head_fsl_booke.S, does initialize the register for the
freescale specific code (as shown at the end of the message).

 =


We are needing this also for Xilinx.  What's the best method to
incorporate this, is it possible to add to head_44x.S?

 =


Thanks,

John

 =


#if !defined(CONFIG_BDI_SWITCH)

            /*

             * The Abatron BDI JTAG debugger does not tolerate others

             * mucking with the debug registers.

             */

            lis     r2,DBCR0_IDM@h

            mtspr   SPRN_DBCR0,r2

            isync

            /* clear any residual debug events */

            li      r2,-1

            mtspr   SPRN_DBSR,r2

#endif

 =



This email and any attachments are intended for the sole use of the
named recipient(s) and contain(s) confidential information that may be
proprietary, privileged or copyrighted under applicable law. If you are
not the intended recipient, do not read, copy, or forward this email
message or any attachments. Delete this email message and any
attachments immediately. =




This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C9BF73.A1F60AA8
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:p=3D"urn:schemas-m=
icrosoft-com:office:powerpoint" xmlns:a=3D"urn:schemas-microsoft-com:office=
:access" xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:s=3D"=
uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" xmlns:rs=3D"urn:schemas-microsof=
t-com:rowset" xmlns:z=3D"#RowsetSchema" xmlns:b=3D"urn:schemas-microsoft-co=
m:office:publisher" xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadshee=
t" xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" xmlns=
:odc=3D"urn:schemas-microsoft-com:office:odc" xmlns:oa=3D"urn:schemas-micro=
soft-com:office:activation" xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" xmlns:D=3D"DAV:" xmln=
s:mt=3D"http://schemas.microsoft.com/sharepoint/soap/meetings/" xmlns:x2=3D=
"http://schemas.microsoft.com/office/excel/2003/xml" xmlns:ois=3D"http://sc=
hemas.microsoft.com/sharepoint/soap/ois/" xmlns:dir=3D"http://schemas.micro=
soft.com/sharepoint/soap/directory/" xmlns:ds=3D"http://www.w3.org/2000/09/=
xmldsig#" xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint/dsp" xmlns:u=
dc=3D"http://schemas.microsoft.com/data/udc" xmlns:xsd=3D"http://www.w3.org=
/2001/XMLSchema" xmlns:sub=3D"http://schemas.microsoft.com/sharepoint/soap/=
2002/1/alerts/" xmlns:ec=3D"http://www.w3.org/2001/04/xmlenc#" xmlns:sp=3D"=
http://schemas.microsoft.com/sharepoint/" xmlns:sps=3D"http://schemas.micro=
soft.com/sharepoint/soap/" xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-in=
stance" xmlns:udcs=3D"http://schemas.microsoft.com/data/udc/soap" xmlns:udc=
xf=3D"http://schemas.microsoft.com/data/udc/xmlfile" xmlns:udcp2p=3D"http:/=
/schemas.microsoft.com/data/udc/parttopart" xmlns:st=3D"&#1;" xmlns:st1=3D"=
urn:schemas-microsoft-com:office:smarttags" xmlns=3D"http://www.w3.org/TR/R=
EC-html40"
xmlns:ns1=3D"http://schemas.microsoft.com/sharepoint/soap/workflow/"
xmlns:ns2=3D"http://schemas.microsoft.com/office/2006/digsig-setup"
xmlns:ns3=3D"http://schemas.microsoft.com/office/2006/digsig"
xmlns:ns4=3D"http://schemas.openxmlformats.org/package/2006/digital-signatu=
re"
xmlns:ns5=3D"http://schemas.openxmlformats.org/markup-compatibility/2006"
xmlns:ns6=3D"http://schemas.microsoft.com/office/2004/12/omml"
xmlns:ns7=3D"http://schemas.openxmlformats.org/package/2006/relationships"
xmlns:ns8=3D"http://microsoft.com/sharepoint/webpartpages"
xmlns:ns9=3D"http://schemas.microsoft.com/exchange/services/2006/types"
xmlns:ns10=3D"http://schemas.microsoft.com/exchange/services/2006/messages"=

xmlns:ns11=3D"http://schemas.microsoft.com/sharepoint/soap/SlideLibrary/"
xmlns:ns12=3D"http://microsoft.com/webservices/SharePointPortalServer/Publi=
shedLinksService"
xmlns:ns13=3D"urn:schemas-microsoft-com:">

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
<![endif]--><o:SmartTagType
 namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags" name=3D"Person=
Name"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--a:link
	{mso-style-priority:99;}
span.MSOHYPERLINK
	{mso-style-priority:99;}
a:visited
	{mso-style-priority:99;}
span.MSOHYPERLINKFOLLOWED
	{mso-style-priority:99;}

 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
	{mso-style-type:personal;
	font-family:Arial;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:Calibri;
	color:#1F497D;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Josh, any thoughts on putting this int=
o
head_44x.S?<o:p></o:p></span></font></p>

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
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'>
linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org] <b><span
style=3D'font-weight:bold'>On Behalf Of </span></b>Tirumala Reddy Marri<br>=

<b><span style=3D'font-weight:bold'>Sent:</span></b> Wednesday, April 15, 2=
009
10:24 AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> <st1:PersonName w:st=3D"=
on">John
 Linn</st1:PersonName>; jwboyer@linux.vnet.ibm.com; grant.likely@secretlab.=
ca;
linuxppc-dev@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> RE: Question about =
DBCR0
initialization for 440</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3D"#1f497d" face=3DCalibri><span
style=3D'font-size:11.0pt;font-family:Calibri;color:#1F497D'>Some debuggers=
 like
BDI(Abatron) they setup the debug registers. If you have different debugger=

which doesn&#8217;t support configuring debug registers I suggest you to
program then in the head_44x.S file.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3D"#1f497d" face=3DCalibri><span
style=3D'font-size:11.0pt;font-family:Calibri;color:#1F497D'><o:p>&nbsp;</o=
:p></span></font></p>

<div>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in'>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span style=3D'font-si=
ze:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'>
linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org
[mailto:linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org] <b><span
style=3D'font-weight:bold'>On Behalf Of </span></b><st1:PersonName w:st=3D"=
on">John
 Linn</st1:PersonName><br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Tuesday, April 14, 200=
9 1:33
PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> jwboyer@linux.vnet.ibm.c=
om;
grant.likely@secretlab.ca; linuxppc-dev@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Question about DBCR=
0
initialization for 440<o:p></o:p></span></font></p>

</div>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>The kernel does not initialize the PPC440 DBCR0 register=
.
This prevents (among other things) the use of software breakpoints with
GDB.&nbsp; I realize that boot loaders probably do initialize this but we r=
un a
lot without a boot loader and so do our customers.<o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>The file, head_fsl_booke.S, does initialize the register=
 for
the freescale specific code (as shown at the end of the message).<o:p></o:p=
></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>We are needing this also for Xilinx.&nbsp; What&#8217;s =
the
best method to incorporate this, is it possible to add to head_44x.S?<o:p><=
/o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>John<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>#if !defined(CONFIG_BDI_SWITCH)<o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;
/*<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;
&nbsp;* The Abatron BDI JTAG debugger does not tolerate others<o:p></o:p></=
span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;
&nbsp;* mucking with the debug registers.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;
&nbsp;*/<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;
lis&nbsp;&nbsp;&nbsp;&nbsp; r2,DBCR0_IDM@h<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;
mtspr&nbsp;&nbsp; SPRN_DBCR0,r2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;
isync<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;
/* clear any residual debug events */<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;
li&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r2,-1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;
mtspr&nbsp;&nbsp; SPRN_DBSR,r2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>#endif<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><br clear=3Dall>
This email and any attachments are intended for the sole use of the named
recipient(s) and contain(s) confidential information that may be proprietar=
y,
privileged or copyrighted under applicable law. If you are not the intended=

recipient, do not read, copy, or forward this email message or any attachme=
nts.
Delete this email message and any attachments immediately. <o:p></o:p></spa=
n></font></p>

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


------_=_NextPart_001_01C9BF73.A1F60AA8--
