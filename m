Return-Path: <Poonam.Aggrwal@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5683F2C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2014 19:07:35 +1100 (EST)
From: "Poonam.Aggrwal@freescale.com" <Poonam.Aggrwal@freescale.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: UART Fifo mode
Date: Tue, 4 Mar 2014 07:52:40 +0000
Message-ID: <c41dba60851342d78609649a76a5980c@BY2PR03MB363.namprd03.prod.outlook.com>
Content-Type: multipart/alternative;
 boundary="_000_c41dba60851342d78609649a76a5980cBY2PR03MB363namprd03pro_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_c41dba60851342d78609649a76a5980cBY2PR03MB363namprd03pro_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello All

I am debugging a UART issue on a Freescale PowerPC SOC.

My observations are:

When FiFo mode is enabled FCR[FEN]=3D1, and the Fifo size is 16byte. I see =
console prints not coming properly, lot of missing characters.

But here when I change the tx_loadsz to 8, the UART works fine.

        [PORT_16550A] =3D {
                .name           =3D "16550A",
                .fifo_size      =3D 16,
-               .tx_loadsz      =3D 16,
+               .tx_loadsz      =3D 8,
                .fcr            =3D UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_=
10,
                .flags          =3D UART_CAP_FIFO,
        },

Can anybody help to understand what is the significance of tx_loadsz. From =
the code (drivers/serial/tty/8250/8250.c), looks like this parameter contro=
ls the bytes we write to the UART Tx register at one  time.
So ideally this should be equal to the Fifo size.

I also see certain UARTs where tx_loadsz is not equal to fifo_size, less th=
an fifo_size.

Please help me to understand how should tx_loadsz be determined?

Many Thanks
Poonam

--_000_c41dba60851342d78609649a76a5980cBY2PR03MB363namprd03pro_
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
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1869485235;
	mso-list-type:hybrid;
	mso-list-template-ids:1638543822 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello All<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am debugging a UART issue on a Freescale PowerPC S=
OC.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">My observations are:<o:p></o:p></p>
<p class=3D"MsoListParagraph">When FiFo mode is enabled FCR[FEN]=3D1, and t=
he Fifo size is 16byte. I see console prints not coming properly, lot of mi=
ssing characters.<o:p></o:p></p>
<p class=3D"MsoListParagraph">But here when I change the tx_loadsz to 8, th=
e UART works fine.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [PORT_165=
50A] =3D {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D &quot;16550A&quot;,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fifo_size&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D 16,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .tx_loadsz&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 16,<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .tx_loadsz&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D 8,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fcr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D UART_FCR_ENABLE_FIFO | UART_FCR_R_TR=
IG_10,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flags&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; =3D UART_CAP_FIFO,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Can anybody help to understand what is the significa=
nce of tx_loadsz. From the code (drivers/serial/tty/8250/8250.c), looks lik=
e this parameter controls the bytes we write to the UART Tx register at one=
 &nbsp;time.<o:p></o:p></p>
<p class=3D"MsoNormal">So ideally this should be equal to the Fifo size.<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><i></i>I also see certain UARTs where tx_loadsz is n=
ot equal to fifo_size, less than fifo_size.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please help me to understand how should tx_loadsz be=
 determined?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Many Thanks<o:p></o:p></p>
<p class=3D"MsoNormal">Poonam <o:p></o:p></p>
</div>
</body>
</html>

--_000_c41dba60851342d78609649a76a5980cBY2PR03MB363namprd03pro_--
