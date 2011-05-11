Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id EC3C4100A18
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:41 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <cdf747e1d383e4ecd054be7b5fb3af0c4e157991.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:29:35 -0500
Subject: [PATCH 18/37] powerpc: move smp_ops_t from machdep.h to smp.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I can't see any reason these functions are needed by machdep.h
and they are all hidden by CONFIG_SMP with no UP alternative.

Also move the declarations for the fallback timebase ops, which
are used to fill in the smp ops.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
 arch/powerpc/include/asm/machdep.h |   21 ---------------------
 arch/powerpc/include/asm/smp.h     |   15 +++++++++++++++
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index b0802a5..47cacdd 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -29,21 +29,6 @@ struct file;
 struct pci_controller;
 struct kimage;
 
-#ifdef CONFIG_SMP
-struct smp_ops_t {
-	void  (*message_pass)(int cpu, int msg);
-	int   (*probe)(void);
-	int   (*kick_cpu)(int nr);
-	void  (*setup_cpu)(int nr);
-	void  (*bringup_done)(void);
-	void  (*take_timebase)(void);
-	void  (*give_timebase)(void);
-	int   (*cpu_disable)(void);
-	void  (*cpu_die)(unsigned int nr);
-	int   (*cpu_bootable)(unsigned int nr);
-};
-#endif
-
 struct machdep_calls {
 	char		*name;
 #ifdef CONFIG_PPC64
@@ -312,12 +297,6 @@ extern sys_ctrler_t sys_ctrler;
 
 #endif /* CONFIG_PPC_PMAC */
 
-#ifdef CONFIG_SMP
-/* Poor default implementations */
-extern void __devinit smp_generic_give_timebase(void);
-extern void __devinit smp_generic_take_timebase(void);
-#endif /* CONFIG_SMP */
-
 
 /* Functions to produce codes on the leds.
  * The SRC code should be unique for the message category and should
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 91472c5..6f7c95c 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -35,9 +35,24 @@ extern void cpu_die(void);
 
 #ifdef CONFIG_SMP
 
+struct smp_ops_t {
+	void  (*message_pass)(int cpu, int msg);
+	int   (*probe)(void);
+	int   (*kick_cpu)(int nr);
+	void  (*setup_cpu)(int nr);
+	void  (*bringup_done)(void);
+	void  (*take_timebase)(void);
+	void  (*give_timebase)(void);
+	int   (*cpu_disable)(void);
+	void  (*cpu_die)(unsigned int nr);
+	int   (*cpu_bootable)(unsigned int nr);
+};
+
 extern void smp_send_debugger_break(void);
 extern void smp_message_recv(int);
 extern void start_secondary_resume(void);
+extern void __devinit smp_generic_give_timebase(void);
+extern void __devinit smp_generic_take_timebase(void);
 
 DECLARE_PER_CPU(unsigned int, cpu_pvr);
 
-- 
1.7.0.4
