Return-Path: <nicolas.pitre@linaro.org>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
 by ozlabs.org (Postfix) with ESMTP id D0AF82C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 17:24:18 +1100 (EST)
Received: from yoda.home ([66.130.143.177]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0N0100CJZQFBKVJ0@VL-VM-MR006.ip.videotron.ca> for
 linuxppc-dev@lists.ozlabs.org; Mon, 27 Jan 2014 01:09:11 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/9] idle: no more arch_cpu_idle_prepare() users
Date: Mon, 27 Jan 2014 01:08:18 -0500
Message-id: <1390802904-28399-4-git-send-email-nicolas.pitre@linaro.org>
In-reply-to: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
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

... so we can get rid of it entirely.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 include/linux/cpu.h | 1 -
 kernel/cpu/idle.c   | 2 --
 2 files changed, 3 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 03e235ad1b..218fab7521 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -221,7 +221,6 @@ void cpu_idle(void);
 void cpu_idle_poll_ctrl(bool enable);
 
 void arch_cpu_idle(void);
-void arch_cpu_idle_prepare(void);
 void arch_cpu_idle_enter(void);
 void arch_cpu_idle_exit(void);
 void arch_cpu_idle_dead(void);
diff --git a/kernel/cpu/idle.c b/kernel/cpu/idle.c
index 988573a9a3..4e327e211b 100644
--- a/kernel/cpu/idle.c
+++ b/kernel/cpu/idle.c
@@ -52,7 +52,6 @@ static inline int cpu_idle_poll(void)
 }
 
 /* Weak implementations for optional arch specific functions */
-void __weak arch_cpu_idle_prepare(void) { }
 void __weak arch_cpu_idle_enter(void) { }
 void __weak arch_cpu_idle_exit(void) { }
 void __weak arch_cpu_idle_dead(void) { }
@@ -136,6 +135,5 @@ void cpu_startup_entry(enum cpuhp_state state)
 	boot_init_stack_canary();
 #endif
 	__current_set_polling();
-	arch_cpu_idle_prepare();
 	cpu_idle_loop();
 }
-- 
1.8.4.108.g55ea5f6
