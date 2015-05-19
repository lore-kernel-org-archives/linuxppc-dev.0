Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D91CD1A15D9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 01:12:07 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 330EB140D4E
 for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2015 01:12:07 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:42:05 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 65808E0059
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:45:06 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4JFAeuk32571436
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:42:02 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4JF8Ubg028283
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:35 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V8 13/28] powerpc, ptrace: Enable support for NT_PPPC_TAR,
 NT_PPC_PPR, NT_PPC_DSCR
Date: Tue, 19 May 2015 20:38:09 +0530
Message-Id: <1432048104-4695-14-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: shuahkh@osg.samsung.com, mikey@neuling.org, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, peterz@infradead.org,
 palves@redhat.com, nacc@linux.vnet.ibm.com, emachado@linux.vnet.ibm.com,
 oleg@redhat.com, davem@davemloft.net, dhowells@redhat.com,
 Ulrich.Weigand@de.ibm.com, kirjanov@gmail.com, davej@redhat.com,
 akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com, tglx@linutronix.de,
 sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables support for running TAR, PPR, DSCR registers
related ELF core notes NT_PPPC_TAR, NT_PPC_PPR, NT_PPC_DSCR based
ptrace requests through PTRACE_GETREGSET, PTRACE_SETREGSET calls.
This is achieved through adding three new register sets REGSET_TAR,
REGSET_PPR, REGSET_DSCR in powerpc corresponding to the ELF core
note sections added in this regad. It implements the get, set and
active functions for all these new register sets added.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c | 117 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 774f5c20..533c787 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1688,6 +1688,78 @@ static int tm_dscr_set(struct task_struct *target,
 }
 #endif	/* CONFIG_PPC_TRANSACTIONAL_MEM */
 
+#ifdef CONFIG_PPC64
+static int ppr_get(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      void *kbuf, void __user *ubuf)
+{
+	int ret;
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				&target->thread.ppr, 0, sizeof(u64));
+	return ret;
+}
+
+static int ppr_set(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				&target->thread.ppr, 0, sizeof(u64));
+	return ret;
+}
+
+static int dscr_get(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      void *kbuf, void __user *ubuf)
+{
+	int ret;
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				&target->thread.dscr, 0, sizeof(u64));
+	return ret;
+}
+static int dscr_set(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				&target->thread.dscr, 0, sizeof(u64));
+	return ret;
+}
+#endif
+#ifdef CONFIG_PPC_BOOK3S_64
+static int tar_get(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      void *kbuf, void __user *ubuf)
+{
+	int ret;
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				&target->thread.tar, 0, sizeof(u64));
+	return ret;
+}
+static int tar_set(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				&target->thread.tar, 0, sizeof(u64));
+	return ret;
+}
+#endif
 /*
  * These are our native regset flavors.
  */
@@ -1713,6 +1785,13 @@ enum powerpc_regset {
 	REGSET_TM_CPPR,		/* TM checkpointed PPR register */
 	REGSET_TM_CDSCR,	/* TM checkpointed DSCR register */
 #endif
+#ifdef CONFIG_PPC64
+	REGSET_PPR,		/* PPR register */
+	REGSET_DSCR,		/* DSCR register */
+#endif
+#ifdef CONFIG_PPC_BOOK3S_64
+	REGSET_TAR,		/* TAR register */
+#endif
 };
 
 static const struct user_regset native_regsets[] = {
@@ -1789,6 +1868,25 @@ static const struct user_regset native_regsets[] = {
 		.active = tm_dscr_active, .get = tm_dscr_get, .set = tm_dscr_set
 	},
 #endif
+#ifdef CONFIG_PPC64
+	[REGSET_PPR] = {
+		.core_note_type = NT_PPC_PPR, .n = 1,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.get = ppr_get, .set = ppr_set
+	},
+	[REGSET_DSCR] = {
+		.core_note_type = NT_PPC_DSCR, .n = 1,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.get = dscr_get, .set = dscr_set
+	},
+#endif
+#ifdef CONFIG_PPC_BOOK3S_64
+	[REGSET_TAR] = {
+		.core_note_type = NT_PPC_TAR, .n = 1,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.get = tar_get, .set = tar_set
+	},
+#endif
 };
 
 static const struct user_regset_view user_ppc_native_view = {
@@ -2056,6 +2154,25 @@ static const struct user_regset compat_regsets[] = {
 		.active = tm_dscr_active, .get = tm_dscr_get, .set = tm_dscr_set
 	},
 #endif
+#ifdef CONFIG_PPC64
+	[REGSET_PPR] = {
+		.core_note_type = NT_PPC_PPR, .n = 1,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.get = ppr_get, .set = ppr_set
+	},
+	[REGSET_DSCR] = {
+		.core_note_type = NT_PPC_DSCR, .n = 1,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.get = dscr_get, .set = dscr_set
+	},
+#endif
+#ifdef CONFIG_PPC_BOOK3S_64
+	[REGSET_TAR] = {
+		.core_note_type = NT_PPC_TAR, .n = 1,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.get = tar_get, .set = tar_set
+	},
+#endif
 };
 
 static const struct user_regset_view user_ppc_compat_view = {
-- 
2.1.0
