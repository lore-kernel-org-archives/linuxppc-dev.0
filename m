Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 78A432C00EF
 for <linuxppc-dev@ozlabs.org>; Sat, 23 Nov 2013 11:44:08 +1100 (EST)
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net
 [192.168.8.180])
 by mail-out.m-online.net (Postfix) with ESMTP id 3dRG3R2tfZz3hhy0
 for <linuxppc-dev@ozlabs.org>; Sat, 23 Nov 2013 01:44:02 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 3dRG3Q4ML5zbbbs
 for <linuxppc-dev@ozlabs.org>; Sat, 23 Nov 2013 01:44:02 +0100 (CET)
Received: from mail.mnet-online.de ([192.168.8.180])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new,
 port 10024) with ESMTP id hMkal6X3PV2t for <linuxppc-dev@ozlabs.org>;
 Sat, 23 Nov 2013 01:44:01 +0100 (CET)
Received: from igel.home (ppp-88-217-33-186.dynamic.mnet-online.de
 [88.217.33.186]) by mail.mnet-online.de (Postfix) with ESMTPA
 for <linuxppc-dev@ozlabs.org>; Sat, 23 Nov 2013 01:44:01 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Subject: eth0: hw csum failure
Date: Sat, 23 Nov 2013 01:44:00 +0100
Message-ID: <87d2ls54mn.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I get a lot of "eth0: hw csum failure" with 3.13-rc1 on my G5.

eth0: hw csum failure
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.13.0-rc1 #1
Call Trace:
[c00000000ffef1d0] [c00000000000f97c] .show_stack+0x60/0x14c (unreliable)
[c00000000ffef2a0] [c00000000069fad8] .dump_stack+0x80/0xa0
[c00000000ffef320] [c000000000552bc0] .netdev_rx_csum_fault+0x4c/0x58
[c00000000ffef3a0] [c000000000546f88] .__skb_checksum_complete_head+0x54/0x78
[c00000000ffef420] [c0000000005f1118] .nf_ip_checksum+0xf4/0x100
[c00000000ffef4b0] [c00000000058e520] .udp_error+0x198/0x210
[c00000000ffef560] [c000000000587694] .nf_conntrack_in+0x14c/0xa20
[c00000000ffef690] [c0000000005f195c] .ipv4_conntrack_in+0x24/0x38
[c00000000ffef700] [c00000000058343c] .nf_iterate+0x64/0xb4
[c00000000ffef7c0] [c00000000058353c] .nf_hook_slow+0xb0/0x188
[c00000000ffef890] [c00000000059ea9c] .ip_rcv+0x390/0x3f0
[c00000000ffef930] [c000000000551578] .__netif_receive_skb_core+0x8c4/0x964
[c00000000ffefa30] [c000000000551c38] .netif_receive_skb+0xb0/0x130
[c00000000ffefae0] [c000000000552740] .napi_gro_receive+0x50/0xc0
[c00000000ffefb60] [c000000000447754] .gem_poll+0x10f0/0x1328
[c00000000ffefcc0] [c000000000552418] .net_rx_action+0xd8/0x240
[c00000000ffefd90] [c00000000004dfc4] .__do_softirq+0x158/0x2c0
[c00000000ffefea0] [c00000000004e448] .irq_exit+0x6c/0xc4
[c00000000ffeff10] [c00000000000ce14] .__do_irq+0xec/0xf8
[c00000000ffeff90] [c000000000019474] .call_do_irq+0x14/0x24
[c0000001f615ba30] [c00000000000cea0] .do_IRQ+0x80/0xc0
[c0000001f615bac0] [c0000000000024b8] hardware_interrupt_common+0x138/0x180
--- Exception: 501 at .arch_cpu_idle+0x78/0x124
    LR = .arch_cpu_idle+0x78/0x124
[c0000001f615bdb0] [c0000000000a3af4] .rcu_idle_enter+0x98/0xb8 (unreliable)
[c0000001f615be30] [c00000000009a978] .cpu_startup_entry+0x110/0x1a0
[c0000001f615bee0] [c00000000001f14c] .start_secondary+0x288/0x290
[c0000001f615bf90] [c0000000000087fc] .start_secondary_prolog+0x10/0x14

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
