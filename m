Return-Path: <Avi.Tsarfati@alvarion.com>
Received: from alvarion.com (mailyoq2.alvarion.com [95.35.11.188])
 by ozlabs.org (Postfix) with ESMTP id 30F322C0095
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2012 23:10:29 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CDAA04.E46F6764"
Subject: RE: gianfar driver crash on P1020
Date: Sun, 14 Oct 2012 14:10:24 +0200
Message-ID: <56439212F1FB0D45B3354883689F4245559643@yoqex01.alvarion.com>
In-Reply-To: <507452B0.7040401@freescale.com>
References: <56439212F1FB0D45B3354883689F4245559383@yoqex01.alvarion.com>
 <507452B0.7040401@freescale.com>
From: "Avi Tsarfati" <Avi.Tsarfati@alvarion.com>
To: "Claudiu Manoil" <claudiu.manoil@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CDAA04.E46F6764
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01CDAA04.E46F6764"

------_=_NextPart_002_01CDAA04.E46F6764
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,=20

The patch you sent me will prevent TX timeouts that will trigger gianfar
stop(gfar_stop is causing the soft lockup) & start by network watchdog
and will solve my first problem.

But, I have this problem again while running some traffic (ping -s 1500
to and from my device) and configuring MTU or set eth interface down. In
both cases gfar_stop sometimes cause soft lockup of 2 minutes.

Trace in case of MTU set:=20

 BR_1: port 1(eth0) entering forwarding state

PHY: mdio@ffe24000:01 - Link is Down

PHY: mdio@ffe24000:01 - Link is Up - 100/Half

PHY: mdio@ffe24000:01 - Link is Down

PHY: mdio@ffe24000:01 - Link is Up - 10/Half

PHY: mdio@ffe24000:01 - Link is Down

BR_1: port 1(eth0) entering disabled state

PHY: mdio@ffe24000:01 - Link is Up - 1000/Full

BR_1: port 1(eth0) entering forwarding state

BUG: soft lockup - CPU#0 stuck for 120s! [wavman:2348]

Modules linked in: xt_physdev xt_state xt_tcpudp ebt_mark ebt_mark_m
ebt_limit ebtable_nat ebtable_broute ebtable_filter ebtables
iptable_mangle iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_conntrack umac online_acs(P) dih(P) netlink_support(P) dfs_addon(P)
waran(P) ath_dev(P) ath_rate_atheros(P) addons_shared(P) ath_hal(P) adf
asf(P) iptable_filter ip_tables x_tables

NIP: c00513b8 LR: c00530b4 CTR: c005304c

REGS: c6009880 TRAP: 0901   Tainted: P            (2.6.31)

MSR: 00029000 <EE,ME,CE>  CR: 22028228  XER: 00000000

TASK =3D cd47aa30[2348] 'wavman' THREAD: c6008000

GPR00: 00000080 c6009930 cd47aa30 00000010 ca690a00 c6009b34 c6009ad8
d1880000=20

GPR08: 11b6598e 00000000 00000000 c0385f14 00000000=20

NIP [c00513b8] handle_IRQ_event+0x28/0x13c

LR [c00530b4] handle_fasteoi_irq+0x68/0xf0

Call Trace:

[c6009930] [00000004] 0x4 (unreliable)

[c6009950] [c00530b4] handle_fasteoi_irq+0x68/0xf0

[c6009960] [c0004f04] do_IRQ+0x98/0xb4

[c6009980] [c000fe58] ret_from_except+0x0/0x18

[c6009a40] [c0187ae0] stop_gfar+0x20/0x11c

[c6009a60] [c0189360] gfar_change_mtu+0x124/0x164

[c6009a80] [c01d5c30] dev_set_mtu+0x70/0xa4

[c6009a90] [c01e112c] do_setlink+0x1dc/0x348

[c6009ad0] [c01e2a9c] rtnl_newlink+0x330/0x460

[c6009bd0] [c01e2288] rtnetlink_rcv_msg+0x228/0x260

[c6009bf0] [c01ee0e8] netlink_rcv_skb+0x110/0x120

[c6009c10] [c01e204c] rtnetlink_rcv+0x28/0x3c

[c6009c30] [c01edd78] netlink_unicast+0x2c4/0x334

[c6009c70] [c01ee7ec] netlink_sendmsg+0x1c8/0x280

[c6009cc0] [c01c4c74] sock_sendmsg+0xac/0xe4

[c6009db0] [c01c4e80] sys_sendmsg+0x1d4/0x284

[c6009f00] [c01c58d4] sys_socketcall+0xe0/0x1f8

[c6009f40] [c000f804] ret_from_syscall+0x0/0x3c

Instruction dump:

801f0024 4bfffe3c 9421ffe0 7c0802a6 bf61000c 7c9f2378 90010024 7c7e1b78=20

80040004 70090020 40820008 7c008146 <3d20c02e> 3ba00000 3b69e138
3b800000=20

=20

Trace in case of set eth down:=20

PHY: mdio@ffe24000:01 - Link is Up - 1000/Full

BR_1: port 1(eth0) entering forwarding state

BR_1: port 1(eth0) entering disabled state

BR_1: port 1(eth0) entering forwarding state

PHY: mdio@ffe24000:01 - Link is Up - 100/Full

BUG: soft lockup - CPU#0 stuck for 120s! [ip:8428]

Modules linked in: xt_physdev xt_state xt_tcpudp ebt_mark ebt_mark_m
ebt_limit ebtable_nat ebtable_broute ebtable_filter ebtables
iptable_mangle iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_conntrack rpldev umac online_acs(P) dih(P) netlink_support(P)
dfs_addon(P) waran(P) ath_dev(P) ath_rate_atheros(P) addons_shared(P)
ath_hal(P) adf asf(P) iptable_filter ip_tables x_tables

NIP: c00513b8 LR: c00530b4 CTR: c005304c

REGS: ca663bc0 TRAP: 0901   Tainted: P            (2.6.31)

MSR: 00029000 <EE,ME,CE>  CR: 22020428  XER: 00000000

TASK =3D c55c7390[8428] 'ip' THREAD: ca662000

GPR00: 00000080 ca663c70 c55c7390 00000010 c627cb00 c0364ae8 00000008
d1880000=20

GPR08: 4800f86b 00000000 00000000 c0385f14 00000000=20

NIP [c00513b8] handle_IRQ_event+0x28/0x13c

LR [c00530b4] handle_fasteoi_irq+0x68/0xf0

Call Trace:

[ca663c70] [ca662000] 0xca662000 (unreliable)

[ca663c90] [c00530b4] handle_fasteoi_irq+0x68/0xf0

[ca663ca0] [c0004f04] do_IRQ+0x98/0xb4

[ca663cc0] [c000fe58] ret_from_except+0x0/0x18

[ca663d80] [c0187af8] stop_gfar+0x38/0x11c

[ca663da0] [c01882c0] gfar_close+0x30/0xa0

[ca663dc0] [c01d62ec] dev_close+0x8c/0xe0

[ca663dd0] [c01d5db8] dev_change_flags+0x154/0x1ac

[ca663df0] [c022277c] devinet_ioctl+0x648/0x824

[ca663e60] [c0223294] inet_ioctl+0xcc/0xf8

[ca663e70] [c01c3c08] sock_ioctl+0x10c/0x2d0

[ca663e90] [c008bc60] vfs_ioctl+0x34/0x8c

[ca663ea0] [c008be84] do_vfs_ioctl+0x88/0x724

[ca663f10] [c008c560] sys_ioctl+0x40/0x74

[ca663f40] [c000f804] ret_from_syscall+0x0/0x3c

Instruction dump:

801f0024 4bfffe3c 9421ffe0 7c0802a6 bf61000c 7c9f2378 90010024 7c7e1b78=20

80040004 70090020 40820008 7c008146 <3d20c02e> 3ba00000 3b69e198
3b800000

=20

A script (test_eth) that I run can reproduce it on my board.

=20

Did you encounter such problem before ?

=20

Thanks in advance,=20

Avi  Tsarfati.

=20

From: Claudiu Manoil [mailto:claudiu.manoil@freescale.com]=20
Sent: Tuesday, October 09, 2012 6:37 PM
To: Avi Tsarfati
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: gianfar driver crash on P1020

=20

Hello,

Did you try this patch?
http://patchwork.ozlabs.org/patch/186315/

Claudiu

On 10/9/2012 3:22 PM, Avi Tsarfati wrote:

	Hi,=20

	=20

	I have the same problem as you do.=20

	Have you found the CPU stuck reason (or fix) in P1020RDB board ?

	=20

	Thanks,

	Avi Tsarfati.

	=20

=09
=09
=09
************************************************************************
************=20
	This footnote confirms that this email message has been scanned
by=20
	PineApp Mail-SeCure for the presence of malicious code, vandals
& computer viruses(187).=20
=09
************************************************************************
************
=09
=09
=09
=09

	_______________________________________________
	Linuxppc-dev mailing list
	Linuxppc-dev@lists.ozlabs.org
	https://lists.ozlabs.org/listinfo/linuxppc-dev




************************************************************************
************=20
This footnote confirms that this email message has been scanned by=20
PineApp Mail-SeCure for the presence of malicious code, vandals &
computer viruses(100).=20
************************************************************************
************


************************************************************************
************=20
This footnote confirms that this email message has been scanned by=20
PineApp Mail-SeCure for the presence of malicious code, vandals &
computer viruses(42).=20
************************************************************************
************


************************************************************************************ 
This footnote confirms that this email message has been scanned by 
PineApp Mail-SeCure for the presence of malicious code, vandals & computer viruses(187). 
************************************************************************************



------_=_NextPart_002_01CDAA04.E46F6764
Content-Type: text/html; charset="us-ascii"
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
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;
	color:black;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
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

<body bgcolor=3Dwhite lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Hi, =
<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>The patch you sent me =
will
prevent TX timeouts that will trigger gianfar stop(gfar_stop is causing =
the
soft lockup) &amp; start by network watchdog and will solve my first =
problem.<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>But, I have this =
problem again
while running some traffic (ping &#8211;s 1500 to and from my device) =
and
configuring MTU or set eth interface down. In both cases gfar_stop =
sometimes cause
soft lockup of 2 minutes.<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Trace in case of MTU =
set: <o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>&nbsp;BR_1:
port 1(eth0) entering forwarding state<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>PHY:
mdio@ffe24000:01 - Link is Down<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>PHY:
mdio@ffe24000:01 - Link is Up - 100/Half<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>PHY:
mdio@ffe24000:01 - Link is Down<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>PHY:
mdio@ffe24000:01 - Link is Up - 10/Half<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>PHY:
mdio@ffe24000:01 - Link is Down<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>BR_1:
port 1(eth0) entering disabled state<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>PHY:
mdio@ffe24000:01 - Link is Up - 1000/Full<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>BR_1:
port 1(eth0) entering forwarding state<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>BUG:
soft lockup - CPU#0 stuck for 120s! [wavman:2348]<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>Modules
linked in: xt_physdev xt_state xt_tcpudp ebt_mark ebt_mark_m ebt_limit
ebtable_nat ebtable_broute ebtable_filter ebtables iptable_mangle =
iptable_nat
nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack umac online_acs(P) =
dih(P)
netlink_support(P) dfs_addon(P) waran(P) ath_dev(P) ath_rate_atheros(P)
addons_shared(P) ath_hal(P) adf asf(P) iptable_filter ip_tables =
x_tables<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>NIP:
c00513b8 LR: c00530b4 CTR: c005304c<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>REGS:
c6009880 TRAP: 0901&nbsp;&nbsp; Tainted:
P&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(2.6.31)<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>MSR:
00029000 &lt;EE,ME,CE&gt;&nbsp; CR: 22028228&nbsp; XER: =
00000000<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>TASK
=3D cd47aa30[2348] 'wavman' THREAD: c6008000<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>GPR00:
00000080 c6009930 cd47aa30 00000010 ca690a00 c6009b34 c6009ad8 d1880000 =
<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>GPR08:
11b6598e 00000000 00000000 c0385f14 00000000 <o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>NIP
[c00513b8] handle_IRQ_event+0x28/0x13c<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>LR
[c00530b4] handle_fasteoi_irq+0x68/0xf0<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>Call
Trace:<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[c6009930]
[00000004] 0x4 (unreliable)<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[c6009950]
[c00530b4] handle_fasteoi_irq+0x68/0xf0<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[c6009960]
[c0004f04] do_IRQ+0x98/0xb4<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[c6009980]
[c000fe58] ret_from_except+0x0/0x18<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[c6009a40]
[c0187ae0] stop_gfar+0x20/0x11c<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[c6009a60]
[c0189360] gfar_change_mtu+0x124/0x164<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[c6009a80]
[c01d5c30] dev_set_mtu+0x70/0xa4<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[c6009a90]
[c01e112c] do_setlink+0x1dc/0x348<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[c6009ad0]
[c01e2a9c] rtnl_newlink+0x330/0x460<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[c6009bd0]
[c01e2288] rtnetlink_rcv_msg+0x228/0x260<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[c6009bf0]
[c01ee0e8] netlink_rcv_skb+0x110/0x120<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[c6009c10]
[c01e204c] rtnetlink_rcv+0x28/0x3c<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[c6009c30]
[c01edd78] netlink_unicast+0x2c4/0x334<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[c6009c70]
[c01ee7ec] netlink_sendmsg+0x1c8/0x280<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[c6009cc0]
[c01c4c74] sock_sendmsg+0xac/0xe4<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[c6009db0]
[c01c4e80] sys_sendmsg+0x1d4/0x284<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[c6009f00]
[c01c58d4] sys_socketcall+0xe0/0x1f8<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[c6009f40]
[c000f804] ret_from_syscall+0x0/0x3c<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>Instruction
dump:<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>801f0024
4bfffe3c 9421ffe0 7c0802a6 bf61000c 7c9f2378 90010024 7c7e1b78 =
<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>80040004
70090020 40820008 7c008146 &lt;3d20c02e&gt; 3ba00000 3b69e138 3b800000 =
<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Trace in case of set =
eth down: <o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>PHY:
mdio@ffe24000:01 - Link is Up - 1000/Full<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>BR_1:
port 1(eth0) entering forwarding state<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>BR_1:
port 1(eth0) entering disabled state<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>BR_1:
port 1(eth0) entering forwarding state<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>PHY:
mdio@ffe24000:01 - Link is Up - 100/Full<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>BUG:
soft lockup - CPU#0 stuck for 120s! [ip:8428]<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>Modules
linked in: xt_physdev xt_state xt_tcpudp ebt_mark ebt_mark_m ebt_limit
ebtable_nat ebtable_broute ebtable_filter ebtables iptable_mangle =
iptable_nat
nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack rpldev umac =
online_acs(P)
dih(P) netlink_support(P) dfs_addon(P) waran(P) ath_dev(P) =
ath_rate_atheros(P)
addons_shared(P) ath_hal(P) adf asf(P) iptable_filter ip_tables =
x_tables<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>NIP:
c00513b8 LR: c00530b4 CTR: c005304c<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>REGS:
ca663bc0 TRAP: 0901&nbsp;&nbsp; Tainted:
P&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(2.6.31)<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>MSR:
00029000 &lt;EE,ME,CE&gt;&nbsp; CR: 22020428&nbsp; XER: =
00000000<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>TASK
=3D c55c7390[8428] 'ip' THREAD: ca662000<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>GPR00:
00000080 ca663c70 c55c7390 00000010 c627cb00 c0364ae8 00000008 d1880000 =
<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>GPR08:
4800f86b 00000000 00000000 c0385f14 00000000 <o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>NIP
[c00513b8] handle_IRQ_event+0x28/0x13c<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>LR
[c00530b4] handle_fasteoi_irq+0x68/0xf0<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>Call
Trace:<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[ca663c70]
[ca662000] 0xca662000 (unreliable)<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[ca663c90]
[c00530b4] handle_fasteoi_irq+0x68/0xf0<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[ca663ca0]
[c0004f04] do_IRQ+0x98/0xb4<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[ca663cc0]
[c000fe58] ret_from_except+0x0/0x18<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[ca663d80]
[c0187af8] stop_gfar+0x38/0x11c<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[ca663da0]
[c01882c0] gfar_close+0x30/0xa0<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[ca663dc0]
[c01d62ec] dev_close+0x8c/0xe0<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[ca663dd0]
[c01d5db8] dev_change_flags+0x154/0x1ac<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[ca663df0]
[c022277c] devinet_ioctl+0x648/0x824<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[ca663e60]
[c0223294] inet_ioctl+0xcc/0xf8<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[ca663e70]
[c01c3c08] sock_ioctl+0x10c/0x2d0<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[ca663e90]
[c008bc60] vfs_ioctl+0x34/0x8c<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[ca663ea0]
[c008be84] do_vfs_ioctl+0x88/0x724<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[ca663f10]
[c008c560] sys_ioctl+0x40/0x74<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>[ca663f40]
[c000f804] ret_from_syscall+0x0/0x3c<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>Instruction
dump:<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>801f0024
4bfffe3c 9421ffe0 7c0802a6 bf61000c 7c9f2378 90010024 7c7e1b78 =
<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:36.0pt'><span =
style=3D'color:#1F497D'>80040004
70090020 40820008 7c008146 &lt;3d20c02e&gt; 3ba00000 3b69e198 =
3b800000<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>A script (test_eth) =
that I run
can reproduce it on my board.<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Did you encounter =
such problem
before ?<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Thanks in advance, =
<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Avi&nbsp; =
Tsarfati.<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<div>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt =
0cm 0cm 0cm'>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";
color:windowtext'>From:</span></b><span =
style=3D'font-size:10.0pt;font-family:
"Tahoma","sans-serif";color:windowtext'> Claudiu Manoil
[mailto:claudiu.manoil@freescale.com] <br>
<b>Sent:</b> Tuesday, October 09, 2012 6:37 PM<br>
<b>To:</b> Avi Tsarfati<br>
<b>Cc:</b> linuxppc-dev@lists.ozlabs.org<br>
<b>Subject:</b> Re: gianfar driver crash on P1020<o:p></o:p></span></p>

</div>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'>Hello,<br>
<br>
Did you try this patch?<br>
<a =
href=3D"http://patchwork.ozlabs.org/patch/186315/">http://patchwork.ozlab=
s.org/patch/186315/</a><br>
<br>
Claudiu<o:p></o:p></p>

<div>

<p class=3DMsoNormal>On 10/9/2012 3:22 PM, Avi Tsarfati =
wrote:<o:p></o:p></p>

</div>

<blockquote style=3D'margin-top:5.0pt;margin-bottom:5.0pt'>

<p class=3DMsoNormal>Hi, <o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;<o:p></o:p></p>

<p class=3DMsoNormal>I have the same problem as you do. <o:p></o:p></p>

<p class=3DMsoNormal>Have you found the CPU stuck reason (or fix) in =
P1020RDB
board ?<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;<o:p></o:p></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0cm;margin-bottom:
5.0pt;margin-left:0cm'>Thanks,<o:p></o:p></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0cm;margin-bottom:
5.0pt;margin-left:0cm'>Avi Tsarfati.<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;<o:p></o:p></p>

<p class=3DMsoNormal><span style=3D'font-size:12.0pt;font-family:"Times =
New Roman","serif"'><br>
<br>
*************************************************************************=
***********
<br>
This footnote confirms that this email message has been scanned by <br>
PineApp Mail-SeCure for the presence of malicious code, vandals &amp; =
computer
viruses(187). <br>
*************************************************************************=
***********<br>
<br>
<br>
<br>
<o:p></o:p></span></p>

<pre>_______________________________________________<o:p></o:p></pre><pre=
>Linuxppc-dev mailing list<o:p></o:p></pre><pre><a
href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.o=
rg</a><o:p></o:p></pre><pre><a
href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozl=
abs.org/listinfo/linuxppc-dev</a><o:p></o:p></pre></blockquote>

<p class=3DMsoNormal><span style=3D'font-size:12.0pt;font-family:"Times =
New Roman","serif"'><br>
<br>
<br>
*************************************************************************=
***********
<br>
This footnote confirms that this email message has been scanned by <br>
PineApp Mail-SeCure for the presence of malicious code, vandals &amp; =
computer
viruses(100). <br>
*************************************************************************=
***********<br>
<br>
<br>
*************************************************************************=
***********
<br>
This footnote confirms that this email message has been scanned by <br>
PineApp Mail-SeCure for the presence of malicious code, vandals &amp; =
computer
viruses(42). <br>
*************************************************************************=
***********<o:p></o:p></span></p>

</div>

<br><br>
************************************************************************************ <br>This footnote confirms that this email message has been scanned by <br>PineApp Mail-SeCure for the presence of malicious code, vandals & computer viruses(187). <br>************************************************************************************<br>
</body>

</html>



------_=_NextPart_002_01CDAA04.E46F6764--

------_=_NextPart_001_01CDAA04.E46F6764
Content-Type: application/octet-stream; name="test_eth"
Content-Transfer-Encoding: base64
Content-Description: test_eth
Content-Disposition: attachment; filename="test_eth"

IyEvYmluL2Jhc2gKCndoaWxlIFsgMSBdCmRvCgllY2hvICJTZXR0aW5nIGF1dG8gbmVnb3RpYXRp
b24iCglpcCBsaW5rIHNldCBldGgwIGRvd24KCWlwIGxpbmsgc2V0IGV0aDAgYWRkcmVzcyAwMDox
ODoyNTpGMDo2NTpCMwoJaXAgbGluayBzZXQgZXRoMCB1cAoJZXRodG9vbCAtcyBldGgwIGF1dG9u
ZWcgb24KCXNsZWVwIDUKCWVjaG8gIlNldHRpbmcgMTAwTSIKCWlwIGxpbmsgc2V0IGV0aDAgZG93
bgoJaXAgbGluayBzZXQgZXRoMCBhZGRyZXNzIDAwOjE4OjI1OkYwOjY1OkIzCglpcCBsaW5rIHNl
dCBldGgwIHVwCglldGh0b29sIC1zIGV0aDAgc3BlZWQgMTAwIGR1cGxleCBmdWxsIGF1dG9uZWcg
b2ZmCglzbGVlcCA1CmRvbmUKCg==

------_=_NextPart_001_01CDAA04.E46F6764--
