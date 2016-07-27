Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzqQW4wCZzDrK7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 19:27:31 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id hh10so1464969pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 02:27:31 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Shuah Khan <shuahkh@osg.samsung.com>,
 Anton Blanchard <anton@samba.org>, Cyril Bur <cyrilbur@gmail.com>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>,
 Khem Raj <raj.khem@gmail.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Chris Smart <chris@distroguy.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v12 02/30] powerpc/process: Add the function
 flush_tmregs_to_thread
Date: Wed, 27 Jul 2016 17:26:27 +0800
Message-Id: <1469611615-2935-3-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1469611615-2935-1-git-send-email-wei.guo.simon@gmail.com>
References: <1469611615-2935-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

This patch creates a function flush_tmregs_to_thread which
will then be used by subsequent patches in this series. The
function checks for self tracing ptrace interface attempts
while in the TM context and logs appropriate warning message.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shuah Khan <shuahkh@osg.samsung.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Cyril Bur <cyrilbur@gmail.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Simon Guo <wei.guo.simon@gmail.com>
Cc: Ulrich Weigand <ulrich.weigand@de.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Rashmica Gupta <rashmicy@gmail.com>
Cc: Khem Raj <raj.khem@gmail.com>
Cc: Jessica Yu <jeyu@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: Chris Smart <chris@distroguy.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/switch_to.h |  8 ++++++++
 arch/powerpc/kernel/process.c        | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 17c8380..0a74ebe 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -75,6 +75,14 @@ static inline void disable_kernel_spe(void)
 static inline void __giveup_spe(struct task_struct *t) { }
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
index 0b93893..e9f7f52 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1051,6 +1051,26 @@ static inline void restore_sprs(struct thread_struct *old_thread,
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
1.8.3.1
