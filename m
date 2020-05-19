Return-Path: <SRS0=gZAI=7B=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C635FC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2020 00:41:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836902072C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2020 00:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836902072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Qxrk5jsXzDqvK
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2020 10:41:10 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49QxgW4f5QzDqJf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2020 10:33:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49QxgV2bB8z9sTj;
 Tue, 19 May 2020 10:33:10 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/7] powerpc/dt_cpu_ftrs: Advertise support for ISA v3.1 if
 selected
Date: Tue, 19 May 2020 10:31:53 +1000
Message-Id: <20200519003157.31946-4-alistair@popple.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519003157.31946-1-alistair@popple.id.au>
References: <20200519003157.31946-1-alistair@popple.id.au>
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
Cc: mikey@neuling.org, npiggin@gmail.com, aneesh.kumar@linux.ibm.com,
 Alistair Popple <alistair@popple.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On powernv hardware support for ISAv3.1 is advertised via a cpu feature
bit in the device tree. This patch enables the associated HWCAP bit if
the device tree indicates ISAv3.1 is available.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/kernel/dt_cpu_ftrs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 36bc0d5c4f3a..b5e21264d168 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -26,6 +26,7 @@
 /* Device-tree visible constants follow */
 #define ISA_V2_07B      2070
 #define ISA_V3_0B       3000
+#define ISA_V3_1        3100
 
 #define USABLE_PR               (1U << 0)
 #define USABLE_OS               (1U << 1)
@@ -654,6 +655,11 @@ static void __init cpufeatures_setup_start(u32 isa)
 		cur_cpu_spec->cpu_features |= CPU_FTR_ARCH_300;
 		cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_ARCH_3_00;
 	}
+
+	if (isa >= 3100) {
+		cur_cpu_spec->cpu_features |= CPU_FTR_ARCH_31;
+		cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_ARCH_3_1;
+	}
 }
 
 static bool __init cpufeatures_process_feature(struct dt_cpu_feature *f)
-- 
2.20.1

