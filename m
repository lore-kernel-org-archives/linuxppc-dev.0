Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id A8588DDDF4
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 06:02:01 +1000 (EST)
Date: Tue, 8 Jul 2008 15:01:37 -0500
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] Add PPC_FEATURE_PSERIES_PMU_COMPAT
Message-ID: <20080708200137.GN9594@localdomain>
References: <20080703232001.GB9594@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080703232001.GB9594@localdomain>
Cc: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Background from Maynard Johnson:
As of POWER6, a set of 32 common events is defined that must be
supported on all future POWER processors.  The main impetus for this
compat set is the need to support partition migration, especially from
processor P(n) to processor P(n+1), where performance software that's
running in the new partition may not be knowledgeable about processor
P(n+1).  If a performance tool determines it does not support the
physical processor, but is told (via the PPC_FEATURE_PSERIES_PMU_COMPAT
bit) that the processor supports the notion of the PMU compat set,
then the performance tool can surface just those events to the user
of the tool.

PPC_FEATURE_PSERIES_PMU_COMPAT indicates that the PMU supports at
least this basic subset of events which is compatible across POWER
processor lines.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---

Changes since v1:
- make name of feature bit less generic
- provide more complete changelog

 arch/powerpc/kernel/cputable.c |    6 ++++--
 include/asm-powerpc/cputable.h |    1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 817cea1..c4eb377 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -70,10 +70,12 @@ extern void __restore_cpu_power7(void);
 				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP)
 #define COMMON_USER_POWER6	(COMMON_USER_PPC64 | PPC_FEATURE_ARCH_2_05 |\
 				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
-				 PPC_FEATURE_TRUE_LE)
+				 PPC_FEATURE_TRUE_LE | \
+				 PPC_FEATURE_PSERIES_PMU_COMPAT)
 #define COMMON_USER_POWER7	(COMMON_USER_PPC64 | PPC_FEATURE_ARCH_2_06 |\
 				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
-				 PPC_FEATURE_TRUE_LE)
+				 PPC_FEATURE_TRUE_LE | \
+				 PPC_FEATURE_PSERIES_PMU_COMPAT)
 #define COMMON_USER_PA6T	(COMMON_USER_PPC64 | PPC_FEATURE_PA6T |\
 				 PPC_FEATURE_TRUE_LE | \
 				 PPC_FEATURE_HAS_ALTIVEC_COMP)
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 3171ac9..d1492a2 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -26,6 +26,7 @@
 #define PPC_FEATURE_POWER6_EXT		0x00000200
 #define PPC_FEATURE_ARCH_2_06		0x00000100
 #define PPC_FEATURE_HAS_VSX		0x00000080
+#define PPC_FEATURE_PSERIES_PMU_COMPAT	0x00000040
 
 #define PPC_FEATURE_TRUE_LE		0x00000002
 #define PPC_FEATURE_PPC_LE		0x00000001
-- 
1.5.6.2
