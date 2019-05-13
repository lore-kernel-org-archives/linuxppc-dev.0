Return-Path: <SRS0=ygHD=TN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95ACC04A6B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 May 2019 00:52:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BDCA2084E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 May 2019 00:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDCA2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=git.icu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 452Mjd4czHzDqJW
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 May 2019 10:52:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=git.icu
 (client-ip=163.172.180.134; helo=git.icu; envelope-from=shawn@git.icu;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=git.icu
Received: from git.icu (git.icu [163.172.180.134])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 452MhB4Sq0zDqCY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2019 10:51:22 +1000 (AEST)
Received: from localhost.localdomain (minicloud.parqtec.unicamp.br
 [143.106.167.126]) by git.icu (Postfix) with ESMTPSA id 5583D220850;
 Mon, 13 May 2019 00:51:15 +0000 (UTC)
From: Shawn Landden <shawn@git.icu>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RESEND] powerpc: add simd.h implementation specific to PowerPC
Date: Sun, 12 May 2019 21:51:04 -0300
Message-Id: <20190513005104.20140-1-shawn@git.icu>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <20190512165032.19942-1-shawn@git.icu>
References: <20190512165032.19942-1-shawn@git.icu>
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
Cc: Shawn Landden <shawn@git.icu>, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

It is safe to do SIMD in an interrupt on PowerPC.
Only disable when there is no SIMD available
(and this is a static branch).

Tested and works with the WireGuard (Zinc) patch I wrote that needs this.
Also improves performance of the crypto subsystem that checks this.

Re-sending because this linuxppc-dev didn't seem to accept it.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=203571
Signed-off-by: Shawn Landden <shawn@git.icu>
---
 arch/powerpc/include/asm/simd.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/powerpc/include/asm/simd.h

diff --git a/arch/powerpc/include/asm/simd.h b/arch/powerpc/include/asm/simd.h
new file mode 100644
index 000000000..b3fecb95a
--- /dev/null
+++ b/arch/powerpc/include/asm/simd.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#include <asm/cpu_has_feature.h>
+
+/*
+ * may_use_simd - whether it is allowable at this time to issue SIMD
+ *                instructions or access the SIMD register file
+ *
+ * As documented in Chapter 6.2.1 Machine Status Save/Restore Registers
+ * of Power ISA (2.07 and 3.0), all registers are saved/restored in an interrupt.
+ */
+static inline bool may_use_simd(void)
+{
+	return !cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE);
+}
-- 
2.21.0.1020.gf2820cf01a

