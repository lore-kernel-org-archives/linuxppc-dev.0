Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 642FF1A09B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 21:36:00 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mmarek@suse.cz, akpm@linux-foundation.org, jbaron@akamai.com,
 peterz@infradead.org, liuj97@gmail.com, mingo@kernel.org, mgorman@suse.de,
 linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com,
 ralf@linux-mips.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
 davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 rostedt@goodmis.org
Subject: [PATCH 1/3] jump_label: Allow asm/jump_label.h to be included in
 assembly
Date: Wed,  7 Jan 2015 21:35:56 +1100
Message-Id: <1420626958-31254-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wrap asm/jump_label.h for all archs with #ifndef __ASSEMBLY__.
Since these are kernel only headers, we don't need #ifdef __KERNEL__
so can simplify things a bit.

If an architecture wants to use jump labels in assembly, it
will still need to define a macro to create the __jump_table
entries (see ARCH_STATIC_BRANCH in the powerpc asm/jump_label.h
for an example).

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/arm/include/asm/jump_label.h   | 5 ++---
 arch/arm64/include/asm/jump_label.h | 8 ++++----
 arch/mips/include/asm/jump_label.h  | 7 +++----
 arch/s390/include/asm/jump_label.h  | 3 +++
 arch/sparc/include/asm/jump_label.h | 5 ++---
 arch/x86/include/asm/jump_label.h   | 5 ++---
 6 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/jump_label.h b/arch/arm/include/asm/jump_label.h
index 70f9b9b..5f337dc 100644
--- a/arch/arm/include/asm/jump_label.h
+++ b/arch/arm/include/asm/jump_label.h
@@ -1,7 +1,7 @@
 #ifndef _ASM_ARM_JUMP_LABEL_H
 #define _ASM_ARM_JUMP_LABEL_H
 
-#ifdef __KERNEL__
+#ifndef __ASSEMBLY__
 
 #include <linux/types.h>
 
@@ -27,8 +27,6 @@ l_yes:
 	return true;
 }
 
-#endif /* __KERNEL__ */
-
 typedef u32 jump_label_t;
 
 struct jump_entry {
@@ -37,4 +35,5 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+#endif  /* __ASSEMBLY__ */
 #endif
diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
index 076a1c7..c0e5165 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -18,11 +18,12 @@
  */
 #ifndef __ASM_JUMP_LABEL_H
 #define __ASM_JUMP_LABEL_H
+
+#ifndef __ASSEMBLY__
+
 #include <linux/types.h>
 #include <asm/insn.h>
 
-#ifdef __KERNEL__
-
 #define JUMP_LABEL_NOP_SIZE		AARCH64_INSN_SIZE
 
 static __always_inline bool arch_static_branch(struct static_key *key)
@@ -39,8 +40,6 @@ l_yes:
 	return true;
 }
 
-#endif /* __KERNEL__ */
-
 typedef u64 jump_label_t;
 
 struct jump_entry {
@@ -49,4 +48,5 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+#endif  /* __ASSEMBLY__ */
 #endif	/* __ASM_JUMP_LABEL_H */
diff --git a/arch/mips/include/asm/jump_label.h b/arch/mips/include/asm/jump_label.h
index fdbff44..608aa57 100644
--- a/arch/mips/include/asm/jump_label.h
+++ b/arch/mips/include/asm/jump_label.h
@@ -8,9 +8,9 @@
 #ifndef _ASM_MIPS_JUMP_LABEL_H
 #define _ASM_MIPS_JUMP_LABEL_H
 
-#include <linux/types.h>
+#ifndef __ASSEMBLY__
 
-#ifdef __KERNEL__
+#include <linux/types.h>
 
 #define JUMP_LABEL_NOP_SIZE 4
 
@@ -39,8 +39,6 @@ l_yes:
 	return true;
 }
 
-#endif /* __KERNEL__ */
-
 #ifdef CONFIG_64BIT
 typedef u64 jump_label_t;
 #else
@@ -53,4 +51,5 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+#endif  /* __ASSEMBLY__ */
 #endif /* _ASM_MIPS_JUMP_LABEL_H */
diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
index 346b1c8..1e78ffd 100644
--- a/arch/s390/include/asm/jump_label.h
+++ b/arch/s390/include/asm/jump_label.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_S390_JUMP_LABEL_H
 #define _ASM_S390_JUMP_LABEL_H
 
+#ifndef __ASSEMBLY__
+
 #include <linux/types.h>
 
 #define JUMP_LABEL_NOP_SIZE 6
@@ -34,4 +36,5 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+#endif  /* __ASSEMBLY__ */
 #endif
diff --git a/arch/sparc/include/asm/jump_label.h b/arch/sparc/include/asm/jump_label.h
index ec2e2e2..cc9b04a 100644
--- a/arch/sparc/include/asm/jump_label.h
+++ b/arch/sparc/include/asm/jump_label.h
@@ -1,7 +1,7 @@
 #ifndef _ASM_SPARC_JUMP_LABEL_H
 #define _ASM_SPARC_JUMP_LABEL_H
 
-#ifdef __KERNEL__
+#ifndef __ASSEMBLY__
 
 #include <linux/types.h>
 
@@ -22,8 +22,6 @@ l_yes:
 	return true;
 }
 
-#endif /* __KERNEL__ */
-
 typedef u32 jump_label_t;
 
 struct jump_entry {
@@ -32,4 +30,5 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+#endif  /* __ASSEMBLY__ */
 #endif
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 6a2cefb..a4c1cf7 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -1,7 +1,7 @@
 #ifndef _ASM_X86_JUMP_LABEL_H
 #define _ASM_X86_JUMP_LABEL_H
 
-#ifdef __KERNEL__
+#ifndef __ASSEMBLY__
 
 #include <linux/stringify.h>
 #include <linux/types.h>
@@ -30,8 +30,6 @@ l_yes:
 	return true;
 }
 
-#endif /* __KERNEL__ */
-
 #ifdef CONFIG_X86_64
 typedef u64 jump_label_t;
 #else
@@ -44,4 +42,5 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+#endif  /* __ASSEMBLY__ */
 #endif
-- 
2.1.0
