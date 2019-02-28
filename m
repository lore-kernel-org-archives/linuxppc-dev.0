Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320F3C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 14:54:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8722133D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 14:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8722133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449FvB4Nz0zDqRH
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 01:54:30 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449FnK5whyzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 01:49:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 449FnK4pl8z9s6w; Fri,  1 Mar 2019 01:49:25 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 449FnK4NNjz9s9T; Fri,  1 Mar 2019 01:49:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v4 3/9] powerpc: Add framework for Kernel Userspace Protection
Date: Fri,  1 Mar 2019 01:49:11 +1100
Message-Id: <20190228144917.16876-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228144917.16876-1-mpe@ellerman.id.au>
References: <20190228144917.16876-1-mpe@ellerman.id.au>
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
Cc: akshay.adiga@linux.vnet.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Christophe Leroy <christophe.leroy@c-s.fr>

This patch adds a skeleton for Kernel Userspace Protection
functionnalities like Kernel Userspace Access Protection and Kernel
Userspace Execution Prevention

The subsequent implementation of KUAP for radix makes use of a MMU
feature in order to patch out assembly when KUAP is disabled or
unsupported. This won't work unless there's an entry point for KUP
support before the feature magic happens, so for PPC64 setup_kup() is
called early in setup.

On PPC32, feature_fixup() is done too early to allow the same.

Suggested-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/kup.h | 11 +++++++++++
 arch/powerpc/kernel/setup_64.c |  7 +++++++
 arch/powerpc/mm/init-common.c  |  5 +++++
 arch/powerpc/mm/init_32.c      |  3 +++
 4 files changed, 26 insertions(+)
 create mode 100644 arch/powerpc/include/asm/kup.h

v4: Unchanged.

diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
new file mode 100644
index 000000000000..7a88b8b9b54d
--- /dev/null
+++ b/arch/powerpc/include/asm/kup.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_KUP_H_
+#define _ASM_POWERPC_KUP_H_
+
+#ifndef __ASSEMBLY__
+
+void setup_kup(void);
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_POWERPC_KUP_H_ */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index daa361fc6a24..47ffa0885081 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -68,6 +68,7 @@
 #include <asm/cputhreads.h>
 #include <asm/hw_irq.h>
 #include <asm/feature-fixups.h>
+#include <asm/kup.h>
 
 #include "setup.h"
 
@@ -331,6 +332,12 @@ void __init early_setup(unsigned long dt_ptr)
 	 */
 	configure_exceptions();
 
+	/*
+	 * Configure Kernel Userspace Protection. This needs to happen before
+	 * feature fixups for platforms that implement this using features.
+	 */
+	setup_kup();
+
 	/* Apply all the dynamic patching */
 	apply_feature_fixups();
 	setup_feature_keys();
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 1e6910eb70ed..36d28e872289 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -24,6 +24,11 @@
 #include <linux/string.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
+#include <asm/kup.h>
+
+void __init setup_kup(void)
+{
+}
 
 #define CTOR(shift) static void ctor_##shift(void *addr) \
 {							\
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 41a3513cadc9..80cc97cd8878 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -45,6 +45,7 @@
 #include <asm/tlb.h>
 #include <asm/sections.h>
 #include <asm/hugetlb.h>
+#include <asm/kup.h>
 
 #include "mmu_decl.h"
 
@@ -178,6 +179,8 @@ void __init MMU_init(void)
 	btext_unmap();
 #endif
 
+	setup_kup();
+
 	/* Shortly after that, the entire linear mapping will be available */
 	memblock_set_current_limit(lowmem_end_addr);
 }
-- 
2.20.1

