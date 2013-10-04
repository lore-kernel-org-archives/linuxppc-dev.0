Return-Path: <Thomas.Huehn@dai-labor.de>
Received: from mail.tu-berlin.de (mail.tu-berlin.de [130.149.7.33])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3D4B12C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 22:19:19 +1000 (EST)
From: =?iso-8859-1?Q?Thomas_H=FChn?= <Thomas.Huehn@dai-labor.de>
To: "claudiu.manoil@freescale.com" <claudiu.manoil@freescale.com>
Subject: Gianfar driver crashes in Kernel v3.10
Date: Fri, 4 Oct 2013 12:03:04 +0000
Message-ID: <8EF35D6A-A132-458C-A3B4-80D4D2C5BA4C@dai-labor.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

We are several Openwrt users based on the TPlink 4900 device and suffer fro=
m a crashing gianfar driver.
We troubleshooted the problem down to the fact, that a 3.8er Linux kernel i=
s working, and a v3.10 crashes, but there is
no reproducable case yet. The driver crashes after a couple of minutes but =
this can not be triggered by high network load, or routing traffic.
I recorded the crash via a serial line and did a gdb lookup in gainfar.c
All infos and logs we collected so far are here: https://forum.openwrt.org/=
viewtopic.php?pid=3D213901#p213901

I cc the linuxppc-dev mailing but not sure this is the rigth one.
Please let us know how we could help to find that bug within the gianfar NA=
PI.

Greetings Thomas




ps: here is my last troubleshooting log on the openwrt mailing list

I just hooked up a serial line to my tplinl4900. Used a recent trunk image =
and could catch the output of the crash.
The problem comes from the ethernet driver gfar

[code]
[ 2671.841927] Oops: Exception in kernel mode, sig: 5 [#1]
[ 2671.847141] Freescale P1014
[ 2671.849925] Modules linked in: ath9k pppoe ppp_async iptable_nat ath9k_c=
ommon pppox p
e xt_tcpudp xt_tcpmss xt_string xt_statistic xt_state xt_recent xt_quota xt=
_pkttype xt_o
mark xt_connbytes xt_comment xt_addrtype xt_TCPMSS xt_REDIRECT xt_NETMAP xt=
_LOG xt_IPMAR
ms_datafab ums_cypress ums_alauda slhc nf_nat_tftp nf_nat_snmp_basic nf_nat=
_sip nf_nat_r
ntrack_sip nf_conntrack_rtsp nf_conntrack_proto_gre nf_conntrack_irc nf_con=
ntrack_h323 n
 compat_xtables compat ath sch_teql sch_tbf sch_sfq sch_red sch_prio sch_ht=
b sch_gred sc
skbedit act_mirred em_u32 cls_u32 cls_tcindex cls_flow cls_route cls_fw sch=
_hfsc sch_ing
r usb_storage leds_gpio ohci_hcd ehci_platform ehci_hcd sd_mod scsi_mod fsl=
_mph_dr_of gp
[ 2671.988946] CPU: 0 PID: 5209 Comm: iftop Not tainted 3.10.13 #2
[ 2671.994859] task: c4b22220 ti: c7ff8000 task.ti: c477e000
[ 2672.000250] NIP: c018c7a0 LR: c018c794 CTR: c000b070
[ 2672.005206] REGS: c7ff9f10 TRAP: 3202   Not tainted  (3.10.13)
[ 2672.011028] MSR: 00029000 <CE,EE,ME>  CR: 48000024  XER: 20000000
[ 2672.017125]=20
GPR00: 000000ff c477fde0 c4b22220 00000000 00000000 000000ff 00000000 70000=
000=20
GPR08: ffffffff 00000008 00000000 ffffffff 00000046 10022248 00000000 00000=
008=20
GPR16: c781b3c0 c781b3c0 000000ff 00000000 00000001 0000021c 00000086 fffff=
800=20
GPR24: c7980300 00000000 00000001 00000040 00000003 c4b33000 00000000 00000=
001=20
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
[ 2672.101338] 7f8f2040 419cfcc4 80900000 38a00000 8061004c 7e118378 81c100=
50 7ffafb78=20
[ 2672.109092] 4bf9eaa1 83810034 7c7e1b78 8361003c <83210038> 83a1004c 4800=
0060 41a2004c
[ 2672.117021] ---[ end trace 565fb54528d305fa ]---
[ 2672.121628]=20
[ 2673.103130] Kernel panic - not syncing: Fatal exception in interrupt
[ 2673.109474] Rebooting in 3 seconds..

U-Boot 2010.12-svn15934 (Dec 11 2012 - 16:23:49)
[/code]


A cross-gdb lookup to gianfar.o shows that the problem appier in function "=
gfar_poll"

[code]
./gdb ../../../target-powerpc_uClibc-0.9.33.2/linux-mpc85xx_generic/linux-3=
.10.12/drivers/net/ethernet/freescale/gianfar.o

This GDB was configured as "--host=3Dx86_64-linux-gnu --target=3Dpowerpc-op=
enwrt-linux-uclibcspe".
For bug reporting instructions, please see:
<[url]http://bugs.launchpad.net/gdb-linaro/[/url]>...
Reading symbols from /home/thomas/BB-evernet/build_dir/target-powerpc_uClib=
c-0.9.33.2/linux-mpc85xx_generic/linux-3.10.12/drivers/net/ethernet/freesca=
le/gianfar.o...done.
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


The changes from Linux kernel 3.8, which seems to have proper working ehter=
net, to the current 3.10 seem to intruduce a bug in the GIANFAR driver: dri=
vers/net/ethernet/freescale/gianfra.c
There were different changes in the NAPI of gianfar driver made between the=
 two kernel versions.=20
You can have a look at them by doin a "git whatchanged -p v3.8..v3.10 drive=
rs/net/ethernet/freescale/gianfar.c" in a recent Linux kernel verion.

[b]So let us all have a look to those changes to find the bug !!![/b]

Probably the maintainer of the gianfar driver should be included here. Clau=
diu Manoil <claudiu.manoil@freescale.com>


So far from troubleshooting.

Greetings Bluse=
