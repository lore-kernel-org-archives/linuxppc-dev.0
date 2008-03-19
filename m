Return-Path: <rob.schalken@core-vision.nl>
Received: from mail140.messagelabs.com (mail140.messagelabs.com
	[85.158.137.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail140.messagelabs.com",
	Issuer "MessageLabs" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8E8E5DDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Mar 2008 01:03:10 +1100 (EST)
Received: from arcobel.nl (adcsvr [172.16.100.34])
	by mailsvr.arcobel.nl (8.13.1/8.13.1/20060317.1) with ESMTP id
	m2JE2uvm009131
	for <linuxppc-embedded@ozlabs.org>; Wed, 19 Mar 2008 15:03:01 +0100
Subject: Uart(lite)/ELDK 4.1 section mismatch -> ML403
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C889C9.EE3668E4"
Date: Wed, 19 Mar 2008 15:01:54 +0100
Message-ID: <2516330804619D4EA81F9AC9ACE9D874341E39@ADCSVR.adc.arcobel.nl>
From: "Rob Schalken" <rob.schalken@core-vision.nl>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C889C9.EE3668E4
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I=20want=20to=20Port=20the=20Linux=202.6.24.3=20to=20the=20ML403=20board.=20=
=20I=20tried=20some
different=20configurations:

=20

**UartLite

After=20changing=20some=20defines=20and=20creating=20some=20symbolic=20lin=
k,=20the=20simple
boot=20loader=20seems=20to

Work.=20My=20kernel=20also=20starts=20because=20when=20I=20read=20the=20me=
mory=20(using=20XMD),
I=20could=20read=20the=20_log_buf=20and

Some=20information=20was=20put=20in.=20I=20used=20the=20kernel=20command=20=
line:
console=3DttyUL0=20ip=3Doff=20root=3D/dev/ram=20rw.=20=20

But=20I=20did=20not=20get=20any=20kernel=20message=20on=20my=20serial=20co=
nsole!=20When=20I
enabled=20the=20early=20boot=20text=20over

Serial=20port,=20the=20compiler=20gives=20some=20errors=20(gen550_init,=20=
RS_TABLE_SIZE,
etc.)!

=20

**16550=20Uart

After=20my=20disaster=20with=20the=20Uartlite,=20I=20started=20to=20use=20=
the=2016550=20uart.
But=20I=20immediately=20get=20the=20following

Error:

arch/ppc/boot/common/ns16550.c:22:=20error:=20'RS_TABLE_SIZE'=20undeclared=

here=20(not=20in=20a=20function)

arch/ppc/boot/common/ns16550.c:24:=20error:=20'SERIAL_PORT_DFNS'=20undecla=
red
here=20(not=20in=20a=20function)

make[2]:=20***=20[arch/ppc/boot/common/ns16550.o]=20Error=201

make[1]:=20***=20[arch/ppc/boot/common]=20Error=202

make:=20***=20[zImage]=20Error=202

=20

I=20use=20ELDK=204.1=20toolchain,=20which=20result=20in=20the=20following=20=
section=20mismatch
(warning)

WARNING:=20vmlinux.o(.text+0x223c):=20Section=20mismatch:=20reference=20to=

.init.text:earl=20y_init=20(between=20'start_here'=20and=20'initial_mmu')

WARNING:=20vmlinux.o(.text+0x2254):=20Section=20mismatch:=20reference=20to=

.init.text:mach=20ine_init=20(between=20'start_here'=20and=20'initial_mmu'=
)

WARNING:=20vmlinux.o(.text+0x2258):=20Section=20mismatch:=20reference=20to=

.init.text:MMU_=20init=20(between=20'start_here'=20and=20'initial_mmu')

WARNING:=20vmlinux.o(.text+0x22b2):=20Section=20mismatch:=20reference=20to=

.init.text:star=20t_kernel=20(between=20'start_here'=20and=20'initial_mmu'=
)

WARNING:=20vmlinux.o(.text+0x22b6):=20Section=20mismatch:=20reference=20to=

.init.text:star=20t_kernel=20(between=20'start_here'=20and=20'initial_mmu'=
)

=20

By=20the=20way,=20the=20hardware=20is=20working,=20this=20has=20been=20tes=
ted!!

=20

Could=20someone=20help=20to=20get=20a=20uart=20work!=20I=20only=20want=20t=
o=20receive=20a=20message
from=20the=20kernel!!!!=20

=20

=20


______________________________________________________________________
This=20email=20has=20been=20scanned=20by=20the=20MessageLabs=20Email=20Sec=
urity=20System.
For=20more=20information=20please=20visit=20http://www.messagelabs.com/ema=
il=20
______________________________________________________________________
------_=_NextPart_001_01C889C9.EE3668E4
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html=20xmlns:v=3D"urn:schemas-microsoft-com:vml"=20xmlns:o=3D"urn:schemas=
-microsoft-com:office:office"=20xmlns:w=3D"urn:schemas-microsoft-com:offic=
e:word"=20xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml"=20x=
mlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta=20http-equiv=3DContent-Type=20content=3D"text/html;=20charset=3Dus-a=
scii">
<meta=20name=3DGenerator=20content=3D"Microsoft=20Word=2012=20(filtered=20=
medium)">
<style>
<!--
=20/*=20Font=20Definitions=20*/
=20@font-face
=09{font-family:Wingdings;
=09panose-1:5=200=200=200=200=200=200=200=200=200;}
@font-face
=09{font-family:Wingdings;
=09panose-1:5=200=200=200=200=200=200=200=200=200;}
@font-face
=09{font-family:Calibri;
=09panose-1:2=2015=205=202=202=202=204=203=202=204;}
@font-face
=09{font-family:Tahoma;
=09panose-1:2=2011=206=204=203=205=204=204=202=204;}
=20/*=20Style=20Definitions=20*/
=20p.MsoNormal,=20li.MsoNormal,=20div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri","sans-serif";}
a:link,=20span.MsoHyperlink
=09{mso-style-priority:99;
=09color:blue;
=09text-decoration:underline;}
a:visited,=20span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:purple;
=09text-decoration:underline;}
p.MsoAcetate,=20li.MsoAcetate,=20div.MsoAcetate
=09{mso-style-priority:99;
=09mso-style-link:"Balloon=20Text=20Char";
=09margin:0in;
=09margin-bottom:.0001pt;
=09font-size:8.0pt;
=09font-family:"Tahoma","sans-serif";}
p.MsoListParagraph,=20li.MsoListParagraph,=20div.MsoListParagraph
=09{mso-style-priority:34;
=09margin-top:0in;
=09margin-right:0in;
=09margin-bottom:0in;
=09margin-left:.5in;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri","sans-serif";}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:"Calibri","sans-serif";
=09color:windowtext;}
span.BalloonTextChar
=09{mso-style-name:"Balloon=20Text=20Char";
=09mso-style-priority:99;
=09mso-style-link:"Balloon=20Text";
=09font-family:"Tahoma","sans-serif";}
.MsoChpDefault
=09{mso-style-type:export-only;}
@page=20Section1
=09{size:8.5in=2011.0in;
=09margin:1.0in=201.0in=201.0in=201.0in;}
div.Section1
=09{page:Section1;}
=20/*=20List=20Definitions=20*/
=20@list=20l0
=09{mso-list-id:935599073;
=09mso-list-type:hybrid;
=09mso-list-template-ids:5172888=20438195346=2068354051=2068354053=2068354=
049=2068354051=2068354053=2068354049=2068354051=2068354053;}
@list=20l0:level1
=09{mso-level-start-at:0;
=09mso-level-number-format:bullet;
=09mso-level-text:\F0B7;
=09mso-level-tab-stop:none;
=09mso-level-number-position:left;
=09text-indent:-.25in;
=09font-family:Symbol;
=09mso-fareast-font-family:Calibri;
=09mso-bidi-font-family:"Times=20New=20Roman";}
ol
=09{margin-bottom:0in;}
ul
=09{margin-bottom:0in;}
-->
</style>
<!--[if=20gte=20mso=209]><xml>
=20<o:shapedefaults=20v:ext=3D"edit"=20spidmax=3D"1026"=20/>
</xml><![endif]--><!--[if=20gte=20mso=209]><xml>
=20<o:shapelayout=20v:ext=3D"edit">
=20=20<o:idmap=20v:ext=3D"edit"=20data=3D"1"=20/>
=20</o:shapelayout></xml><![endif]-->
</head>

<body=20lang=3DNL=20link=3Dblue=20vlink=3Dpurple>

<div=20class=3DSection1>

<p=20class=3DMsoNormal><span=20lang=3DEN-US>I=20want=20to=20Port=20the=20L=
inux=202.6.24.3=20to=20the
ML403=20board.=20&nbsp;I=20tried=20some=20different=20configurations:<o:p>=
</o:p></span></p>

<p=20class=3DMsoNormal><span=20lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p=20class=3DMsoNormal><span=20lang=3DEN-US>**UartLite<o:p></o:p></span></=
p>

<p=20class=3DMsoNormal><span=20lang=3DEN-US>After=20changing=20some=20defi=
nes=20and=20creating
some=20symbolic=20link,=20the=20simple=20boot=20loader=20seems=20to<o:p></=
o:p></span></p>

<p=20class=3DMsoNormal><span=20lang=3DEN-US>Work.=20My=20kernel=20also=20s=
tarts=20because=20when=20I=20read
the=20memory=20(using=20XMD),=20I=20could=20read=20the=20_<i>log</i>_buf=20=
and<o:p></o:p></span></p>

<p=20class=3DMsoNormal><span=20lang=3DEN-US>Some=20information=20was=20put=
=20in.=20I=20used=20the
kernel=20command=20line:=20console=3DttyUL0=20ip=3Doff=20root=3D/dev/ram=20=
rw.&nbsp;=20<o:p></o:p></span></p>

<p=20class=3DMsoNormal><span=20lang=3DEN-US>But=20I=20did=20not=20get=20an=
y=20kernel=20message=20on=20my
serial=20console!=20When=20I=20enabled=20the=20early=20boot=20text=20over<=
o:p></o:p></span></p>

<p=20class=3DMsoNormal><span=20lang=3DEN-US>Serial=20port,=20the=20compile=
r=20gives=20some=20errors
(gen550_init,=20RS_TABLE_SIZE,=20etc.)!<o:p></o:p></span></p>

<p=20class=3DMsoNormal><span=20lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p=20class=3DMsoNormal><span=20lang=3DEN-US>**16550=20Uart<o:p></o:p></spa=
n></p>

<p=20class=3DMsoNormal><span=20lang=3DEN-US>After=20my=20disaster=20with=20=
the=20Uartlite,=20I
started=20to=20use=20the=2016550=20uart.=20But=20I=20immediately=20get=20t=
he=20following<o:p></o:p></span></p>

<p=20class=3DMsoNormal><span=20lang=3DEN-US>Error:<o:p></o:p></span></p>

<p=20class=3DMsoNormal=20style=3D'text-indent:35.4pt'><span=20lang=3DEN-US=
>arch/ppc/boot/common/ns16550.c:22:
error:=20'RS_TABLE_SIZE'=20undeclared=20here=20(not=20in=20a=20function)<o=
:p></o:p></span></p>

<p=20class=3DMsoNormal=20style=3D'text-indent:35.4pt'><span=20lang=3DEN-US=
>arch/ppc/boot/common/ns16550.c:24:
error:=20'SERIAL_PORT_DFNS'=20undeclared=20here=20(not=20in=20a=20function=
)<o:p></o:p></span></p>

<p=20class=3DMsoNormal=20style=3D'text-indent:35.4pt'><span=20lang=3DEN-US=
>make[2]:=20***
[arch/ppc/boot/common/ns16550.o]=20Error=201<o:p></o:p></span></p>

<p=20class=3DMsoNormal=20style=3D'text-indent:35.4pt'><span=20lang=3DEN-US=
>make[1]:=20***
[arch/ppc/boot/common]=20Error=202<o:p></o:p></span></p>

<p=20class=3DMsoNormal=20style=3D'text-indent:35.4pt'><span=20lang=3DEN-US=
>make:=20***
[zImage]=20Error=202<o:p></o:p></span></p>

<p=20class=3DMsoNormal=20style=3D'text-indent:35.4pt'><span=20lang=3DEN-US=
><o:p>&nbsp;</o:p></span></p>

<p=20class=3DMsoNormal><span=20lang=3DEN-US>I=20use=20ELDK=204.1=20toolcha=
in,=20which=20result=20in
the=20following=20section=20mismatch=20(warning)<o:p></o:p></span></p>

<p=20class=3DMsoNormal=20style=3D'text-indent:35.4pt'><span=20lang=3DEN-US=
>WARNING:
vmlinux.o(.text+0x223c):=20Section=20mismatch:=20reference=20to=20.init.te=
xt:earl=20y_init
(between=20'start_here'=20and=20'initial_mmu')<o:p></o:p></span></p>

<p=20class=3DMsoNormal=20style=3D'text-indent:35.4pt'><span=20lang=3DEN-US=
>WARNING:
vmlinux.o(.text+0x2254):=20Section=20mismatch:=20reference=20to=20.init.te=
xt:mach
ine_init=20(between=20'start_here'=20and=20'initial_mmu')<o:p></o:p></span=
></p>

<p=20class=3DMsoNormal=20style=3D'text-indent:35.4pt'><span=20lang=3DEN-US=
>WARNING:
vmlinux.o(.text+0x2258):=20Section=20mismatch:=20reference=20to=20.init.te=
xt:MMU_=20init
(between=20'start_here'=20and=20'initial_mmu')<o:p></o:p></span></p>

<p=20class=3DMsoNormal=20style=3D'text-indent:35.4pt'><span=20lang=3DEN-US=
>WARNING:
vmlinux.o(.text+0x22b2):=20Section=20mismatch:=20reference=20to=20.init.te=
xt:star
t_kernel=20(between=20'start_here'=20and=20'initial_mmu')<o:p></o:p></span=
></p>

<p=20class=3DMsoNormal=20style=3D'text-indent:35.4pt'><span=20lang=3DEN-US=
>WARNING:
vmlinux.o(.text+0x22b6):=20Section=20mismatch:=20reference=20to=20.init.te=
xt:star
t_kernel=20(between=20'start_here'=20and=20'initial_mmu')<o:p></o:p></span=
></p>

<p=20class=3DMsoNormal><span=20lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p=20class=3DMsoNormal><span=20lang=3DEN-US>By=20the=20way,=20the=20hardwa=
re=20is=20working,=20this
has=20been=20tested!!<o:p></o:p></span></p>

<p=20class=3DMsoNormal><span=20lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p=20class=3DMsoNormal><span=20lang=3DEN-US>Could=20someone=20help=20to=20=
get=20a=20uart=20work!=20I
only=20want=20to=20receive=20a=20message=20from=20the=20kernel!!!!=20<o:p>=
</o:p></span></p>

<p=20class=3DMsoNormal><span=20lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p=20class=3DMsoNormal><span=20lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

</div>


<BR>
______________________________________________________________________<BR>=

This=20email=20has=20been=20scanned=20by=20the=20MessageLabs=20Email=20Sec=
urity=20System.<BR>
For=20more=20information=20please=20visit=20http://www.messagelabs.com/ema=
il=20<BR>
______________________________________________________________________<BR>=

</body>

</html>

------_=_NextPart_001_01C889C9.EE3668E4--
