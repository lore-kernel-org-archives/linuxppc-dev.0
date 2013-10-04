Return-Path: <thomas@net.t-labs.tu-berlin.de>
Received: from mail.net.t-labs.tu-berlin.de (mail.net.t-labs.tu-berlin.de
 [IPv6:2001:470:96b9:4:130:149:220:252])
 by ozlabs.org (Postfix) with ESMTP id C9F582C0085
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 22:35:18 +1000 (EST)
Received: from [10.10.4.143] (p57B623B4.dip0.t-ipconnect.de [87.182.35.180])
 by mail.net.t-labs.tu-berlin.de (Postfix) with ESMTPSA id 0B31C4C6F8E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 14:28:35 +0200 (CEST)
From: =?iso-8859-1?Q?Thomas_H=FChn?= <thomas@net.t-labs.tu-berlin.de>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_F12C2A0A-45A6-4EF3-9D0E-14B120ED73CC"
Subject: Gianfar driver crashes in Kernel v3.10
Message-Id: <E0CAE3C8-5883-4D20-8A95-CCC88B4A811C@net.t-labs.tu-berlin.de>
Date: Fri, 4 Oct 2013 14:28:34 +0200
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail=_F12C2A0A-45A6-4EF3-9D0E-14B120ED73CC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi all,

We are several Openwrt users based on the TPlink 4900 device and suffer =
from a crashing gianfar driver.
We troubleshooted the problem down to the fact, that a 3.8er Linux =
kernel is working, and a v3.10 crashes, but there is
no reproducable case yet. The driver crashes after a couple of minutes =
but this can not be triggered by high network load, or routing traffic.
I recorded the crash via a serial line and did a gdb lookup in gainfar.c
All infos and logs we collected so far in the OpenWRt =
forum:https://forum.openwrt.org/viewtopic.php?pid=3D213901#p213901

Here is my last troubleshooting log on the openwrt mailing list

I just hooked up a serial line to my tplinl4900. Used a recent trunk =
image and could catch the output of the crash.
The problem comes from the ethernet driver gfar

[code]
[ 2671.841927] Oops: Exception in kernel mode, sig: 5 [#1]
[ 2671.847141] Freescale P1014
[ 2671.849925] Modules linked in: ath9k pppoe ppp_async iptable_nat =
ath9k_common pppox p
e xt_tcpudp xt_tcpmss xt_string xt_statistic xt_state xt_recent xt_quota =
xt_pkttype xt_o
mark xt_connbytes xt_comment xt_addrtype xt_TCPMSS xt_REDIRECT xt_NETMAP =
xt_LOG xt_IPMAR
ms_datafab ums_cypress ums_alauda slhc nf_nat_tftp nf_nat_snmp_basic =
nf_nat_sip nf_nat_r
ntrack_sip nf_conntrack_rtsp nf_conntrack_proto_gre nf_conntrack_irc =
nf_conntrack_h323 n
compat_xtables compat ath sch_teql sch_tbf sch_sfq sch_red sch_prio =
sch_htb sch_gred sc
skbedit act_mirred em_u32 cls_u32 cls_tcindex cls_flow cls_route cls_fw =
sch_hfsc sch_ing
r usb_storage leds_gpio ohci_hcd ehci_platform ehci_hcd sd_mod scsi_mod =
fsl_mph_dr_of gp
[ 2671.988946] CPU: 0 PID: 5209 Comm: iftop Not tainted 3.10.13 #2
[ 2671.994859] task: c4b22220 ti: c7ff8000 task.ti: c477e000
[ 2672.000250] NIP: c018c7a0 LR: c018c794 CTR: c000b070
[ 2672.005206] REGS: c7ff9f10 TRAP: 3202   Not tainted  (3.10.13)
[ 2672.011028] MSR: 00029000 <CE,EE,ME>  CR: 48000024  XER: 20000000
[ 2672.017125]=20
GPR00: 000000ff c477fde0 c4b22220 00000000 00000000 000000ff 00000000 =
70000000=20
GPR08: ffffffff 00000008 00000000 ffffffff 00000046 10022248 00000000 =
00000008=20
GPR16: c781b3c0 c781b3c0 000000ff 00000000 00000001 0000021c 00000086 =
fffff800=20
GPR24: c7980300 00000000 00000001 00000040 00000003 c4b33000 00000000 =
00000001=20
[ 2672.046832] NIP [c018c7a0] gfar_poll+0x424/0x520
[ 2672.051442] LR [c018c794] gfar_poll+0x418/0x520
[ 2672.055962] Call Trace:
[ 2672.058402] [c477fde0] [c018c674] gfar_poll+0x2f8/0x520 (unreliable)
[ 2672.064762] [c477fe80] [c01b0ce8] net_rx_action+0x6c/0x158
[ 2672.070249] [c477feb0] [c0027dc4] __do_softirq+0xbc/0x16c
[ 2672.075642] [c477ff00] [c0027f7c] irq_exit+0x4c/0x68
[ 2672.080604] [c477ff10] [c00041f8] do_IRQ+0xf4/0x10c
[ 2672.085478] [c477ff40] [c000ca3c] ret_from_except+0x0/0x18
[ 2672.090991] --- Exception: 501 at 0x48083c28
[ 2672.090991]     LR =3D 0x48083bf8
[ 2672.098378] Instruction dump:
[ 2672.101338] 7f8f2040 419cfcc4 80900000 38a00000 8061004c 7e118378 =
81c10050 7ffafb78=20
[ 2672.109092] 4bf9eaa1 83810034 7c7e1b78 8361003c <83210038> 83a1004c =
48000060 41a2004c
[ 2672.117021] ---[ end trace 565fb54528d305fa ]---
[ 2672.121628]=20
[ 2673.103130] Kernel panic - not syncing: Fatal exception in interrupt
[ 2673.109474] Rebooting in 3 seconds..

U-Boot 2010.12-svn15934 (Dec 11 2012 - 16:23:49)
[/code]


A cross-gdb lookup to gianfar.o shows that the problem appier in =
function "gfar_poll"

[code]
./gdb =
../../../target-powerpc_uClibc-0.9.33.2/linux-mpc85xx_generic/linux-3.10.1=
2/drivers/net/ethernet/freescale/gianfar.o

This GDB was configured as "--host=3Dx86_64-linux-gnu =
--target=3Dpowerpc-openwrt-linux-uclibcspe".
For bug reporting instructions, please see:
<[url]http://bugs.launchpad.net/gdb-linaro/[/url]>...
Reading symbols from =
/home/thomas/BB-evernet/build_dir/target-powerpc_uClibc-0.9.33.2/linux-mpc=
85xx_generic/linux-3.10.12/drivers/net/ethernet/freescale/gianfar.o...done=
.
(gdb) l *gfar_poll+0x2f8/0x520
0x4538 is in gfar_poll (drivers/net/ethernet/freescale/gianfar.c:2829).
2824
2825            return howmany;
2826    }
2827
2828    static int gfar_poll(struct napi_struct *napi, int budget)
2829    {
2830            struct gfar_priv_grp *gfargrp =3D
2831                    container_of(napi, struct gfar_priv_grp, napi);
2832            struct gfar_private *priv =3D gfargrp->priv;
2833            struct gfar __iomem *regs =3D gfargrp->regs;
(gdb) q

[/code]


The changes from Linux kernel 3.8, which seems to have proper working =
ehternet, to the current 3.10 seem to intruduce a bug in the GIANFAR =
driver: drivers/net/ethernet/freescale/gianfra.c
There were different changes in the NAPI of gianfar driver made between =
the two kernel versions.=20
Please let us know which next troubleshooting step you would recommend =
to nail down the issue.

So far from troubleshooting.

Greetings Thomas=

--Apple-Mail=_F12C2A0A-45A6-4EF3-9D0E-14B120ED73CC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; ">Hi =
all,<br><br>We are several Openwrt users based on the TPlink 4900 device =
and suffer from a crashing gianfar driver.<br>We troubleshooted the =
problem down to the fact, that a 3.8er Linux kernel is working, and a =
v3.10 crashes, but there is<br>no reproducable case yet. The driver =
crashes after a couple of minutes but this can not be triggered by high =
network load, or routing traffic.<br>I recorded the crash via a serial =
line and did a gdb lookup in gainfar.c<br>All infos and logs we =
collected so far in the OpenWRt forum:<a =
href=3D"https://forum.openwrt.org/viewtopic.php?pid=3D213901#p213901">http=
s://forum.openwrt.org/viewtopic.php?pid=3D213901#p213901</a><br><br>Here =
is my last troubleshooting log on the openwrt mailing list<br><br>I just =
hooked up a serial line to my tplinl4900. Used a recent trunk image and =
could catch the output of the crash.<br>The problem comes from the =
ethernet driver gfar<br><br>[code]<br>[ 2671.841927] Oops: Exception in =
kernel mode, sig: 5 [#1]<br>[ 2671.847141] Freescale P1014<br>[ =
2671.849925] Modules linked in: ath9k pppoe ppp_async iptable_nat =
ath9k_common pppox p<br>e xt_tcpudp xt_tcpmss xt_string xt_statistic =
xt_state xt_recent xt_quota xt_pkttype xt_o<br>mark xt_connbytes =
xt_comment xt_addrtype xt_TCPMSS xt_REDIRECT xt_NETMAP xt_LOG =
xt_IPMAR<br>ms_datafab ums_cypress ums_alauda slhc nf_nat_tftp =
nf_nat_snmp_basic nf_nat_sip nf_nat_r<br>ntrack_sip nf_conntrack_rtsp =
nf_conntrack_proto_gre nf_conntrack_irc nf_conntrack_h323 =
n<br>compat_xtables compat ath sch_teql sch_tbf sch_sfq sch_red sch_prio =
sch_htb sch_gred sc<br>skbedit act_mirred em_u32 cls_u32 cls_tcindex =
cls_flow cls_route cls_fw sch_hfsc sch_ing<br>r usb_storage leds_gpio =
ohci_hcd ehci_platform ehci_hcd sd_mod scsi_mod fsl_mph_dr_of gp<br>[ =
2671.988946] CPU: 0 PID: 5209 Comm: iftop Not tainted 3.10.13 #2<br>[ =
2671.994859] task: c4b22220 ti: c7ff8000 task.ti: c477e000<br>[ =
2672.000250] NIP: c018c7a0 LR: c018c794 CTR: c000b070<br>[ 2672.005206] =
REGS: c7ff9f10 TRAP: 3202 &nbsp;&nbsp;Not tainted &nbsp;(3.10.13)<br>[ =
2672.011028] MSR: 00029000 &lt;CE,EE,ME&gt; &nbsp;CR: 48000024 =
&nbsp;XER: 20000000<br>[ 2672.017125]&nbsp;<br>GPR00: 000000ff c477fde0 =
c4b22220 00000000 00000000 000000ff 00000000 70000000&nbsp;<br>GPR08: =
ffffffff 00000008 00000000 ffffffff 00000046 10022248 00000000 =
00000008&nbsp;<br>GPR16: c781b3c0 c781b3c0 000000ff 00000000 00000001 =
0000021c 00000086 fffff800&nbsp;<br>GPR24: c7980300 00000000 00000001 =
00000040 00000003 c4b33000 00000000 00000001&nbsp;<br>[ 2672.046832] NIP =
[c018c7a0] gfar_poll+0x424/0x520<br>[ 2672.051442] LR [c018c794] =
gfar_poll+0x418/0x520<br>[ 2672.055962] Call Trace:<br>[ 2672.058402] =
[c477fde0] [c018c674] gfar_poll+0x2f8/0x520 (unreliable)<br>[ =
2672.064762] [c477fe80] [c01b0ce8] net_rx_action+0x6c/0x158<br>[ =
2672.070249] [c477feb0] [c0027dc4] __do_softirq+0xbc/0x16c<br>[ =
2672.075642] [c477ff00] [c0027f7c] irq_exit+0x4c/0x68<br>[ 2672.080604] =
[c477ff10] [c00041f8] do_IRQ+0xf4/0x10c<br>[ 2672.085478] [c477ff40] =
[c000ca3c] ret_from_except+0x0/0x18<br>[ 2672.090991] --- Exception: 501 =
at 0x48083c28<br>[ 2672.090991] &nbsp;&nbsp;&nbsp;&nbsp;LR =3D =
0x48083bf8<br>[ 2672.098378] Instruction dump:<br>[ 2672.101338] =
7f8f2040 419cfcc4 80900000 38a00000 8061004c 7e118378 81c10050 =
7ffafb78&nbsp;<br>[ 2672.109092] 4bf9eaa1 83810034 7c7e1b78 8361003c =
&lt;83210038&gt; 83a1004c 48000060 41a2004c<br>[ 2672.117021] ---[ end =
trace 565fb54528d305fa ]---<br>[ 2672.121628]&nbsp;<br>[ 2673.103130] =
Kernel panic - not syncing: Fatal exception in interrupt<br>[ =
2673.109474] Rebooting in 3 seconds..<br><br>U-Boot 2010.12-svn15934 =
(Dec 11 2012 - 16:23:49)<br>[/code]<br><br><br>A cross-gdb lookup to =
gianfar.o shows that the problem appier in function =
"gfar_poll"<br><br>[code]<br>./gdb =
../../../target-powerpc_uClibc-0.9.33.2/linux-mpc85xx_generic/linux-3.10.1=
2/drivers/net/ethernet/freescale/gianfar.o<br><br>This GDB was =
configured as "--host=3Dx86_64-linux-gnu =
--target=3Dpowerpc-openwrt-linux-uclibcspe".<br>For bug reporting =
instructions, please see:<br>&lt;[url]<a =
href=3D"http://bugs.launchpad.net/gdb-linaro/[/url]">http://bugs.launchpad=
.net/gdb-linaro/[/url]</a>&gt;...<br>Reading symbols from =
/home/thomas/BB-evernet/build_dir/target-powerpc_uClibc-0.9.33.2/linux-mpc=
85xx_generic/linux-3.10.12/drivers/net/ethernet/freescale/gianfar.o...done=
.<br>(gdb) l *gfar_poll+0x2f8/0x520<br>0x4538 is in gfar_poll =
(drivers/net/ethernet/freescale/gianfar.c:2829).<br>2824<br>2825 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
howmany;<br>2826 &nbsp;&nbsp;&nbsp;}<br>2827<br>2828 =
&nbsp;&nbsp;&nbsp;static int gfar_poll(struct napi_struct *napi, int =
budget)<br>2829 &nbsp;&nbsp;&nbsp;{<br>2830 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct =
gfar_priv_grp *gfargrp =3D<br>2831 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;container_of(napi, struct =
gfar_priv_grp, napi);<br>2832 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct =
gfar_private *priv =3D gfargrp-&gt;priv;<br>2833 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct =
gfar __iomem *regs =3D gfargrp-&gt;regs;<br>(gdb) =
q<br><br>[/code]<br><br><br>The changes from Linux kernel 3.8, which =
seems to have proper working ehternet, to the current 3.10 seem to =
intruduce a bug in the GIANFAR driver: =
drivers/net/ethernet/freescale/gianfra.c<br>There were different changes =
in the NAPI of gianfar driver made between the two kernel =
versions.&nbsp;<br>Please let us know which next troubleshooting step =
you would recommend to nail down the issue.<br><br>So far from =
troubleshooting.<br><br>Greetings Thomas</body></html>=

--Apple-Mail=_F12C2A0A-45A6-4EF3-9D0E-14B120ED73CC--
