Return-Path: <john.p.price@l-3com.com>
Received: from smtp2out.l-3com.com (smtp2out.l-3com.com [166.20.51.112])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ironport2.l-3com.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 63933B7BBF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 00:54:14 +1100 (EST)
From: john.p.price@l-3com.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Network Stack SKB Reallocation
Date: Tue, 27 Oct 2009 09:43:24 -0400
Message-ID: <B9639434CFA424438117913649CDB78710729A20@MA_EXCHANGE.corp.sds.l-3com.com>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0330BEB38D@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330BEB38D@midas.usurf.usu.edu>
To: "Jonathan Haws" <Jonathan.Haws@sdl.usu.edu>,
	<linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jonathan, I've read your post with great interest.

I have a custom board with custom fpga's connected to the PPC405EX EBC
bus on banks 2 and 3.  Running linux 2.6.29.1.  The board collects data
and dma's it to a scatter-gather dma buffer and then uses TCP/writev +
Ethernet 9KB Jumbo packets to transmit data off of the board.

Our systems have 7 of these data collection boards, we are seeing the
following stack trace, the boards do not crash apparently the just
continue to run.

~ # BUG: Bad page state in process dcb  pfn:080db
page:c03d2b60 flags:00044000 count:0 mapcount:0 mapping:(null)
index:3718
Call Trace:
[ce871980] [c0006bc0] show_stack+0x44/0x16c (unreliable)
[ce8719c0] [c005374c] bad_page+0x94/0x12c
[ce8719e0] [c0053c30] __free_pages_ok+0x364/0x3ec
[ce871a20] [c0057c00] put_compound_page+0x48/0x60
[ce871a30] [c0075520] kfree+0xd4/0xd8
[ce871a40] [c0175140] skb_release_data+0x80/0xc8
[ce871a50] [c0174f30] __kfree_skb+0x18/0xe8
[ce871a60] [c01ab9e4] tcp_ack+0x48c/0x1a84
[ce871af0] [c01add8c] tcp_rcv_state_process+0x70/0x9ac
[ce871b10] [c01b47fc] tcp_v4_do_rcv+0x9c/0x1a8
[ce871b40] [c01b6328] tcp_v4_rcv+0x4d4/0x5b8
[ce871b70] [c0198b90] ip_local_deliver+0x90/0x140
[ce871b90] [c0198f24] ip_rcv+0x2e4/0x4bc


The above occurs on at least one of the seven boards over the course of
a multi-day run.

Another trace from an actual crash, occurs not so often;

DCB: tcp connection request accepted - line length: 18168
Unable to handle kernel paging request for data at address 0x0004009c
Faulting instruction address: 0xc017500c
Oops: Kernel access of bad area, sig: 11 [#1]
DCB
Modules linked in: ds3b3 dma ds3b2
NIP: c017500c LR: c01351f8 CTR: c013513c
REGS: cd779aa0 TRAP: 0300   Not tainted  (2.6.29.1)
MSR: 00029030 <EE,ME,CE,IR,DR>  CR: 42424024  XER: 2000005f
DEAR: 0004009c, ESR: 00000000
TASK =3D ce8883f0[770] 'dcb' THREAD: cd778000
GPR00: 00000060 cd779b50 ce8883f0 00040000 00000020 c001220c 00000001
00000014=20
GPR08: 00000002 0004009c 00000003 000000c0 22424022 10183238 000022f4
00000001=20
GPR16: 00000020 000022f4 000237c0 00000000 cd6590e4 13511000 00000008
bfe9d520=20
GPR24: ce8e2c34 ce8e2c2c ce811ce0 00000001 00000018 ce811360 00000300
ce8113c0=20
NIP [c017500c] kfree_skb+0xc/0x38
LR [c01351f8] emac_poll_tx+0xbc/0x310
Call Trace:
[cd779b50] [c001220c] __mtdcr_table+0x0/0x3ff8 (unreliable)
[cd779b70] [c0132248] mal_poll+0x44/0x1c8
[cd779ba0] [c017fb10] net_rx_action+0x94/0x188
[cd779bd0] [c0024740] __do_softirq+0x84/0x124
[cd779c00] [c0004f10] do_softirq+0x58/0x5c
[cd779c10] [c00245b0] irq_exit+0x48/0x58
[cd779c20] [c0004fb4] do_IRQ+0xa0/0xc4
[cd779c40] [c000eba0] ret_from_except+0x0/0x18
[cd779d00] [c01a4ec0] tcp_sendmsg+0x220/0xbf0
[cd779d80] [c016dd18] sock_aio_write+0xf0/0x104
[cd779de0] [c007a5b0] do_sync_readv_writev+0xbc/0x130
[cd779e90] [c007ae54] do_readv_writev+0xb4/0x1c4
[cd779f10] [c007b010] sys_writev+0x4c/0x90
[cd779f40] [c000e558] ret_from_syscall+0x0/0x3c
Instruction dump:
3d20c02b 80695ac4 7fe4fb78 4bf00fb9 80010014 83e1000c 7c0803a6 38210010=20
4e800020 2c030000 4d820020 3923009c <8003009c> 2f800001 409e0008
4bffff00=20
Kernel panic - not syncing: Fatal exception in interrupt
Rebooting in 1 seconds..


So the questions I have for you are as follows;

	1. Do either of these trace appear related to the issue your
driver patch will fix?

	2. If I set path MTU to 1500, will that avoid the issue?=20

	3. Would you have any further suggestions?

thanks



-----Original Message-----
From: linuxppc-dev-bounces+john.p.price=3Dl-3com.com@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+john.p.price=3Dl-3com.com@lists.ozlabs.org]
On Behalf Of Jonathan Haws
Sent: Monday, October 26, 2009 2:43 PM
To: linuxppc-dev@lists.ozlabs.org
Subject: Network Stack SKB Reallocation

Quick question about the network stack in general:

Does the stack itself release an SKB allocated by the device driver back
to the heap upstream, or does it require that the device driver handle
that?

Thanks!

Jonathan


_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
