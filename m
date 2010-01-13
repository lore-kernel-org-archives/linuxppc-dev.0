Return-Path: <anton@ozlabs.org>
Date: Thu, 14 Jan 2010 09:04:11 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Replace per_cpu(, smp_processor_id()) with
	__get_cpu_var()
Message-ID: <20100113220410.GM12666@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The cputime code has a few places that do per_cpu(, smp_processor_id()).
Replace them with __get_cpu_var().

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/include/asm/cputime.h
===================================================================
--- linux-cpumask.orig/arch/powerpc/include/asm/cputime.h	2010-01-13 08:57:32.634007010 +1100
+++ linux-cpumask/arch/powerpc/include/asm/cputime.h	2010-01-13 08:58:45.265253809 +1100
@@ -73,10 +73,9 @@ static inline unsigned long cputime_to_j
 static inline cputime_t cputime_to_scaled(const cputime_t ct)
 {
 	if (cpu_has_feature(CPU_FTR_SPURR) &&
-	    per_cpu(cputime_last_delta, smp_processor_id()))
-		return ct *
-			per_cpu(cputime_scaled_last_delta, smp_processor_id())/
-			per_cpu(cputime_last_delta, smp_processor_id());
+	    __get_cpu_var(cputime_last_delta))
+		return ct * __get_cpu_var(cputime_scaled_last_delta) /
+			    __get_cpu_var(cputime_last_delta);
 	return ct;
 }
 
Index: linux-cpumask/arch/powerpc/kernel/time.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/kernel/time.c	2010-01-13 08:57:32.714003980 +1100
+++ linux-cpumask/arch/powerpc/kernel/time.c	2010-01-13 08:58:45.265253809 +1100
@@ -265,8 +265,8 @@ void account_system_vtime(struct task_st
 		account_system_time(tsk, 0, delta, deltascaled);
 	else
 		account_idle_time(delta);
-	per_cpu(cputime_last_delta, smp_processor_id()) = delta;
-	per_cpu(cputime_scaled_last_delta, smp_processor_id()) = deltascaled;
+	__get_cpu_var(cputime_last_delta) = delta;
+	__get_cpu_var(cputime_scaled_last_delta) = deltascaled;
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(account_system_vtime);
