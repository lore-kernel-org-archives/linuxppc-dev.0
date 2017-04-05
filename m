Return-Path: <srs0=xpzz=3n=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vydSY1cLqzDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 17:55:57 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vydSY0bKkz8t15
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 17:55:57 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vydSX3NMHz9s84
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Apr 2017 17:55:56 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 02/10] powerpc: Add optional smp_ops->prepare_cpu SMP
 callback
Date: Wed,  5 Apr 2017 17:54:48 +1000
Message-Id: <20170405075456.13561-2-benh@kernel.crashing.org>
In-Reply-To: <20170405075456.13561-1-benh@kernel.crashing.org>
References: <20170405075456.13561-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some platforms (will) need to perform allocations before bringing
a new CPU online. Doing it from smp_ops->setup_cpu is the wrong
thing to do:

 - It has no useful failure path (too late)
 - Calling any allocator will enable interrupts prematurely
   causing problems with large decrementer among others

Instead, add a new callback that is called from __cpu_up (so from
the context trying to online the new CPU) at a point where we
can safely allocate and handle failures.

This will be used by XIVE support.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/smp.h |  1 +
 arch/powerpc/kernel/smp.c      | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 32db16d..2f8e36f 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -44,6 +44,7 @@ struct smp_ops_t {
 #endif
 	void  (*probe)(void);
 	int   (*kick_cpu)(int nr);
+	int   (*prepare_cpu)(int nr);
 	void  (*setup_cpu)(int nr);
 	void  (*bringup_done)(void);
 	void  (*take_timebase)(void);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 46f89e6..b12f5f0 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -521,6 +521,16 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 
 	cpu_idle_thread_init(cpu, tidle);
 
+	/*
+	 * The platform might need to allocate resources prior to bringing
+	 * up the CPU
+	 */
+	if (smp_ops->prepare_cpu) {
+		rc = smp_ops->prepare_cpu(cpu);
+		if (rc)
+			return rc;
+	}
+
 	/* Make sure callin-map entry is 0 (can be leftover a CPU
 	 * hotplug
 	 */
-- 
2.9.3
