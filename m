Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E0FC10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 16:10:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC6D20821
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 16:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC6D20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nF6f0NnNzDqVp
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 02:10:18 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBkG27X9zDqDp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:22:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44nBkF2PM3z9sB3; Mon, 22 Apr 2019 00:22:29 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBkD1Q1Pz9sMx; Mon, 22 Apr 2019 00:22:27 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.4 40/52] powerpc/64s: Add new security feature flags
 for count cache flush
Date: Mon, 22 Apr 2019 00:20:25 +1000
Message-Id: <20190421142037.21881-41-mpe@ellerman.id.au>
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

commit dc8c6cce9a26a51fc19961accb978217a3ba8c75 upstream.

Add security feature flags to indicate the need for software to flush
the count cache on context switch, and for the presence of a hardware
assisted count cache flush.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/security_features.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/security_features.h b/arch/powerpc/include/asm/security_features.h
index 44989b22383c..a0d47bc18a5c 100644
--- a/arch/powerpc/include/asm/security_features.h
+++ b/arch/powerpc/include/asm/security_features.h
@@ -59,6 +59,9 @@ static inline bool security_ftr_enabled(unsigned long feature)
 // Indirect branch prediction cache disabled
 #define SEC_FTR_COUNT_CACHE_DISABLED	0x0000000000000020ull
 
+// bcctr 2,0,0 triggers a hardware assisted count cache flush
+#define SEC_FTR_BCCTR_FLUSH_ASSIST	0x0000000000000800ull
+
 
 // Features indicating need for Spectre/Meltdown mitigations
 
@@ -74,6 +77,9 @@ static inline bool security_ftr_enabled(unsigned long feature)
 // Firmware configuration indicates user favours security over performance
 #define SEC_FTR_FAVOUR_SECURITY		0x0000000000000200ull
 
+// Software required to flush count cache on context switch
+#define SEC_FTR_FLUSH_COUNT_CACHE	0x0000000000000400ull
+
 
 // Features enabled by default
 #define SEC_FTR_DEFAULT \
-- 
2.20.1

