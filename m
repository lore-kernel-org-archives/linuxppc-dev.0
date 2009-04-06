Return-Path: <fredrik.arnerup@edgeware.tv>
Received: from mail.edgeware.tv (mail.edgeware.tv [82.99.7.138])
	by ozlabs.org (Postfix) with ESMTP id 46D3BDDEE2
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 01:31:57 +1000 (EST)
Received: from edgeware48 (unknown [192.168.99.245])
	by mail.edgeware.tv (Postfix) with ESMTPSA id 0422351B6076
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Apr 2009 17:21:07 +0200 (CEST)
From: "Fredrik Arnerup" <fredrik.arnerup@edgeware.tv>
To: <linuxppc-dev@ozlabs.org>
Subject: Recap: Kernel oops while duming user core.
Date: Mon, 6 Apr 2009 17:23:12 +0200
Message-ID: <1C9CDA9B925A4C77B150D492AFFD022F@edgeware.tv>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Was the kernel oops when dumping core ever resolved?
(http://ozlabs.org/pipermail/linuxppc-dev/2008-February/051080.html, quoted
below)

What was the cause? Is there a patch? A bug tracker ticket?
Using ELDK here, so still running 2.6.24 ...

Thanks,
/Fredrik Arnerup


////////////////////////////////////////
Kernel oops while duming user core.
Rune Torgersen runet at innovsys.com
Fri Feb 1 00:45:33 EST 2008

Hi

I get the following kernel core while a user program I have is dumping
core.
Any DIeas at what to look for? (this is runnign 2.6.24, arch/powerpc on
a 8280)
When runnign the program on 2.6.18 arch/ppc, the program gets a sig 11
and dumps core.
On 2.6.24, I ghet the kernel oops, and then the program hangs sround
forever and is unkillable.

Unable to handle kernel paging request for data at address 0x48024000
Faulting instruction address: 0xc000ef88
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT Innovative Systems ApMax
Modules linked in: drv_wd(P) drv_scc devcom drv_pcir tipc drv_ss7
drv_auxcpu drv_leds(P) drv_ethsw proc_sysinfo(P) i2c_8266(P)
NIP: c000ef88 LR: c0012180 CTR: 00000080
REGS: eebc9b70 TRAP: 0300   Tainted: P         (2.6.24)
MSR: 00009032 <EE,ME,IR,DR>  CR: 24004442  XER: 00000000
DAR: 48024000, DSISR: 20000000
TASK = eebac3c0[3131] 'armd' THREAD: eebc8000
GPR00: ee9b7d00 eebc9c20 eebac3c0 48024000 00000080 399a4181 48024000
00000000
GPR08: 399a4181 ee9b7d00 00000000 c2000000 44004422 10100f38 ee82fc00
bfffffff
GPR16: ef377060 00000030 ee9b7d00 00000000 eebc9cdc 00000011 eebc9cd8
eeb96480
GPR24: ee9b7d00 399a4181 48024000 eeb9a370 eeb9a370 399a4181 48024000
c2733480
NIP [c000ef88] __flush_dcache_icache+0x14/0x40
LR [c0012180] update_mmu_cache+0x74/0x114
Call Trace:
[eebc9c20] [eebc8000] 0xeebc8000 (unreliable)
[eebc9c40] [c005d060] handle_mm_fault+0x630/0xbc0
[eebc9c80] [c005d9e4] get_user_pages+0x3f4/0x4fc
[eebc9cd0] [c00aa7c4] elf_core_dump+0x9a4/0xc5c
[eebc9d60] [c00779e4] do_coredump+0x6e0/0x748
[eebc9e50] [c002a5b0] get_signal_to_deliver+0x40c/0x45c
[eebc9e80] [c0008ce8] do_signal+0x50/0x294
[eebc9f40] [c000fb98] do_user_signal+0x74/0xc4
--- Exception: 300 at 0x10044efc
    LR = 0x10044ec0
Instruction dump:
4d820020 7c8903a6 7c001bac 38630020 4200fff8 7c0004ac 4e800020 60000000
54630026 38800080 7c8903a6 7c661b78 <7c00186c> 38630020 4200fff8
7c0004ac
---[ end trace 97db37eaf213da3c ]---
note: armd[3131] exited with preempt_count 2
 
