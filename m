Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bdqf1Z8kzF2ST
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 23:07:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [RFC PATCH 2/4] powerpc/nmi: Add an API for sending "safe" NMIs
Date: Wed,  2 May 2018 23:07:27 +1000
Message-Id: <20180502130729.24077-2-mpe@ellerman.id.au>
In-Reply-To: <20180502130729.24077-1-mpe@ellerman.id.au>
References: <20180502130729.24077-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the options we have for sending NMIs are not necessarily
safe, that is they can potentially interrupt a CPU in a
non-recoverable region of code, meaning the kernel must then panic().

But we'd like to use smp_send_nmi_ipi() to do cross-CPU calls in
situations where we don't want to risk a panic(), because it doesn't
have the requirement that interrupts must be enabled like
smp_call_function().

So add an API for the caller to indicate that it wants to use the NMI
infrastructure, but doesn't want to do anything "unsafe".

Currently that is implemented by not actually calling cause_nmi_ipi(),
instead falling back to an IPI. In future we can pass the safe
parameter down to cause_nmi_ipi() and the individual backends can
potentially take it into account before deciding what to do.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---

I dislike "safe" but I couldn't think of a better word, suggestions
welcome.
---
 arch/powerpc/include/asm/smp.h |  1 +
 arch/powerpc/kernel/smp.c      | 20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index cfecfee1194b..29ffaabdf75b 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -58,6 +58,7 @@ struct smp_ops_t {
 
 extern void smp_flush_nmi_ipi(u64 delay_us);
 extern int smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us);
+extern int smp_send_safe_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us);
 extern void smp_send_debugger_break(void);
 extern void start_secondary_resume(void);
 extern void smp_generic_give_timebase(void);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e16ec7b3b427..6be19381ee70 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -419,9 +419,9 @@ int smp_handle_nmi_ipi(struct pt_regs *regs)
 	return ret;
 }
 
-static void do_smp_send_nmi_ipi(int cpu)
+static void do_smp_send_nmi_ipi(int cpu, bool safe)
 {
-	if (smp_ops->cause_nmi_ipi && smp_ops->cause_nmi_ipi(cpu))
+	if (!safe && smp_ops->cause_nmi_ipi && smp_ops->cause_nmi_ipi(cpu))
 		return;
 
 	if (cpu >= 0) {
@@ -461,7 +461,7 @@ void smp_flush_nmi_ipi(u64 delay_us)
  * - delay_us > 0 is the delay before giving up waiting for targets to
  *   enter the handler, == 0 specifies indefinite delay.
  */
-int smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us)
+int __smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us, bool safe)
 {
 	unsigned long flags;
 	int me = raw_smp_processor_id();
@@ -494,7 +494,7 @@ int smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us)
 	nmi_ipi_busy_count++;
 	nmi_ipi_unlock();
 
-	do_smp_send_nmi_ipi(cpu);
+	do_smp_send_nmi_ipi(cpu, safe);
 
 	while (!cpumask_empty(&nmi_ipi_pending_mask)) {
 		udelay(1);
@@ -516,6 +516,16 @@ int smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us)
 
 	return ret;
 }
+
+int smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us)
+{
+	return __smp_send_nmi_ipi(cpu, fn, delay_us, false);
+}
+
+int smp_send_safe_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us)
+{
+	return __smp_send_nmi_ipi(cpu, fn, delay_us, true);
+}
 #endif /* CONFIG_NMI_IPI */
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
@@ -559,7 +569,7 @@ void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
 			 * entire NMI dance and waiting for
 			 * cpus to clear pending mask, etc.
 			 */
-			do_smp_send_nmi_ipi(cpu);
+			do_smp_send_nmi_ipi(cpu, false);
 		}
 	}
 }
-- 
2.14.1
