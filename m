Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40W7kr4V7QzDrDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 15:18:12 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id b5so12495898pgv.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 22:18:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2] powerpc: NMI IPI make NMI IPIs fully sychronous
Date: Wed, 25 Apr 2018 15:17:59 +1000
Message-Id: <20180425051759.9474-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is an asynchronous aspect to smp_send_nmi_ipi. The caller waits
for all CPUs to call in to the handler, but it does not wait for
completion of the handler. This is a needless complication, so remove
it and always wait synchronously.

The synchronous wait allows the caller to easily time out and clear
the wait for completion (zero nmi_ipi_busy_count) in the case of badly
behaved handlers. This would have prevented the recent smp_send_stop
NMI IPI bug from causing the system to hang.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Changes since v2:
- Fixed a locking bug in the timeout path
- Move all the shared memory accesses under the lock to avoid worrys
  about memory ordering.

 arch/powerpc/include/asm/smp.h |  1 -
 arch/powerpc/kernel/smp.c      | 52 ++++++++++++++++++----------------
 arch/powerpc/kernel/watchdog.c |  1 -
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index cfecfee1194b..8b844435cbd5 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -56,7 +56,6 @@ struct smp_ops_t {
 	int   (*cpu_bootable)(unsigned int nr);
 };
 
-extern void smp_flush_nmi_ipi(u64 delay_us);
 extern int smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us);
 extern void smp_send_debugger_break(void);
 extern void start_secondary_resume(void);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 250fccf04c6e..8ad9288a72a0 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -412,7 +412,8 @@ int smp_handle_nmi_ipi(struct pt_regs *regs)
 	fn(regs);
 
 	nmi_ipi_lock();
-	nmi_ipi_busy_count--;
+	if (nmi_ipi_busy_count > 1) /* Can race with caller time-out */
+		nmi_ipi_busy_count--;
 out:
 	nmi_ipi_unlock_end(&flags);
 
@@ -437,29 +438,11 @@ static void do_smp_send_nmi_ipi(int cpu)
 	}
 }
 
-void smp_flush_nmi_ipi(u64 delay_us)
-{
-	unsigned long flags;
-
-	nmi_ipi_lock_start(&flags);
-	while (nmi_ipi_busy_count) {
-		nmi_ipi_unlock_end(&flags);
-		udelay(1);
-		if (delay_us) {
-			delay_us--;
-			if (!delay_us)
-				return;
-		}
-		nmi_ipi_lock_start(&flags);
-	}
-	nmi_ipi_unlock_end(&flags);
-}
-
 /*
  * - cpu is the target CPU (must not be this CPU), or NMI_IPI_ALL_OTHERS.
  * - fn is the target callback function.
  * - delay_us > 0 is the delay before giving up waiting for targets to
- *   enter the handler, == 0 specifies indefinite delay.
+ *   complete executing the handler, == 0 specifies indefinite delay.
  */
 int smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us)
 {
@@ -496,8 +479,23 @@ int smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us)
 
 	do_smp_send_nmi_ipi(cpu);
 
+	nmi_ipi_lock();
+	/* nmi_ipi_busy_count is held here, so unlock/lock is okay */
 	while (!cpumask_empty(&nmi_ipi_pending_mask)) {
+		nmi_ipi_unlock();
 		udelay(1);
+		nmi_ipi_lock();
+		if (delay_us) {
+			delay_us--;
+			if (!delay_us)
+				break;
+		}
+	}
+
+	while (nmi_ipi_busy_count > 1) {
+		nmi_ipi_unlock();
+		udelay(1);
+		nmi_ipi_lock();
 		if (delay_us) {
 			delay_us--;
 			if (!delay_us)
@@ -505,12 +503,17 @@ int smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us)
 		}
 	}
 
-	nmi_ipi_lock();
 	if (!cpumask_empty(&nmi_ipi_pending_mask)) {
-		/* Could not gather all CPUs */
+		/* Timeout waiting for CPUs to call smp_handle_nmi_ipi */
 		ret = 0;
 		cpumask_clear(&nmi_ipi_pending_mask);
 	}
+	if (nmi_ipi_busy_count > 1) {
+		/* Timeout waiting for CPUs to execute fn */
+		ret = 0;
+		nmi_ipi_busy_count = 1;
+	}
+
 	nmi_ipi_busy_count--;
 	nmi_ipi_unlock_end(&flags);
 
@@ -574,7 +577,8 @@ static void stop_this_cpu(struct pt_regs *regs)
 	 * smp_send_nmi_ipi() call spin forever. Mark it done now.
 	 */
 	nmi_ipi_lock();
-	nmi_ipi_busy_count--;
+	if (nmi_ipi_busy_count > 1)
+		nmi_ipi_busy_count--;
 	nmi_ipi_unlock();
 #else
 static void stop_this_cpu(void *dummy)
diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 6256dc3b0087..8cf048c6c1eb 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -165,7 +165,6 @@ static void watchdog_smp_panic(int cpu, u64 tb)
 				continue;
 			smp_send_nmi_ipi(c, wd_lockup_ipi, 1000000);
 		}
-		smp_flush_nmi_ipi(1000000);
 	}
 
 	/* Take the stuck CPUs out of the watch group */
-- 
2.17.0
