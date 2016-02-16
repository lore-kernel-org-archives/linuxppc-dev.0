Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 25EAE1A006F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 20:01:41 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E5C6F1401AF
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:40 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 19:01:39 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 359643578052
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:37 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1G91T0K61472828
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:37 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1G90xlS017561
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:04 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: peterz@infradead.org, akpm@linux-foundation.org, tglx@linutronix.de,
 james.hogan@imgtec.com, avagin@openvz.org, Paul.Clothier@imgtec.com,
 palves@redhat.com, oleg@redhat.com, dhowells@redhat.com,
 davej@redhat.com, davem@davemloft.net, mikey@neuling.org,
 benh@kernel.crashing.org, sukadev@linux.vnet.ibm.com,
 mpe@ellerman.id.au, sam.bobroff@au1.ibm.com, kirjanov@gmail.com,
 shuahkh@osg.samsung.com, Ulrich.Weigand@de.ibm.com,
 emachado@linux.vnet.ibm.com
Subject: [PATCH V10 02/28] powerpc,
 process: Add the function flush_tmregs_to_thread
Date: Tue, 16 Feb 2016 14:29:32 +0530
Message-Id: <1455613198-5113-3-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch creates a function flush_tmregs_to_thread which
will then be used by subsequent patches in this series. The
function checks for self tracing ptrace interface attempts
while in the TM context and logs appropriate warning message.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/switch_to.h |  8 ++++++++
 arch/powerpc/kernel/process.c        | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 5b268b6..7b297bf 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -70,6 +70,14 @@ static inline void disable_kernel_spe(void)
 }
 #endif
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+extern void flush_tmregs_to_thread(struct task_struct *);
+#else
+static inline void flush_tmregs_to_thread(struct task_struct *t)
+{
+}
+#endif
+
 static inline void clear_task_ebb(struct task_struct *t)
 {
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index dccc87e..2c4fa7f 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -918,6 +918,26 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 #endif
 }
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+void flush_tmregs_to_thread(struct task_struct *tsk)
+{
+	/*
+	 * Process self tracing is not yet supported through
+	 * ptrace interface. Ptrace generic code should have
+	 * prevented this from happening in the first place.
+	 * Warn once here with the message, if some how it
+	 * is attempted.
+	 */
+	WARN_ONCE(tsk == current,
+		"Not expecting ptrace on self: TM regs may be incorrect\n");
+
+	/*
+	 * If task is not current, it should have been flushed
+	 * already to it's thread_struct during __switch_to().
+	 */
+}
+#endif
+
 struct task_struct *__switch_to(struct task_struct *prev,
 	struct task_struct *new)
 {
-- 
2.1.0
