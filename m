Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4545D1A0932
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 03:45:09 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BA81914003E
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2014 03:45:07 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 12 Dec 2014 02:45:07 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 27BB22BB0052
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2014 03:45:05 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBBGj4xc26476666
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2014 03:45:05 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBBGj3j7006539
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2014 03:45:04 +1100
Subject: [PATCH] powerpc/kdump: skip enabling big endian exception during crash
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Thu, 11 Dec 2014 22:14:54 +0530
Message-ID: <20141211164454.4641.71441.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In LE kernel, we currently have a hack for kexec that resets the exception endian
before starting a new kernel as the kernel that is loaded could be a big endian
or a little endian kernel. In kdump case, resetting exception endian fails when
one or more cpus is disabled. But in case of kdump, we can conveniently ignore
resetting endianess as crashkernel is always of same endianess as primary kernel.
This patch adds a new inline function to say if this is kdump path. This function
is used at places where such a check is needed.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kexec.h       |   10 ++++++++++
 arch/powerpc/kernel/machine_kexec_64.c |    2 +-
 arch/powerpc/platforms/pseries/lpar.c  |    7 ++++++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 19c36cb..0d96d4d 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -86,6 +86,11 @@ extern int overlaps_crashkernel(unsigned long start, unsigned long size);
 extern void reserve_crashkernel(void);
 extern void machine_kexec_mask_interrupts(void);
 
+static inline int is_kdump_path(void)
+{
+	return (crashing_cpu >= 0) ? 1 : 0;
+}
+
 #else /* !CONFIG_KEXEC */
 static inline void crash_kexec_secondary(struct pt_regs *regs) { }
 
@@ -106,6 +111,11 @@ static inline int crash_shutdown_unregister(crash_shutdown_t handler)
 	return 0;
 }
 
+static inline int is_kdump_path(void)
+{
+	return 0;
+}
+
 #endif /* CONFIG_KEXEC */
 #endif /* ! __ASSEMBLY__ */
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 879b3aa..b4fe804 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -330,7 +330,7 @@ void default_machine_kexec(struct kimage *image)
         * using debugger IPI.
         */
 
-	if (crashing_cpu == -1)
+	if (!is_kdump_path())
 		kexec_prepare_cpus();
 
 	pr_debug("kexec: Starting switchover sequence.\n");
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index f6880d2..be41680 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -43,6 +43,7 @@
 #include <asm/trace.h>
 #include <asm/firmware.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/kexec.h>
 #include <asm/fadump.h>
 
 #include "pseries.h"
@@ -257,8 +258,12 @@ static void pSeries_lpar_hptab_clear(void)
 	 *
 	 * This is also called on boot when a fadump happens. In that case we
 	 * must not change the exception endian mode.
+	 *
+	 * This is also called during kdump which doesn't need resetting, as the
+	 * the crashkernel is of same endainess as primary kernel.
 	 */
-	if (firmware_has_feature(FW_FEATURE_SET_MODE) && !is_fadump_active()) {
+	if (firmware_has_feature(FW_FEATURE_SET_MODE) && !is_fadump_active() &&
+			!is_kdump_path()) {
 		long rc;
 
 		rc = pseries_big_endian_exceptions();
