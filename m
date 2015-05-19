Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EDE4A1A06A3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 01:08:46 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E7B8C140DD6
 for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2015 01:08:45 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:38:44 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 855EE3940049
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:42 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4JF8ZrE6226008
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:35 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4JF8U7n028282
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:34 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V8 14/28] powerpc, ptrace: Enable support for EBB registers
Date: Tue, 19 May 2015 20:38:10 +0530
Message-Id: <1432048104-4695-15-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch enables support for EBB state registers related
ELF core note NT_PPC_EBB based ptrace requests through
PTRACE_GETREGSET, PTRACE_SETREGSET calls. This is achieved
through adding one new register sets REGSET_EBB in powerpc
corresponding to the ELF core note sections added in this
regard. It also implements the get, set and active functions
for this new register sets added.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/uapi/asm/elf.h |   2 +
 arch/powerpc/kernel/ptrace.c        | 147 ++++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/elf.h b/arch/powerpc/include/uapi/asm/elf.h
index 9e6b6e3..80876ff 100644
--- a/arch/powerpc/include/uapi/asm/elf.h
+++ b/arch/powerpc/include/uapi/asm/elf.h
@@ -94,6 +94,8 @@
 #define ELF_NVMX	34	/* includes all vector registers */
 #define ELF_NVSX	32	/* includes all VSX registers */
 #define ELF_NTMSPRREG	3	/* include tfhar, tfiar, texasr */
+#define ELF_NEBB	8	/* includes ebbrr, ebbhr, bescr, siar,
+				   sdar, sier, mmcr2, mmcr0 */
 
 typedef unsigned long elf_greg_t64;
 typedef elf_greg_t64 elf_gregset_t64[ELF_NGREG];
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 533c787..1db88a5 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1759,6 +1759,142 @@ static int tar_set(struct task_struct *target,
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
@@ -1791,6 +1927,7 @@ enum powerpc_regset {
 #endif
 #ifdef CONFIG_PPC_BOOK3S_64
 	REGSET_TAR,		/* TAR register */
+	REGSET_EBB,		/* EBB registers */
 #endif
 };
 
@@ -1886,6 +2023,11 @@ static const struct user_regset native_regsets[] = {
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
 
@@ -2172,6 +2314,11 @@ static const struct user_regset compat_regsets[] = {
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
