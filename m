Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpssB0LYtzDrcq
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Sep 2017 08:47:26 +1000 (AEST)
Received: by mail-qk0-x241.google.com with SMTP id r66so2160388qke.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 15:47:25 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: [PATCH 24/25] powerpc/ptrace: Add memory protection key regset
Date: Fri,  8 Sep 2017 15:45:12 -0700
Message-Id: <1504910713-7094-33-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

The AMR/IAMR/UAMOR are part of the program context.
Allow it to be accessed via ptrace and through core files.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pkeys.h    |    5 +++
 arch/powerpc/include/uapi/asm/elf.h |    1 +
 arch/powerpc/kernel/ptrace.c        |   66 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h            |    1 +
 4 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 50522a0..a0111de 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -209,6 +209,11 @@ static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	return __arch_set_user_pkey_access(tsk, pkey, init_val);
 }
 
+static inline bool arch_pkeys_enabled(void)
+{
+	return pkey_inited;
+}
+
 static inline void pkey_mm_init(struct mm_struct *mm)
 {
 	if (!pkey_inited)
diff --git a/arch/powerpc/include/uapi/asm/elf.h b/arch/powerpc/include/uapi/asm/elf.h
index b2c6fdd..923e6d5 100644
--- a/arch/powerpc/include/uapi/asm/elf.h
+++ b/arch/powerpc/include/uapi/asm/elf.h
@@ -96,6 +96,7 @@
 #define ELF_NTMSPRREG	3	/* include tfhar, tfiar, texasr */
 #define ELF_NEBB	3	/* includes ebbrr, ebbhr, bescr */
 #define ELF_NPMU	5	/* includes siar, sdar, sier, mmcr2, mmcr0 */
+#define ELF_NPKEY	3	/* includes amr, iamr, uamor */
 
 typedef unsigned long elf_greg_t64;
 typedef elf_greg_t64 elf_gregset_t64[ELF_NGREG];
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 07cd22e..6a9d3ec 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -39,6 +39,7 @@
 #include <asm/pgtable.h>
 #include <asm/switch_to.h>
 #include <asm/tm.h>
+#include <asm/pkeys.h>
 #include <asm/asm-prototypes.h>
 
 #define CREATE_TRACE_POINTS
@@ -1775,6 +1776,61 @@ static int pmu_set(struct task_struct *target,
 	return ret;
 }
 #endif
+
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+static int pkey_active(struct task_struct *target,
+		       const struct user_regset *regset)
+{
+	if (!arch_pkeys_enabled())
+		return -ENODEV;
+
+	return regset->n;
+}
+
+static int pkey_get(struct task_struct *target,
+		    const struct user_regset *regset,
+		    unsigned int pos, unsigned int count,
+		    void *kbuf, void __user *ubuf)
+{
+	BUILD_BUG_ON(TSO(amr) + sizeof(unsigned long) != TSO(iamr));
+	BUILD_BUG_ON(TSO(iamr) + sizeof(unsigned long) != TSO(uamor));
+
+	if (!arch_pkeys_enabled())
+		return -ENODEV;
+
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				   &target->thread.amr, 0,
+				   ELF_NPKEY * sizeof(unsigned long));
+}
+
+static int pkey_set(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      const void *kbuf, const void __user *ubuf)
+{
+	u64 new_amr;
+	int ret;
+
+	if (!arch_pkeys_enabled())
+		return -ENODEV;
+
+	/* Only the AMR can be set from userspace */
+	if (pos != 0 || count != sizeof(new_amr))
+		return -EINVAL;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 &new_amr, 0, sizeof(new_amr));
+	if (ret)
+		return ret;
+
+	/* UAMOR determines which bits of the AMR can be set from userspace. */
+	target->thread.amr = (new_amr & target->thread.uamor) |
+		(target->thread.amr & ~target->thread.uamor);
+
+	return 0;
+}
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 /*
  * These are our native regset flavors.
  */
@@ -1809,6 +1865,9 @@ enum powerpc_regset {
 	REGSET_EBB,		/* EBB registers */
 	REGSET_PMR,		/* Performance Monitor Registers */
 #endif
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	REGSET_PKEY,		/* AMR register */
+#endif
 };
 
 static const struct user_regset native_regsets[] = {
@@ -1914,6 +1973,13 @@ enum powerpc_regset {
 		.active = pmu_active, .get = pmu_get, .set = pmu_set
 	},
 #endif
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	[REGSET_PKEY] = {
+		.core_note_type = NT_PPC_PKEY, .n = ELF_NPKEY,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.active = pkey_active, .get = pkey_get, .set = pkey_set
+	},
+#endif
 };
 
 static const struct user_regset_view user_ppc_native_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index b5280db..0708516 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -395,6 +395,7 @@
 #define NT_PPC_TM_CTAR	0x10d		/* TM checkpointed Target Address Register */
 #define NT_PPC_TM_CPPR	0x10e		/* TM checkpointed Program Priority Register */
 #define NT_PPC_TM_CDSCR	0x10f		/* TM checkpointed Data Stream Control Register */
+#define NT_PPC_PKEY	0x110		/* Memory Protection Keys registers */
 #define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
 #define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=deny) */
 #define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
-- 
1.7.1
