Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 245661A06A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 19:06:15 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 77BEA1401DD
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 19:06:14 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 18:06:14 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C1F623578047
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 19:06:12 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAP86CgT31457344
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 19:06:12 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAP86AIp002804
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 19:06:12 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [V5 6/7] powerpc,
 ptrace: Enable support for miscellaneous debug registers
Date: Tue, 25 Nov 2014 13:35:30 +0530
Message-Id: <1416902731-22446-7-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch enables get and set of miscellaneous debug registers through
ptrace PTRACE_GETREGSET-PTRACE_SETREGSET interface by implementing new
powerpc specific register set REGSET_MISC support corresponding to the
new ELF core note NT_PPC_MISC added previously in this regard.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/uapi/asm/elf.h |   1 +
 arch/powerpc/kernel/ptrace.c        | 123 ++++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/elf.h b/arch/powerpc/include/uapi/asm/elf.h
index fdc8e2f..a41bd98 100644
--- a/arch/powerpc/include/uapi/asm/elf.h
+++ b/arch/powerpc/include/uapi/asm/elf.h
@@ -93,6 +93,7 @@
 #define ELF_NFPREG	33	/* includes fpscr */
 #define ELF_NVMX	34	/* includes all vector registers */
 #define ELF_NTMSPRREG	7	/* includes TM sprs, org_msr, dscr, tar, ppr */
+#define ELF_NMISCREG	3	/* includes dscr, tar, ppr */
 
 typedef unsigned long elf_greg_t64;
 typedef elf_greg_t64 elf_gregset_t64[ELF_NGREG];
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index faa9058..61cc7ae 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1324,6 +1324,114 @@ static int tm_cvmx_set(struct task_struct *target,
 }
 #endif	/* CONFIG_PPC_TRANSACTIONAL_MEM */
 
+#ifdef CONFIG_PPC64
+/*
+ * get_misc_dbg
+ *
+ * This function gets miscellaneous debug registers
+ * which includes DSCR, PPR and TAR.
+ *
+ * Userspace intarface buffer layout:
+ *
+ * struct {
+ *	unsigned long dscr;
+ *	unsigned long ppr;
+ *	unsigned long tar;
+ * };
+ *
+ * The data element 'tar' will be valid only if the
+ * kernel has CONFIG_PPC_BOOK3S_64 config option enabled.
+ */
+static int get_misc_dbg(struct task_struct *target,
+			const struct user_regset *regset, unsigned int pos,
+			unsigned int count, void *kbuf, void __user *ubuf)
+{
+	int ret;
+
+	/* Build test */
+	BUILD_BUG_ON(TSO(dscr) + 2 * sizeof(unsigned long) != TSO(ppr));
+
+#ifdef CONFIG_PPC_BOOK3S_64
+	BUILD_BUG_ON(TSO(ppr) + sizeof(unsigned long) != TSO(tar));
+#endif
+
+	/* DSCR register */
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					&target->thread.dscr, 0,
+					sizeof(unsigned long));
+
+	/* PPR register */
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+						&target->thread.ppr,
+						sizeof(unsigned long),
+						2 * sizeof(unsigned long));
+
+#ifdef CONFIG_PPC_BOOK3S_64
+	/* TAR register */
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+						&target->thread.tar,
+						2 * sizeof(unsigned long),
+						3 * sizeof(unsigned long));
+#endif
+	return ret;
+}
+
+/*
+ * set_misc_dbg
+ *
+ * This function sets miscellaneous debug registers
+ * which includes DSCR, PPR and TAR.
+ *
+ * Userspace intarface buffer layout:
+ *
+ * struct {
+ *	unsigned long dscr;
+ *	unsigned long ppr;
+ *	unsigned long tar;
+ * };
+ *
+ * The data element 'tar' will be valid only if the
+ * kernel has CONFIG_PPC_BOOK3S_64 config option enabled.
+ */
+static int set_misc_dbg(struct task_struct *target,
+			const struct user_regset *regset, unsigned int pos,
+			unsigned int count, const void *kbuf,
+			const void __user *ubuf)
+{
+	int ret;
+
+	/* Build test */
+	BUILD_BUG_ON(TSO(dscr) + 2 * sizeof(unsigned long) != TSO(ppr));
+
+#ifdef CONFIG_PPC_BOOK3S_64
+	BUILD_BUG_ON(TSO(ppr) + sizeof(unsigned long) != TSO(tar));
+#endif
+
+	/* DSCR register */
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+					&target->thread.dscr, 0,
+					sizeof(unsigned long));
+
+	/* PPR register */
+	if (!ret)
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+						&target->thread.ppr,
+						sizeof(unsigned long),
+						2 * sizeof(unsigned long));
+#ifdef CONFIG_PPC_BOOK3S_64
+	/* TAR register */
+	if (!ret)
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+						&target->thread.tar,
+						2 * sizeof(unsigned long),
+						3 * sizeof(unsigned long));
+#endif
+	return ret;
+}
+#endif /* CONFIG_PPC64 */
+
 /*
  * These are our native regset flavors.
  */
@@ -1345,6 +1453,9 @@ enum powerpc_regset {
 	REGSET_TM_CFPR,		/* TM checkpointed FPR registers */
 	REGSET_TM_CVMX,		/* TM checkpointed VMX registers */
 #endif
+#ifdef CONFIG_PPC64
+	REGSET_MISC		/* Miscellaneous debug registers */
+#endif
 };
 
 static const struct user_regset native_regsets[] = {
@@ -1401,6 +1512,13 @@ static const struct user_regset native_regsets[] = {
 		.active = tm_cvmx_active, .get = tm_cvmx_get, .set = tm_cvmx_set
 	},
 #endif
+#ifdef CONFIG_PPC64
+	[REGSET_MISC] = {
+		.core_note_type = NT_PPC_MISC, .n = ELF_NMISCREG,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.get = get_misc_dbg, .set = set_misc_dbg
+	},
+#endif
 };
 
 static const struct user_regset_view user_ppc_native_view = {
@@ -1647,6 +1765,11 @@ static const struct user_regset compat_regsets[] = {
 		.active = tm_cvmx_active, .get = tm_cvmx_get, .set = tm_cvmx_set
 	},
 #endif
+	[REGSET_MISC] = {
+		.core_note_type = NT_PPC_MISC, .n = ELF_NMISCREG,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.get = get_misc_dbg, .set = set_misc_dbg
+	},
 };
 
 static const struct user_regset_view user_ppc_compat_view = {
-- 
1.9.3
