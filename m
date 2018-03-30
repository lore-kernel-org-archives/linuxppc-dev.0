Return-Path: <prvs=0627bbde4d=mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40CT9g31mWzF1w0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2018 04:28:35 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2UHPD1r052602
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 13:28:33 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h1s32h912-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 13:28:32 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Fri, 30 Mar 2018 13:28:32 -0400
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: Move default security feature flags
Date: Fri, 30 Mar 2018 14:28:24 -0300
Message-Id: <1522430905-32131-1-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves the definition of the default security feature flags
(i.e., enabled by default) closer to the security feature flags.

This can be used to restore current flags to the default flags.

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/security_features.h | 8 ++++++++
 arch/powerpc/kernel/security.c               | 7 +------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/security_features.h b/arch/powerpc/include/asm/security_features.h
index 400a905..fa4d2e1 100644
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
index 2cee3dc..bab5a27 100644
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
1.8.3.1
