Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb7cJ1hhyzDsZg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 18:24:32 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/8xx: add dedicated machine check handler
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20160916082412.428AE1A2455@localhost.localdomain>
Date: Fri, 16 Sep 2016 10:23:11 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During a machine check, the 8xx provides indication of
whether the check is due to data or instruction access, so
let's display it.

Lets also move 8xx specific handling into the new handler.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: moved into the new handler the part conditionned by CONFIG_8xx

 arch/powerpc/include/asm/cputable.h |  1 +
 arch/powerpc/kernel/cputable.c      |  1 +
 arch/powerpc/kernel/traps.c         | 36 +++++++++++++++++++++++++-----------
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index f752e6f..ab68d0e 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -43,6 +43,7 @@ extern int machine_check_e500mc(struct pt_regs *regs);
 extern int machine_check_e500(struct pt_regs *regs);
 extern int machine_check_e200(struct pt_regs *regs);
 extern int machine_check_47x(struct pt_regs *regs);
+int machine_check_8xx(struct pt_regs *regs);
 
 extern void cpu_down_flush_e500v2(void);
 extern void cpu_down_flush_e500mc(void);
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 6c4646a..6a82ef0 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1248,6 +1248,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.mmu_features		= MMU_FTR_TYPE_8xx,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
+		.machine_check		= machine_check_8xx,
 		.platform		= "ppc823",
 	},
 #endif /* CONFIG_8xx */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 8bd8e73..04254ad 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -665,6 +665,31 @@ int machine_check_e200(struct pt_regs *regs)
 
 	return 0;
 }
+#elif defined(CONFIG_PPC_8xx)
+int machine_check_8xx(struct pt_regs *regs)
+{
+	unsigned long reason = get_mc_reason(regs);
+
+	pr_err("Machine check in kernel mode.\n");
+	pr_err("Caused by (from SRR1=%lx): ", reason);
+	if (reason & 0x40000000)
+		pr_err("Fetch error at address %lx\n", regs->nip);
+	else
+		pr_err("Data access error at address %lx\n", regs->dar);
+
+#ifdef CONFIG_PCI
+	/* the qspan pci read routines can cause machine checks -- Cort
+	 *
+	 * yuck !!! that totally needs to go away ! There are better ways
+	 * to deal with that than having a wart in the mcheck handler.
+	 * -- BenH
+	 */
+	bad_page_fault(regs, regs->dar, SIGBUS);
+	return 1;
+#else
+	return 0;
+#endif
+}
 #else
 int machine_check_generic(struct pt_regs *regs)
 {
@@ -724,17 +749,6 @@ void machine_check_exception(struct pt_regs *regs)
 	if (recover > 0)
 		goto bail;
 
-#if defined(CONFIG_8xx) && defined(CONFIG_PCI)
-	/* the qspan pci read routines can cause machine checks -- Cort
-	 *
-	 * yuck !!! that totally needs to go away ! There are better ways
-	 * to deal with that than having a wart in the mcheck handler.
-	 * -- BenH
-	 */
-	bad_page_fault(regs, regs->dar, SIGBUS);
-	goto bail;
-#endif
-
 	if (debugger_fault_handler(regs))
 		goto bail;
 
-- 
2.1.0
