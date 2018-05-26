Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40t98t1chMzDr0y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 May 2018 14:28:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: greg@kroah.com
Cc: stable@vger.kernel.org,
	tglx@linutronix.de,
	linuxppc-dev@ozlabs.org
Subject: [PATCH stable 4.14 v2 20/23] powerpc: Move default security feature
 flags
Date: Sat, 26 May 2018 14:27:46 +1000
Message-Id: <20180526042749.5324-21-mpe@ellerman.id.au>
In-Reply-To: <20180526042749.5324-1-mpe@ellerman.id.au>
References: <20180526042749.5324-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

commit e7347a86830f38dc3e40c8f7e28c04412b12a2e7 upstream.

This moves the definition of the default security feature flags
(i.e., enabled by default) closer to the security feature flags.

This can be used to restore current flags to the default flags.

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/security_features.h | 8 ++++++++
 arch/powerpc/kernel/security.c               | 7 +------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/security_features.h b/arch/powerpc/include/asm/security_features.h
index 400a9050e035..fa4d2e1cf772 100644
--- a/arch/powerpc/include/asm/security_features.h
+++ b/arch/powerpc/include/asm/security_features.h
@@ -63,4 +63,12 @@ static inline bool security_ftr_enabled(unsigned long feature)
 // Firmware configuration indicates user favours security over performance
 #define SEC_FTR_FAVOUR_SECURITY		0x0000000000000200ull
 
+
+// Features enabled by default
+#define SEC_FTR_DEFAULT \
+	(SEC_FTR_L1D_FLUSH_HV | \
+	 SEC_FTR_L1D_FLUSH_PR | \
+	 SEC_FTR_BNDS_CHK_SPEC_BAR | \
+	 SEC_FTR_FAVOUR_SECURITY)
+
 #endif /* _ASM_POWERPC_SECURITY_FEATURES_H */
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 2cee3dcd231b..bab5a27ea805 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -11,12 +11,7 @@
 #include <asm/security_features.h>
 
 
-unsigned long powerpc_security_features __read_mostly = \
-	SEC_FTR_L1D_FLUSH_HV | \
-	SEC_FTR_L1D_FLUSH_PR | \
-	SEC_FTR_BNDS_CHK_SPEC_BAR | \
-	SEC_FTR_FAVOUR_SECURITY;
-
+unsigned long powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
 
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
-- 
2.14.1
