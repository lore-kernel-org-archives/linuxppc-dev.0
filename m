Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 265722C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 09:09:11 +1100 (EST)
Message-ID: <1381270140.7979.287.camel@snotra.buserror.net>
Subject: Re: Gianfar driver crashes in Kernel v3.10
From: Scott Wood <scottwood@freescale.com>
To: Thomas =?ISO-8859-1?Q?H=FChn?= <Thomas.Huehn@dai-labor.de>
Date: Tue, 8 Oct 2013 17:09:00 -0500
In-Reply-To: <8EF35D6A-A132-458C-A3B4-80D4D2C5BA4C@dai-labor.de>
References: <8EF35D6A-A132-458C-A3B4-80D4D2C5BA4C@dai-labor.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "claudiu.manoil@freescale.com" <claudiu.manoil@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-10-04 at 12:03 +0000, Thomas H=C3=BChn wrote:
> [code]
> [ 2671.841927] Oops: Exception in kernel mode, sig: 5 [#1]
> [ 2671.847141] Freescale P1014
> [ 2671.849925] Modules linked in: ath9k pppoe ppp_async iptable_nat ath=
9k_common pppox p
> e xt_tcpudp xt_tcpmss xt_string xt_statistic xt_state xt_recent xt_quot=
a xt_pkttype xt_o
> mark xt_connbytes xt_comment xt_addrtype xt_TCPMSS xt_REDIRECT xt_NETMA=
P xt_LOG xt_IPMAR
> ms_datafab ums_cypress ums_alauda slhc nf_nat_tftp nf_nat_snmp_basic nf=
_nat_sip nf_nat_r
> ntrack_sip nf_conntrack_rtsp nf_conntrack_proto_gre nf_conntrack_irc nf=
_conntrack_h323 n
>  compat_xtables compat ath sch_teql sch_tbf sch_sfq sch_red sch_prio sc=
h_htb sch_gred sc
> skbedit act_mirred em_u32 cls_u32 cls_tcindex cls_flow cls_route cls_fw=
 sch_hfsc sch_ing
> r usb_storage leds_gpio ohci_hcd ehci_platform ehci_hcd sd_mod scsi_mod=
 fsl_mph_dr_of gp
> [ 2671.988946] CPU: 0 PID: 5209 Comm: iftop Not tainted 3.10.13 #2
> [ 2671.994859] task: c4b22220 ti: c7ff8000 task.ti: c477e000
> [ 2672.000250] NIP: c018c7a0 LR: c018c794 CTR: c000b070
> [ 2672.005206] REGS: c7ff9f10 TRAP: 3202   Not tainted  (3.10.13)

Trap 0x3202 is a watchdog timer.

Did you get a "Bad trap at..." line before the above dump?  Do you have
any idea why the watchdog would have been armed without CONFIG_BOOKE_WDT
being set?  Is CONFIG_BOOKE_WDT set?

-Scott
