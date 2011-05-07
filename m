Return-Path: <jignesh.patel@onrampwireless.com>
Received: from relay.ihostexchange.net (relay.ihostexchange.net [66.46.182.56])
	by ozlabs.org (Postfix) with ESMTP id 853ACB6EE6
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 May 2011 11:24:15 +1000 (EST)
Subject: ibm_newemac driver hangs while using 10Mbps full-duplex
From: Jignesh Patel <jignesh.patel@onrampwireless.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 6 May 2011 18:18:14 -0700
Message-ID: <1304731094.1702.611.camel@jpatel-desktop>
MIME-Version: 1.0
Reply-To: jignesh.patel@onrampwireless.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, 

We are using denx kernel 2.6.31.4 on ppc405ex with national
semiconductor DP83640 Ethernet transceiver.  The kernel driver
(ibm_newemac) seems to hang after setting the ethernet phy to use 10Mbps
Full-duplex settings. The time after which the driver hangs is random.

I am predicting that it's the driver issue because we cannot send or
receive any packets even though ethernet phy detects a good link and
interface is up (eth0). Bringing the interface down and back up using
ifconfig command fixes the hang and normal packet transfer continues.

Also, some times during 10Mbps operation we see following warning from
the kernel:

eth0: link is up, 10 FDX
NETDEV WATCHDOG: eth0 (emac): transmit queue 0 timed out
------------[ cut here ]------------
Badness at net/sched/sch_generic.c:246
NIP: c02094a4 LR: c02094a4 CTR: c0175af0
REGS: c03a9d00 TRAP: 0700   Not tainted  (2.6.31.4)
MSR: 00029030 <EE,ME,CE,IR,DR>  CR: 24000024  XER: 20000000
TASK = c037f440[0] 'swapper' THREAD: c03a8000
GPR00: c02094a4 c03a9db0 c037f440 0000003f 00002631 ffffffff c0175a5c
00000036
GPR08: c03b1d40 c0380000 00002631 00004000 24000082 fffffeef 0ffed700
00800000
GPR16: 00000000 007fff00 c038138c c03b0000 c0300000 c03b0000 0000000a
c03a9e18
GPR24: c0380000 c03a8000 00000000 c03b5ec8 c03b0000 c0380000 00000000
cf012000
NIP [c02094a4] dev_watchdog+0x290/0x2a0
LR [c02094a4] dev_watchdog+0x290/0x2a0
Call Trace:
[c03a9db0] [c02094a4] dev_watchdog+0x290/0x2a0 (unreliable)
[c03a9e10] [c002d60c] run_timer_softirq+0xfc/0x1b8
[c03a9e50] [c00284a8] __do_softirq+0xb0/0x130
[c03a9e90] [c0004900] do_softirq+0x58/0x5c
[c03a9ea0] [c00282bc] irq_exit+0x48/0x58
[c03a9eb0] [c000bd94] timer_interrupt+0xa4/0x108
[c03a9ed0] [c000f618] ret_from_except+0x0/0x18
[c03a9f90] [c0007eb0] cpu_idle+0xd0/0xe0
[c03a9fb0] [c0002928] rest_init+0x5c/0x6c
[c03a9fc0] [c0355738] start_kernel+0x230/0x2b8
[c03a9ff0] [c0002254] start_here+0x44/0xb0
Instruction dump:
7c0903a6 4bffff78 38810008 7fe3fb78 38a00040 4bfebc4d 7c651b78 3c60c033
7fc6f378 7fe4fb78 3863e668 4be1a415 <0fe00000> 38000001 901cfa00
4bffff14
eth0: link is down


Does anyone have an understanding of how ibm_newemac is supposed to
behave in 10Mbps Full-duplex operation? any help to solve this issue is
really appreciated

Thanks!

-Jignesh
