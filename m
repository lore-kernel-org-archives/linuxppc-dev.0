Return-Path: <srs0=cc4y=bg=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y89Rp49JBzDqnb
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 13:28:54 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3y89Rp2kKfz8vjD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 13:28:54 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3y89Rn5FW8z9t8C
 for <linuxppc-dev@ozlabs.org>; Sat,  7 Oct 2017 13:28:53 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v972OZoi077659
 for <linuxppc-dev@ozlabs.org>; Fri, 6 Oct 2017 22:28:51 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2deex8qe1h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 06 Oct 2017 22:28:51 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 6 Oct 2017 20:28:50 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 14/18] powerpc: Define set_thread_used_vas()
Date: Fri,  6 Oct 2017 19:28:14 -0700
In-Reply-To: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1507343298-27496-15-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A CP_ABORT instruction is required in processes that have mapped a VAS
"paste address" with the intention of using COPY/PASTE instructions.
But since CP_ABORT is expensive, we want to restrict it to only processes
that use/intend to use COPY/PASTE.

Define an interface, set_thread_used_vas(), that VAS can use to indicate
that the current process opened a send window. During context switch,
issue CP_ABORT only for processes that have the flag set.

Thanks for input from Nick Piggin, Michael Ellerman.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/processor.h |  2 ++
 arch/powerpc/include/asm/switch_to.h |  2 ++
 arch/powerpc/kernel/process.c        | 32 ++++++++++++++++++++++----------
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 58cc212..bdab3b74 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -341,7 +341,9 @@ struct thread_struct {
 	unsigned long	sier;
 	unsigned long	mmcr2;
 	unsigned 	mmcr0;
+
 	unsigned 	used_ebb;
+	unsigned int	used_vas;
 #endif
 };
 
diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index f5da32f..aeb305b 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -91,6 +91,8 @@ static inline void clear_task_ebb(struct task_struct *t)
 #endif
 }
 
+extern int set_thread_used_vas(void);
+
 extern int set_thread_tidr(struct task_struct *t);
 extern void clear_thread_tidr(struct task_struct *t);
 
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index d861fcd..cb5f108 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1234,17 +1234,17 @@ struct task_struct *__switch_to(struct task_struct *prev,
 		 * The copy-paste buffer can only store into foreign real
 		 * addresses, so unprivileged processes can not see the
 		 * data or use it in any way unless they have foreign real
-		 * mappings. We don't have a VAS driver that allocates those
-		 * yet, so no cpabort is required.
+		 * mappings. If the new process has the foreign real address
+		 * mappings, we must issue a cp_abort to clear any state and
+		 * prevent a covert channel being setup.
+		 *
+		 * DD1 allows paste into normal system memory so we do an
+		 * unpaired copy, rather than cp_abort, to clear the buffer,
+		 * since cp_abort is quite expensive.
 		 */
-		if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
-			/*
-			 * DD1 allows paste into normal system memory, so we
-			 * do an unpaired copy here to clear the buffer and
-			 * prevent a covert channel being set up.
-			 *
-			 * cpabort is not used because it is quite expensive.
-			 */
+		if (new_thread->used_vas) {
+			asm volatile(PPC_CP_ABORT);
+		} else if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
 			asm volatile(PPC_COPY(%0, %1)
 					: : "r"(dummy_copy_buffer), "r"(0));
 		}
@@ -1445,6 +1445,18 @@ void flush_thread(void)
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 }
 
+int set_thread_used_vas(void)
+{
+#ifdef CONFIG_PPC_BOOK3S_64
+	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		return -EINVAL;
+
+	current->thread.used_vas = 1;
+
+#endif /* CONFIG_PPC_BOOK3S_64 */
+	return 0;
+}
+
 #ifdef CONFIG_PPC64
 static DEFINE_SPINLOCK(vas_thread_id_lock);
 static DEFINE_IDA(vas_thread_ida);
-- 
2.7.4
