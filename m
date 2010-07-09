Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 45BEEB6F01
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 16:17:01 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id o696Gxkg027074
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:16:59 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o696H0xm1527998
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:00 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o696Gxc7003382
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:00 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/13] powerpc/book3e: Move doorbell_exception from traps.c to
	dbell.c
Date: Fri,  9 Jul 2010 16:16:45 +1000
Message-Id: <1278656215-24705-3-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1278656215-24705-2-git-send-email-benh@kernel.crashing.org>
References: <1278656215-24705-1-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-2-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

... where it belongs

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/dbell.c |   22 +++++++++++++++++++++-
 arch/powerpc/kernel/traps.c |   21 ---------------------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
index 1493734..e3a7177 100644
--- a/arch/powerpc/kernel/dbell.c
+++ b/arch/powerpc/kernel/dbell.c
@@ -41,4 +41,24 @@ void smp_dbell_message_pass(int target, int msg)
 		ppc_msgsnd(PPC_DBELL, PPC_DBELL_MSG_BRDCAST, 0);
 	}
 }
-#endif
+
+void doorbell_exception(struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+	int msg;
+
+	if (num_online_cpus() < 2)
+		return;
+
+	for (msg = 0; msg < 4; msg++)
+		if (test_and_clear_bit(msg, &dbell_smp_message[cpu]))
+			smp_message_recv(msg);
+}
+
+#else /* CONFIG_SMP */
+void doorbell_exception(struct pt_regs *regs)
+{
+	printk(KERN_WARNING "Received doorbell on non-smp system\n");
+}
+#endif /* CONFIG_SMP */
+
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index e5fe5a8..a45a63c 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -55,9 +55,6 @@
 #endif
 #include <asm/kexec.h>
 #include <asm/ppc-opcode.h>
-#ifdef CONFIG_FSL_BOOKE
-#include <asm/dbell.h>
-#endif
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
 int (*__debugger)(struct pt_regs *regs) __read_mostly;
@@ -1342,24 +1339,6 @@ void vsx_assist_exception(struct pt_regs *regs)
 #endif /* CONFIG_VSX */
 
 #ifdef CONFIG_FSL_BOOKE
-
-void doorbell_exception(struct pt_regs *regs)
-{
-#ifdef CONFIG_SMP
-	int cpu = smp_processor_id();
-	int msg;
-
-	if (num_online_cpus() < 2)
-		return;
-
-	for (msg = 0; msg < 4; msg++)
-		if (test_and_clear_bit(msg, &dbell_smp_message[cpu]))
-			smp_message_recv(msg);
-#else
-	printk(KERN_WARNING "Received doorbell on non-smp system\n");
-#endif
-}
-
 void CacheLockingException(struct pt_regs *regs, unsigned long address,
 			   unsigned long error_code)
 {
-- 
1.6.3.3
