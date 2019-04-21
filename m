Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA41C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:41:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA60A2077C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA60A2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nDSy2zS0zDqFm
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 01:41:06 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBjR128vzDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:21:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44nBjP5N57z9sMQ; Mon, 22 Apr 2019 00:21:45 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBjP06jSz9sML; Mon, 22 Apr 2019 00:21:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.4 21/52] powerpc: Move default security feature flags
Date: Mon, 22 Apr 2019 00:20:06 +1000
Message-Id: <20190421142037.21881-22-mpe@ellerman.id.au>
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
2.20.1

