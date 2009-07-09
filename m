Return-Path: <Matteo.Canella@mta.it>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5F54FB7086
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jul 2009 20:13:11 +1000 (EST)
Received: from cluster-a.mailcontrol.com (cluster-a.mailcontrol.com
	[85.115.52.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.mailcontrol.com",
	Issuer "DigiCert Global CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 20347DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2009 20:13:09 +1000 (EST)
Received: from mailserver.mta.int (mail.mta.it [89.96.171.250])
	by rly21a.srv.mailcontrol.com (MailControl) with ESMTP id
	n699UL70021368
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Jul 2009 10:30:21 +0100
From: Canella Matteo <Matteo.Canella@mta.it>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Date: Thu, 9 Jul 2009 11:30:10 +0200
Subject: SPI driver on mpc5121
Message-ID: <BD9F3F3F5A6CCF4BA032B9FED4DD312E5D09531C5C@mta-digimail.MTA.INT>
Content-Type: multipart/alternative;
	boundary="_000_BD9F3F3F5A6CCF4BA032B9FED4DD312E5D09531C5CmtadigimailMT_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_BD9F3F3F5A6CCF4BA032B9FED4DD312E5D09531C5CmtadigimailMT_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
I'm on a mpc5121 platform, kernel 2.6.24.6, and I'm using the mpc512x_psc_s=
pi driver to communicate  with a touch screen controller.
I'm sending commands and reading data from the controller using 24-bit pack=
et (3 bytes).
The speed of the SPI is set to 640 KHz.
I thought that I would need 8/640K =3D 12,5 us each byte I send, but this i=
s not true.
I'm verifying the time needed by mpc512x_psc_spi_transfer_rxtx function in =
order to send one byte toggling a digital output when it sets the TX/RX fla=
gs (after it copies data in the transmission buffer) and toggling the outpu=
t again when the empty buffer interrupt is triggered.
I see that the actual 12,5us data transfer is preceded by a 20us delay and =
followed by another 15,6us delay. So the transfer is done in almost 50 us.

Is this a normal behavior? Does the PSC controller need this overhead in th=
e transfer time?
DSCKI and DTL delays are set to zero.

Another doubt I have:

In mpc512x_psc_spi_transfer_rxtx, Mode Register 2 of the PSC is set to zero=
. This is done (as manual says) by access to MR1 (by a read) and then write=
 a zero on the same address.:

in_8(&psc->mode);
mdelay(1);
out_8(&psc->mode, 0x0);
mdelay(1);

I don't understand why a 1ms delay is needed. The manual doesn't say anythi=
ng about this.
I tried to comment out these delays and anyway it seems to work correctly.

Best regards,
Matteo Canella



--_000_BD9F3F3F5A6CCF4BA032B9FED4DD312E5D09531C5CmtadigimailMT_
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
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
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
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:70.85pt 2.0cm 2.0cm 2.0cm;}
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

<body lang=3DIT link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span lang=3DEN-US>Hi,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>I&#8217;m on a mpc5121 platform, ke=
rnel
2.6.24.6, and I&#8217;m using the mpc512x_psc_spi driver to communicate &nb=
sp;with
a touch screen controller.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>I&#8217;m sending commands and read=
ing data
from the controller using 24-bit packet (3 bytes).<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>The speed of the SPI is set to 640 =
KHz.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>I thought that I would need 8/640K =
=3D 12,5
us each byte I send, but this is not true.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>I&#8217;m verifying the time needed=
 by mpc512x_psc_spi_transfer_rxtx
function in order to send one byte toggling a digital output when it sets t=
he
TX/RX flags (after it copies data in the transmission buffer) and toggling =
the
output again when the empty buffer interrupt is triggered.<o:p></o:p></span=
></p>

<p class=3DMsoNormal><span lang=3DEN-US>I see that the actual 12,5us data t=
ransfer
is preceded by a 20us delay and followed by another 15,6us delay. So the
transfer is done in almost 50 us.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Is this a normal behavior? Does the=
 PSC
controller need this overhead in the transfer time?<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>DSCKI and DTL delays are set to zer=
o.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Another doubt I have:<o:p></o:p></s=
pan></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>In mpc512x_psc_spi_transfer_rxtx, M=
ode Register
2 of the PSC is set to zero. This is done (as manual says) by access to MR1=
 (by
a read) and then write a zero on the same address.:<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>in_8(&amp;psc-&gt;mode);<o:p></o:p>=
</span></p>

<p class=3DMsoNormal><span lang=3DEN-US>mdelay(1);<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>out_8(&amp;psc-&gt;mode, 0x0);<o:p>=
</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>mdelay(1);<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>I don&#8217;t understand why a 1ms =
delay is
needed. The manual doesn&#8217;t say anything about this.<o:p></o:p></span>=
</p>

<p class=3DMsoNormal><span lang=3DEN-US>I tried to comment out these delays=
 and anyway
it seems to work correctly.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Best regards,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Matteo Canella<o:p></o:p></span></p=
>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

--_000_BD9F3F3F5A6CCF4BA032B9FED4DD312E5D09531C5CmtadigimailMT_--
