Return-Path: <JayasriS@aaesys.com>
Received: from AAE-Exch.aaesys.com (mail.aaesys.com [67.131.247.41])
	by ozlabs.org (Postfix) with ESMTP id 972B2DDF46
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Sep 2008 06:30:41 +1000 (EST)
From: Jayasri Sangu <JayasriS@aaesys.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Mon, 8 Sep 2008 13:25:08 -0700
Subject: kernel_thread crash 2.6.26 kernel on MPC8248 board
Message-ID: <2DE723F44CAFD24A9B6BF606813F010C0945BE32@aae-exch>
Content-Type: multipart/alternative;
	boundary="_000_2DE723F44CAFD24A9B6BF606813F010C0945BE32aaeexch_"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_000_2DE723F44CAFD24A9B6BF606813F010C0945BE32aaeexch_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,



      Our kernel 2.6.26  on MPC8248 board  crashes as the cache reaches 12M=
B, giving the following Oops message.





Oops: kernel access of bad area, sig: 11 [#1]

NIP: c0013638 LR: c00138bc CTR: c00c0c08

REGS: c7ce1e40 TRAP: 0300   Not tainted  (2.6.26)

MSR: 00001032 <ME,IR,DR>  CR: 24004024  XER: 20000000

DAR: 4bffffa0, DSISR: 20000000

TASK =3D c7c7b800[14] 'rpciod/0' THREAD: c7ce0000

GPR00: c00138bc c7ce1ef0 c7c7b800 c0400508 00000003 00000001 00000000 c7ce1=
f48

GPR08: c7de704c 4bffffa0 4bffff94 c027accc 00ae8da1 dfef4fbb 07ffd000 00000=
001

GPR16: 007fff78 00800000 00000000 ffffffff 00000000 c0276dbc c0270000 c0276=
dbc

GPR24: c0270000 00000003 00000000 c7ce1f48 00000001 00009032 c0400508 c7de7=
044 NIP [c0013638] __wake_up_common+0x30/0xa4 LR [c00138bc] __wake_up+0x28/=
0x40 Call Trace:

[c7ce1ef0] [00001032] 0x1032 (unreliable) [c7ce1f20] [c00138bc] __wake_up+0=
x28/0x40 [c7ce1f40] [c002f9ec] __wake_up_bit+0x30/0x40 [c7ce1f60] [c01ea67c=
] __rpc_execute+0x214/0x29c [c7ce1f80] [c002be7c] run_workqueue+0xac/0x158 =
[c7ce1fa0] [c002c29c] worker_thread+0x50/0xb4 [c7ce1fd0] [c002f640] kthread=
+0x84/0x8c [c7ce1ff0] [c0005df8] kernel_thread+0x44/0x60 Instruction dump:

7c0802a6 9421ffd0 bf210014 7c7e1b78 7c992378 7cbc2b78 90010034 7cda3378 812=
30000 7cfb3b78 7f891800 3949fff4 <816a000c> 3bebfff4 419e0058 800a0008

Oops: kernel access of bad area, sig: 11 [#2]

NIP: c00781cc LR: c00782d4 CTR: 00000000

REGS: c7ce1c30 TRAP: 0300   Tainted: G      D    (2.6.26)

MSR: 00009032 <EE,ME,IR,DR>  CR: 24048084  XER: 20000000

DAR: 7fe6fb78, DSISR: 20000000

TASK =3D c7c7b800[14] 'rpciod/0' THREAD: c7ce0000

GPR00: 7fe6fb78 c7ce1ce0 c7c7b800 c7801180 c7ce1d38 c02572bd 00000000 00000=
001

GPR08: fffffffb 00008e24 c0400f20 c0290000 24048022 dfef4fbb 07ffd000 00000=
001

GPR16: 007fff78 00800000 00000000 c023b4d8 c02572bc c0250000 00200200 00000=
000

GPR24: c7ce1d44 00000002 000197dc c7ce1d38 c7801180 7fe6fb78 c7ce1d38 00000=
002 NIP [c00781cc] __d_lookup+0x84/0x154 LR [c00782d4] d_lookup+0x38/0x64 C=
all Trace:

[c7ce1ce0] [00000003] 0x3 (unreliable)

[c7ce1d10] [c00782d4] d_lookup+0x38/0x64 [c7ce1d30] [c009c970] proc_flush_t=
ask+0xa4/0x248 [c7ce1d90] [c001c614] release_task+0x44/0x360 [c7ce1dc0] [c0=
01cfa4] do_exit+0x4dc/0x634 [c7ce1e00] [c0004938] nonrecoverable_exception+=
0x0/0x4c [c7ce1e10] [c000f270] bad_page_fault+0x58/0x5c [c7ce1e30] [c000415=
c] handle_page_fault+0x7c/0x80 [c7ce1ef0] [00001032] 0x1032 [c7ce1f20] [c00=
138bc] __wake_up+0x28/0x40 [c7ce1f40] [c002f9ec] __wake_up_bit+0x30/0x40 [c=
7ce1f60] [c01ea67c] __rpc_execute+0x214/0x29c [c7ce1f80] [c002be7c] run_wor=
kqueue+0xac/0x158 [c7ce1fa0] [c002c29c] worker_thread+0x50/0xb4 [c7ce1fd0] =
[c002f640] kthread+0x84/0x8c [c7ce1ff0] [c0005df8] kernel_thread+0x44/0x60 =
Instruction dump:

3d60c029 7d295038 814ba0d0 5529103a 7c09502e 2f800000 7c1d0378 40be0014 480=
00080 2f9f0000 7ffdfb78 419e0074 <83fd0000> 2f9f0000 419e0008 7c00fa2c Fixi=
ng recursive fault but reboot is needed









Thanks

Jayasri Sangu




--_000_2DE723F44CAFD24A9B6BF606813F010C0945BE32aaeexch_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.5pt;
	font-family:Consolas;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:Consolas;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
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

<p class=3DMsoPlainText>Hi,<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Our kernel 2.6.26&nb=
sp; on MPC8248 board&nbsp; crashes as the
cache reaches 12MB, giving the following Oops message.<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>Oops: kernel access of bad area, sig: 11 [#1]<o:p><=
/o:p></p>

<p class=3DMsoPlainText>NIP: c0013638 LR: c00138bc CTR: c00c0c08<o:p></o:p>=
</p>

<p class=3DMsoPlainText>REGS: c7ce1e40 TRAP: 0300&nbsp;&nbsp; Not tainted&n=
bsp; (2.6.26)<o:p></o:p></p>

<p class=3DMsoPlainText>MSR: 00001032 &lt;ME,IR,DR&gt;&nbsp; CR: 24004024&n=
bsp; XER:
20000000<o:p></o:p></p>

<p class=3DMsoPlainText>DAR: 4bffffa0, DSISR: 20000000<o:p></o:p></p>

<p class=3DMsoPlainText>TASK =3D c7c7b800[14] 'rpciod/0' THREAD: c7ce0000<o=
:p></o:p></p>

<p class=3DMsoPlainText>GPR00: c00138bc c7ce1ef0 c7c7b800 c0400508 00000003
00000001 00000000 c7ce1f48<o:p></o:p></p>

<p class=3DMsoPlainText>GPR08: c7de704c 4bffffa0 4bffff94 c027accc 00ae8da1
dfef4fbb 07ffd000 00000001<o:p></o:p></p>

<p class=3DMsoPlainText>GPR16: 007fff78 00800000 00000000 ffffffff 00000000
c0276dbc c0270000 c0276dbc<o:p></o:p></p>

<p class=3DMsoPlainText>GPR24: c0270000 00000003 00000000 c7ce1f48 00000001
00009032 c0400508 c7de7044 NIP [c0013638] __wake_up_common+0x30/0xa4 LR
[c00138bc] __wake_up+0x28/0x40 Call Trace:<o:p></o:p></p>

<p class=3DMsoPlainText>[c7ce1ef0] [00001032] 0x1032 (unreliable) [c7ce1f20=
]
[c00138bc] __wake_up+0x28/0x40 [c7ce1f40] [c002f9ec] __wake_up_bit+0x30/0x4=
0
[c7ce1f60] [c01ea67c] __rpc_execute+0x214/0x29c [c7ce1f80] [c002be7c]
run_workqueue+0xac/0x158 [c7ce1fa0] [c002c29c] worker_thread+0x50/0xb4
[c7ce1fd0] [c002f640] kthread+0x84/0x8c [c7ce1ff0] [c0005df8]
kernel_thread+0x44/0x60 Instruction dump:<o:p></o:p></p>

<p class=3DMsoPlainText>7c0802a6 9421ffd0 bf210014 7c7e1b78 7c992378 7cbc2b=
78
90010034 7cda3378 81230000 7cfb3b78 7f891800 3949fff4 &lt;816a000c&gt; 3beb=
fff4
419e0058 800a0008<o:p></o:p></p>

<p class=3DMsoPlainText>Oops: kernel access of bad area, sig: 11 [#2]<o:p><=
/o:p></p>

<p class=3DMsoPlainText>NIP: c00781cc LR: c00782d4 CTR: 00000000<o:p></o:p>=
</p>

<p class=3DMsoPlainText>REGS: c7ce1c30 TRAP: 0300&nbsp;&nbsp; Tainted: G&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; (2.6.26)<o:p></o:p></p>

<p class=3DMsoPlainText>MSR: 00009032 &lt;EE,ME,IR,DR&gt;&nbsp; CR: 2404808=
4&nbsp; XER:
20000000<o:p></o:p></p>

<p class=3DMsoPlainText>DAR: 7fe6fb78, DSISR: 20000000<o:p></o:p></p>

<p class=3DMsoPlainText>TASK =3D c7c7b800[14] 'rpciod/0' THREAD: c7ce0000<o=
:p></o:p></p>

<p class=3DMsoPlainText>GPR00: 7fe6fb78 c7ce1ce0 c7c7b800 c7801180 c7ce1d38
c02572bd 00000000 00000001<o:p></o:p></p>

<p class=3DMsoPlainText>GPR08: fffffffb 00008e24 c0400f20 c0290000 24048022
dfef4fbb 07ffd000 00000001<o:p></o:p></p>

<p class=3DMsoPlainText>GPR16: 007fff78 00800000 00000000 c023b4d8 c02572bc
c0250000 00200200 00000000<o:p></o:p></p>

<p class=3DMsoPlainText>GPR24: c7ce1d44 00000002 000197dc c7ce1d38 c7801180
7fe6fb78 c7ce1d38 00000002 NIP [c00781cc] __d_lookup+0x84/0x154 LR [c00782d=
4]
d_lookup+0x38/0x64 Call Trace:<o:p></o:p></p>

<p class=3DMsoPlainText>[c7ce1ce0] [00000003] 0x3 (unreliable)<o:p></o:p></=
p>

<p class=3DMsoPlainText>[c7ce1d10] [c00782d4] d_lookup+0x38/0x64 [c7ce1d30]
[c009c970] proc_flush_task+0xa4/0x248 [c7ce1d90] [c001c614]
release_task+0x44/0x360 [c7ce1dc0] [c001cfa4] do_exit+0x4dc/0x634 [c7ce1e00=
]
[c0004938] nonrecoverable_exception+0x0/0x4c [c7ce1e10] [c000f270]
bad_page_fault+0x58/0x5c [c7ce1e30] [c000415c] handle_page_fault+0x7c/0x80
[c7ce1ef0] [00001032] 0x1032 [c7ce1f20] [c00138bc] __wake_up+0x28/0x40
[c7ce1f40] [c002f9ec] __wake_up_bit+0x30/0x40 [c7ce1f60] [c01ea67c]
__rpc_execute+0x214/0x29c [c7ce1f80] [c002be7c] run_workqueue+0xac/0x158
[c7ce1fa0] [c002c29c] worker_thread+0x50/0xb4 [c7ce1fd0] [c002f640]
kthread+0x84/0x8c [c7ce1ff0] [c0005df8] kernel_thread+0x44/0x60 Instruction
dump:<o:p></o:p></p>

<p class=3DMsoPlainText>3d60c029 7d295038 814ba0d0 5529103a 7c09502e 2f8000=
00
7c1d0378 40be0014 48000080 2f9f0000 7ffdfb78 419e0074 &lt;83fd0000&gt; 2f9f=
0000
419e0008 7c00fa2c Fixing recursive fault but reboot is needed<o:p></o:p></p=
>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>Thanks<o:p></o:p></p>

<p class=3DMsoPlainText>Jayasri Sangu<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

--_000_2DE723F44CAFD24A9B6BF606813F010C0945BE32aaeexch_--
