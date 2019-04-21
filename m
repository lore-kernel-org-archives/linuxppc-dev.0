Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E43C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:26:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F54420859
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F54420859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nD7k3g7bzDqCB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 01:26:10 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBhy683jzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:21:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44nBhx64LBz9sB3; Mon, 22 Apr 2019 00:21:21 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBhx1rLnz9sLt; Mon, 22 Apr 2019 00:21:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.4 11/52] powerpc: Add security feature flags for
 Spectre/Meltdown
Date: Mon, 22 Apr 2019 00:19:56 +1000
Message-Id: <20190421142037.21881-12-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190421142037.21881-1-mpe@ellerman.id.au>
References: <20190421142037.21881-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: diana.craciun@nxp.com, linuxppc-dev@ozlabs.org, msuchanek@suse.de,
 npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

commit 9a868f634349e62922c226834aa23e3d1329ae7f upstream.

This commit adds security feature flags to reflect the settings we
receive from firmware regarding Spectre/Meltdown mitigations.

The feature names reflect the names we are given by firmware on bare
metal machines. See the hostboot source for details.

Arguably these could be firmware features, but that then requires them
to be read early in boot so they're available prior to asm feature
patching, but we don't actually want to use them for patching. We may
also want to dynamically update them in future, which would be
incompatible with the way firmware features work (at the moment at
least). So for now just make them separate flags.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/security_features.h | 65 ++++++++++++++++++++
 arch/powerpc/kernel/Makefile                 |  2 +-
 arch/powerpc/kernel/security.c               | 15 +++++
 3 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/security_features.h
 create mode 100644 arch/powerpc/kernel/security.c

diff --git a/arch/powerpc/include/asm/security_features.h b/arch/powerpc/include/asm/security_features.h
new file mode 100644
index 000000000000..db00ad2c72c2
--- /dev/null
+++ b/arch/powerpc/include/asm/security_features.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Security related feature bit definitions.
+ *
+ * Copyright 2018, Michael Ellerman, IBM Corporation.
+ */
+
+#ifndef _ASM_POWERPC_SECURITY_FEATURES_H
+#define _ASM_POWERPC_SECURITY_FEATURES_H
+
+
+extern unsigned long powerpc_security_features;
+
+static inline void security_ftr_set(unsigned long feature)
+{
+	powerpc_security_features |= feature;
+}
+
+static inline void security_ftr_clear(unsigned long feature)
+{
+	powerpc_security_features &= ~feature;
+}
+
+static inline bool security_ftr_enabled(unsigned long feature)
+{
+	return !!(powerpc_security_features & feature);
+}
+
+
+// Features indicating support for Spectre/Meltdown mitigations
+
+// The L1-D cache can be flushed with ori r30,r30,0
+#define SEC_FTR_L1D_FLUSH_ORI30		0x0000000000000001ull
+
+// The L1-D cache can be flushed with mtspr 882,r0 (aka SPRN_TRIG2)
+#define SEC_FTR_L1D_FLUSH_TRIG2		0x0000000000000002ull
+
+// ori r31,r31,0 acts as a speculation barrier
+#define SEC_FTR_SPEC_BAR_ORI31		0x0000000000000004ull
+
+// Speculation past bctr is disabled
+#define SEC_FTR_BCCTRL_SERIALISED	0x0000000000000008ull
+
+// Entries in L1-D are private to a SMT thread
+#define SEC_FTR_L1D_THREAD_PRIV		0x0000000000000010ull
+
+// Indirect branch prediction cache disabled
+#define SEC_FTR_COUNT_CACHE_DISABLED	0x0000000000000020ull
+
+
+// Features indicating need for Spectre/Meltdown mitigations
+
+// The L1-D cache should be flushed on MSR[HV] 1->0 transition (hypervisor to guest)
+#define SEC_FTR_L1D_FLUSH_HV		0x0000000000000040ull
+
+// The L1-D cache should be flushed on MSR[PR] 0->1 transition (kernel to userspace)
+#define SEC_FTR_L1D_FLUSH_PR		0x0000000000000080ull
+
+// A speculation barrier should be used for bounds checks (Spectre variant 1)
+#define SEC_FTR_BNDS_CHK_SPEC_BAR	0x0000000000000100ull
+
+// Firmware configuration indicates user favours security over performance
+#define SEC_FTR_FAVOUR_SECURITY		0x0000000000000200ull
+
+#endif /* _ASM_POWERPC_SECURITY_FEATURES_H */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index ba336930d448..e9b0962743b8 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -40,7 +40,7 @@ obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
-obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o security.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= mce.o mce_power.o
 obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
new file mode 100644
index 000000000000..4ccba00d224c
--- /dev/null
+++ b/arch/powerpc/kernel/security.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Security related flags and so on.
+//
+// Copyright 2018, Michael Ellerman, IBM Corporation.
+
+#include <linux/kernel.h>
+#include <asm/security_features.h>
+
+
+unsigned long powerpc_security_features __read_mostly = \
+	SEC_FTR_L1D_FLUSH_HV | \
+	SEC_FTR_L1D_FLUSH_PR | \
+	SEC_FTR_BNDS_CHK_SPEC_BAR | \
+	SEC_FTR_FAVOUR_SECURITY;
-- 
2.20.1

