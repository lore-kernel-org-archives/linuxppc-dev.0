Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 36DF41A04B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 19:05:58 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 692571401AC
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 19:05:57 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 18:05:56 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6CE5F2BB005B
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 19:05:54 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAP85s8m41484428
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 19:05:54 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAP85qcK002222
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 19:05:54 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [V5 2/7] powerpc, process: Add the function flush_tmregs_to_thread
Date: Tue, 25 Nov 2014 13:35:26 +0530
Message-Id: <1416902731-22446-3-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1416902731-22446-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1416902731-22446-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: shuahkh@osg.samsung.com, mikey@neuling.org, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, peterz@infradead.org,
 palves@redhat.com, oleg@redhat.com, davem@davemloft.net, dhowells@redhat.com,
 kirjanov@gmail.com, davej@redhat.com, akpm@linux-foundation.org,
 sukadev@linux.vnet.ibm.com, tglx@linutronix.de, sam.bobroff@au1.ibm.com
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
index 58abeda..23752a9 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -82,6 +82,14 @@ static inline void flush_spe_to_thread(struct task_struct *t)
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
index 923cd2d..0013f24 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -745,6 +745,26 @@ void restore_tm_state(struct pt_regs *regs)
 #define __switch_to_tm(prev)
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
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
1.9.3
