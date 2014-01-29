Return-Path: <nicolas.pitre@linaro.org>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
 by ozlabs.org (Postfix) with ESMTP id BDEB62C0309
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 04:45:26 +1100 (EST)
Received: from yoda.home ([66.130.143.177]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0N0600IREBZJOTG0@VL-VM-MR006.ip.videotron.ca> for
 linuxppc-dev@lists.ozlabs.org; Wed, 29 Jan 2014 12:45:19 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Russell King <linux@arm.linux.org.uk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>, Paul Mundt <lethal@linux-sh.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v2 6/6] cpu/idle.c: move to sched/idle.c
Date: Wed, 29 Jan 2014 12:45:13 -0500
Message-id: <1391017513-12995-7-git-send-email-nicolas.pitre@linaro.org>
In-reply-to: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Integration of cpuidle with the scheduler requires that the idle loop be
closely integrated with the scheduler proper. Moving cpu/idle.c into the
sched directory will allow for a smoother integration, and eliminate a
subdirectory which contained only one source file.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 kernel/Makefile              | 1 -
 kernel/cpu/Makefile          | 1 -
 kernel/sched/Makefile        | 2 +-
 kernel/{cpu => sched}/idle.c | 0
 4 files changed, 1 insertion(+), 3 deletions(-)
 delete mode 100644 kernel/cpu/Makefile
 rename kernel/{cpu => sched}/idle.c (100%)

diff --git a/kernel/Makefile b/kernel/Makefile
index bc010ee272..6f1c7e5cfc 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -22,7 +22,6 @@ obj-y += sched/
 obj-y += locking/
 obj-y += power/
 obj-y += printk/
-obj-y += cpu/
 obj-y += irq/
 obj-y += rcu/
 
diff --git a/kernel/cpu/Makefile b/kernel/cpu/Makefile
deleted file mode 100644
index 59ab052ef7..0000000000
--- a/kernel/cpu/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-obj-y	= idle.o
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 7b621409cf..ac3e0ea68f 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -11,7 +11,7 @@ ifneq ($(CONFIG_SCHED_OMIT_FRAME_POINTER),y)
 CFLAGS_core.o := $(PROFILING) -fno-omit-frame-pointer
 endif
 
-obj-y += core.o proc.o clock.o cputime.o idle_task.o fair.o rt.o stop_task.o
+obj-y += core.o proc.o clock.o cputime.o idle_task.o idle.o fair.o rt.o stop_task.o
 obj-y += wait.o completion.o
 obj-$(CONFIG_SMP) += cpupri.o
 obj-$(CONFIG_SCHED_AUTOGROUP) += auto_group.o
diff --git a/kernel/cpu/idle.c b/kernel/sched/idle.c
similarity index 100%
rename from kernel/cpu/idle.c
rename to kernel/sched/idle.c
-- 
1.8.4.108.g55ea5f6
