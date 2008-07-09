Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id AC05ADEA27
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 01:09:56 +1000 (EST)
Date: Wed, 9 Jul 2008 10:06:57 -0500
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3] Add PPC_FEATURE_PSERIES_PERFMON_COMPAT
Message-ID: <20080709150657.GQ9594@localdomain>
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
physical processor, but is told (via the
PPC_FEATURE_PSERIES_PERFMON_COMPAT bit) that the processor supports
the notion of the PMU compat set, then the performance tool can
surface just those events to the user of the tool.

PPC_FEATURE_PSERIES_PERFMON_COMPAT indicates that the PMU supports at
least this basic subset of events which is compatible across POWER
processor lines.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---

Changes since v2:
- Further disambiguated name of feature bit (PMU -> PERFMON)

Changes since v1:
- make name of feature bit less generic
- provide more complete changelog

 arch/powerpc/kernel/cputable.c |    6 ++++--
 include/asm-powerpc/cputable.h |    3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 817cea1..02088b0 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -70,10 +70,12 @@ extern void __restore_cpu_power7(void);
 				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP)
 #define COMMON_USER_POWER6	(COMMON_USER_PPC64 | PPC_FEATURE_ARCH_2_05 |\
 				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
-				 PPC_FEATURE_TRUE_LE)
+				 PPC_FEATURE_TRUE_LE | \
+				 PPC_FEATURE_PSERIES_PERFMON_COMPAT)
 #define COMMON_USER_POWER7	(COMMON_USER_PPC64 | PPC_FEATURE_ARCH_2_06 |\
 				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
-				 PPC_FEATURE_TRUE_LE)
+				 PPC_FEATURE_TRUE_LE | \
+				 PPC_FEATURE_PSERIES_PERFMON_COMPAT)
 #define COMMON_USER_PA6T	(COMMON_USER_PPC64 | PPC_FEATURE_PA6T |\
 				 PPC_FEATURE_TRUE_LE | \
 				 PPC_FEATURE_HAS_ALTIVEC_COMP)
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 3171ac9..58d4281 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -27,6 +27,9 @@
 #define PPC_FEATURE_ARCH_2_06		0x00000100
 #define PPC_FEATURE_HAS_VSX		0x00000080
 
+#define PPC_FEATURE_PSERIES_PERFMON_COMPAT \
+					0x00000040
+
 #define PPC_FEATURE_TRUE_LE		0x00000002
 #define PPC_FEATURE_PPC_LE		0x00000001
 
-- 
1.5.6.2
