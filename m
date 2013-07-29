Return-Path: <afleming@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A52392C00E8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 09:33:17 +1000 (EST)
From: Andy Fleming <afleming@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 1/2] powerpc: Add smp_generic_cpu_bootable
Date: Mon, 29 Jul 2013 18:33:04 -0500
Message-ID: <1375140785-9782-1-git-send-email-afleming@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cell and PSeries both implemented their own versions of a
cpu_bootable smp_op which do the same thing (well, the PSeries
one has support for more than 2 threads). Copy the PSeries one
to generic code, and rename it smp_generic_cpu_bootable.

Signed-off-by: Andy Fleming <afleming@freescale.com>
---

v2: Removed Change-Id

 arch/powerpc/include/asm/smp.h |    2 ++
 arch/powerpc/kernel/smp.c      |   23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index ffbaabe..f2b5d41 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -182,6 +182,8 @@ extern int smt_enabled_at_boot;
 extern int smp_mpic_probe(void);
 extern void smp_mpic_setup_cpu(int cpu);
 extern int smp_generic_kick_cpu(int nr);
+extern int smp_generic_cpu_bootable(unsigned int nr);
+
 
 extern void smp_generic_give_timebase(void);
 extern void smp_generic_take_timebase(void);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 38b0ba6..3cd42aa 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -81,6 +81,29 @@ int smt_enabled_at_boot = 1;
 
 static void (*crash_ipi_function_ptr)(struct pt_regs *) = NULL;
 
+/*
+ * Returns 1 if the specified cpu should be brought up during boot.
+ * Used to inhibit booting threads if they've been disabled or
+ * limited on the command line
+ */
+int smp_generic_cpu_bootable(unsigned int nr)
+{
+	/* Special case - we inhibit secondary thread startup
+	 * during boot if the user requests it.
+	 */
+	if (system_state == SYSTEM_BOOTING && cpu_has_feature(CPU_FTR_SMT)) {
+		if (!smt_enabled_at_boot && cpu_thread_in_core(nr) != 0)
+			return 0;
+		if (smt_enabled_at_boot
+		    && cpu_thread_in_core(nr) >= smt_enabled_at_boot)
+			return 0;
+	}
+
+	return 1;
+}
+EXPORT_SYMBOL(smp_generic_cpu_bootable);
+
+
 #ifdef CONFIG_PPC64
 int smp_generic_kick_cpu(int nr)
 {
-- 
1.7.9.7
