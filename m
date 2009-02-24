Return-Path: <jeff@theptrgroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [71.246.247.9])
	by ozlabs.org (Postfix) with ESMTP id 9B7D9DDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 14:28:24 +1100 (EST)
Received: from [10.11.13.78] (unknown [10.11.13.78])
	by mail.theptrgroup.com (Postfix) with ESMTP id 4504F5F5CE
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 22:28:47 -0500 (EST)
Subject: 2.6.29-rc6-rt2 fails for powerpc
From: jeff angielski <jeff@theptrgroup.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Mon, 23 Feb 2009 22:28:20 -0500
Message-Id: <1235446100.23197.28.camel@penguin>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


1. Git clone of the latest 2.6.29-rc6.
2. Applied the 2.6.29-rc6-rt2 patch.
3. Copied XXX config from arch/powerpc/configs to .config
4. make -j2 ARCH=powerpc oldconfig
5. make -j2 ARCH=powerpc 

It fails with redefinition errors of the rwsem stuff from
arch/powerpc/include/asm/rwsem.h and include/linux/rt_lock.h.

Anybody else having this problem?  Google was not my friend, nor the RT
Wiki... 

The detailed compile output is here:


 $ make -j2 ARCH=powerpc
scripts/kconfig/conf -s arch/powerpc/Kconfig
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-powerpc
  CC      arch/powerpc/kernel/asm-offsets.s
In file included from include/linux/rwsem.h:37,
                 from include/linux/mm_types.h:11,
                 from include/linux/sched.h:61,
                 from arch/powerpc/kernel/asm-offsets.c:17:
/home/jaa/src/linux-2.6/arch/powerpc/include/asm/rwsem.h:24: error: redefinition of 'struct rw_semaphore'
In file included from include/linux/rwsem.h:37,
                 from include/linux/mm_types.h:11,
                 from include/linux/sched.h:61,
                 from arch/powerpc/kernel/asm-offsets.c:17:
/home/jaa/src/linux-2.6/arch/powerpc/include/asm/rwsem.h:46:1: warning: "__RWSEM_INITIALIZER" redefined
In file included from include/linux/spinlock.h:118,
                 from include/linux/seqlock.h:34,
                 from include/linux/time.h:8,
                 from include/linux/timex.h:56,
                 from include/linux/sched.h:54,
                 from arch/powerpc/kernel/asm-offsets.c:17:
include/linux/rt_lock.h:191:1: warning: this is the location of the previous definition
In file included from include/linux/rwsem.h:37,
                 from include/linux/mm_types.h:11,
                 from include/linux/sched.h:61,
                 from arch/powerpc/kernel/asm-offsets.c:17:
/home/jaa/src/linux-2.6/arch/powerpc/include/asm/rwsem.h:50:1: warning: "DECLARE_RWSEM" redefined
In file included from include/linux/spinlock.h:118,
                 from include/linux/seqlock.h:34,
                 from include/linux/time.h:8,
                 from include/linux/timex.h:56,
                 from include/linux/sched.h:54,
                 from arch/powerpc/kernel/asm-offsets.c:17:
include/linux/rt_lock.h:195:1: warning: this is the location of the previous definition
In file included from include/linux/rwsem.h:37,
                 from include/linux/mm_types.h:11,
                 from include/linux/sched.h:61,
                 from arch/powerpc/kernel/asm-offsets.c:17:
/home/jaa/src/linux-2.6/arch/powerpc/include/asm/rwsem.h:61:1: warning: "init_rwsem" redefined
In file included from include/linux/spinlock.h:118,
                 from include/linux/seqlock.h:34,
                 from include/linux/time.h:8,
                 from include/linux/timex.h:56,
                 from include/linux/sched.h:54,
                 from arch/powerpc/kernel/asm-offsets.c:17:
include/linux/rt_lock.h:232:1: warning: this is the location of the previous definition
/home/jaa/src/linux-2.6/arch/powerpc/include/asm/rwsem.h:167: error: expected identifier or '(' before '{' token
make[1]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2



-- 
Jeff Angielski
The PTR Group
www.theptrgroup.com
