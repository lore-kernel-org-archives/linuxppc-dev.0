Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EFFC1B6ED0
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Mar 2010 21:30:15 +1100 (EST)
Received: from sesr04.transmode.se (sesr04.transmode.se [192.168.201.15])
	by gw1.transmode.se (Postfix) with ESMTP id 231F4650009
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Mar 2010 11:30:10 +0100 (CET)
Subject: Strange OOPS in 2.6.33
To: linuxppc-dev@ozlabs.org
Message-ID: <OFCCEB0071.2A524538-ONC12576DC.00390771-C12576DC.0039ACAE@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 4 Mar 2010 11:29:57 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Got this OOPS a few times after coldstarting out
board a few times:

Unable to handle kernel paging request for unknown fault
Faulting instruction address: 0xc020e2b4
Oops: Kernel access of bad area, sig: 11 [#1]
TMCUTU
Modules linked in:
NIP: c020e2b4 LR: c020e274 CTR: 00000000
REGS: c7a41b40 TRAP: 0600   Not tainted  (2.6.33)
MSR: 00009032 <EE,ME,IR,DR>  CR: 28002424  XER: 00000000
DAR: 09f52312, DSISR: 00000120
TASK = c7889940[420] 'syslogd' THREAD: c7a40000
GPR00: 09f52312 c7a41bf0 c7889940 00000000 00000002 c7a41c40 c02734ac c78acc68
GPR08: c7a41c00 c78acc00 00000000 09f5214b c796e3d4 1001f444 00000000 bfe78700
GPR16: bfe77400 bfe77ee0 bfe773f8 00000021 0ffef130 00000000 c7a41df0 00000000
GPR24: 00000000 c7a41cf0 c7a41c70 00000011 7f000001 09f5214a c034a5cc c7a41c00
NIP [c020e2b4] ip_dev_find+0x90/0xf0
LR [c020e274] ip_dev_find+0x50/0xf0
Call Trace:
[c7a41bf0] [c020e274] ip_dev_find+0x50/0xf0 (unreliable)
[c7a41c60] [c01dd86c] __ip_route_output_key+0x8d4/0xb00
[c7a41d50] [c01ddab8] ip_route_output_flow+0x1c/0xa0
[c7a41d60] [c01ff8a0] ip4_datagram_connect+0x17c/0x2b8
[c7a41e30] [c020a75c] inet_dgram_connect+0x5c/0xa8
[c7a41e50] [c01a5030] sys_connect+0x7c/0xcc
[c7a41f00] [c01a6008] sys_socketcall+0x128/0x214
[c7a41f40] [c0011800] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff6e004
    LR = 0xfe2dac0
Instruction dump:
bb810060 38210070 7c0803a6 4e800020 88010052 2f800002 409e0028 81210054
83a90068 2f9d0000 419e0018 381d01c8 <7d200028> 31290001 7d20012d 40a2fff4
---[ end trace 0824e85bac28e7e4 ]---

gdb says:
(gdb) list *0xc020e2b4
0xc020e2b4 is in ip_dev_find (/usr/local/src/BUILD/trunk/os2kernel/arch/powerpc/include/asm/atomic.h:106).
101
102	static __inline__ void atomic_inc(atomic_t *v)
103	{
104		int t;
105
106		__asm__ __volatile__(
107	"1:	lwarx	%0,0,%2		# atomic_inc\n\
108		addic	%0,%0,1\n"
109		PPC405_ERR77(0,%2)
110	"	stwcx.	%0,0,%2 \n\

gdb) disass 0xc020e2b4 0xc020e2c4
Dump of assembler code from 0xc020e2b4 to 0xc020e2c4:
0xc020e2b4 <ip_dev_find+144>:	lwarx   r9,0,r0
0xc020e2b8 <ip_dev_find+148>:	addic   r9,r9,1
0xc020e2bc <ip_dev_find+152>:	stwcx.  r9,0,r0
0xc020e2c0 <ip_dev_find+156>:	bne-    0xc020e2b4 <ip_dev_find+144>

This is on a MPC8321 CPU
gcc 3.4.6

Any ideas?

  Jocke
