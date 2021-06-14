Return-Path: <SRS0=LJle=LI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2B8C2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jun 2021 23:08:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6534461107
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jun 2021 23:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6534461107
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G3nDh5ndHz3ckR
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 09:08:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=dEJHKYnB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=paulus@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=dEJHKYnB; dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G3n9g0bm2z2ysk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jun 2021 09:05:41 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 4G3n9b2t3gz9sW7; Tue, 15 Jun 2021 09:05:39 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4G3n9b25Gwz9sXL; Tue, 15 Jun 2021 09:05:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1623711939; bh=sgrM+WScv2wkftWMuivtLDglVOWQ3X1P7FCvile3F3I=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=dEJHKYnBRMvOultN+S/gDzpJOfIucZ2HRXrDovy2IE7a1/ZvKpF5FKXAXJW/Bi2ns
 +D+6pbP1LFNVJ8Ios59Cw4zqQ7pwO67NzFplCJVHUEULQB+pQNAQKNIojeroH7YZtZ
 8ClX5fnN48G7/KCE+Xk+1PQgyFUerw8t/pnOp6XlXkdSGQ5W1urKg5F5+dH/ptZgbS
 z09VPB1R8vK/E0eXCSJGtat9mvSVuzfbO80/wYbZWWVJD26RyoUXsJYJh/nGMUepKx
 rZHV1MUxFmlUEiThTShyKZIO3I4l77NZWfPzpwYbggqEDGlJT9hwH+FdSI/FTSM7NB
 STUxAdYcKDzVA==
Date: Tue, 15 Jun 2021 09:02:02 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/11] powerpc: Add support for microwatt's hardware random
 number generator
Message-ID: <YMff6iLDiCbFQmrW@thinks.paulus.ozlabs.org>
References: <YMfeswgEHeXSLOUF@thinks.paulus.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMfeswgEHeXSLOUF@thinks.paulus.ozlabs.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is accessed using the DARN instruction and should probably be
done more generically.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/archrandom.h     | 12 +++++-
 arch/powerpc/platforms/microwatt/Kconfig  |  1 +
 arch/powerpc/platforms/microwatt/Makefile |  2 +-
 arch/powerpc/platforms/microwatt/rng.c    | 48 +++++++++++++++++++++++
 4 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/platforms/microwatt/rng.c

diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
index 9a53e29680f4..e8ae0f7740f9 100644
--- a/arch/powerpc/include/asm/archrandom.h
+++ b/arch/powerpc/include/asm/archrandom.h
@@ -8,12 +8,22 @@
 
 static inline bool __must_check arch_get_random_long(unsigned long *v)
 {
+	if (ppc_md.get_random_seed)
+		return ppc_md.get_random_seed(v);
+
 	return false;
 }
 
 static inline bool __must_check arch_get_random_int(unsigned int *v)
 {
-	return false;
+	unsigned long val;
+	bool rc;
+
+	rc = arch_get_random_long(&val);
+	if (rc)
+		*v = val;
+
+	return rc;
 }
 
 static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
diff --git a/arch/powerpc/platforms/microwatt/Kconfig b/arch/powerpc/platforms/microwatt/Kconfig
index 50ed0cedb5f1..8f6a81978461 100644
--- a/arch/powerpc/platforms/microwatt/Kconfig
+++ b/arch/powerpc/platforms/microwatt/Kconfig
@@ -7,6 +7,7 @@ config PPC_MICROWATT
 	select PPC_ICP_NATIVE
 	select PPC_NATIVE
 	select PPC_UDBG_16550
+	select ARCH_RANDOM
 	help
           This option enables support for FPGA-based Microwatt implementations.
 
diff --git a/arch/powerpc/platforms/microwatt/Makefile b/arch/powerpc/platforms/microwatt/Makefile
index e6885b3b2ee7..116d6d3ad3f0 100644
--- a/arch/powerpc/platforms/microwatt/Makefile
+++ b/arch/powerpc/platforms/microwatt/Makefile
@@ -1 +1 @@
-obj-y	+= setup.o
+obj-y	+= setup.o rng.o
diff --git a/arch/powerpc/platforms/microwatt/rng.c b/arch/powerpc/platforms/microwatt/rng.c
new file mode 100644
index 000000000000..3d8ee6eb7dad
--- /dev/null
+++ b/arch/powerpc/platforms/microwatt/rng.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Derived from arch/powerpc/platforms/powernv/rng.c, which is:
+ * Copyright 2013, Michael Ellerman, IBM Corporation.
+ */
+
+#define pr_fmt(fmt)	"microwatt-rng: " fmt
+
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <asm/archrandom.h>
+#include <asm/cputable.h>
+#include <asm/machdep.h>
+
+#define DARN_ERR 0xFFFFFFFFFFFFFFFFul
+
+int microwatt_get_random_darn(unsigned long *v)
+{
+	unsigned long val;
+
+	/* Using DARN with L=1 - 64-bit conditioned random number */
+	asm volatile(PPC_DARN(%0, 1) : "=r"(val));
+
+	if (val == DARN_ERR)
+		return 0;
+
+	*v = val;
+
+	return 1;
+}
+
+static __init int rng_init(void)
+{
+	unsigned long val;
+	int i;
+
+	for (i = 0; i < 10; i++) {
+		if (microwatt_get_random_darn(&val)) {
+			ppc_md.get_random_seed = microwatt_get_random_darn;
+			return 0;
+		}
+	}
+
+	pr_warn("Unable to use DARN for get_random_seed()\n");
+
+	return -EIO;
+}
+machine_subsys_initcall(, rng_init);
-- 
2.31.1

