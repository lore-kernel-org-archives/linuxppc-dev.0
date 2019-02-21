Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A3BC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 09:39:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D8220880
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 09:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="mZrKumfV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aele8Py0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D8220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444qF43vJYzDqPB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 20:39:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="mZrKumfV"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="aele8Py0"; dkim-atps=neutral
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444q9V2n2VzDqPC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 20:36:30 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id ED299220D0;
 Thu, 21 Feb 2019 04:36:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 21 Feb 2019 04:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=1P63kGbsVFuBa
 K0rcVbu5M1YQbbnh/BjZjuVOGJYTNI=; b=mZrKumfVa2+7bNZwSu1mrxL7Ni1Cm
 xOBglVrEyzV+vMoIC++PFLxpCNqM+H4yyczyg1K9vHD2F610zTkF6DlG5zssDJQ5
 opVTP1RMv+Qb4YnHTJVqZVE9kSksxtIoqGGKFnDUyPjWJCQKe4piKSzdcSNCTYUd
 SCmx88QZLvMxX3H5IBY0lvVu/W1wq5bPsnl3G+iaPmsnjfeVGQo0p4UgLWjHTvpw
 bJz46Vx+QuAvAIdLstudNIgdi4+8b/FGQCUnWWPUIR9mGwuSJp1QKlsOP1JREAiP
 lymEJ1V9eZZhZn7JNUdouH7QFSjcPPbJvLh2lvbWrKSzIFeDAVJYr+5Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=1P63kGbsVFuBaK0rcVbu5M1YQbbnh/BjZjuVOGJYTNI=; b=aele8Py0
 V5KPOLwis9IYSxZVdGLAJxumr6YDqFbDPAH1RrrtceUwnSLRlKKyNmbjxnBKcQgX
 pOAbzjsNR3Ep3ucPZUfkn+Ee0Sdopc65yQsaCgoHzxQE2u+stJ2jIawdY0ZnLZ/Q
 J6Zr+yDsqO+wBy+UbEESruoryC3dQ1Fff1hqFij+TpLEUOiPIa7b9FfPsmm9Bg2z
 jksYEKrPNbxVs1MkonGMQPQQCZcabMKgAIYKydvn2QtOKENlSh311SGiGBRGRacl
 knWcD4SXm9E8IZ3RNj0KSITx9FYM7n0rbllxug6CIqjgBoTH58bRZgvB91sdVMIT
 Dg11OuvHyCdN+w==
X-ME-Sender: <xms:G3FuXGsLBSO5zUB8N_IMQWo4Q73dGhOvOYdotiF-rGnQA-MHhoJV-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdekgddtjeculddtuddrgedtledrtddtmd
 cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
 uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefhvf
 fufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhushhsvghllhcuvehurhhr
 vgihuceorhhushgtuhhrsehruhhsshgvlhhlrdgttgeqnecukfhppeduvddvrdelledrke
 dvrddutdenucfrrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhl
 rdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:G3FuXHJMD1ed43XO0X_pNvLdiwwo66oBzblMdcS2mv7SWTgiVk2qNQ>
 <xmx:G3FuXFaWhd9-8XapSPemx1maF5mSH9ZCODvSd72qtPvlUrUhLrKF3A>
 <xmx:G3FuXBcVPEmOBEJm0TurGyshZN3KawzEb5RX7GmPHsJuytAQ_mLgJw>
 <xmx:G3FuXEmm5lOQ54zr3X5wdnA-vEqyX7Pmh8e2O96iIZal3Y9O5hWX6g>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6344610331;
 Thu, 21 Feb 2019 04:36:25 -0500 (EST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/7] powerpc: Add framework for Kernel Userspace Protection
Date: Thu, 21 Feb 2019 20:35:55 +1100
Message-Id: <20190221093601.27920-2-ruscur@russell.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221093601.27920-1-ruscur@russell.cc>
References: <20190221093601.27920-1-ruscur@russell.cc>
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
Cc: Russell Currey <ruscur@russell.cc>, npiggin@gmail.com,
 kernel-hardening@lists.openwall.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Christophe Leroy <christophe.leroy@c-s.fr>

This patch adds a skeleton for Kernel Userspace Protection
functionnalities like Kernel Userspace Access Protection and
Kernel Userspace Execution Prevention

The subsequent implementation of KUAP for radix makes use of a MMU
feature in order to patch out assembly when KUAP is disabled or
unsupported.  This won't work unless there's an entry point for
KUP support before the feature magic happens, so for PPC64
setup_kup() is called early in setup.

On PPC32, feature_fixup is done too early to allow the same.

Suggested-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/kup.h | 11 +++++++++++
 arch/powerpc/kernel/setup_64.c |  7 +++++++
 arch/powerpc/mm/init-common.c  |  5 +++++
 arch/powerpc/mm/init_32.c      |  3 +++
 4 files changed, 26 insertions(+)
 create mode 100644 arch/powerpc/include/asm/kup.h

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
index 236c1151a3a7..771f280a6bf6 100644
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
index 3e59e5d64b01..93cfa8cf015d 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -45,6 +45,7 @@
 #include <asm/tlb.h>
 #include <asm/sections.h>
 #include <asm/hugetlb.h>
+#include <asm/kup.h>
 
 #include "mmu_decl.h"
 
@@ -182,6 +183,8 @@ void __init MMU_init(void)
 	btext_unmap();
 #endif
 
+	setup_kup();
+
 	/* Shortly after that, the entire linear mapping will be available */
 	memblock_set_current_limit(lowmem_end_addr);
 }
-- 
2.20.1

