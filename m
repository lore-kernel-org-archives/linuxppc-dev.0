Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 718EB679E6
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2006 03:32:53 +1000 (EST)
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 2E6D31D921
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2006 19:32:47 +0200 (CEST)
Date: Mon, 24 Apr 2006 19:32:46 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: alignment exceptionhandler sleeps in invalid context
Message-ID: <20060424173246.GA22318@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I'm not sure where the bug is. Does it mean the network stack does
something nasty, or is the exception handler itself broken? (probably the latter)
This is 2.6.16.9 on a p270.

<3>Debug: sleeping function called from invalid context at arch/powerpc/kernel/align.c:440
<4>in_atomic():1, irqs_disabled():0
<4>Call Trace:
<4>[C00000000FFE6D10] [C00000000000EE20] .show_stack+0x68/0x1b0 (unreliable)
<4>[C00000000FFE6DB0] [C000000000054248] .__might_sleep+0xd8/0xf4
<4>[C00000000FFE6E30] [C00000000000C490] .fix_alignment+0x50c/0x9c8
<4>[C00000000FFE6F10] [C000000000024E20] .alignment_exception+0x18/0xc8
<4>[C00000000FFE6F90] [C00000000000430C] alignment_common+0x10c/0x180
<4>--- Exception: 600 at .csum_partial+0x34/0x9c
<4>    LR = .skb_checksum+0x194/0x35c
<4>[C00000000FFE7280] [D00000000033F3D0] 0xd00000000033f3d0 (unreliable)
<4>[C00000000FFE7340] [C0000000002EB558] .skb_checksum_help+0x98/0x124
<4>[C00000000FFE73D0] [D000000000330748] .ip_nat_fn+0x84/0x278 [iptable_nat]
<4>[C00000000FFE7490] [D000000000330C34] .ip_nat_local_fn+0x40/0xec [iptable_nat]
<4>[C00000000FFE7520] [C00000000030DAE0] .nf_iterate+0x80/0x11c
<4>[C00000000FFE75E0] [C00000000030DEC8] .nf_hook_slow+0x8c/0x17c
<4>[C00000000FFE76B0] [C00000000031D2B0] .ip_queue_xmit+0x4bc/0x5d0
<4>[C00000000FFE7800] [C00000000032FBA0] .tcp_transmit_skb+0x7d8/0x844
<4>[C00000000FFE78B0] [C0000000003318F0] .__tcp_push_pending_frames+0x2d4/0x3fc
<4>[C00000000FFE7970] [C00000000032EAD4] .tcp_rcv_established+0x894/0x964
<4>[C00000000FFE7A20] [C0000000003355C8] .tcp_v4_do_rcv+0x5c/0x48c
<4>[C00000000FFE7AF0] [C000000000338A48] .tcp_v4_rcv+0xc78/0xcfc
<4>[C00000000FFE7BC0] [C000000000316310] .ip_local_deliver+0x208/0x36c
<4>[C00000000FFE7C50] [C000000000316024] .ip_rcv+0x600/0x6e4
<4>[C00000000FFE7CF0] [C0000000002EBB34] .netif_receive_skb+0x500/0x598
<4>[C00000000FFE7D90] [C0000000002EE37C] .process_backlog+0xcc/0x1c8
<4>[C00000000FFE7E40] [C0000000002EE55C] .net_rx_action+0xe4/0x230
<4>[C00000000FFE7EF0] [C000000000066524] .__do_softirq+0x98/0x164
<4>[C00000000FFE7F90] [C000000000025854] .call_do_softirq+0x14/0x24
<4>[C0000003BA3C3370] [C00000000000BCC8] .do_softirq+0x8c/0xd8
<4>[C0000003BA3C3400] [C0000000000663E4] .local_bh_enable+0x58/0x8c
<4>[C0000003BA3C3480] [C0000000002EEA34] .dev_queue_xmit+0x2f0/0x318
<4>[C0000003BA3C3510] [C00000000031CA60] .ip_output+0x348/0x3f0
<4>[C0000003BA3C35B0] [C00000000031D2E0] .ip_queue_xmit+0x4ec/0x5d0
<4>[C0000003BA3C3700] [C00000000032FBA0] .tcp_transmit_skb+0x7d8/0x844
<4>[C0000003BA3C37B0] [C0000000003231A8] .tcp_cleanup_rbuf+0x148/0x168
<4>[C0000003BA3C3840] [C000000000325B24] .tcp_recvmsg+0x8a8/0xa00
<4>[C0000003BA3C3930] [C0000000002E0C64] .sock_common_recvmsg+0x5c/0x84
<4>[C0000003BA3C39C0] [C0000000002DD408] .do_sock_read+0x120/0x14c
<4>[C0000003BA3C3A60] [C0000000002DF034] .sock_aio_read+0x58/0x74
<4>[C0000003BA3C3B70] [C0000000000C6050] .do_sync_read+0xd4/0x130
<4>[C0000003BA3C3CF0] [C0000000000C6ECC] .vfs_read+0x134/0x1fc
<4>[C0000003BA3C3D90] [C0000000000C7390] .sys_read+0x4c/0x8c
<4>[C0000003BA3C3E30] [C00000000000871C] syscall_exit+0x0/0x40
