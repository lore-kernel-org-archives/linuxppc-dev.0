Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2752810083F
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 16:17:03 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id o696GoGE023517
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:16:50 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o696H2wP352288
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:02 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o696H1vm011408
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:01 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/13] powerpc/book3e: Resend doorbell exceptions to ourself
Date: Fri,  9 Jul 2010 16:16:50 +1000
Message-Id: <1278656215-24705-8-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1278656215-24705-7-git-send-email-benh@kernel.crashing.org>
References: <1278656215-24705-1-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-2-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-3-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-4-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-5-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-6-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-7-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>

If we are soft disabled and receive a doorbell exception we don't process
it immediately. This means we need to check on the way out of irq restore
if there are any doorbell exceptions to process.

The problem is at that point we don't know what our regs are, and that
in turn makes xmon unhappy. To workaround the problem, instead of checking
for and processing doorbells, we check for any doorbells and if there were
any we send ourselves another.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/dbell.h |    1 +
 arch/powerpc/kernel/dbell.c      |   10 ++++++++++
 arch/powerpc/kernel/irq.c        |    4 ++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index ced7e48..0893ab9 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -29,6 +29,7 @@ enum ppc_dbell {
 
 extern void doorbell_message_pass(int target, int msg);
 extern void doorbell_exception(struct pt_regs *regs);
+extern void doorbell_check_self(void);
 extern void doorbell_setup_this_cpu(void);
 
 static inline void ppc_msgsnd(enum ppc_dbell type, u32 flags, u32 tag)
diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
index f7b5188..3307a52 100644
--- a/arch/powerpc/kernel/dbell.c
+++ b/arch/powerpc/kernel/dbell.c
@@ -81,6 +81,16 @@ out:
 	set_irq_regs(old_regs);
 }
 
+void doorbell_check_self(void)
+{
+	struct doorbell_cpu_info *info = &__get_cpu_var(doorbell_cpu_info);
+
+	if (!info->messages)
+		return;
+
+	ppc_msgsnd(PPC_DBELL, 0, info->tag);
+}
+
 #else /* CONFIG_SMP */
 void doorbell_exception(struct pt_regs *regs)
 {
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 2f6dc7f..8f96d31 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -156,8 +156,8 @@ notrace void raw_local_irq_restore(unsigned long en)
 		return;
 
 #if defined(CONFIG_BOOKE) && defined(CONFIG_SMP)
-	/* Check for pending doorbell interrupts on SMP */
-	doorbell_exception(NULL);
+	/* Check for pending doorbell interrupts and resend to ourself */
+	doorbell_check_self();
 #endif
 
 	/*
-- 
1.6.3.3
