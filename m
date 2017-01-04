Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttZ720WHxzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 13:11:26 +1100 (AEDT)
Date: Tue, 3 Jan 2017 18:11:20 -0800 (PST)
From: Christian Kujau <lists@nerdbynature.de>
To: linuxppc-dev@lists.ozlabs.org
cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>
Subject: DEBUG_LOCKS_WARN_ON(1) / lockdep.c:3134 lockdep_init_map+0x1e8/0x1f0
Message-ID: <alpine.DEB.2.20.99.1701031806120.31470@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

booting v4.10-rc2 on this PowerPC G4 machine prints the following early 
on, but then continues to boot and the machine is running fine so far:


BUG: key ef0ba7d0 not in .data!
DEBUG_LOCKS_WARN_ON(1)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at 
/usr/local/src/linux-git/kernel/locking/lockdep.c:3134 lockdep_init_map+0x1e8/0x1f0
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 4.10.0-rc2 #4
task: ef04aa60 task.stack: ef042000
NIP: c005eb78 LR: c005eb78 CTR: 00000000
REGS: ef043d70 TRAP: 0700   Not tainted  (4.10.0-rc2)
MSR: 02029032 <VEC,EE,ME,IR,DR,RI>
  CR: 48000022  XER: 20000000
GPR00: c005eb78 ef043e20 ef04aa60 00000016 00000001 c0068b24 00000000 00000001 
GPR08: 00000000 00000000 00004ead 000000d6 28000024 00000000 c00047f0 00000000 
GPR16: 00000000 00000000 c08b9280 effedfa0 c078d6ac c1070000 c078eddc c078ee14 
GPR24: c078ed24 c078ee24 00000002 ef085a00 00000000 c08b0000 ef0ba7d0 ef0ba7b4 
NIP [c005eb78] lockdep_init_map+0x1e8/0x1f0
LR [c005eb78] lockdep_init_map+0x1e8/0x1f0
Call Trace:
[ef043e20] [c005eb78] lockdep_init_map+0x1e8/0x1f0 (unreliable)
[ef043e40] [c083adb4] kw_i2c_add+0xc0/0x134
[ef043e60] [c083b29c] pmac_i2c_init+0x3b8/0x518
[ef043ea0] [c00040c0] do_one_initcall+0x40/0x174
[ef043f00] [c0834064] kernel_init_freeable+0x134/0x1cc
[ef043f30] [c0004808] kernel_init+0x18/0x110
[ef043f40] [c0010ad8] ret_from_kernel_thread+0x5c/0x64
Instruction dump:
4837259d 2f830000 41befec0 3d20c08b 812953a0 2f890000 409efeb0 3c60c079 
3c80c07b 3884b48c 3863f9e4 4860d52d <0fe00000> 4bfffe94 9421ff70 7c0802a6 
---[ end trace 8a79d8041d87d000 ]---


Full dmesg and .config: http://nerdbynature.de/bits/4.10-rc2/


Thanks for listening,
Christian.
-- 
BOFH excuse #409:

The vulcan-death-grip ping has been applied.
