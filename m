Return-Path: <B21989@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D7735B7187
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Nov 2010 19:23:39 +1100 (EST)
Received: from mail131-va3 (localhost.localdomain [127.0.0.1])	by
	mail131-va3-R.bigfish.com (Postfix) with ESMTP id BBA2DC3A3CB	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 17 Nov 2010 08:08:25 +0000 (UTC)
Received: from VA3EHSMHS015.bigfish.com (unknown [10.7.14.251])	by
	mail131-va3.bigfish.com (Postfix) with ESMTP id E3C6C13D0001	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 17 Nov 2010 08:08:24 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id oAH88MTl005198	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Nov 2010 01:08:22 -0700 (MST)
Received: from az33exm20.fsl.freescale.net (az33exm20.am.freescale.net
	[10.64.32.6])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	oAH88Mhl015572	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Nov 2010 02:08:22 -0600 (CST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB862E.BD230E80"
Subject: RE: [PATCH 4/4][v2] rapidio,
	powerpc/85xx: Error interrupt handler for sRIO.
Date: Wed, 17 Nov 2010 01:09:19 -0700
Message-ID: <267A3B246C22C34A8E574051858E07700108B5@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E552015397DD@CORPEXCH1.na.ads.idt.com>
References: <1288777048-25105-1-git-send-email-b21989@freescale.com>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552015397DD@CORPEXCH1.na.ads.idt.com>
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>,
	<akpm@linux-foundation.org>
Cc: Zang Roy-R61911 <r61911@freescale.com>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------_=_NextPart_001_01CB862E.BD230E80
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

=20

=20

=20

Best Regards,=20
Shaohui Xie=20

=20

From: Bounine, Alexandre [mailto:Alexandre.Bounine@idt.com]=20
Sent: Tuesday, November 16, 2010 10:01 PM
To: Xie Shaohui-B21989; akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Li
Yang-R58472; Gala Kumar-B11780; Zang Roy-R61911
Subject: RE: [PATCH 4/4][v2] rapidio, powerpc/85xx: Error interrupt
handler for sRIO.

=20

> From: Shaohui Xie [mailto:b21989@freescale.com]
>
> The sRIO controller reports errors to the core with one signal, it
uses
> register EPWISR to provides the core quick access to where the error
occurred.
> The EPWISR indicates that there are 4 interrupts sources, port1,
port2, message
> unit and port write receive, but the sRIO driver does not support
port2
> for now, still the handler takes care of port2.
> Currently the handler only clear error status without any recovery.
>

Do these dual-RIO controllers have only one port-write interrupt?
(sorry, user manuals are not available for download from FSL). =20

[Xie Shaohui] Yes, only one inbound port-write interrupt.



> @@ -1082,14 +1142,24 @@ fsl_rio_port_write_handler(int irq, void
*dev_instance)
>       ipwsr =3D in_be32(&priv->msg_regs->pwsr);
>
>       epwisr =3D in_be32(priv->regs_win + RIO_EPWISR);
> -     if (epwisr & 0x80000000) {
> +     if (epwisr & EPWISR_ERR_PINT1) {
>               tmp =3D in_be32(priv->regs_win + RIO_LTLEDCSR);
>               pr_info("RIO_LTLEDCSR =3D 0x%x\n", tmp);
> -             out_be32(priv->regs_win + RIO_LTLEDCSR, 0);
> +             port_error_handler(port, 0);
> +     }
> +
> +     if (epwisr & EPWISR_ERR_PINT2) {
> +             pr_info("RIO: port2 error\n");
> +             port_error_handler(port, 1);
> +     }
> +
> +     if (epwisr & EPWISR_ERR_MU) {
> +             pr_info("RIO: message unit error\n");
> +             msg_unit_error_handler(port);
>       }
>
> -     if (!(epwisr & 0x00000001))
> -             return IRQ_HANDLED;
> +     if (!(epwisr & EPWISR_ERR_PW))
> +             return IRQ_NONE;
>
>  #ifdef DEBUG_PW
>       pr_debug("PW Int->IPWMR: 0x%08x IPWSR: 0x%08x (", ipwmr, ipwsr);

This part is out of sync with mainline code tree (37-rc1). Probably it
should be updated to make it easier to apply your patch. Besides that,
works as expected on my RIO setup.




[Xie Shaohui] Ok, I'll updated my patch to latest kernel.

BTW: Something wrong with my outlook, seems it cannot prefix  each line
of original message to some specific emails, but not all, Sorry if this
cause you trouble to read my reply.=20


------_=_NextPart_001_01CB862E.BD230E80
Content-Type: text/html; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<title>RE: [PATCH 4/4][v2] rapidio, powerpc/85xx: Error interrupt =
handler for
sRIO.</title>
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
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

<div class=3DWordSection1>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<div>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";
color:blue'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";
color:blue'>Best Regards,</span><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'> <br>
</span><span style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";
color:blue'>Shaohui Xie</span><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'> <o:p></o:p></span></p>

</div>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<div style=3D'border:none;border-left:solid blue 1.5pt;padding:0in 0in =
0in 4.0pt'>

<div>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt =
0in 0in 0in'>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>From:</span>=
</b><span
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> Bounine, =
Alexandre
[mailto:Alexandre.Bounine@idt.com] <br>
<b>Sent:</b> Tuesday, November 16, 2010 10:01 PM<br>
<b>To:</b> Xie Shaohui-B21989; akpm@linux-foundation.org<br>
<b>Cc:</b> linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; =
Li
Yang-R58472; Gala Kumar-B11780; Zang Roy-R61911<br>
<b>Subject:</b> RE: [PATCH 4/4][v2] rapidio, powerpc/85xx: Error =
interrupt
handler for sRIO.<o:p></o:p></span></p>

</div>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p style=3D'margin-bottom:12.0pt'><span style=3D'font-size:10.0pt'>&gt; =
From:
Shaohui Xie [<a =
href=3D"mailto:b21989@freescale.com">mailto:b21989@freescale.com</a>]<br>=

&gt;<br>
&gt; The sRIO controller reports errors to the core with one signal, =
it<br>
uses<br>
&gt; register EPWISR to provides the core quick access to where the =
error<br>
occurred.<br>
&gt; The EPWISR indicates that there are 4 interrupts sources, =
port1,<br>
port2, message<br>
&gt; unit and port write receive, but the sRIO driver does not =
support<br>
port2<br>
&gt; for now, still the handler takes care of port2.<br>
&gt; Currently the handler only clear error status without any =
recovery.<br>
&gt;<br>
<br>
Do these dual-RIO controllers have only one port-write interrupt?<br>
(sorry, user manuals are not available for download from =
FSL).&nbsp;&nbsp;<span
style=3D'color:#1F497D'><o:p></o:p></span></span></p>

<p style=3D'margin-bottom:12.0pt'><b><i><span =
style=3D'font-size:11.0pt;font-family:
"Calibri","sans-serif";color:#1F497D'>[Xie Shaohui] Yes, only one =
inbound port-write
interrupt.<o:p></o:p></span></i></b></p>

<p style=3D'margin-bottom:12.0pt'><span style=3D'font-size:10.0pt'><br>
<br>
&gt; @@ -1082,14 +1142,24 @@ fsl_rio_port_write_handler(int irq, =
void<br>
*dev_instance)<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; ipwsr =3D =
in_be32(&amp;priv-&gt;msg_regs-&gt;pwsr);<br>
&gt;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; epwisr =3D in_be32(priv-&gt;regs_win =
+
RIO_EPWISR);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (epwisr &amp; 0x80000000) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (epwisr &amp; EPWISR_ERR_PINT1) {<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
tmp =3D in_be32(priv-&gt;regs_win + RIO_LTLEDCSR);<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
pr_info(&quot;RIO_LTLEDCSR =3D 0x%x\n&quot;, tmp);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
out_be32(priv-&gt;regs_win + RIO_LTLEDCSR, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
port_error_handler(port, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (epwisr &amp; EPWISR_ERR_PINT2) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
pr_info(&quot;RIO: port2 error\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
port_error_handler(port, 1);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (epwisr &amp; EPWISR_ERR_MU) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
pr_info(&quot;RIO: message unit error\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
msg_unit_error_handler(port);<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!(epwisr &amp; 0x00000001))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
return IRQ_HANDLED;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!(epwisr &amp; EPWISR_ERR_PW))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
return IRQ_NONE;<br>
&gt;<br>
&gt;&nbsp; #ifdef DEBUG_PW<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;PW Int-&gt;IPWMR: =
0x%08x
IPWSR: 0x%08x (&quot;, ipwmr, ipwsr);<br>
<br>
This part is out of sync with mainline code tree (37-rc1). Probably =
it<br>
should be updated to make it easier to apply your patch. Besides =
that,<br>
works as expected on my RIO setup.<br>
<br>
<br>
<o:p></o:p></span></p>

<p style=3D'margin-bottom:12.0pt'><b><i><span =
style=3D'font-size:11.0pt;font-family:
"Calibri","sans-serif";color:#1F497D'>[Xie Shaohui] Ok, I&#8217;ll =
updated my
patch to latest kernel.<o:p></o:p></span></i></b></p>

<p style=3D'margin-bottom:12.0pt'><b><i><span =
style=3D'font-size:11.0pt;font-family:
"Calibri","sans-serif";color:#1F497D'>BTW: Something wrong with my =
outlook,
seems it cannot prefix &nbsp;each line of original message to some =
specific emails,
but not all, Sorry if this cause you trouble to read my reply. =
</span></i></b><span
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'><o:p></o:p></span></p>

</div>

</div>

</body>

</html>

------_=_NextPart_001_01CB862E.BD230E80--
