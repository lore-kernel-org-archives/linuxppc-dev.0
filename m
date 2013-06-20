Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F32CC2C033D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 20:28:54 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [v5][PATCH 6/6] book3e/kgdb: Fix a single stgep case of lazy IRQ
Date: Thu, 20 Jun 2013 18:28:30 +0800
Message-ID: <1371724110-8250-7-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1371724110-8250-1-git-send-email-tiejun.chen@windriver.com>
References: <1371724110-8250-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we're in kgdb_singlestep(), we have to work around to get
thread_info by copying from the kernel stack before calling
kgdb_handle_exception(), then copying it back afterwards.

But for PPC64, we have a lazy interrupt implementation. So after
copying thread info frome kernle stack, if we need to replay an
interrupt, we shouldn't restore that previous backup thread info
to make sure we can replay an interrupt lately with a proper
thread info.

This patch use __check_irq_replay() to guarantee this process.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kernel/irq.c  |   10 ++++++++++
 arch/powerpc/kernel/kgdb.c |    3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index ea185e0..3625453 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -339,7 +339,17 @@ bool prep_irq_for_idle(void)
 	return true;
 }
 
+notrace unsigned int check_irq_replay(void)
+{
+	return __check_irq_replay();
+}
+#else
+notrace unsigned int check_irq_replay(void)
+{
+	return 0;
+}
 #endif /* CONFIG_PPC64 */
+EXPORT_SYMBOL(check_irq_replay);
 
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index cde7818..5b30408 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -152,6 +152,7 @@ static int kgdb_handle_breakpoint(struct pt_regs *regs)
 }
 
 static DEFINE_PER_CPU(struct thread_info, kgdb_thread_info);
+extern notrace unsigned int check_irq_replay(void);
 static int kgdb_singlestep(struct pt_regs *regs)
 {
 	struct thread_info *thread_info, *exception_thread_info;
@@ -181,7 +182,7 @@ static int kgdb_singlestep(struct pt_regs *regs)
 
 	kgdb_handle_exception(0, SIGTRAP, 0, regs);
 
-	if (thread_info != exception_thread_info)
+	if ((thread_info != exception_thread_info) && (!check_irq_replay()))
 		/* Restore current_thread_info lastly. */
 		memcpy(exception_thread_info, backup_current_thread_info, sizeof *thread_info);
 
-- 
1.7.9.5
