Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 83571B70AE
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Aug 2010 06:36:38 +1000 (EST)
Received: from crust.elkhashab.com (localhost [127.0.0.1])
	by crust.elkhashab.com (8.14.3/8.14.3/Debian-5) with ESMTP id
	o7DKaalB012218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Aug 2010 15:36:36 -0500
Received: (from ayman@localhost)
	by crust.elkhashab.com (8.14.3/8.14.3/Submit) id o7DKaaS6012217
	for linuxppc-dev@ozlabs.org; Fri, 13 Aug 2010 15:36:36 -0500
Date: Fri, 13 Aug 2010 15:36:36 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: linuxppc-dev@ozlabs.org
Subject: help with kernel panics in task swapper on 460ex
Message-ID: <20100813203636.GA11899@crust.elkhashab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have an odd problem when using the 460ex rev b processors.  Previously,
I'd used the rev A without any issues on the same pcbs.  This happens on
multiple units now.  Basically, while running the system will just 
randomly kernel panic.  We have seen this probably 4 or 5 times on a 
over the course of several days per board.  On many occasions, the CPU 
will not kernel dump at all and will just be dead after having run for
some amount of time.  The kernel is 2.6.31.5

The exact details (though I don't think they are too useful are as follows.
The one interesting item if I read it correctly, is that the CPU was 
trying to get instructions from c002xxxx address.  However, this board only
has 512MB of memory so it seems that the address (if it is physical) isn't 
valid.  

Are there any tricks we can use to analyze this problem?  Or is there any
information we can collect to help pinpoint where this issue might lie?

Thanks 
ame

Unable to handle kernel paging request for data at address 0x8072f938
Faulting instruction address: 0xc002eac4
Oops: Kernel access of bad area, sig: 11 [#1]
PowerPC 44x Platform
Modules linked in: mapper
NIP: c002eac4 LR: c004811c CTR: c000add0
REGS: c038be60 TRAP: 0300   Not tainted  (2.6.31.5)
MSR: 00021000 <ME,CE>  CR: 24644324  XER: 00000000
DEAR: 8072f938, ESR: 00000000
TASK = c036a318[0] 'swapper' THREAD: c038a000
GPR00: 000000f6 c038bf10 c036a318 fffef700 fffef6f9 000000f9 000000f6 00061583
GPR08: c0398070 8072f930 c0398070 c03978c0 004ffffe 415ec006 1ffb3300 00000000
GPR16: 1ffa6e70 1ffad780 00000000 00000000 00000000 c036b1a0 ff1ad8aa c038bf48
GPR24: 00029000 0000001c 262a1965 c036de50 c039269c fffef700 fffef700 2625a000
NIP [c002eac4] get_next_timer_interrupt+0x30/0x260
LR [c004811c] tick_nohz_stop_sched_tick+0x110/0x404
Call Trace:
[c038bf10] [c003df74] ktime_get+0x1c/0x44 (unreliable)
[c038bf40] [c004811c] tick_nohz_stop_sched_tick+0x110/0x404
[c038bf90] [c0006f00] cpu_idle+0x50/0xd8
[c038bfb0] [c000197c] rest_init+0x5c/0x70
[c038bfc0] [c033f844] start_kernel+0x224/0x2a0
[c038bff0] [c0000200] skpinv+0x190/0x1cc
Instruction dump:
9421ffd0 7c0802a6 bfa10024 90010034 3d20c037 8169d1b8 7c7e1b78 808b0004
5485063e 7ca62b78 54c91838 7d295a14 <81090008> 39290008 48000014 80080014
---[ end trace 13e96cd635551e49 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
Rebooting in 1 seconds..aymane@vbox:~$ 
