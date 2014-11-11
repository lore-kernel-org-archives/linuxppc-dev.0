Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 221EE1A050C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Nov 2014 16:27:25 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DF5D4140188
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2014 16:27:24 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 11 Nov 2014 15:27:24 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DEA272CE806E
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2014 16:27:20 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAB5R8un27852898
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2014 16:27:08 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAB5RIWP030841
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2014 16:27:20 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V4 7/8] powerpc,
 ptrace: Enable support for miscellaneous debug registers
Date: Tue, 11 Nov 2014 10:56:36 +0530
Message-Id: <1415683597-22819-8-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1415683597-22819-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1415683597-22819-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, peterz@infradead.org, palves@redhat.com,
 oleg@redhat.com, davem@davemloft.net, dhowells@redhat.com, davej@redhat.com,
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

This patch enables get and set of miscellaneous debug registers through
ptrace PTRACE_GETREGSET-PTRACE_SETREGSET interface by implementing new
powerpc specific register set REGSET_MISC support corresponding to the
new ELF core note NT_PPC_MISC added previously in this regard.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/uapi/asm/elf.h |   1 +
 arch/powerpc/kernel/ptrace.c        | 102 ++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

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
index b279947..61a2581 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1327,6 +1327,97 @@ static int tm_cvmx_set(struct task_struct *target,
 #endif	/* CONFIG_PPC_TRANSACTIONAL_MEM */
 
 /*
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
+ */
+static int get_misc_dbg(struct task_struct *target,
+			const struct user_regset *regset, unsigned int pos,
+			unsigned int count, void *kbuf, void __user *ubuf)
+{
+	int ret;
+
+	/* Build test */
+	BUILD_BUG_ON(TSO(dscr) + 2 * sizeof(unsigned long) != TSO(ppr));
+	BUILD_BUG_ON(TSO(ppr) + sizeof(unsigned long) != TSO(tar));
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
+	/* TAR register */
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+						&target->thread.tar,
+						2 * sizeof(unsigned long),
+						3 * sizeof(unsigned long));
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
+	BUILD_BUG_ON(TSO(ppr) + sizeof(unsigned long) != TSO(tar));
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
+
+	/* TAR register */
+	if (!ret)
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+						&target->thread.tar,
+						2 * sizeof(unsigned long),
+						3 * sizeof(unsigned long));
+	return ret;
+}
+
+/*
  * These are our native regset flavors.
  */
 enum powerpc_regset {
@@ -1347,6 +1438,7 @@ enum powerpc_regset {
 	REGSET_TM_CFPR,		/* TM checkpointed FPR registers */
 	REGSET_TM_CVMX,		/* TM checkpointed VMX registers */
 #endif
+	REGSET_MISC		/* Miscellaneous debug registers */
 };
 
 static const struct user_regset native_regsets[] = {
@@ -1403,6 +1495,11 @@ static const struct user_regset native_regsets[] = {
 		.active = tm_cvmx_active, .get = tm_cvmx_get, .set = tm_cvmx_set
 	},
 #endif
+	[REGSET_MISC] = {
+		.core_note_type = NT_PPC_MISC, .n = ELF_NMISCREG,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.get = get_misc_dbg, .set = set_misc_dbg
+	},
 };
 
 static const struct user_regset_view user_ppc_native_view = {
@@ -1646,6 +1743,11 @@ static const struct user_regset compat_regsets[] = {
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
