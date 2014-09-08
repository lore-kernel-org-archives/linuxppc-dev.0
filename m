Return-Path: <atomlin@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411B81A08D5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Sep 2014 05:25:46 +1000 (EST)
From: Aaron Tomlin <atomlin@redhat.com>
To: peterz@infradead.org
Subject: [PATCH v2 0/3] sched: Always check the integrity of the canary
Date: Mon,  8 Sep 2014 20:23:14 +0100
Message-Id: <1410204197-31204-1-git-send-email-atomlin@redhat.com>
In-Reply-To: <20140904161124.GD1436@atomlin.usersys.redhat.com>
References: <20140904161124.GD1436@atomlin.usersys.redhat.com>
Cc: dzickus@redhat.com, jcastillo@redhat.com, riel@redhat.com,
 minchan@kernel.org, bmr@redhat.com, x86@kernel.org, oleg@redhat.com,
 rostedt@goodmis.org, linux-kernel@vger.kernel.org, hannes@cmpxchg.org,
 mingo@redhat.com, aneesh.kumar@linux.vnet.ibm.com, akpm@google.com,
 atomlin@redhat.com, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org, pzijlstr@redhat.com
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

The first patch adds a canary to init_task's end of stack.
While the second patch provides a helper to determine the
integrity of the canary. The third checks for a stack
overrun and takes appropriate action since the damage
is already done, there is no point in continuing.

Changes since v1:

 * Rebased against v3.17-rc4
 * Add a canary to init_task - Oleg Nesterov
 * Fix various code formatting issues - Peter Zijlstra
 * Introduce Kconfig option - Peter Zijlstra

Aaron Tomlin (3):
  init/main.c: Give init_task a canary
  sched: Add helper for task stack page overrun checking
  sched: BUG when stack end location is over written

 arch/powerpc/mm/fault.c    |  5 +----
 arch/x86/mm/fault.c        |  5 +----
 include/linux/sched.h      |  4 ++++
 init/main.c                |  1 +
 kernel/fork.c              | 12 +++++++++---
 kernel/sched/core.c        |  4 ++++
 kernel/trace/trace_stack.c |  4 +---
 lib/Kconfig.debug          | 12 ++++++++++++
 8 files changed, 33 insertions(+), 14 deletions(-)

-- 
1.9.3
