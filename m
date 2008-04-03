Return-Path: <xiaochang.duan@xilinx.com>
Received: from outbound8-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 83D2FDE06A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Apr 2008 02:43:27 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C895A1.6005CB46"
Subject: RE: Xilinx LLTEMAC driver issues
Date: Thu, 3 Apr 2008 09:42:50 -0600
In-Reply-To: <BAY138-W45D7625ED50533D8D2680BB2F70@phx.gbl>
References: <20080329125416.B09261AD8051@mail119-sin.bigfish.com><000601c8931f$e1d549a0$a57fdce0$@se>
	<7e0dd21a0804020020s66a091ferfbbf4142adcd84ae@mail.gmail.com>
	<20080403003200.CB2BF1968046@mail103-sin.bigfish.com>
	<BAY138-W45D7625ED50533D8D2680BB2F70@phx.gbl>
From: "Xiaochang Duan" <xiaochang.duan@xilinx.com>
To: "MingLiu" <eemingliu@hotmail.com>, "John Bonesio" <jbonesio@xilinx.com>,
	"Johann Baudy" <johaahn@gmail.com>
Message-Id: <20080403154253.286DE5A004D@mail128-sin.bigfish.com>
Cc: John Linn <linnj@xilinx.com>, git <git@xilinx.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C895A1.6005CB46
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

According to C operator precedence =
((http://www.difranco.net/cop2220/op-prec.htm), the following patch =
should not be needed as operator =A1=B0<<=A1=B1 has higher precedence =
than operator =A1=B0|=A1=B1.

=20

-    XLlDma_mBdWrite((BdPtr), XLLDMA_BD_USR1_OFFSET, (Start) << 16 | =
(Insert))

+    XLlDma_mBdWrite((BdPtr), XLLDMA_BD_USR1_OFFSET, ((Start) << 16) |=20

+ (Insert))

=20

Also FYI, the XLlDma_mBdWrite currently is defined in xlldma driver as:

=20

#define XLlDma_mBdWrite(BaseAddress, Offset, Data)                \

            (*(u32*)((u32)(BaseAddress) + (u32)(Offset)) =3D (Data))

=20

So I don=A1=AFt understand why the patch could help.

=20

Thanks,=20

-Xiaochang

________________________________

From: MingLiu [mailto:eemingliu@hotmail.com]=20
Sent: Thursday, April 03, 2008 2:29 AM
To: John Bonesio; Johann Baudy
Cc: linuxppc-embedded@ozlabs.org; John Linn; git
Subject: RE: Xilinx LLTEMAC driver issues

=20

Dear all,

> The change with the extra parenthesis (in the patch starting with line =
133) seems unecessary. I looked at the XLlDma_mBdWrite macro and it =
appeared to have the correct use of parethesis in the implementation.
> So, assuming there's nothing subtle that I missed, it's not needed. =
However, it does no harm either.

However it really helps after I tried this patch. So there should be =
some difference after it is used.=20
=20
One more question, does this mean that the problem is not on the =
hardware timing, but the device driver?=20
=20
BR
Ming

________________________________

Windows Live =
Writer=A3=AC=D6=A7=B3=D6=C0=EB=CF=DF=D7=AB=D0=B4=B2=A9=BF=CD=C4=DA=C8=DD=A3=
=AC=CB=E6=CA=B1=CB=E6=B5=D8=CF=EB=D0=B4=BE=CD=D0=B4=A1=A3 =
=C1=A2=BC=B4=CA=B9=D3=C3=A3=A1 <http://get.live.cn/product/writer.html>=20


------_=_NextPart_001_01C895A1.6005CB46
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dgb2312">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><o:SmartTagType
 namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags" =
name=3D"PersonName"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:SimSun;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:blue;
	text-decoration:underline;}
p
	{mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:SimSun;}
span.EmailStyle18
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

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>According to C operator precedence =
((<a
href=3D"http://www.difranco.net/cop2220/op-prec.htm">http://www.difranco.=
net/cop2220/op-prec.htm</a>),
the following patch should not be needed as operator =
=A1=B0&lt;&lt;=A1=B1 has higher
precedence than operator =A1=B0|=A1=B1.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:.5in;text-autospace:none'><font size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>-&nbsp;&nbsp;&nbsp;
XLlDma_mBdWrite((BdPtr), XLLDMA_BD_USR1_OFFSET, (Start) &lt;&lt; 16 | =
(Insert))<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:.5in;text-autospace:none'><font size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;
XLlDma_mBdWrite((BdPtr), XLLDMA_BD_USR1_OFFSET, ((Start) &lt;&lt; 16) | =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:.5in;text-autospace:none'><font size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>+
(Insert))<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Also FYI, the XLlDma_mBdWrite =
currently is
defined in xlldma driver as:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:.5in;text-autospace:none'><font size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>#define
XLlDma_mBdWrite(BaseAddress, Offset, =
Data)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; \<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*(u32*)((u32)(BaseAddress)
+ (u32)(Offset)) =3D (Data))</span></font><font size=3D2 color=3Dnavy =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'><o:p></o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>So I don=A1=AFt understand why the =
patch could
help.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Thanks, =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>-Xiaochang<o:p></o:p></span></font><=
/p>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3DSimSun><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> =
MingLiu
[mailto:eemingliu@hotmail.com] <br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Thursday, April 03, =
2008
2:29 AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> John Bonesio; Johann =
Baudy<br>
<b><span style=3D'font-weight:bold'>Cc:</span></b> =
linuxppc-embedded@ozlabs.org; <st1:PersonName
w:st=3D"on">John Linn</st1:PersonName>; git<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> RE: Xilinx =
LLTEMAC driver
issues</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D1 =
face=3DTahoma><span
style=3D'font-size:9.0pt;font-family:Tahoma'>Dear all,<br>
<br>
&gt; The change with the extra parenthesis (in the patch starting with =
line
133) seems unecessary. I looked at the XLlDma_mBdWrite macro and it =
appeared to
have the correct use of parethesis in the implementation.<br>
&gt; So, assuming there's nothing subtle that I missed, it's not needed.
However, it does no harm either.<br>
<br>
However it really helps after I tried this patch. So there should be =
some
difference after it is used. <br>
&nbsp;<br>
One more question, does this mean that the problem is not on the =
hardware
timing, but the device driver? <br>
&nbsp;<br>
BR<br>
Ming<o:p></o:p></span></font></p>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D1
face=3DTahoma><span style=3D'font-size:9.0pt;font-family:Tahoma'>

<hr size=3D2 width=3D"100%" align=3Dcenter>

</span></font></div>

<p class=3DMsoNormal><font size=3D1 face=3DTahoma><span =
style=3D'font-size:9.0pt;
font-family:Tahoma'>Windows Live Writer</span></font><font =
size=3D1><span
lang=3DZH-CN =
style=3D'font-size:9.0pt'>=A3=AC=D6=A7=B3=D6=C0=EB=CF=DF=D7=AB=D0=B4=B2=A9=
=BF=CD=C4=DA=C8=DD=A3=AC=CB=E6=CA=B1=CB=E6=B5=D8=CF=EB=D0=B4=BE=CD=D0=B4=A1=
=A3</span></font><font
size=3D1 face=3DTahoma><span lang=3DZH-CN =
style=3D'font-size:9.0pt;font-family:Tahoma'>
</span></font><font size=3D1 face=3DTahoma><span =
style=3D'font-size:9.0pt;font-family:
Tahoma'><a href=3D"http://get.live.cn/product/writer.html" =
target=3D"_new"><font
face=3DSimSun><span lang=3DZH-CN =
style=3D'font-family:SimSun'>=C1=A2=BC=B4=CA=B9=D3=C3=A3=A1</span></font>=
</a><o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C895A1.6005CB46--
