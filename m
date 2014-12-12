Return-Path: <Amit.Tomar@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0130.outbound.protection.outlook.com [65.55.169.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8CB431A0326
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 19:24:07 +1100 (AEDT)
From: Amit Tomar <Amit.Tomar@freescale.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: [Patch] :Fix ISR return value in i2c-mpc.c 
Date: Fri, 12 Dec 2014 08:08:17 +0000
Message-ID: <BL2PR03MB4495ADAE7D752F82B58B1D783600@BL2PR03MB449.namprd03.prod.outlook.com>
Content-Type: multipart/alternative;
 boundary="_000_BL2PR03MB4495ADAE7D752F82B58B1D783600BL2PR03MB449namprd_"
MIME-Version: 1.0
Cc: "agraf@suse.de" <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_BL2PR03MB4495ADAE7D752F82B58B1D783600BL2PR03MB449namprd_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

ISR should return IRQ_HANDLED only in case of handling something.


Signed-off-by: Amit Singh Tomar <amit.tomar@freescale.com>
---
drivers/i2c/busses/i2c-mpc.c |    3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 0edf630..7a3136f 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -95,8 +95,9 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)
        i2c->interrupt =3D readb(i2c->base + MPC_I2C_SR);
        writeb(0, i2c->base + MPC_I2C_SR);
        wake_up(&i2c->queue);
+     return IRQ_HANDLED;
    }
-   return IRQ_HANDLED;
+  return IRQ_NONE;
}

/* Sometimes 9th clock pulse isn't generated, and slave doesn't release
--
1.7.9.5


--_000_BL2PR03MB4495ADAE7D752F82B58B1D783600BL2PR03MB449namprd_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">ISR should return IRQ_HANDLED only in case of handli=
ng something.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Amit Singh Tomar &lt;amit.tomar@frees=
cale.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/i2c/busses/i2c-mpc.c |&nbsp;&nbsp;&nbsp; 3 &=
#43;&#43;-<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 2 insertions(&#43;), 1 deletion(-)<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/=
i2c/busses/i2c-mpc.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 0edf630..7a3136f 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/drivers/i2c/busses/i2c-mpc.c<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/drivers/i2c/busses/i2c-mpc.c<o:p><=
/o:p></p>
<p class=3D"MsoNormal">@@ -95,8 &#43;95,9 @@ static irqreturn_t mpc_i2c_isr=
(int irq, void *dev_id)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c-&gt;i=
nterrupt =3D readb(i2c-&gt;base &#43; MPC_I2C_SR);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; writeb(0,=
 i2c-&gt;base &#43; MPC_I2C_SR);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wake_up(&=
amp;i2c-&gt;queue);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp; &nbsp;&nbsp;return IRQ_HANDLED;<o:=
p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp; return IRQ_HANDLED;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; &nbsp;return IRQ_NONE;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">/* Sometimes 9th clock pulse isn't generated, and sl=
ave doesn't release<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">1.7.9.5<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BL2PR03MB4495ADAE7D752F82B58B1D783600BL2PR03MB449namprd_--
