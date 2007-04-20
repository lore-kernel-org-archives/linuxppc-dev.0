Return-Path: <matvejchikov@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 33B02DDE18
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Apr 2007 23:05:48 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id p76so784225pyb
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Apr 2007 06:05:43 -0700 (PDT)
Message-ID: <8496f91a0704200605t34900bdfi50fc9d82b8b0cd21@mail.gmail.com>
Date: Fri, 20 Apr 2007 17:05:43 +0400
From: "Matvejchikov Ilya" <matvejchikov@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: kernel 2.6.20 panic
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: matvejchikov@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Good day!

My system is : mpc8260 + FCC1(LAN), FCC2(FIBER), FCC3(FIBER) + 2.6.20
+ bridging.
I have a problem... :( Is anybody can tell me where to dig?

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- - - - - - - - - - - - - - - - - - - - -
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc0046978
Oops: Kernel access of bad area, sig: 11 [#1]

Modules linked in:
NIP: C0046978 LR: C00FFED0 CTR: C0146E30
REGS: c01cdc40 TRAP: 0300   Not tainted  (2.6.20ppc)
MSR: 00009032 <EE,ME,IR,DR>  CR: 28002024  XER: 20000000
DAR: 00000000, DSISR: 20000000
TASK = c01bc110[0] 'swapper' THREAD: c01cc000
GPR00: C00FFED0 C01CDCF0 C01BC110 00000000 C0163CC0 0000A9E3 00000000 00000000
GPR08: 00600800 00000004 00000000 C01CC000 28002028 00404002 00FFB000 007FFC13
GPR16: 00000001 00000000 FFFFFFFF 00800000 00FF5EAC 00000000 C01C0000 C01CDE48
GPR24: FFFF46B8 C01EA244 C01EA4C0 FFFFFFFF C0F6B000 C0E7CC00 C0E7CC00 00000001
NIP [C0046978] put_page+0x14/0x110
LR [C00FFED0] skb_release_data+0xb0/0xc4
Call Trace:
[C01CDCF0] [C003D600] handle_edge_irq+0xe4/0x1a8 (unreliable)
[C01CDD00] [C00FFED0] skb_release_data+0xb0/0xc4
[C01CDD10] [C00FFBD0] kfree_skbmem+0x18/0xf4
[C01CDD20] [C010606C] dev_hard_start_xmit+0x17c/0x29c
[C01CDD40] [C0114178] __qdisc_run+0x9c/0x1b8
[C01CDD70] [C0108350] dev_queue_xmit+0x168/0x298
[C01CDD90] [C0155A74] br_dev_queue_push_xmit+0x78/0xc4
[C01CDDA0] [C01567C8] br_handle_frame_finish+0x13c/0x154
[C01CDDC0] [C0156924] br_handle_frame+0x144/0x190
--- Exception: c01cdea0 at 0xff5eac
    LR = 0xc01e0000
[C01CDDE0] [C0105BC8] netif_receive_skb+0x1b8/0x354 (unreliable)
[C01CDE10] [C0107954] process_backlog+0xa0/0x180
[C01CDE40] [C0107ACC] net_rx_action+0x98/0x18c
[C01CDE70] [C001F43C] __do_softirq+0x80/0xf4
[C01CDEA0] [C0006158] do_softirq+0x58/0x5c
[C01CDEB0] [C001F1D4] irq_exit+0x48/0x58
[C01CDEC0] [C0006204] do_IRQ+0xa8/0xc8
[C01CDED0] [C000F5DC] ret_from_except+0x0/0x14
--- Exception: 501 at cpu_idle+0xa0/0xe8
    LR = cpu_idle+0xa0/0xe8
[C01CDF90] [C0008EC0] cpu_idle+0xd8/0xe8 (unreliable)
[C01CDFB0] [C0003B9C] rest_init+0x28/0x38
[C01CDFC0] [C01A06B4] start_kernel+0x1b8/0x238
[C01CDFF0] [00003438] 0x3438
Instruction dump:
90010014 4bffff8d 38600000 80010014 38210010 7c0803a6 4e800020 9421fff0
7c0802a6 7c671b78 39230004 90010014 <80030000> 700b4000 408200e4 7c004828
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 <0>Rebooting in 180 seconds..

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- - - - - - - - - - - - - - - - - - - - - - - - - - - -

Best Regards,
Matvejchikov Ilya.
