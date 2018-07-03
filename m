Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KdBf6YMMzF0X5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 18:51:05 +1000 (AEST)
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Oops in sock_wfree
Message-ID: <8929d3b5-5c07-b6a1-b3c8-8625ff1c79a8@c-s.fr>
Date: Tue, 3 Jul 2018 10:51:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I was having strange unexpected memory corruption, therefore I activated 
DEBUG_PAGEALLOC and I now end up with the following Oops, which tends to 
make me think we have somewhere in the network code a use-after-free 
bug. I saw a few of such bugs have been fixed for IPv4 and IPv6. Maybe 
we have one remaining for Unix sockets ? How can I spot it off and fix it ?

[   39.645644] Unable to handle kernel paging request for data at 
address 0xc2235010
[   39.652860] Faulting instruction address: 0xc0334d5c
[   39.657783] Oops: Kernel access of bad area, sig: 11 [#1]
[   39.663085] BE PREEMPT DEBUG_PAGEALLOC CMPC885
[   39.667488] SAF3000 DIE NOTIFICATION
[   39.671050] CPU: 0 PID: 269 Comm: in:imuxsock Not tainted 
4.14.52-00025-g5bada429cf #22
[   39.679633] task: c623e100 task.stack: c651e000
[   39.684106] NIP:  c0334d5c LR: c043602c CTR: c0435fb8
[   39.689103] REGS: c651fc00 TRAP: 0300   Not tainted 
(4.14.52-00025-g5bada429cf)
[   39.697087] MSR:  00009032 <EE,ME,IR,DR,RI>  CR: 28002822 XER: 20000000
[   39.703720] DAR: c2235010 DSISR: c0000000
[   39.703720] GPR00: c043602c c651fcb0 c623e100 c619eec0 c642c540 
00000008 00000018 c651fd4c
[   39.703720] GPR08: c0435fb8 000002b0 c068d830 00000004 28004822 
100d4208 00000000 77990848
[   39.703720] GPR16: 0ff58398 778eb4b0 1039f050 1039f0a8 1005ddbc 
0ff5a7bc 00000000 00000000
[   39.703720] GPR24: 00000072 c5011650 c651feb8 00000072 c619eec0 
00000040 c2234fc0 c619eec0
[   39.741401] NIP [c0334d5c] sock_wfree+0x18/0xa4
[   39.745843] LR [c043602c] unix_destruct_scm+0x74/0x88
[   39.750786] Call Trace:
[   39.753253] [c651fcb0] [c006348c] ns_to_timeval+0x4c/0x7c (unreliable)
[   39.759690] [c651fcc0] [c043602c] unix_destruct_scm+0x74/0x88
[   39.765385] [c651fcf0] [c033a10c] skb_release_head_state+0x8c/0x110
[   39.771571] [c651fd00] [c033a3c4] skb_release_all+0x18/0x50
[   39.777078] [c651fd10] [c033a7cc] consume_skb+0x38/0xec
[   39.782255] [c651fd20] [c0342d7c] skb_free_datagram+0x1c/0x68
[   39.787922] [c651fd30] [c0435c8c] unix_dgram_recvmsg+0x19c/0x4ac
[   39.793863] [c651fdb0] [c0331370] ___sys_recvmsg+0x98/0x138
[   39.799371] [c651feb0] [c0333280] __sys_recvmsg+0x40/0x84
[   39.804707] [c651ff10] [c0333680] SyS_socketcall+0xb8/0x1d4
[   39.810220] [c651ff40] [c000d1ac] ret_from_syscall+0x0/0x38
[   39.815673] Instruction dump:
[   39.818612] 41beffac 4bffff58 38800003 4bffffa0 38800001 4bffff98 
7c0802a6 9421fff0
[   39.826267] bfc10008 90010014 83c30010 812300a8 <815e0050> 3bfe00e0 
71480200 4082003c
[   39.834113] ---[ end trace 8affde0490d7e25e ]---

Thanks
Christophe
