Return-Path: <John.Linn@xilinx.com>
Received: from VA3EHSOBE005.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id B5D88DDDFA
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 09:22:51 +1000 (EST)
Received: from mail187-va3 (localhost.localdomain [127.0.0.1])	by
	mail187-va3-R.bigfish.com (Postfix) with ESMTP id 5ED0ABD80E6	for
	<linuxppc-dev@ozlabs.org>; Mon, 16 Jun 2008 23:22:47 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])	by mail187-va3.bigfish.com
	(Postfix) with ESMTP id D2F81910046	for <linuxppc-dev@ozlabs.org>;
	Mon, 16 Jun 2008 23:22:42 +0000 (UTC)
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
	helo=xsj-smtp1.xilinx.com)	by xsj-gw1 with esmtp (Exim
	4.63)	(envelope-from
	<John.Linn@xilinx.com>)	id 1K8O26-0006xD-IO	for linuxppc-dev@ozlabs.org;
	Mon, 16 Jun 2008 16:22:42 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8D007.DF8C5EA1"
Subject: Problems with NFS root on arch/ppc after pulling 2.6.26-rc6, on PPC405
Date: Mon, 16 Jun 2008 17:22:39 -0600
From: John Linn <John.Linn@xilinx.com>
To: <linuxppc-dev@ozlabs.org>
Message-ID: <20080616232242.D2F81910046@mail187-va3.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------_=_NextPart_001_01C8D007.DF8C5EA1
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

I'm not seeing any issue with arch/powerpc. =


 =


But with arch/ppc I'm seeing problems with NFS root after I pulled in
2.6.26-rc6.  Has anyone else seen anything like this?

 =


It's consistent in that it typically happens on boot after freeing
unused kernel memory, but the actual task that running seems to vary.

 =


We were running on 2.6.25 without the issue.

 =


Thanks,

John

 =


   11.660218] Looking up port of RPC 100003/2 on 172.16.40.76

[   11.740956] Looking up port of RPC 100005/1 on 172.16.40.76

[   11.859230] VFS: Mounted root (nfs filesystem).

[   11.914236] Freeing unused kernel memory: 108k init

[   12.175480] Oops: kernel access of bad area, sig: 11 [#1]

[   12.240202] NIP: c01b74a8 LR: c01b7424 CTR: c0014664

[   12.299677] REGS: c34b9ec0 TRAP: 0300   Not tainted  (2.6.26-rc6)

[   12.372670] MSR: 00021030 <ME,IR,DR>  CR: 95000033  XER: c0000025

[   12.446306] DEAR: 0000002c, ESR: 00000000

[   12.494326] TASK =3D c3c580a0[178] 'rpciod/0' THREAD: c34b8000

[   12.560037] GPR00: 0000002c c34b9f70 c3c580a0 c3c450c0 c025d078
00000032 00000001 00000032

[   12.661061] GPR08: 10682916 00000037 0000058f c025d028 625a0000
ffffffff ffffffff ffffffff

[   12.762088] GPR16: ffffffff ffffffff ffffffff ffffffff ffffffff
ffffffff ffffffff ffffffff

[   12.863113] GPR24: ffffffff c0027b74 c34b8000 c3c581f4 c3c450c0
00000000 c3c580a0 00000000

[   12.966324] NIP [c01b74a8] schedule+0x1ec/0x348

[   13.020693] LR [c01b7424] schedule+0x168/0x348

[   13.074016] Call Trace:

[   13.103285] [c34b9f70] [c01b7424] schedule+0x168/0x348 (unreliable)

[   13.178688] [c34b9fa0] [c0027b74] worker_thread+0x7c/0xb8

[   13.243573] [c34b9fd0] [c002b264] kthread+0x50/0x8c

[   13.302209] [c34b9ff0] [c00048d8] kernel_thread+0x44/0x60

[   13.367090] Instruction dump:

[   13.402714] 7d290194 912b0028 914b002c 813b0000 39290001 913b0000
83bc00b4 83fe00b8

[   13.496342] 2f9d0000 40be0024 93fc00b8 381f002c <7d000028> 31080001
7c00022c 7d00012d

[   13.594651] ------------[ cut here ]------------

[   13.649976] kernel BUG at kernel/exit.c:1098!

[   13.702155] XXX: Exception

[   13.702170]   Signal: 5

[   13.702182]   Code:   30001

[   13.702195]   Addr:   0

[   13.826503] Oops: Exception in kernel mode, sig: 5 [#2]

[   13.889100] NIP: c0019b78 LR: c0019b78 CTR: c0014664

[   13.948580] REGS: c34b9d90 TRAP: 0700   Tainted: G      D
(2.6.26-rc6)

[   14.029904] MSR: 00029030 <EE,ME,IR,DR>  CR: 39005093  XER: e0000025

[   14.106772] TASK =3D c3c580a0[178] 'rpciod/0' THREAD: c34b8000

[   14.172485] GPR00: c0019b78 c34b9e40 c3c580a0 c3c450c0 c025d078
c025d078 00000001 00000002

[   14.273509] GPR08: 00000000 00000000 54fcebe2 00000000 1a8fe938
ffffffff ffffffff ffffffff

[   14.374534] GPR16: ffffffff ffffffff ffffffff ffffffff ffffffff
ffffffff ffffffff ffffffff

[   14.475560] GPR24: ffffffff c0027b74 00000001 c3c58098 c3c178a0
c3c58188 c3c580a0 00000020

[   14.578771] NIP [c0019b78] do_exit+0x5d8/0x5e0

[   14.632097] LR [c0019b78] do_exit+0x5d8/0x5e0

[   14.684379] Call Trace:

[   14.713649] [c34b9e40] [c0019b78] do_exit+0x5d8/0x5e0 (unreliable)

[   14.788011] [c34b9e80] [c00035bc] nonrecoverable_exception+0x0/0x4c

[   14.863310] [c34b9e90] [c0009a18] bad_page_fault+0x48/0x5c

[   14.929236] [c34b9eb0] [c0002d28] handle_page_fault+0x7c/0x80

[   14.998287] [c34b9f70] [c01b7424] schedule+0x168/0x348

[   15.060049] [c34b9fa0] [c0027b74] worker_thread+0x7c/0xb8

[   15.124934] [c34b9fd0] [c002b264] kthread+0x50/0x8c

[   15.183570] [c34b9ff0] [c00048d8] kernel_thread+0x44/0x60

[   15.248454] Instruction dump:

[   15.284076] 2f800000 61290008 913e000c 419e0008 480c4315 807e03fc
2f830000 419e0008

[   15.377703] 4804939d 38000040 901e0000 4819d749 <0fe00000> 48000000
7c0802a6 9421fff0

[   15.475780] Fixing recursive fault but reboot is needed!

[   15.539679] Oops: kernel access of bad area, sig: 11 [#3]

[   15.604344] NIP: c01b74a8 LR: c01b7424 CTR: c0014664

[   15.663821] REGS: c34b9bb0 TRAP: 0300   Tainted: G      D
(2.6.26-rc6)

[   15.745146] MSR: 00021030 <ME,IR,DR>  CR: 99005053  XER: c0000025

[   15.818782] DEAR: 0000002c, ESR: 00000000

[   15.866801] TASK =3D c3c580a0[178] 'rpciod/0' THREAD: c34b8000

[   15.932513] GPR00: 0000002c c34b9c60 c3c580a0 c3c44490 c025d078
c3c444b8 00000000 00000000

[   16.033537] GPR08: 26098f63 00000001 00000590 c025d028 feced300
ffffffff ffffffff ffffffff

[   16.134563] GPR16: ffffffff ffffffff ffffffff ffffffff ffffffff
ffffffff ffffffff ffffffff

[   16.235589] GPR24: ffffffff c0019660 c34b8000 c3c45218 c3c44490
00000000 c3c450c0 00000000

[   16.338799] NIP [c01b74a8] schedule+0x1ec/0x348

[   16.393167] LR [c01b7424] schedule+0x168/0x348

[   16.446490] Call Trace:

[   16.475760] [c34b9c60] [c01b7424] schedule+0x168/0x348 (unreliable)

[   16.551163] [c34b9c90] [c0019660] do_exit+0xc0/0x5e0

[   16.610840] [c34b9cd0] [c00035bc] nonrecoverable_exception+0x0/0x4c

[   16.686140] [c34b9ce0] [c0003658] _exception+0x50/0xdc

[   16.747901] [c34b9d80] [c0002e70] ret_from_except_full+0x0/0x4c

[   16.819037] [c34b9e40] [c0019b78] do_exit+0x5d8/0x5e0

[   16.879755] [c34b9e80] [c00035bc] nonrecoverable_exception+0x0/0x4c

[   16.955055] [c34b9e90] [c0009a18] bad_page_fault+0x48/0x5c

[   17.020983] [c34b9eb0] [c0002d28] handle_page_fault+0x7c/0x80

[   17.090034] [c34b9f70] [c01b7424] schedule+0x168/0x348

[   17.151796] [c34b9fa0] [c0027b74] worker_thread+0x7c/0xb8

[   17.216680] [c34b9fd0] [c002b264] kthread+0x50/0x8c

[   17.275317] [c34b9ff0] [c00048d8] kernel_thread+0x44/0x60

[   17.340198] Instruction dump:

[   17.375821] 7d290194 912b0028 914b002c 813b0000 39290001 913b0000
83bc00b4 83fe00b8

[   17.469449] 2f9d0000 40be0024 93fc00b8 381f002c <7d000028> 31080001
7c00022c 7d00012d

[   17.568873] Fixing recursive fault but reboot is needed!

[   17.632776] Oops: kernel access of bad area, sig: 11 [#4]

[   17.697446] NIP: c01b74a8 LR: c01b7424 CTR: c0014664

[   17.756920] REGS: c34b9a50 TRAP: 0300   Tainted: G      D
(2.6.26-rc6)

[   17.838245] MSR: 00021030 <ME,IR,DR>  CR: 99005053  XER: c0000025

[   17.911880] DEAR: 0000002c, ESR: 00000000

[   17.959903] TASK =3D c3c580a0[178] 'rpciod/0' THREAD: c34b8000

[   18.025612] GPR00: 0000002c c34b9b00 c3c580a0 c3c16860 c025d078
c3c450f4 00000000 00000000

[   18.126636] GPR08: 7a5fbbd5 00000001 00000591 c025d028 26098f63
ffffffff ffffffff ffffffff

[   18.227662] GPR16: ffffffff ffffffff ffffffff ffffffff ffffffff
ffffffff ffffffff ffffffff

[   18.328688] GPR24: ffffffff c0019660 c34b8000 c3c445e8 c3c16860
00000000 c3c44490 00000000

[   18.431898] NIP [c01b74a8] schedule+0x1ec/0x348

[   18.486267] LR [c01b7424] schedule+0x168/0x348

[   18.539589] Call Trace:

[   18.568859] [c34b9b00] [c01b7424] schedule+0x168/0x348 (unreliable)



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C8D007.DF8C5EA1
Content-Type: text/html; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:st1=3D"urn:schemas-microsoft-com:off=
ice:smarttags" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"=

 name=3D"State"/>
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"=

 name=3D"City"/>
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"=

 name=3D"PlaceType"/>
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"=

 name=3D"PlaceName"/>
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"=

 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:Arial;}
h1
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.3in;
	text-indent:-.3in;
	page-break-after:avoid;
	mso-list:l0 level1 lfo8;
	font-size:16.0pt;
	font-family:Arial;}
h2
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:12.0pt;
	margin-left:.4in;
	text-indent:-.4in;
	page-break-after:avoid;
	mso-list:l0 level2 lfo8;
	font-size:14.0pt;
	font-family:Arial;}
h3
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.5in;
	text-indent:-.5in;
	page-break-after:avoid;
	mso-list:l1 level3 lfo10;
	font-size:13.0pt;
	font-family:Arial;}
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
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:.5in .5in .5in .5in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1143350910;
	mso-list-template-ids:1338282562;}
@list l0:level1
	{mso-level-style-link:"Heading 1";
	mso-level-text:%1;
	mso-level-tab-stop:.3in;
	mso-level-number-position:left;
	margin-left:.3in;
	text-indent:-.3in;}
@list l0:level2
	{mso-level-style-link:"Heading 2";
	mso-level-text:"%1\.%2";
	mso-level-tab-stop:.4in;
	mso-level-number-position:left;
	margin-left:.4in;
	text-indent:-.4in;}
@list l0:level3
	{mso-level-text:"%1\.%2\.%3";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	margin-left:.5in;
	text-indent:-.5in;}
@list l0:level4
	{mso-level-text:"%1\.%2\.%3\.%4";
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l0:level5
	{mso-level-text:"%1\.%2\.%3\.%4\.%5";
	mso-level-tab-stop:.7in;
	mso-level-number-position:left;
	margin-left:.7in;
	text-indent:-.7in;}
@list l0:level6
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6";
	mso-level-tab-stop:.8in;
	mso-level-number-position:left;
	margin-left:.8in;
	text-indent:-.8in;}
@list l0:level7
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7";
	mso-level-tab-stop:.9in;
	mso-level-number-position:left;
	margin-left:.9in;
	text-indent:-.9in;}
@list l0:level8
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8";
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	margin-left:1.0in;
	text-indent:-1.0in;}
@list l0:level9
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9";
	mso-level-tab-stop:1.1in;
	mso-level-number-position:left;
	margin-left:1.1in;
	text-indent:-1.1in;}
@list l1
	{mso-list-id:1860200171;
	mso-list-template-ids:1400561736;}
@list l1:level1
	{mso-level-text:%1;
	mso-level-tab-stop:.3in;
	mso-level-number-position:left;
	margin-left:.3in;
	text-indent:-.3in;}
@list l1:level2
	{mso-level-text:"%1\.%2";
	mso-level-tab-stop:.4in;
	mso-level-number-position:left;
	margin-left:.4in;
	text-indent:-.4in;}
@list l1:level3
	{mso-level-reset-level:level2;
	mso-level-style-link:"Heading 3";
	mso-level-text:"%1\.%2\.%3";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	margin-left:.5in;
	text-indent:-.5in;}
@list l1:level4
	{mso-level-text:"%1\.%2\.%3\.%4";
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l1:level5
	{mso-level-text:"%1\.%2\.%3\.%4\.%5";
	mso-level-tab-stop:.7in;
	mso-level-number-position:left;
	margin-left:.7in;
	text-indent:-.7in;}
@list l1:level6
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6";
	mso-level-tab-stop:.8in;
	mso-level-number-position:left;
	margin-left:.8in;
	text-indent:-.8in;}
@list l1:level7
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7";
	mso-level-tab-stop:.9in;
	mso-level-number-position:left;
	margin-left:.9in;
	text-indent:-.9in;}
@list l1:level8
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8";
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	margin-left:1.0in;
	text-indent:-1.0in;}
@list l1:level9
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9";
	mso-level-tab-stop:1.1in;
	mso-level-number-position:left;
	margin-left:1.1in;
	text-indent:-1.1in;}
@list l2
	{mso-list-id:2077240681;
	mso-list-template-ids:-762429638;}
@list l2:level1
	{mso-level-text:%1;
	mso-level-tab-stop:.3in;
	mso-level-number-position:left;
	margin-left:.3in;
	text-indent:-.3in;}
@list l2:level2
	{mso-level-text:"%1\.%2";
	mso-level-tab-stop:.4in;
	mso-level-number-position:left;
	margin-left:.4in;
	text-indent:-.4in;}
@list l2:level3
	{mso-level-text:"%1\.%2\.%3";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	margin-left:.5in;
	text-indent:-.5in;}
@list l2:level4
	{mso-level-text:"%1\.%2\.%3\.%4";
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l2:level5
	{mso-level-text:"%1\.%2\.%3\.%4\.%5";
	mso-level-tab-stop:.7in;
	mso-level-number-position:left;
	margin-left:.7in;
	text-indent:-.7in;}
@list l2:level6
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6";
	mso-level-tab-stop:.8in;
	mso-level-number-position:left;
	margin-left:.8in;
	text-indent:-.8in;}
@list l2:level7
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7";
	mso-level-tab-stop:.9in;
	mso-level-number-position:left;
	margin-left:.9in;
	text-indent:-.9in;}
@list l2:level8
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8";
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	margin-left:1.0in;
	text-indent:-1.0in;}
@list l2:level9
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9";
	mso-level-tab-stop:1.1in;
	mso-level-number-position:left;
	margin-left:1.1in;
	text-indent:-1.1in;}
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
10.0pt;color:navy'>I&#8217;m not seeing any issue with arch/powerpc. <o:p><=
/o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;color:navy'>But with arch/ppc I&#8217;m seeing problems with NFS roo=
t
after I pulled in 2.6.26-rc6. &nbsp;Has anyone else seen anything like this=
?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;color:navy'>It&#8217;s consistent in that it typically happens on bo=
ot
after freeing unused kernel memory, but the actual task that running seems =
to
vary.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;color:navy'>We were running on 2.6.25 without the issue.<o:p></o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;color:navy'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;color:navy'>John<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>&nbsp;&nbsp;
11.660218] Looking up <st1:place w:st=3D"on"><st1:PlaceType w:st=3D"on">por=
t</st1:PlaceType>
 of <st1:PlaceName w:st=3D"on">RPC</st1:PlaceName></st1:place> 100003/2 on
172.16.40.76<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
11.740956] Looking up <st1:place w:st=3D"on"><st1:PlaceType w:st=3D"on">por=
t</st1:PlaceType>
 of <st1:PlaceName w:st=3D"on">RPC</st1:PlaceName></st1:place> 100005/1 on
172.16.40.76<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
11.859230] VFS: Mounted root (nfs filesystem).<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
11.914236] Freeing unused kernel memory: 108k init<o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
12.175480] Oops: kernel access of bad area, sig: 11 [#1]<o:p></o:p></span><=
/font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
12.240202] NIP: c01b74a8 LR: c01b7424 CTR: c0014664<o:p></o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
12.299677] REGS: c34b9ec0 TRAP: 0300&nbsp;&nbsp; Not tainted&nbsp; (2.6.26-=
rc6)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
12.372670] MSR: 00021030 &lt;ME,IR,DR&gt;&nbsp; CR: 95000033&nbsp; XER:
c0000025<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
12.446306] DEAR: 0000002c, ESR: 00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
12.494326] TASK =3D c3c580a0[178] 'rpciod/0' THREAD: c34b8000<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
12.560037] GPR00: 0000002c c34b9f70 c3c580a0 c3c450c0 c025d078 00000032
00000001 00000032<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
12.661061] GPR08: 10682916 00000037 0000058f c025d028 625a0000 ffffffff
ffffffff ffffffff<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
12.762088] GPR16: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
ffffffff ffffffff<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
12.863113] GPR24: ffffffff c0027b74 c34b8000 c3c581f4 c3c450c0 00000000
c3c580a0 00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
12.966324] NIP [c01b74a8] schedule+0x1ec/0x348<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
13.020693] LR [c01b7424] schedule+0x168/0x348<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
13.074016] Call Trace:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
13.103285] [c34b9f70] [c01b7424] schedule+0x168/0x348 (unreliable)<o:p></o:=
p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
13.178688] [c34b9fa0] [c0027b74] worker_thread+0x7c/0xb8<o:p></o:p></span><=
/font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
13.243573] [c34b9fd0] [c002b264] kthread+0x50/0x8c<o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
13.302209] [c34b9ff0] [c00048d8] kernel_thread+0x44/0x60<o:p></o:p></span><=
/font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
13.367090] Instruction dump:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
13.402714] 7d290194 912b0028 914b002c 813b0000 39290001 913b0000 83bc00b4
83fe00b8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
13.496342] 2f9d0000 40be0024 93fc00b8 381f002c &lt;7d000028&gt; 31080001
7c00022c 7d00012d<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
13.594651] ------------[ cut here ]------------<o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
13.649976] kernel BUG at kernel/exit.c:1098!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
13.702155] XXX: Exception<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
13.702170]&nbsp;&nbsp; Signal: 5<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
13.702182]&nbsp;&nbsp; Code:&nbsp;&nbsp; 30001<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
13.702195]&nbsp;&nbsp; Addr:&nbsp;&nbsp; 0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
13.826503] Oops: Exception in kernel mode, sig: 5 [#2]<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
13.889100] NIP: c0019b78 LR: c0019b78 CTR: c0014664<o:p></o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
13.948580] REGS: c34b9d90 TRAP: 0700&nbsp;&nbsp; Tainted:
G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; (2.6.26-rc6)<o:p></o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
14.029904] MSR: 00029030 &lt;<st1:place w:st=3D"on"><st1:City w:st=3D"on">E=
E</st1:City>,<st1:State
 w:st=3D"on">ME</st1:State></st1:place>,IR,DR&gt;&nbsp; CR: 39005093&nbsp; =
XER:
e0000025<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
14.106772] TASK =3D c3c580a0[178] 'rpciod/0' THREAD: c34b8000<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DIT style=3D'f=
ont-size:10.0pt'>[&nbsp;&nbsp;
14.172485] GPR00: c0019b78 c34b9e40 c3c580a0 c3c450c0 c025d078 c025d078
00000001 00000002<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DIT style=3D'f=
ont-size:10.0pt'>[&nbsp;&nbsp;
14.273509] GPR08: 00000000 00000000 54fcebe2 00000000 1a8fe938 ffffffff
ffffffff ffffffff<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DIT style=3D'f=
ont-size:10.0pt'>[&nbsp;&nbsp;
14.374534] GPR16: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
ffffffff ffffffff<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
14.475560] GPR24: ffffffff c0027b74 00000001 c3c58098 c3c178a0 c3c58188
c3c580a0 00000020<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
14.578771] NIP [c0019b78] do_exit+0x5d8/0x5e0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
14.632097] LR [c0019b78] do_exit+0x5d8/0x5e0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
14.684379] Call Trace:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
14.713649] [c34b9e40] [c0019b78] do_exit+0x5d8/0x5e0 (unreliable)<o:p></o:p=
></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
14.788011] [c34b9e80] [c00035bc] nonrecoverable_exception+0x0/0x4c<o:p></o:=
p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
14.863310] [c34b9e90] [c0009a18] bad_page_fault+0x48/0x5c<o:p></o:p></span>=
</font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
14.929236] [c34b9eb0] [c0002d28] handle_page_fault+0x7c/0x80<o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
14.998287] [c34b9f70] [c01b7424] schedule+0x168/0x348<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
15.060049] [c34b9fa0] [c0027b74] worker_thread+0x7c/0xb8<o:p></o:p></span><=
/font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
15.124934] [c34b9fd0] [c002b264] kthread+0x50/0x8c<o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
15.183570] [c34b9ff0] [c00048d8] kernel_thread+0x44/0x60<o:p></o:p></span><=
/font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DIT style=3D'f=
ont-size:10.0pt'>[&nbsp;&nbsp;
15.248454] Instruction dump:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DIT style=3D'f=
ont-size:10.0pt'>[&nbsp;&nbsp;
15.284076] 2f800000 61290008 913e000c 419e0008 480c4315 807e03fc 2f830000
419e0008<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DIT style=3D'f=
ont-size:10.0pt'>[&nbsp;&nbsp;
15.377703] 4804939d 38000040 901e0000 4819d749 &lt;0fe00000&gt; 48000000
7c0802a6 9421fff0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;
&nbsp;15.475780] Fixing recursive fault but reboot is needed!<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
15.539679] Oops: kernel access of bad area, sig: 11 [#3]<o:p></o:p></span><=
/font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
15.604344] NIP: c01b74a8 LR: c01b7424 CTR: c0014664<o:p></o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
15.663821] REGS: c34b9bb0 TRAP: 0300&nbsp;&nbsp; Tainted:
G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; (2.6.26-rc6)<o:p></o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
15.745146] MSR: 00021030 &lt;ME,IR,DR&gt;&nbsp; CR: 99005053&nbsp; XER:
c0000025<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
15.818782] DEAR: 0000002c, ESR: 00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
15.866801] TASK =3D c3c580a0[178] 'rpciod/0' THREAD: c34b8000<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
15.932513] GPR00: 0000002c c34b9c60 c3c580a0 c3c44490 c025d078 c3c444b8
00000000 00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
16.033537] GPR08: 26098f63 00000001 00000590 c025d028 feced300 ffffffff
ffffffff ffffffff<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
16.134563] GPR16: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
ffffffff ffffffff<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
16.235589] GPR24: ffffffff c0019660 c34b8000 c3c45218 c3c44490 00000000
c3c450c0 00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
16.338799] NIP [c01b74a8] schedule+0x1ec/0x348<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
16.393167] LR [c01b7424] schedule+0x168/0x348<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
16.446490] Call Trace:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
16.475760] [c34b9c60] [c01b7424] schedule+0x168/0x348 (unreliable)<o:p></o:=
p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
16.551163] [c34b9c90] [c0019660] do_exit+0xc0/0x5e0<o:p></o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
16.610840] [c34b9cd0] [c00035bc] nonrecoverable_exception+0x0/0x4c<o:p></o:=
p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
16.686140] [c34b9ce0] [c0003658] _exception+0x50/0xdc<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
16.747901] [c34b9d80] [c0002e70] ret_from_except_full+0x0/0x4c<o:p></o:p></=
span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DIT style=3D'f=
ont-size:10.0pt'>[&nbsp;&nbsp;
16.819037] [c34b9e40] [c0019b78] do_exit+0x5d8/0x5e0<o:p></o:p></span></fon=
t></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
16.879755] [c34b9e80] [c00035bc] nonrecoverable_exception+0x0/0x4c<o:p></o:=
p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
16.955055] [c34b9e90] [c0009a18] bad_page_fault+0x48/0x5c<o:p></o:p></span>=
</font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
17.020983] [c34b9eb0] [c0002d28] handle_page_fault+0x7c/0x80<o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
17.090034] [c34b9f70] [c01b7424] schedule+0x168/0x348<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
17.151796] [c34b9fa0] [c0027b74] worker_thread+0x7c/0xb8<o:p></o:p></span><=
/font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
17.216680] [c34b9fd0] [c002b264] kthread+0x50/0x8c<o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
17.275317] [c34b9ff0] [c00048d8] kernel_thread+0x44/0x60<o:p></o:p></span><=
/font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
17.340198] Instruction dump:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
17.375821] 7d290194 912b0028 914b002c 813b0000 39290001 913b0000 83bc00b4
83fe00b8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
17.469449] 2f9d0000 40be0024 93fc00b8 381f002c &lt;7d000028&gt; 31080001
7c00022c 7d00012d<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
17.568873] Fixing recursive fault but reboot is needed!<o:p></o:p></span></=
font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
17.632776] Oops: kernel access of bad area, sig: 11 [#4]<o:p></o:p></span><=
/font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
17.697446] NIP: c01b74a8 LR: c01b7424 CTR: c0014664<o:p></o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
17.756920] REGS: c34b9a50 TRAP: 0300&nbsp;&nbsp; Tainted:
G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; (2.6.26-rc6)<o:p></o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
17.838245] MSR: 00021030 &lt;ME,IR,DR&gt;&nbsp; CR: 99005053&nbsp; XER:
c0000025<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[
&nbsp;&nbsp;17.911880] DEAR: 0000002c, ESR: 00000000<o:p></o:p></span></fon=
t></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
17.959903] TASK =3D c3c580a0[178] 'rpciod/0' THREAD: c34b8000<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
18.025612] GPR00: 0000002c c34b9b00 c3c580a0 c3c16860 c025d078 c3c450f4
00000000 00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
18.126636] GPR08: 7a5fbbd5 00000001 00000591 c025d028 26098f63 ffffffff
ffffffff ffffffff<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
18.227662] GPR16: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
ffffffff ffffffff<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DIT style=3D'f=
ont-size:10.0pt'>[&nbsp;&nbsp;
18.328688] GPR24: ffffffff c0019660 c34b8000 c3c445e8 c3c16860 00000000
c3c44490 00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
18.431898] NIP [c01b74a8] schedule+0x1ec/0x348<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
18.486267] LR [c01b7424] schedule+0x168/0x348<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
18.539589] Call Trace:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt'>[&nbsp;&nbsp;
18.568859] [c34b9b00] [c01b7424] schedule+0x168/0x348 (unreliable)<o:p></o:=
p></span></font></p>

</div>

<br clear=3Dall> This email and any attachments are intended for the sole u=
se of the named recipient(s) and contain(s) confidential information that m=
ay be proprietary, privileged or copyrighted under applicable law. If you a=
re not the intended recipient, do not read, copy, or forward this email mes=
sage or any attachments. Delete this email message and any attachments imme=
diately.
</body>

</html>


------_=_NextPart_001_01C8D007.DF8C5EA1--
