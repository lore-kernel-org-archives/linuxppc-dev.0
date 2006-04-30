Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5994267A00
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Apr 2006 14:48:35 +1000 (EST)
Date: Sat, 29 Apr 2006 23:48:15 -0500
To: paulus@samba.org
Subject: [PATCH] powerpc: rename PPC_FEATURE_POWER.* to PPC_FEATURE_ARCH.*
Message-ID: <20060430044814.GP5518@pb15.lixom.net>
References: <17491.1134.565353.149941@cargo.ozlabs.ibm.com>
	<20060429151936.GM5518@pb15.lixom.net>
	<17491.64254.653743.367039@cargo.ozlabs.ibm.com>
	<20060430035001.GN5518@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060430035001.GN5518@pb15.lixom.net>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 29, 2006 at 10:50:01PM -0500, Olof Johansson wrote:

> A rename of existing names might make sense for consistency/clarity. But
> that's outside of __KERNEL__ so it would break userspace.

Less talk, more patches. 2.6.18 material.

Btw, looks like glibc duplicates the definitions instead of includes them,
but let's be nice and keep them anyway. Besides, they got the ISA
version to processor mappings wrong in their comments.


---

Rename PPC_FEATURE_POWER.* to be signify the base architecture versions
instead. Keep the old names around since they're defined outside of
__KERNEL__.

If POWER5 is 2.02 (last public version), and POWER6 is 2.05, then POWER5+
should be 2.03 or 2.04. Not sure what fills in the hole, but I took a
guess that 5+ is 2.03.


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 3f7182d..7017d1c 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -52,10 +52,10 @@ extern void __setup_cpu_ppc970(unsigned 
 #define COMMON_USER		(PPC_FEATURE_32 | PPC_FEATURE_HAS_FPU | \
 				 PPC_FEATURE_HAS_MMU)
 #define COMMON_USER_PPC64	(COMMON_USER | PPC_FEATURE_64)
-#define COMMON_USER_POWER4	(COMMON_USER_PPC64 | PPC_FEATURE_POWER4)
-#define COMMON_USER_POWER5	(COMMON_USER_PPC64 | PPC_FEATURE_POWER5 |\
+#define COMMON_USER_POWER4	(COMMON_USER_PPC64 | PPC_FEATURE_ARCH_2_00)
+#define COMMON_USER_POWER5	(COMMON_USER_PPC64 | PPC_FEATURE_ARCH_2_02 |\
 				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP)
-#define COMMON_USER_POWER5_PLUS	(COMMON_USER_PPC64 | PPC_FEATURE_POWER5_PLUS|\
+#define COMMON_USER_POWER5_PLUS	(COMMON_USER_PPC64 | PPC_FEATURE_ARCH_2_03|\
 				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP)
 #define COMMON_USER_POWER6	(COMMON_USER_PPC64 | PPC_FEATURE_ARCH_2_05 |\
 				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP)
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 9fcf016..deae3af 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -15,15 +15,24 @@
 #define PPC_FEATURE_HAS_EFP_SINGLE	0x00400000
 #define PPC_FEATURE_HAS_EFP_DOUBLE	0x00200000
 #define PPC_FEATURE_NO_TB		0x00100000
-#define PPC_FEATURE_POWER4		0x00080000
-#define PPC_FEATURE_POWER5		0x00040000
-#define PPC_FEATURE_POWER5_PLUS		0x00020000
+#define PPC_FEATURE_ARCH_2_00		0x00080000
+#define PPC_FEATURE_ARCH_2_02		0x00040000
+#define PPC_FEATURE_ARCH_2_03		0x00020000
 #define PPC_FEATURE_CELL		0x00010000
 #define PPC_FEATURE_BOOKE		0x00008000
 #define PPC_FEATURE_SMT			0x00004000
 #define PPC_FEATURE_ICACHE_SNOOP	0x00002000
 #define PPC_FEATURE_ARCH_2_05		0x00001000
 
+/*
+ * These are needed for userspace compat, since processor
+ * models used to be used before instead of arch versions
+ */
+
+#define PPC_FEATURE_POWER4	PPC_FEATURE_ARCH_2_00
+#define PPC_FEATURE_POWER5	PPC_FEATURE_ARCH_2_02
+#define PPC_FEATURE_POWER5_PLUS	PPC_FEATURE_ARCH_2_03
+
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
