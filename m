Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [194.246.123.103])
 by ozlabs.org (Postfix) with ESMTP id 03E3FB6F65
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2011 19:50:38 +1100 (EST)
Date: Tue, 15 Nov 2011 00:44:19 -0800 (PST)
From: Christian Kujau <lists@nerdbynature.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 3.2.0-rc1 panic on PowerPC
Message-ID: <alpine.DEB.2.01.1111150035560.8000@trent.utfs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I noticed a few crashes on this PowerBook G4 lately, starting somewhere in 
3.2.0-rc1. The crashes are really rare and as I'm not on the system all 
the time I did not notice most of them. By the time I did, the screen was 
blank already and I had to hard-reset the box. But not this time:

  http://nerdbynature.de/bits/3.2.0-rc1/oops/

When the crash occured, the system was failry loaded (CPU and disk I/O 
wise), so that may have triggered it. I tried to type off the stack trace, 
I hope there are not too many typos, see below.

The machine is fairly old, so maybe it's "just" bad RAM or something, I 
wouldn't be suprised. But maybe not, the box us pretty stable most of the 
time and only now I notice these rare crashes.

If anyone could take a quick look...?

Thank you,
Christian.

Instruction dump:
92c40008 68000001 0f000000 80040000 5400003c 90040000 817f000c 380bffff
901f000c 2f090000 81640018 81440014 <916a0004> 914b0000 92840014 92a49918
Kernel panic - not syncing: Fatal exception in interrupt
Call Trace:
show_stack+0x70/0x1bc (unreliable)
panic+0xc8/0x220
die+0x2ac/0x2b8
bad_page_fault+0xbc/0x104
handle_page_fault+0x7c/0x80
Exception: 300 at T.975+0x3f4/0x570
LR = T.957+0x300/0x570
kmem_cache_alloc+0x150/0x150
__aloc_skb+0x50/0x148
tcp_send_ack+0x35/0x138
tcp_delay_timer+0x140/0x244
run_timer_softirq+0x1a0/0x2ec
__do_softirq+0xf4/0x1bc
call_do_softirq+0x14/0x24
do_softirq+0xfc/0x128
irq_exit+0xa0/0xa4
timer_interrupt+0x148/0x180
ret_from_except+0x0/0x14
cpu_idle+0xa0/0x118
rest_init+0xf0/0x114
start_kernel+0x2d0/0x2f0
0x3444
Rebooting in 180 seconds..

-- 
BOFH excuse #184:

loop found in loop in redundant loopback
