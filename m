Return-Path: <jvan_1@students.concordia.ca>
Message-ID: <1108746180.42161fc4a86f6@webmail.cam.org>
Date: Fri, 18 Feb 2005 12:03:00 -0500
From: Philip Van-Houtte <jvan_1@students.concordia.ca>
To: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: oops in process_backlog : kernel 2.6.9
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I have an embedded application, running a stock kernel 2.6.9, on an 8240 
receiving UDP. Occasionaly after a (re)boot the system will oops after 
opening (socket/bind) its first connection just as the traffic comes in.

It always occurs after the call to netif_receive_skb has competed.


Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: C021FD14 LR: C021FCB4 SP: C3049C70 REGS: c3049bc0 TRAP: 0300    Tainted: P
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00003CAE, DSISR: 20000000
TASK = c309d050[162] 'rtp_daemon' THREAD: c3048000Last syscall: 102
GPR00: 00001032 C3049C70 C309D050 00000000 C3049B50 00000000 00000000 C5023E04
GPR08: 00000002 0000000D 00000000 C036496C 2010C002 00000000 037FB000 038D0000
GPR16: 00002020 00000000 10000000 7FFFF960 00000001 00000000 C0300000 C3049CB8
GPR24: FFFBDE37 C0364960 C0364988 00000040 00000000 C0429800 00000001 C036496C
NIP [c021fd14] process_backlog+0x108/0x188
LR [c021fcb4] process_backlog+0xa8/0x188
Call trace:
 [c021fe2c] net_rx_action+0x98/0x178
 [c011fdd0] __do_softirq+0xdc/0xec
 [c011fe38] do_softirq+0x58/0x5c
 [c0106188] do_IRQ+0xdc/0xe0
 [c01048ec] ret_from_except+0x0/0x14
 [c0217f68] lock_sock+0x6c/0x84
 [c02152ac] sys_bind+0x70/0x94
 [c0215f58] sys_socketcall+0xc8/0x1d8
 [c0104240] ret_from_syscall+0x0/0x44
Kernel panic - not syncing: Aiee, killing interrupt handler!
 <0>Rebooting in 180 seconds..


Any insights/work-arounds/ would be appreciated.
