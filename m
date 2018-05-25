Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40shny6DBpzF1jq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 20:10:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: greg@kroah.com
Cc: stable@vger.kernel.org,
	tglx@linutronix.de,
	linuxppc-dev@ozlabs.org
Subject: [PATCH stable 4.14 13/23] powerpc/64s: Move cpu_show_meltdown()
Date: Fri, 25 May 2018 20:09:44 +1000
Message-Id: <20180525100954.31599-14-mpe@ellerman.id.au>
In-Reply-To: <20180525100954.31599-1-mpe@ellerman.id.au>
References: <20180525100954.31599-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This landed in setup_64.c for no good reason other than we had nowhere
else to put it. Now that we have a security-related file, that is a
better place for it so move it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
(cherry picked from commit 8ad33041563a10b34988800c682ada14b2612533)
---
 arch/powerpc/kernel/security.c | 11 +++++++++++
 arch/powerpc/kernel/setup_64.c |  8 --------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 4ccba00d224c..564e7f182a16 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -5,6 +5,8 @@
 // Copyright 2018, Michael Ellerman, IBM Corporation.
 
 #include <linux/kernel.h>
+#include <linux/device.h>
+
 #include <asm/security_features.h>
 
 
@@ -13,3 +15,12 @@ unsigned long powerpc_security_features __read_mostly = \
 	SEC_FTR_L1D_FLUSH_PR | \
 	SEC_FTR_BNDS_CHK_SPEC_BAR | \
 	SEC_FTR_FAVOUR_SECURITY;
+
+
+ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	if (rfi_flush)
+		return sprintf(buf, "Mitigation: RFI Flush\n");
+
+	return sprintf(buf, "Vulnerable\n");
+}
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index da12b54cbe5c..1146174f45c5 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -910,12 +910,4 @@ static __init int rfi_flush_debugfs_init(void)
 }
 device_initcall(rfi_flush_debugfs_init);
 #endif
-
-ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	if (rfi_flush)
-		return sprintf(buf, "Mitigation: RFI Flush\n");
-
-	return sprintf(buf, "Vulnerable\n");
-}
 #endif /* CONFIG_PPC_BOOK3S_64 */
-- 
2.14.1
