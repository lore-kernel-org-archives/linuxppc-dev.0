Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rsV2W3BBCzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jul 2016 12:03:15 +1000 (AEST)
Received: by mail-pf0-f196.google.com with SMTP id i6so8588252pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jul 2016 19:03:15 -0700 (PDT)
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
Subject: [PATCH v11 11/27] powerpc/ptrace: Enable support for EBB registers
Date: Sun, 17 Jul 2016 09:59:44 +0800
Message-Id: <1468720800-2950-12-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1468720800-2950-1-git-send-email-wei.guo.simon@gmail.com>
References: <1468720800-2950-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

This patch enables support for EBB state registers related
ELF core note NT_PPC_EBB based ptrace requests through
PTRACE_GETREGSET, PTRACE_SETREGSET calls. This is achieved
through adding one new register sets REGSET_EBB in powerpc
corresponding to the ELF core note sections added in this
regard. It also implements the get, set and active functions
for this new register sets added.

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
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/uapi/asm/elf.h |  1 +
 arch/powerpc/kernel/ptrace.c        | 75 +++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/elf.h b/arch/powerpc/include/uapi/asm/elf.h
index e703c64..8c4d71a 100644
--- a/arch/powerpc/include/uapi/asm/elf.h
+++ b/arch/powerpc/include/uapi/asm/elf.h
@@ -94,6 +94,7 @@
 #define ELF_NVMX	34	/* includes all vector registers */
 #define ELF_NVSX	32	/* includes all VSX registers */
 #define ELF_NTMSPRREG	3	/* include tfhar, tfiar, texasr */
+#define ELF_NEBB       3       /* includes ebbrr, ebbhr, bescr */
 
 typedef unsigned long elf_greg_t64;
 typedef elf_greg_t64 elf_gregset_t64[ELF_NGREG];
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 1a091db..52c69ed 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1527,6 +1527,70 @@ static int tar_set(struct task_struct *target,
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
+	/* Build tests */
+	BUILD_BUG_ON(TSO(ebbrr) + sizeof(unsigned long) != TSO(ebbhr));
+	BUILD_BUG_ON(TSO(ebbhr) + sizeof(unsigned long) != TSO(bescr));
+
+	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
+		return -ENODEV;
+
+	if (!target->thread.used_ebb)
+		return -ENODATA;
+
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+			&target->thread.ebbrr, 0, 3 * sizeof(unsigned long));
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
+	return ret;
+}
 #endif
 /*
  * These are our native regset flavors.
@@ -1559,6 +1623,7 @@ enum powerpc_regset {
 #endif
 #ifdef CONFIG_PPC_BOOK3S_64
 	REGSET_TAR,		/* TAR register */
+	REGSET_EBB,		/* EBB registers */
 #endif
 };
 
@@ -1654,6 +1719,11 @@ static const struct user_regset native_regsets[] = {
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
 
@@ -1940,6 +2010,11 @@ static const struct user_regset compat_regsets[] = {
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
1.8.3.1
