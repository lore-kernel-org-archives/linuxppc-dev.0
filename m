Return-Path: <msteckly@ixiacom.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 898051007D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 01:21:12 +1000 (EST)
Received: from mail42-tx2 (localhost [127.0.0.1])	by mail42-tx2-R.bigfish.com
 (Postfix) with ESMTP id 0746E4E0487	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 26 Jun 2012 15:19:27 +0000 (UTC)
Received: from TX2EHSMHS039.bigfish.com (unknown [10.9.14.254])	by
 mail42-tx2.bigfish.com (Postfix) with ESMTP id 7E299202E5	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2012 15:19:24 +0000 (UTC)
Message-ID: <4FE9D35C.7050701@ixiacom.com>
Date: Tue, 26 Jun 2012 11:21:00 -0400
From: Michael Steckly <msteckly@ixiacom.com>
MIME-Version: 1.0
To: <linuxppc-dev@lists.ozlabs.org>
Subject: Help with Freescale DPAA bug
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm hoping someone here can help me.  Several levels of Freescale
management have assured me that I am authorized to discuss their Linux
code on public lists--and even explicitly suggested the ozlabs
linuxppc-dev list.

I'm using the P4080 processor and the Freescale SDK on a custom board. 
We've had some stability issues so I've turned on some debugging in the
DPAA (CONFIG_FSL_DPA_CHECKING) and when I enable multiple cores, the
system panics with the message:

Parallel attempts to enter bman_released() detected.
Kernel panic - not syncing: only one instance of bman_released/acquired
allowed
Call Trace:
[ede35de0] [c000812c] show_stack+0x44/0x154 (unreliable)
[ede35e20] [c0419e28] panic+0xa4/0x1d0
[ede35e70] [c0301324] bman_release+0x614/0x854
[ede35ed0] [c02e4dbc] dpa_bp_add_8+0xe0/0x1b4
[ede35f40] [c02e6eb0] dpaa_eth_poll+0x8c/0x98
[ede35f60] [c0329fd4] net_rx_action+0xc0/0x178
[ede35fa0] [c0032f78] __do_softirq+0xe8/0x174
[ede35ff0] [c000d7fc] call_do_softirq+0x14/0x24
[e90a9e80] [c00047fc] do_softirq+0x98/0xc4
[e90a9ea0] [c003328c] irq_exit+0x60/0x70
[e90a9eb0] [c00044ec] do_IRQ+0x94/0x188
[e90a9ee0] [c000f29c] ret_from_except+0x0/0x18
Parallel attempts to enter bman_released() detected.
--- Exception: 501 at cpu_idle+0x88/0xd8
    LR = cpu_idle+0x88/0xd8
Kernel panic - not syncing: only one instance of bman_released/acquired
allowed
[e90a9fa0] [c0008bb4] cpu_idle+0xd4/0xd8Call Trace:
 (unreliable)[ede1dde0] [c000812c] show_stack+0x44/0x154
 (unreliable)[e90a9fc0] [c041c5b8] start_secondary+0x2b8/0x2bc

[ede1de20] [c0419e28] panic+0xa4/0x1d0[e90a9ff0] [c0001e7c]
__secondary_start+0x30/0x84

[ede1de70] [c0301324] bman_release+0x614/0x854
[ede1ded0] [c02e4dbc] dpa_bp_add_8+0xe0/0x1b4
Rebooting in 180 seconds...

It's fairly easy to reproduce.  I just run 'watch -n1 ping -c64 -l64
<ip-on-same-subnet>' and leave it run for less than 30 seconds.

I've consulted Freescale on this, but their suggestion was to turn the
debugging option off.  While this will prevent the kernel panic, it will
not prevent multiple threads from entering the critical section at the
same time--which, according to their own code, is bad.

As far as I can tell, disabling the debug option will just turn an
explicit panic into a mysterious instability with the system that will
probably result in ethernet related issues.

I've configured the DPAA options like this:

> egrep -i '(bman|dpa)' .config
CONFIG_HAS_FSL_QBMAN=y
# CONFIG_FSL_USDPAA_SHMEM is not set
CONFIG_DPA=y
CONFIG_DPA_OFFLINE_PORTS=y
CONFIG_DPA_MAX_FRM_SIZE=1522
CONFIG_FSL_DPA_1588=m
# CONFIG_DPAA_ETH_UNIT_TESTS is not set
CONFIG_FSL_DPA=y
# Freescale Datapath QMan/BMan options
CONFIG_FSL_DPA_CHECKING=y
CONFIG_FSL_DPA_HAVE_IRQ=y
CONFIG_FSL_DPA_CAN_WAIT=y
CONFIG_FSL_DPA_CAN_WAIT_SYNC=y
CONFIG_FSL_DPA_PIRQ_FAST=y
CONFIG_FSL_DPA_PIRQ_SLOW=y
CONFIG_FSL_DPA_PORTAL_SHARE=y
CONFIG_FSL_BMAN=y
CONFIG_FSL_BMAN_PORTAL=y
CONFIG_FSL_BMAN_CONFIG=y
# CONFIG_FSL_BMAN_TEST is not set
CONFIG_FSL_QMAN_CI_SCHED_CFG_BMAN_W=2

Does anyone have any additional info/suggestions on this?

Any help would be much appreciated.  Thanks in advance.

Mike
