Return-Path: <atomlin@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 476661A03C5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 00:52:56 +1000 (EST)
From: Aaron Tomlin <atomlin@redhat.com>
To: peterz@infradead.org
Subject: [PATCH 0/2] sched: Always check the integrity of the canary
Date: Thu,  4 Sep 2014 15:50:22 +0100
Message-Id: <1409842224-11847-1-git-send-email-atomlin@redhat.com>
Cc: dzickus@redhat.com, jcastillo@redhat.com, riel@redhat.com,
 minchan@kernel.org, bmr@redhat.com, x86@kernel.org, oleg@redhat.com,
 rostedt@goodmis.org, linux-kernel@vger.kernel.org, hannes@cmpxchg.org,
 mingo@redhat.com, aneesh.kumar@linux.vnet.ibm.com, atomlin@redhat.com,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 pzijlstr@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently in the event of a stack overrun a call to schedule()
does not check for this type of corruption. This corruption is
often silent and can go unnoticed. However once the corrupted
region is examined at a later stage, the outcome is undefined
and often results in a sporadic page fault which cannot be
handled.

The first patch provides a helper to determine the integrity
of the canary. While the second patch checks for a stack
overrun and takes appropriate action since the damage is
already done, there is no point in continuing.

Aaron Tomlin (2):
  sched: Add helper for task stack page overrun checking
  sched: BUG when stack end location is over written

 arch/powerpc/mm/fault.c    | 6 ++----
 arch/x86/mm/fault.c        | 5 +----
 include/linux/sched.h      | 3 +++
 kernel/sched/core.c        | 3 +++
 kernel/trace/trace_stack.c | 5 ++---
 5 files changed, 11 insertions(+), 11 deletions(-)

-- 
1.9.3
