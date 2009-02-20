Return-Path: <DusharaJ@optiscan.com>
Received: from mail.optiscan.com (mail.optiscan.com [203.26.112.1])
	by ozlabs.org (Postfix) with ESMTP id 8FE40DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 18:18:09 +1100 (EST)
From: Dushara Jayasinghe <DusharaJ@optiscan.com>
To: 'Michael Bergandi' <mbergandi@gmail.com>
Date: Fri, 20 Feb 2009 18:18:07 +1100
Subject: RE: Newby trying to get Ethernet going on MPC83xx series device.
Message-ID: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40550@mailsvr>
References: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40549@mailsvr>
	<3A45394FD742FA419B760BB8D398F9ED246F06@zch01exm26.fsl.freescale.net>
	<FD3D453EC8A8D5479E7E063D31E2FA44268653@zin33exm24.fsl.freescale.net>
	<DE0CCFFBFF707949BEABD4537A14ACBA0C04B4054B@mailsvr>
	<2a27d3730902182319i2c59d68dk98e7975714f80549@mail.gmail.com>
	<FD3D453EC8A8D5479E7E063D31E2FA4426866A@zin33exm24.fsl.freescale.net>
	<DE0CCFFBFF707949BEABD4537A14ACBA0C04B4054D@mailsvr>
	<1c641bc80902192100w2c46a447ued43a6b98b877676@mail.gmail.com>
In-Reply-To: <1c641bc80902192100w2c46a447ued43a6b98b877676@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="_000_DE0CCFFBFF707949BEABD4537A14ACBA0C04B40550mailsvr_"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Aggrwal Poonam-B10812 <Poonam.Aggrwal@freescale.com>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--_000_DE0CCFFBFF707949BEABD4537A14ACBA0C04B40550mailsvr_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sorry, I'm a late comer here, but I might have an idea.  First off, I don't=
 see below what
kernel version you are using? I may have missed it somewhere.
[dj]
Sorry I should have mentioned that earlier. I'm using 2.6.29-rc5 (pulled co=
uple of days ago)

Hmm, well, the first thing I catch is this is an old dts format. Depending =
on your kernel version, you
may want to comply with the  dts v1 spec. The v1 spec is much more strict o=
n the format of the values
that are provided for the properties.
[dj]
I've fixed that since. Thanks.

                       phy0: ethernet-phy@0 {
                               interrupt-parent =3D <&ipic>;
                               interrupts =3D <3 8>;
                               reg =3D <0>;
                               device_type =3D "ethernet-phy";
                       };
                       phy1: ethernet-phy@1 {
                               interrupt-parent =3D <&ipic>;
                               interrupts =3D <3 8>;
                               reg =3D <1>;
                               device_type =3D "ethernet-phy";
                       };
               };

Are you sure both PHY's use interrupt 3? I would think not.
[dj]
I need to follow that through and see.

 Also is top posting ok? I haven't figured out how to enable '>' on bloody =
Microsoft Outlook, for incoming plain text messages.

I'm a little new to this list, but in general top posting is frowned upon. =
Unfortunately, I can't help you with the Outlook problem.
I can tell you that not being able to determine what part of a message came=
 when is extremely annoying. I hope you find a fix
for it. Or, you could try Thunderbird :)
[dj]
I'm using the HTML format. I've tagged my comments just in case the context=
 is lost.
Consequently, I found, some further insights into the issue. Here's a debug=
 output.
[    7.124188] {
[    7.143107] bus_id=3Dmdio@24520:00                                 < - -=
 printed in drivers/net/phy/phy_device.c : phy_connect()
[    7.181907] match check mdio@24520:1f                       < - - printe=
d in drivers/base/bus.c : match_name()
[    7.225946] mdio@24520:00 not found
[    7.267883] }
Where does the :1f or :00 get added?
Thanks
D


--_000_DE0CCFFBFF707949BEABD4537A14ACBA0C04B40550mailsvr_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:m=3D"http://schema=
s.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html=
40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
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

<body lang=3DEN-AU link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'>Sorry, I'm a late comer=
 here,
but I might have an idea.&nbsp; First off, I don't see below what <br>
kernel version you are using? I may have missed it somewhere.<o:p></o:p></p=
>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span style=3D'font-siz=
e:11.0pt;
font-family:"Calibri","sans-serif";color:#1F497D'>[dj]<o:p></o:p></span></p=
>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span style=3D'font-siz=
e:11.0pt;
font-family:"Calibri","sans-serif";color:#1F497D'>Sorry I should have menti=
oned
that earlier. I&#8217;m using 2.6.29-rc5 (pulled couple of days ago)<o:p></=
o:p></span></p>

<div>

<div>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><br>
Hmm, well, the first thing I catch is this is an old dts format. Depending =
on
your kernel version, you <br>
may want to comply with the&nbsp; dts v1 spec. The v1 spec is much more str=
ict
on the format of the values<br>
that are provided for the properties. <span style=3D'color:#1F497D'><o:p></=
o:p></span></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span style=3D'font-siz=
e:11.0pt;
font-family:"Calibri","sans-serif";color:#1F497D'>[dj]<o:p></o:p></span></p=
>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span style=3D'font-siz=
e:11.0pt;
font-family:"Calibri","sans-serif";color:#1F497D'>I&#8217;ve fixed that sin=
ce.
Thanks.<o:p></o:p></span></p>

</div>

<blockquote style=3D'border:none;border-left:solid #CCCCCC 1.0pt;padding:0c=
m 0cm 0cm 6.0pt;
margin-left:4.8pt;margin-right:0cm'>

<p class=3DMsoNormal><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;
&nbsp;phy0: ethernet-phy@0 {<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;interrupt-parent =3D &lt;&amp;ipic&gt;;<b=
r>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;interrupts =3D &lt;3 8&gt;;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg =3D &lt;0&gt;;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;device_type =3D &quot;ethernet-phy&quot;;=
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;
&nbsp;};<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;
&nbsp;phy1: ethernet-phy@1 {<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;interrupt-parent =3D &lt;&amp;ipic&gt;;<b=
r>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;interrupts =3D &lt;3 8&gt;;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg =3D &lt;1&gt;;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;device_type =3D &quot;ethernet-phy&quot;;=
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;
&nbsp;};<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;};<o:p></o:p></p>

</blockquote>

<div>

<p class=3DMsoNormal>&nbsp;<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'>Are you sure both PHY's=
 use
interrupt 3? I would think not.<span style=3D'color:#1F497D'><o:p></o:p></s=
pan></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span style=3D'font-siz=
e:11.0pt;
font-family:"Calibri","sans-serif";color:#1F497D'>[dj]<o:p></o:p></span></p=
>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span style=3D'font-siz=
e:11.0pt;
font-family:"Calibri","sans-serif";color:#1F497D'>I need to follow that thr=
ough
and see. <o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span style=3D'font-siz=
e:11.0pt;
font-family:"Calibri","sans-serif";color:#1F497D'><o:p>&nbsp;</o:p></span><=
/p>

</div>

<blockquote style=3D'border:none;border-left:solid #CCCCCC 1.0pt;padding:0c=
m 0cm 0cm 6.0pt;
margin-left:4.8pt;margin-right:0cm'>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'>&nbsp;Also is top posti=
ng ok? I
haven't figured out how to enable '&gt;' on bloody Microsoft Outlook, for i=
ncoming
plain text messages.<o:p></o:p></p>

</blockquote>

<div>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><br>
I'm a little new to this list, but in general top posting is frowned upon.
Unfortunately, I can't help you with the Outlook problem. <br>
I can tell you that not being able to determine what part of a message came
when is extremely annoying. I hope you find a fix<br>
for it. Or, you could try Thunderbird :)<o:p></o:p></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span style=3D'font-siz=
e:11.0pt;
font-family:"Calibri","sans-serif";color:#1F497D'>[dj]<o:p></o:p></span></p=
>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span style=3D'font-siz=
e:11.0pt;
font-family:"Calibri","sans-serif";color:#1F497D'>I&#8217;m using the HTML
format. I&#8217;ve tagged my comments just in case the context is lost.<o:p=
></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span style=3D'font-siz=
e:11.0pt;
font-family:"Calibri","sans-serif";color:#1F497D'>Consequently, I found, so=
me
further insights into the issue. Here&#8217;s a debug output.<o:p></o:p></s=
pan></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span style=3D'font-siz=
e:11.0pt;
font-family:"Calibri","sans-serif";color:#1F497D'>[&nbsp;&nbsp;&nbsp; 7.124=
188]
{<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span style=3D'font-siz=
e:11.0pt;
font-family:"Calibri","sans-serif";color:#1F497D'>[&nbsp;&nbsp;&nbsp; 7.143=
107]
bus_id=3Dmdio@24520:00 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;
- - printed in drivers/net/phy/phy_device.c : phy_connect()<o:p></o:p></spa=
n></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span style=3D'font-siz=
e:11.0pt;
font-family:"Calibri","sans-serif";color:#1F497D'>[&nbsp;&nbsp;&nbsp; 7.181=
907]
match check mdio@24520:1f&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;
&lt; - - printed in drivers/base/bus.c : match_name()<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span style=3D'font-siz=
e:11.0pt;
font-family:"Calibri","sans-serif";color:#1F497D'>[&nbsp;&nbsp;&nbsp; 7.225=
946]
mdio@24520:00 not found<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span style=3D'font-siz=
e:11.0pt;
font-family:"Calibri","sans-serif";color:#1F497D'>[&nbsp;&nbsp;&nbsp; 7.267=
883]
}<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span style=3D'font-siz=
e:11.0pt;
font-family:"Calibri","sans-serif";color:#1F497D'>Where does the :1f or :00=
 get
added?<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span style=3D'font-siz=
e:11.0pt;
font-family:"Calibri","sans-serif";color:#1F497D'>Thanks<o:p></o:p></span><=
/p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span style=3D'font-siz=
e:11.0pt;
font-family:"Calibri","sans-serif";color:#1F497D'>D<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span style=3D'font-siz=
e:11.0pt;
font-family:"Calibri","sans-serif";color:#1F497D'><o:p>&nbsp;</o:p></span><=
/p>

</div>

</div>

</div>

</body>

</html>

--_000_DE0CCFFBFF707949BEABD4537A14ACBA0C04B40550mailsvr_--
