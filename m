Return-Path: <sfr@canb.auug.org.au>
Date: Mon, 19 Sep 2005 23:28:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20050919232821.7709b9f5.sfr@canb.auug.org.au>
In-Reply-To: <20050919231051.28fcdf30.sfr@canb.auug.org.au>
References: <20050919231051.28fcdf30.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 6/6] powerpc: reduce oprofile/common.c differences
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rename and slightly modify {request,free}_perfmon_irq in the ppc code.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

---
 arch/powerpc/oprofile/common.c |   13 -------------
 arch/ppc/kernel/perfmon.c      |   10 +++++-----
 include/asm-ppc/perfmon.h      |    4 ++--
 3 files changed, 7 insertions(+), 20 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

b3a2095ea11906c79fd1c43819e9b9c8d4f0ab51
diff --git a/arch/powerpc/oprofile/common.c b/arch/powerpc/oprofile/common.c
--- a/arch/powerpc/oprofile/common.c
+++ b/arch/powerpc/oprofile/common.c
@@ -46,19 +46,12 @@ static void op_handle_interrupt(struct p
 
 static int op_powerpc_setup(void)
 {
-#ifdef __powerpc64__
 	int err;
 
 	/* Grab the hardware */
 	err = reserve_pmc_hardware(op_handle_interrupt);
 	if (err)
 		return err;
-#else /* __powerpc64__ */
-	/* Install our interrupt handler into the existing hook.  */
-	if (request_perfmon_irq(&op_handle_interrupt))
-		return -EBUSY;
-	mb();
-#endif /* __powerpc64__ */
 
 	/* Pre-compute the values to stuff in the hardware registers.  */
 	model->reg_setup(ctr, &sys, model->num_counters);
@@ -78,13 +71,7 @@ static int op_powerpc_setup(void)
 
 static void op_powerpc_shutdown(void)
 {
-#ifdef __powerpc64__
 	release_pmc_hardware();
-#else /* __powerpc64__ */
-	mb();
-	/* Remove our interrupt handler. We may be removing this module. */
-	free_perfmon_irq();
-#endif /* __powerpc64__ */
 }
 
 static void op_powerpc_cpu_start(void *dummy)
diff --git a/arch/ppc/kernel/perfmon.c b/arch/ppc/kernel/perfmon.c
--- a/arch/ppc/kernel/perfmon.c
+++ b/arch/ppc/kernel/perfmon.c
@@ -61,7 +61,7 @@ void (*perf_irq)(struct pt_regs *) = dum
 
 /* Grab the interrupt, if it's free.
  * Returns 0 on success, -1 if the interrupt is taken already */
-int request_perfmon_irq(void (*handler)(struct pt_regs *))
+int reserve_pmc_hardware(void (*handler)(struct pt_regs *))
 {
 	int err = 0;
 
@@ -71,7 +71,7 @@ int request_perfmon_irq(void (*handler)(
 		perf_irq = handler;
 	else {
 		pr_info("perfmon irq already handled by %p\n", perf_irq);
-		err = -1;
+		err = -EBUSY;
 	}
 
 	spin_unlock(&perfmon_lock);
@@ -79,7 +79,7 @@ int request_perfmon_irq(void (*handler)(
 	return err;
 }
 
-void free_perfmon_irq(void)
+void release_pmc_hardware(void)
 {
 	spin_lock(&perfmon_lock);
 
@@ -89,5 +89,5 @@ void free_perfmon_irq(void)
 }
 
 EXPORT_SYMBOL(perf_irq);
-EXPORT_SYMBOL(request_perfmon_irq);
-EXPORT_SYMBOL(free_perfmon_irq);
+EXPORT_SYMBOL(reserve_pmc_hardware);
+EXPORT_SYMBOL(release_pmc_hardware);
diff --git a/include/asm-ppc/perfmon.h b/include/asm-ppc/perfmon.h
--- a/include/asm-ppc/perfmon.h
+++ b/include/asm-ppc/perfmon.h
@@ -3,8 +3,8 @@
 
 extern void (*perf_irq)(struct pt_regs *);
 
-int request_perfmon_irq(void (*handler)(struct pt_regs *));
-void free_perfmon_irq(void);
+int reserve_pmc_hardware(void (*handler)(struct pt_regs *));
+void release_pmc_hardware(void);
 
 #ifdef CONFIG_FSL_BOOKE
 void init_pmc_stop(int ctr);
