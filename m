Return-Path: <SRS0=hJnm=LM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE750C48BDF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 03:56:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF0361351
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 03:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF0361351
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G5lTG5Sc0z3c7H
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 13:56:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=AhTOiHec;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=paulus@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=AhTOiHec; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G5lMP3T2Rz3c1k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 13:50:55 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 4G5lML3dQvz9sXL; Fri, 18 Jun 2021 13:50:54 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4G5lML3HS2z9sfG; Fri, 18 Jun 2021 13:50:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1623988254; bh=BuIb8txlo7m7Ua1rdz1ixEJHxyWv5ncIwQS16h/q0BM=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=AhTOiHecn4csjmgpPzvyzC4wfsjFwtFolkphrbgoXGV1zC2N9XJTtGw2vfgJsrHfU
 K38yn+sDiVypWOY+wKhSoERYP1TBFdOzCH2H0ma3jm5hLOkB2gRViLRuyZeEfpVICj
 SoO5Km6yGRDTQVnSmfh6HDRj2ZrD4PVGJE/Elb48OVV9vCa5Mt5BW8w01sochgjyVn
 +oNx7MhXfCJZ39VQjWXvKsjdyiIqzEBDtY/y/n/2CF+1dHoHaTiT+6W/cmnLZHEhqY
 eJLRmx4uayIfCnkV/PLkZlASHSVec1MssLS2CaaCo00kCLsLHvZj3iuslmApN0e5Qp
 cUBG4wDPI12Ow==
Date: Fri, 18 Jun 2021 13:47:08 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 6/9] powerpc/microwatt: Add support for hardware random
 number generator
Message-ID: <YMwXPHlV/ZleiQUY@thinks.paulus.ozlabs.org>
References: <YMwWPcsaWzMlDPqQ@thinks.paulus.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMwWPcsaWzMlDPqQ@thinks.paulus.ozlabs.org>
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

Microwatt's hardware RNG is accessed using the DARN instruction.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/platforms/microwatt/Kconfig  |  1 +
 arch/powerpc/platforms/microwatt/Makefile |  2 +-
 arch/powerpc/platforms/microwatt/rng.c    | 48 +++++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/microwatt/rng.c

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

