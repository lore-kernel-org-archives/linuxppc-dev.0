Message-ID: <3CD36741.2FEFB8B@kegel.com>
Date: Fri, 03 May 2002 21:44:49 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: khttpd stability circa 2.4.17?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
I have a kernel retrieved with
 bk clone -r1.779 bk://ppc.bkserver.net/linuxppc_2_4_devel linuxppc_2_4_devel-2.4.17
and then patched with a bunch of odd patches needed for our application.
It's running on ppc405's and ppc750's, and seems
to work ok until you fire up khttpd, hit port 80 with traffic, and cycle
khttpd up and down.  I don't know if this is because of our patches or
not; has anyone here done any stress testing of khttpd?
If so, have you seen any oopses?

My patched kernel has a fairly repeatable oops.  Here it is,
as analysed by the ksymoops that comes with hardhat 2.0 journeyman
(just in case this *isn't* caused by our patches):

ksymoops 2.4.1 on i686 2.4.18-dan.  Options used
     -V (default)
     -K (default)
     -L (default)
     -O (default)
     -m System.map (specified)

Oops: kernel access of bad area, sig: 11
NIP: C00AC718 XER: 00000000 LR: C00ADCE0 SP: C2E5BB50 REGS: c2e5ba90 TRAP: 0800
Using defaults from ksymoops -t elf32-little -a unknown
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c2e5a000[435] 'ixia_load' Last syscall: 102
last math 00000000 last altivec 00000000
GPR00: 00007F00 C2E5BB50 C2E5A000 C0100000 C2E5BB78 000004B0 7F000001 7F000001
GPR08: 04B00050 00000738 C2993000 007F007B 0003C053 10028860 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 00000E8C 0000012B C01162A0
GPR24: 0000012C C010F1E4 00000000 C29780C8 C29781D8 C2E5BB78 C2993738 68796A6B
Call backtrace:
00000000 C00ADCE0 C00AE068 C00AE5E8 C0092BA8 C0093040 C008423C
C00144E4 C0083AB4 C0095AC0 C0095F30 C00A6EA0 C00A9980 C00AC674
C00BAFA8 C007C814 C007D2A4 C00028DC 10026238 0FFD6A10 10006028
100059C0 1000357C 10003F28 100042D0 100048F4 0FE9EDBC 00000000
Kernel panic: Aiee, killing interrupt handler!
Warning (Oops_read): Code line not seen, dumping what data is available

>>???; c00ac718 <tcp_v4_search_req+48/c8>   <=====
Trace; 00000000 Before first symbol
Trace; c00adce0 <tcp_v4_hnd_req+38/1f0>
Trace; c00ae068 <tcp_v4_do_rcv+c8/180>
Trace; c00ae5e8 <tcp_v4_rcv+4c8/7a8>
Trace; c0092ba8 <ip_local_deliver+158/218>
Trace; c0093040 <ip_rcv+3d8/48c>
Trace; c008423c <net_rx_action+214/34c>
Trace; c00144e4 <do_softirq+88/100>
Trace; c0083ab4 <dev_queue_xmit+250/340>
Trace; c0095ac0 <ip_output+110/178>
Trace; c0095f30 <ip_queue_xmit+408/594>
Trace; c00a6ea0 <tcp_transmit_skb+52c/618>
Trace; c00a9980 <tcp_connect+490/608>
Trace; c00ac674 <tcp_v4_connect+318/374>
Trace; c00bafa8 <inet_stream_connect+158/2f8>
Trace; c007c814 <sys_connect+68/8c>
Trace; c007d2a4 <sys_socketcall+f0/1e0>
Trace; c00028dc <ret_from_syscall_1+0/b4>
Trace; 10026238 Before first symbol

Suggestions welcome.
- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
