Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F6A11A0038
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 20:02:28 +1100 (AEDT)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D51FA1409B7
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:02:27 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 19:02:27 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EB27E3578057
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:02:25 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1G92HZx31064292
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:02:25 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1G91p6I020452
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:53 +1100
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
Subject: [PATCH V10 14/28] powerpc, ptrace: Enable support for EBB registers
Date: Tue, 16 Feb 2016 14:29:44 +0530
Message-Id: <1455613198-5113-15-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch enables support for EBB state registers related
ELF core note NT_PPC_EBB based ptrace requests through
PTRACE_GETREGSET, PTRACE_SETREGSET calls. This is achieved
through adding one new register sets REGSET_EBB in powerpc
corresponding to the ELF core note sections added in this
regard. It also implements the get, set and active functions
for this new register sets added.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/uapi/asm/elf.h |   3 +
 arch/powerpc/kernel/ptrace.c        | 147 ++++++++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/elf.h b/arch/powerpc/include/uapi/asm/elf.h
index e703c64..64945d2 100644
--- a/arch/powerpc/include/uapi/asm/elf.h
+++ b/arch/powerpc/include/uapi/asm/elf.h
@@ -94,6 +94,9 @@
 #define ELF_NVMX	34	/* includes all vector registers */
 #define ELF_NVSX	32	/* includes all VSX registers */
 #define ELF_NTMSPRREG	3	/* include tfhar, tfiar, texasr */
+#define ELF_NEBB	8	/* includes ebbrr, ebbhr, bescr, siar,
+				 * sdar, sier, mmcr2, mmcr0
+				 */
 
 typedef unsigned long elf_greg_t64;
 typedef elf_greg_t64 elf_gregset_t64[ELF_NGREG];
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 587f031..b063fc4 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1760,6 +1760,142 @@ static int tar_set(struct task_struct *target,
 				&target->thread.tar, 0, sizeof(u64));
 	return ret;
 }
+
+static int ebb_active(struct task_struct *target,
+			 const struct user_regset *regset)
+{
+	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
+		return -ENODEV;
+
+	if (target->thread.used_ebb)
+		return regset->n;
+
+	return 0;
+}
+
+static int ebb_get(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      void *kbuf, void __user *ubuf)
+{
+	int ret;
+
+	/* Build tests */
+	BUILD_BUG_ON(TSO(ebbrr) + sizeof(unsigned long) != TSO(ebbhr));
+	BUILD_BUG_ON(TSO(ebbhr) + sizeof(unsigned long) != TSO(bescr));
+	BUILD_BUG_ON(TSO(bescr) + sizeof(unsigned long) != TSO(siar));
+	BUILD_BUG_ON(TSO(siar) + sizeof(unsigned long) != TSO(sdar));
+	BUILD_BUG_ON(TSO(sdar) + sizeof(unsigned long) != TSO(sier));
+	BUILD_BUG_ON(TSO(sier) + sizeof(unsigned long) != TSO(mmcr2));
+	BUILD_BUG_ON(TSO(mmcr2) + sizeof(unsigned long) != TSO(mmcr0));
+
+	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
+		return -ENODEV;
+
+	if (!target->thread.used_ebb)
+		return -ENODATA;
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+			&target->thread.ebbrr, 0, sizeof(unsigned long));
+
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+			&target->thread.ebbhr, sizeof(unsigned long),
+			2 * sizeof(unsigned long));
+
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+			&target->thread.bescr,
+			2 * sizeof(unsigned long), 3 * sizeof(unsigned long));
+
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+			&target->thread.siar, 3 * sizeof(unsigned long),
+			4 * sizeof(unsigned long));
+
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+			&target->thread.sdar, 4 * sizeof(unsigned long),
+			5 * sizeof(unsigned long));
+
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+			&target->thread.sier, 5 * sizeof(unsigned long),
+			6 * sizeof(unsigned long));
+
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+			&target->thread.mmcr2, 6 * sizeof(unsigned long),
+			7 * sizeof(unsigned long));
+
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+			&target->thread.mmcr0, 7 * sizeof(unsigned long),
+			8 * sizeof(unsigned long));
+	return ret;
+}
+
+static int ebb_set(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      const void *kbuf, const void __user *ubuf)
+{
+	int ret = 0;
+
+	/* Build tests */
+	BUILD_BUG_ON(TSO(ebbrr) + sizeof(unsigned long) != TSO(ebbhr));
+	BUILD_BUG_ON(TSO(ebbhr) + sizeof(unsigned long) != TSO(bescr));
+	BUILD_BUG_ON(TSO(bescr) + sizeof(unsigned long) != TSO(siar));
+	BUILD_BUG_ON(TSO(siar) + sizeof(unsigned long) != TSO(sdar));
+	BUILD_BUG_ON(TSO(sdar) + sizeof(unsigned long) != TSO(sier));
+	BUILD_BUG_ON(TSO(sier) + sizeof(unsigned long) != TSO(mmcr2));
+	BUILD_BUG_ON(TSO(mmcr2) + sizeof(unsigned long) != TSO(mmcr0));
+
+	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
+		return -ENODEV;
+
+	if (target->thread.used_ebb)
+		return -ENODATA;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+			&target->thread.ebbrr, 0, sizeof(unsigned long));
+
+	if (!ret)
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+			&target->thread.ebbhr, sizeof(unsigned long),
+			2 * sizeof(unsigned long));
+
+	if (!ret)
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+			&target->thread.bescr,
+			2 * sizeof(unsigned long), 3 * sizeof(unsigned long));
+
+	if (!ret)
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+			&target->thread.siar, 3 * sizeof(unsigned long),
+			4 * sizeof(unsigned long));
+
+	if (!ret)
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+			&target->thread.sdar, 4 * sizeof(unsigned long),
+			5 * sizeof(unsigned long));
+
+	if (!ret)
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+			&target->thread.sier, 5 * sizeof(unsigned long),
+			6 * sizeof(unsigned long));
+
+	if (!ret)
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+			&target->thread.mmcr2, 6 * sizeof(unsigned long),
+			7 * sizeof(unsigned long));
+
+	if (!ret)
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+			&target->thread.mmcr0, 7 * sizeof(unsigned long),
+			8 * sizeof(unsigned long));
+	return ret;
+}
 #endif
 /*
  * These are our native regset flavors.
@@ -1792,6 +1928,7 @@ enum powerpc_regset {
 #endif
 #ifdef CONFIG_PPC_BOOK3S_64
 	REGSET_TAR,		/* TAR register */
+	REGSET_EBB,		/* EBB registers */
 #endif
 };
 
@@ -1887,6 +2024,11 @@ static const struct user_regset native_regsets[] = {
 		.size = sizeof(u64), .align = sizeof(u64),
 		.get = tar_get, .set = tar_set
 	},
+	[REGSET_EBB] = {
+		.core_note_type = NT_PPC_EBB, .n = ELF_NEBB,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.active = ebb_active, .get = ebb_get, .set = ebb_set
+	},
 #endif
 };
 
@@ -2173,6 +2315,11 @@ static const struct user_regset compat_regsets[] = {
 		.size = sizeof(u64), .align = sizeof(u64),
 		.get = tar_get, .set = tar_set
 	},
+	[REGSET_EBB] = {
+		.core_note_type = NT_PPC_EBB, .n = ELF_NEBB,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.active = ebb_active, .get = ebb_get, .set = ebb_set
+	},
 #endif
 };
 
-- 
2.1.0
