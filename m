Return-Path: <B29882@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id DD368100CD9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2011 09:55:13 +1100 (EST)
Received: from mail186-tx2 (localhost.localdomain [127.0.0.1])	by
 mail186-tx2-R.bigfish.com (Postfix) with ESMTP id E152012B80EB	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 22:55:06 +0000 (UTC)
Received: from TX2EHSMHS026.bigfish.com (unknown [10.9.14.253])	by
 mail186-tx2.bigfish.com (Postfix) with ESMTP id A2ED7111004E	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 22:54:09 +0000 (UTC)
From: Matthew McClintock <msm@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <kumar.gala@freescale.com>
Subject: [PATCH 5/5] powerpc/setup_{32, 64}.c: remove unneeded boot_cpuid{,
 _phys}
Date: Tue, 25 Oct 2011 17:54:06 -0500
Message-ID: <1319583246-6120-5-git-send-email-msm@freescale.com>
In-Reply-To: <1319583246-6120-1-git-send-email-msm@freescale.com>
References: <1319583246-6120-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

boot_cpuid and init_thread_info.cpu are redundant, just use the
var that stays around longer and add a define to make boot_cpuid
point at the correct value

boot_cpudid_phys is not needed and can completely go away from the
SMP case, we leave it there for the non-SMP case since the paca
struct is not around to store this info

This patch also has the effect of having the logical cpu number
of the boot cpu be updated correctly independently of the ordering
of the cpu nodes in the device tree.

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
Could also just change boot_cpuid every to init_thread_info.cpu instead
of using this define

This is only tested on 32-bit parts, only compiled on 64-bit

 arch/powerpc/include/asm/smp.h |    2 +-
 arch/powerpc/kernel/setup_32.c |    7 ++++---
 arch/powerpc/kernel/setup_64.c |    1 -
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index adba970..f26c554 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -29,7 +29,7 @@
 #endif
 #include <asm/percpu.h>
 
-extern int boot_cpuid;
+#define boot_cpuid 	(init_thread_info.cpu)
 extern int spinning_secondaries;
 
 extern void cpu_die(void);
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index c1ce863..f396847 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -46,10 +46,11 @@
 
 extern void bootx_init(unsigned long r4, unsigned long phys);
 
-int boot_cpuid = -1;
-EXPORT_SYMBOL_GPL(boot_cpuid);
-int boot_cpuid_phys;
+/* we need a place to store phys cpu for non-SMP case */
+#ifndef CONFIG_SMP
+int boot_cpuid_phys = -1;
 EXPORT_SYMBOL_GPL(boot_cpuid_phys);
+#endif
 
 int smp_hw_index[NR_CPUS];
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index d4168c9..eacefba 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -73,7 +73,6 @@
 #define DBG(fmt...)
 #endif
 
-int boot_cpuid = 0;
 int __initdata spinning_secondaries;
 u64 ppc64_pft_size;
 
-- 
1.7.6.1
