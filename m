Return-Path: <alastair@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rq7D00mnRzDqKK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:48:15 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D5i0Ma108833
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 01:48:14 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452at07a8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 01:48:14 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Wed, 13 Jul 2016 15:48:11 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E19C02CE802D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:48:08 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6D5m8xI18219166
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:48:08 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6D5m7s8008929
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:48:08 +1000
From: alastair@au1.ibm.com
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, paulus@samba.org, herbert@gondor.apana.org.au,
 davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH 2/2] crypto: vmx - Convert to CPU feature based module
 autoloading
Date: Wed, 13 Jul 2016 15:47:20 +1000
In-Reply-To: <1468388840-12068-1-git-send-email-alastair@au1.ibm.com>
References: <1468388840-12068-1-git-send-email-alastair@au1.ibm.com>
Message-Id: <1468388840-12068-5-git-send-email-alastair@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alastair D'Silva <alastair@d-silva.org>

This patch utilises the GENERIC_CPU_AUTOPROBE infrastructure
to automatically load the vmx_crypto module if the CPU supports
it.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/crypto/vmx/Kconfig | 2 +-
 drivers/crypto/vmx/vmx.c   | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/vmx/Kconfig b/drivers/crypto/vmx/Kconfig
index 89d8208..a83ead1 100644
--- a/drivers/crypto/vmx/Kconfig
+++ b/drivers/crypto/vmx/Kconfig
@@ -1,7 +1,7 @@
 config CRYPTO_DEV_VMX_ENCRYPT
 	tristate "Encryption acceleration support on P8 CPU"
 	depends on CRYPTO_DEV_VMX
-	default y
+	default m
 	help
 	  Support for VMX cryptographic acceleration instructions on Power8 CPU.
 	  This module supports acceleration for AES and GHASH in hardware. If you
diff --git a/drivers/crypto/vmx/vmx.c b/drivers/crypto/vmx/vmx.c
index e163d57..5a40f2f 100644
--- a/drivers/crypto/vmx/vmx.c
+++ b/drivers/crypto/vmx/vmx.c
@@ -23,6 +23,7 @@
 #include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/err.h>
+#include <linux/cpufeature.h>
 #include <linux/crypto.h>
 #include <asm/cputable.h>
 #include <crypto/internal/hash.h>
@@ -43,9 +44,6 @@ int __init p8_init(void)
 	int ret = 0;
 	struct crypto_alg **alg_it;
 
-	if (!(cur_cpu_spec->cpu_user_features2 & PPC_FEATURE2_VEC_CRYPTO))
-		return -ENODEV;
-
 	for (alg_it = algs; *alg_it; alg_it++) {
 		ret = crypto_register_alg(*alg_it);
 		printk(KERN_INFO "crypto_register_alg '%s' = %d\n",
@@ -78,7 +76,7 @@ void __exit p8_exit(void)
 	crypto_unregister_shash(&p8_ghash_alg);
 }
 
-module_init(p8_init);
+module_cpu_feature_match(PPC_MODULE_FEATURE_VEC_CRYPTO, p8_init);
 module_exit(p8_exit);
 
 MODULE_AUTHOR("Marcelo Cerri<mhcerri@br.ibm.com>");
-- 
2.7.4
