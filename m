Return-Path: <B08782@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E49D92C032E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 22:07:54 +1100 (EST)
Message-ID: <52568A7A.6090909@freescale.com>
Date: Thu, 10 Oct 2013 14:07:38 +0300
From: Claudiu Manoil <claudiu.manoil@freescale.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Thomas_H=FChn?= <thomas@net.t-labs.tu-berlin.de>
Subject: Re: Gianfar driver crashes in Kernel v3.10
References: <E0CAE3C8-5883-4D20-8A95-CCC88B4A811C@net.t-labs.tu-berlin.de>
In-Reply-To: <E0CAE3C8-5883-4D20-8A95-CCC88B4A811C@net.t-labs.tu-berlin.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/4/2013 3:28 PM, Thomas H=FChn wrote:
>
> [code]
> [ 2671.841927] Oops: Exception in kernel mode, sig: 5 [#1]
> [ 2671.847141] Freescale P1014
> [ 2671.849925] Modules linked in: ath9k pppoe ppp_async iptable_nat
> ath9k_common pppox p
> e xt_tcpudp xt_tcpmss xt_string xt_statistic xt_state xt_recent xt_quot=
a
> xt_pkttype xt_o
> mark xt_connbytes xt_comment xt_addrtype xt_TCPMSS xt_REDIRECT xt_NETMA=
P
> xt_LOG xt_IPMAR
> ms_datafab ums_cypress ums_alauda slhc nf_nat_tftp nf_nat_snmp_basic
> nf_nat_sip nf_nat_r
> ntrack_sip nf_conntrack_rtsp nf_conntrack_proto_gre nf_conntrack_irc
> nf_conntrack_h323 n
> compat_xtables compat ath sch_teql sch_tbf sch_sfq sch_red sch_prio
> sch_htb sch_gred sc
> skbedit act_mirred em_u32 cls_u32 cls_tcindex cls_flow cls_route cls_fw
> sch_hfsc sch_ing
> r usb_storage leds_gpio ohci_hcd ehci_platform ehci_hcd sd_mod scsi_mod
> fsl_mph_dr_of gp
> [ 2671.988946] CPU: 0 PID: 5209 Comm: iftop Not tainted 3.10.13 #2
> [ 2671.994859] task: c4b22220 ti: c7ff8000 task.ti: c477e000
> [ 2672.000250] NIP: c018c7a0 LR: c018c794 CTR: c000b070
> [ 2672.005206] REGS: c7ff9f10 TRAP: 3202   Not tainted  (3.10.13)
> [ 2672.011028] MSR: 00029000 <CE,EE,ME>  CR: 48000024  XER: 20000000
> [ 2672.017125]
> GPR00: 000000ff c477fde0 c4b22220 00000000 00000000 000000ff 00000000
> 70000000
> GPR08: ffffffff 00000008 00000000 ffffffff 00000046 10022248 00000000
> 00000008
> GPR16: c781b3c0 c781b3c0 000000ff 00000000 00000001 0000021c 00000086
> fffff800
> GPR24: c7980300 00000000 00000001 00000040 00000003 c4b33000 00000000
> 00000001
> [ 2672.046832] NIP [c018c7a0] gfar_poll+0x424/0x520
> [ 2672.051442] LR [c018c794] gfar_poll+0x418/0x520
> [ 2672.055962] Call Trace:
> [ 2672.058402] [c477fde0] [c018c674] gfar_poll+0x2f8/0x520 (unreliable)
> [ 2672.064762] [c477fe80] [c01b0ce8] net_rx_action+0x6c/0x158
> [ 2672.070249] [c477feb0] [c0027dc4] __do_softirq+0xbc/0x16c
> [ 2672.075642] [c477ff00] [c0027f7c] irq_exit+0x4c/0x68
> [ 2672.080604] [c477ff10] [c00041f8] do_IRQ+0xf4/0x10c
> [ 2672.085478] [c477ff40] [c000ca3c] ret_from_except+0x0/0x18
> [ 2672.090991] --- Exception: 501 at 0x48083c28
> [ 2672.090991]     LR =3D 0x48083bf8
> [ 2672.098378] Instruction dump:
> [ 2672.101338] 7f8f2040 419cfcc4 80900000 38a00000 8061004c 7e118378
> 81c10050 7ffafb78
> [ 2672.109092] 4bf9eaa1 83810034 7c7e1b78 8361003c <83210038> 83a1004c
> 48000060 41a2004c
> [ 2672.117021] ---[ end trace 565fb54528d305fa ]---
> [ 2672.121628]
> [ 2673.103130] Kernel panic - not syncing: Fatal exception in interrupt
> [ 2673.109474] Rebooting in 3 seconds..
>
> U-Boot 2010.12-svn15934 (Dec 11 2012 - 16:23:49)
> [/code]
>

Hi,

Does this show up on a half duplex (100Mb/s) link?
Could you provide following for the gianfar interface, on your setup:
# ethtool ethX
and
# ethtool -d ethX | grep 500

Is there any other indication before this Oops? Like a tx timeout WARN?

Thanks,
Claudiu
