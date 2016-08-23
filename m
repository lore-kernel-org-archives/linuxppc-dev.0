Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJTtV53KLzDrK6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 22:16:02 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: add dedicated machine check handler
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20160823121556.243EA1A2459@localhost.localdomain>
Date: Tue, 23 Aug 2016 14:15:56 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/cputable.h |  1 +
 arch/powerpc/kernel/cputable.c      |  1 +
 arch/powerpc/kernel/traps.c         | 13 +++++++++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 82026b4..863b356 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -43,6 +43,7 @@ extern int machine_check_e500mc(struct pt_regs *regs);
 extern int machine_check_e500(struct pt_regs *regs);
 extern int machine_check_e200(struct pt_regs *regs);
 extern int machine_check_47x(struct pt_regs *regs);
+extern int machine_check_8xx(struct pt_regs *regs);
 
 extern void cpu_down_flush_e500v2(void);
 extern void cpu_down_flush_e500mc(void);
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 74248ab..f7bee9e 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1229,6 +1229,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.mmu_features		= MMU_FTR_TYPE_8xx,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
+		.machine_check		= machine_check_8xx,
 		.platform		= "ppc823",
 	},
 #endif /* CONFIG_8xx */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 2cb5892..37db564 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -664,6 +664,19 @@ int machine_check_e200(struct pt_regs *regs)
 
 	return 0;
 }
+#elif defined(CONFIG_PPC_8xx)
+int machine_check_8xx(struct pt_regs *regs)
+{
+	unsigned long reason = get_mc_reason(regs);
+
+	printk("Machine check in kernel mode.\n");
+	printk("Caused by (from SRR1=%lx): ", reason);
+	if (reason & 0x40000000)
+		printk("Fetch error at address %lx\n", regs->nip);
+	else
+		printk("Data access error at address %lx\n", regs->dar);
+	return 0;
+}
 #else
 int machine_check_generic(struct pt_regs *regs)
 {
-- 
2.1.0
