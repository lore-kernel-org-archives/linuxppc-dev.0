Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 215692C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 21:00:52 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Fri, 29 Mar 2013 15:27:53 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 345A83940053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 15:30:44 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2TA0aCe44236842
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 15:30:37 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2TA0duM006112
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 21:00:41 +1100
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/6] powerpc: Support context tracking for Power pSeries
Date: Fri, 29 Mar 2013 18:00:15 +0800
Message-Id: <1364551221-23177-1-git-send-email-zhong@linux.vnet.ibm.com>
Cc: Li Zhong <zhong@linux.vnet.ibm.com>, fweisbec@gmail.com, paulus@samba.org,
 paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches try to support context tracking for Power arch, beginning with
64-bit pSeries. The codes are ported from that of the x86_64, and in each
patch, I listed the corresponding patch for x86.

Would you please help review and give your comments?

v2:

I rebased the patches against 3.9-rcs, and also added a patch to replace
the exception handling with the generic code in tip timers/nohz.

I assume these patches would get in through powerpc tree, so I didn't combine
the new patch (#6) with the original one (#2). So that if powerpc tree picks
these, it could pick the first five patches, and apply patch #6 later
when the dependency enters into powerpc tree (maybe on some 3.10-rcs).

I'm also wondering whether it is possible for these to go through
tip timers/nohz, so for now, patches #6 and #2 could be combined into one, and
no need to  worry about the issues caused by arch/common code merging. And it
might also make future changes easier.

Thanks, Zhong

Li Zhong (6):
  powerpc: Syscall hooks for context tracking subsystem
  powerpc: Exception hooks for context tracking subsystem
  powerpc: Exit user context on notify resume
  powerpc: Use the new schedule_user API on userspace preemption
  powerpc: select HAVE_CONTEXT_TRACKING for pSeries
  powerpc: Use generic code for exception handling

 arch/powerpc/include/asm/context_tracking.h |   10 +++
 arch/powerpc/include/asm/thread_info.h      |    7 ++-
 arch/powerpc/kernel/entry_64.S              |    3 +-
 arch/powerpc/kernel/ptrace.c                |    5 ++
 arch/powerpc/kernel/signal.c                |    5 ++
 arch/powerpc/kernel/traps.c                 |   91 ++++++++++++++++++++-------
 arch/powerpc/mm/fault.c                     |   16 ++++-
 arch/powerpc/mm/hash_utils_64.c             |   38 ++++++++---
 arch/powerpc/platforms/pseries/Kconfig      |    1 +
 9 files changed, 140 insertions(+), 36 deletions(-)
 create mode 100644 arch/powerpc/include/asm/context_tracking.h

-- 
1.7.9.5
