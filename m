Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id DE785DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 05:37:46 +1100 (EST)
Date: Tue, 31 Mar 2009 14:37:42 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Problem with module_init?
Message-ID: <20090331143742.083c6cb0@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With the latest from Linus' tree, I get the following oops:

Oops: Kernel access of bad area, sig: 11 [#1]
Warp
Modules linked in: simple(+)
NIP: d14b8000 LR: c0001420 CTR: 00000000
REGS: cf2a1df0 TRAP: 0400   Not tainted  (2.6.29-pika)
MSR: 00029000 <EE,ME,CE>  CR: 24000022  XER: 00000000
TASK = cf896100[1673] 'insmod' THREAD: cf2a0000
GPR00: 00000000 cf2a1ea0 cf896100 d14b8000 00000001 d14b5360 ffffffff
00000000 GPR08: c03312fc c03312fc c0546018 c0546018 24000022 100872cc
0ffa7d00 007fff99 GPR16: 00400450 00800000 007fff00 0ffa7cec 00000000
ffffffff 00000000 1008323c GPR24: 10083254 00000000 c0330000 c0310000
c03110a4 d14b8000 cf2a0000 d14b5360 NIP [d14b8000] simple_init+0x0/0x8
[simple] LR [c0001420] do_one_initcall+0x34/0x1a0
Call Trace:
[cf2a1f20] [c0045e18] sys_init_module+0xb0/0x1b8
[cf2a1f40] [c000dbbc] ret_from_syscall+0x0/0x3c
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX <38600000> 4e800020 XXXXXXXX
XXXXXXXX ---[ end trace 9ac3b092cfc75a75 ]---

This is the entire driver:

#include <linux/module.h>

static int __init simple_init(void)
{
	return 0;
}
module_init(simple_init);

static void __exit simple_exit(void)
{
}
module_exit(simple_exit);

MODULE_DESCRIPTION("simple driver");
MODULE_LICENSE("GPL");

Has something changed for module?

Cheers,
   Sean
