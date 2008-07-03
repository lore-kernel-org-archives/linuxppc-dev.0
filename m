Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 09F79DDDF9
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 09:20:25 +1000 (EST)
Date: Thu, 3 Jul 2008 18:20:01 -0500
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Add PPC_FEATURE_PMU_COMPAT
Message-ID: <20080703232001.GB9594@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Beginning with Power6, there is a set of 32 PMU events which is
compatible across POWER processor lines.  PPC_FEATURE_PMU_COMPAT
indicates support for this subset.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/kernel/cputable.c |    4 ++--
 include/asm-powerpc/cputable.h |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 817cea1..a9c90be 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -70,10 +70,10 @@ extern void __restore_cpu_power7(void);
 				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP)
 #define COMMON_USER_POWER6	(COMMON_USER_PPC64 | PPC_FEATURE_ARCH_2_05 |\
 				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
-				 PPC_FEATURE_TRUE_LE)
+				 PPC_FEATURE_TRUE_LE | PPC_FEATURE_PMU_COMPAT)
 #define COMMON_USER_POWER7	(COMMON_USER_PPC64 | PPC_FEATURE_ARCH_2_06 |\
 				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
-				 PPC_FEATURE_TRUE_LE)
+				 PPC_FEATURE_TRUE_LE | PPC_FEATURE_PMU_COMPAT)
 #define COMMON_USER_PA6T	(COMMON_USER_PPC64 | PPC_FEATURE_PA6T |\
 				 PPC_FEATURE_TRUE_LE | \
 				 PPC_FEATURE_HAS_ALTIVEC_COMP)
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 4e4491c..a9c1de3 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -26,6 +26,7 @@
 #define PPC_FEATURE_POWER6_EXT		0x00000200
 #define PPC_FEATURE_ARCH_2_06		0x00000100
 #define PPC_FEATURE_HAS_VSX		0x00000080
+#define PPC_FEATURE_PMU_COMPAT		0x00000040
 
 #define PPC_FEATURE_TRUE_LE		0x00000002
 #define PPC_FEATURE_PPC_LE		0x00000001
-- 
1.5.5.1
