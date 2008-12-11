Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id 5E722DDFF9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 11:28:48 +1100 (EST)
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C91018937
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 19:28:43 -0500 (EST)
Received: from thinkcentre (unknown [67.9.156.46]) by
	b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPA id 116A918917
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 19:28:42 -0500 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] move smp_hw_index to 32-bit code
Date: Wed, 10 Dec 2008 18:28:41 -0600
Message-Id: <1228955322-16995-1-git-send-email-ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

smp_hw_index isn't used on 64-bit, so move it from smp.c to
setup_32.c.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/kernel/setup_32.c |    2 ++
 arch/powerpc/kernel/smp.c      |    1 -
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index c1a2762..2e9fcf0 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -49,6 +49,8 @@ int boot_cpuid;
 EXPORT_SYMBOL_GPL(boot_cpuid);
 int boot_cpuid_phys;
 
+int smp_hw_index[NR_CPUS];
+
 unsigned long ISA_DMA_THRESHOLD;
 unsigned int DMA_MODE_READ;
 unsigned int DMA_MODE_WRITE;
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index ff9f701..5af6ac1 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -57,7 +57,6 @@
 #define DBG(fmt...)
 #endif
 
-int smp_hw_index[NR_CPUS];
 struct thread_info *secondary_ti;
 
 cpumask_t cpu_possible_map = CPU_MASK_NONE;
-- 
1.5.5
