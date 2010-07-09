Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 35528B6F04
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 16:17:00 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id o696GvnB027056
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:16:57 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o696GxhK1667324
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:16:59 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o696GxdS003365
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:16:59 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/13] powerpc/book3e: Hack to get gdb moving along on Book3E
	64-bit
Date: Fri,  9 Jul 2010 16:16:44 +1000
Message-Id: <1278656215-24705-2-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1278656215-24705-1-git-send-email-benh@kernel.crashing.org>
References: <1278656215-24705-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Our handling of debug interrupts on Book3E 64-bit is not quite
the way it should be just yet. This is a workaround to let gdb
work at least for now. We ensure that when context switching,
we set the appropriate DBCR0 value for the new task. We also
make sure that we turn off MSR[DE] within the kernel, and set
it as part of the bits that get set when going back to userspace.

In the long run, we will probably set the userspace DBCR0 on the
exception exit code path and ensure we have some proper kernel
value to set on the way into the kernel, a bit like ppc32 does,
but that will take more work.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/reg_booke.h |    4 ++--
 arch/powerpc/kernel/process.c        |   22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 2360317..66dc6f0 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -29,8 +29,8 @@
 #if defined(CONFIG_PPC_BOOK3E_64)
 #define MSR_		MSR_ME | MSR_CE
 #define MSR_KERNEL      MSR_ | MSR_CM
-#define MSR_USER32	MSR_ | MSR_PR | MSR_EE
-#define MSR_USER64	MSR_USER32 | MSR_CM
+#define MSR_USER32	MSR_ | MSR_PR | MSR_EE | MSR_DE
+#define MSR_USER64	MSR_USER32 | MSR_CM | MSR_DE
 #elif defined (CONFIG_40x)
 #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE)
 #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 1e78453..551f671 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -477,6 +477,28 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	new_thread = &new->thread;
 	old_thread = &current->thread;
 
+#if defined(CONFIG_PPC_BOOK3E_64)
+	/* XXX Current Book3E code doesn't deal with kernel side DBCR0,
+	 * we always hold the user values, so we set it now.
+	 *
+	 * However, we ensure the kernel MSR:DE is appropriately cleared too
+	 * to avoid spurrious single step exceptions in the kernel.
+	 *
+	 * This will have to change to merge with the ppc32 code at some point,
+	 * but I don't like much what ppc32 is doing today so there's some
+	 * thinking needed there
+	 */
+	if ((new_thread->dbcr0 | old_thread->dbcr0) & DBCR0_IDM) {
+		u32 dbcr0;
+
+		mtmsr(mfmsr() & ~MSR_DE);
+		isync();
+		dbcr0 = mfspr(SPRN_DBCR0);
+		dbcr0 = (dbcr0 & DBCR0_EDM) | new_thread->dbcr0;
+		mtspr(SPRN_DBCR0, dbcr0);
+	}
+#endif /* CONFIG_PPC64_BOOK3E */
+
 #ifdef CONFIG_PPC64
 	/*
 	 * Collect processor utilization data per process
-- 
1.6.3.3
