Return-Path: <mlcreech@gmail.com>
Received: from mail-vx0-f170.google.com (mail-vx0-f170.google.com
	[209.85.220.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2CD70B6F54
	for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2011 07:37:08 +1000 (EST)
Received: by vxb40 with SMTP id 40so972804vxb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 11 May 2011 14:37:04 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 11 May 2011 17:37:04 -0400
Message-ID: <BANLkTikp5yVgrCe7tbc4cvG5wvy7XJp2fQ@mail.gmail.com>
Subject: fsl_udc_core: BUG: scheduling while atomic
From: "Matthew L. Creech" <mlcreech@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

My MPC8313-based board, running a 2.6.37 kernel, is occasionally
hitting this bug while doing RNDIS-based communication:

BUG: scheduling while atomic: lighttpd/1145/0x10000200
Call Trace:
[c6a8b910] [c00086c0] show_stack+0x7c/0x194 (unreliable)
[c6a8b950] [c0019e28] __schedule_bug+0x54/0x68
[c6a8b960] [c02b04e8] schedule+0xa4/0x408
[c6a8ba50] [c02b0988] _cond_resched+0x38/0x64
[c6a8ba60] [c0080e8c] dma_pool_alloc+0x5c/0x2a4
[c6a8bac0] [c01c57b0] fsl_req_to_dtd+0x68/0x24c
[c6a8bb00] [c01c5b68] fsl_ep_queue+0x1d4/0x264
[c6a8bb20] [c01c7eec] eth_start_xmit+0x278/0x344
[c6a8bb50] [c01fdbc8] dev_hard_start_xmit+0x520/0x680
[c6a8bba0] [c02122a4] sch_direct_xmit+0x68/0x1e0
[c6a8bbc0] [c01fdf20] dev_queue_xmit+0x1f8/0x3c4
[c6a8bbe0] [c022d684] ip_finish_output+0x2d4/0x328
[c6a8bc10] [c022db08] ip_local_out+0x38/0x4c
[c6a8bc20] [c022e3cc] ip_queue_xmit+0x2cc/0x360
[c6a8bca0] [c0241844] tcp_transmit_skb+0x7cc/0x838
[c6a8bd00] [c0244434] tcp_write_xmit+0x8c4/0xa34
[c6a8bd60] [c0237618] tcp_sendmsg+0x900/0xbd4
[c6a8bdd0] [c0256088] inet_sendmsg+0x74/0x8c
[c6a8bdf0] [c01ea498] sock_aio_write+0x130/0x14c
[c6a8be50] [c00855fc] do_sync_write+0xb0/0x110
[c6a8bef0] [c0086294] vfs_write+0xdc/0x17c
[c6a8bf10] [c008642c] sys_write+0x54/0x9c
[c6a8bf40] [c000f2cc] ret_from_syscall+0x0/0x38

This seems similar to a bug from 2010:

http://www.spinics.net/lists/linux-usb/msg31354.html

which concludes that the fsl_udc_core driver is wrongly using
GFP_KERNEL in fsl_build_dtd().  However I'm not sure what an
appropriate fix is, since just replacing it with GFP_ATOMIC causes
allocation failures.  Any helpful tips?

Thanks

-- 
Matthew L. Creech
