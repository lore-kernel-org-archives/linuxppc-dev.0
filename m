Return-Path: <haokexin@gmail.com>
Received: from mail-yh0-x22f.google.com (mail-yh0-x22f.google.com
 [IPv6:2607:f8b0:4002:c01::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 12BE91A06F5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 22:33:38 +1100 (AEDT)
Received: by yhch68 with SMTP id h68so16359130yhc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 04:33:35 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] powerpc: add ticket spinlock
Date: Mon, 16 Mar 2015 19:33:14 +0800
Message-Id: <1426505597-1042-1-git-send-email-haokexin@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This patch series convert the simple spinlock to ticket-based spinlock for the
platforms without shared processors. I have run the following command ten times
on a t4240rdb board (12 dual-threaded cpus):
	./perf bench sched messaging -g 100

                                Before      After
    Averaged total time [sec]:  2.623       2.479 

We can see a ~5% performance enhancing. I also run the following command ten
times on a p1020rdb board (2 cpus):
	./perf bench sched messaging -g 20 

                                Before      After
    Averaged total time [sec]:  3.139       3.144 

So the overhead for the 2 cpus platform is also trivial. 


Kevin Hao (3):
  powerpc: introduce PPC_HAS_LOCK_OWNER
  powerpc: spinlock: refactor codes wrapped by PPC_HAS_LOCK_OWNER
  powerpc: add ticket spinlock

 arch/powerpc/Kconfig                      |   8 ++
 arch/powerpc/include/asm/spinlock.h       | 144 ++++++++++++++++++++++--------
 arch/powerpc/include/asm/spinlock_types.h |  16 ++++
 arch/powerpc/lib/locks.c                  |   4 +-
 arch/powerpc/platforms/pseries/Kconfig    |   1 +
 5 files changed, 133 insertions(+), 40 deletions(-)

-- 
2.1.0
