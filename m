Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE0DC10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:27:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8910820833
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8910820833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nD9c5GRzzDqLJ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 01:27:48 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBj25hCFzDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:21:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44nBj12Dfmz9sMx; Mon, 22 Apr 2019 00:21:25 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBhz6ywxz9s5c; Mon, 22 Apr 2019 00:21:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.4 12/52] powerpc/pseries: Set or clear security
 feature flags
Date: Mon, 22 Apr 2019 00:19:57 +1000
Message-Id: <20190421142037.21881-13-mpe@ellerman.id.au>
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

commit f636c14790ead6cc22cf62279b1f8d7e11a67116 upstream.

Now that we have feature flags for security related things, set or
clear them based on what we receive from the hypercall.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/setup.c | 43 ++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index ab8c4c8b46bd..7c7c95c00252 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -67,6 +67,7 @@
 #include <asm/eeh.h>
 #include <asm/reg.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/security_features.h>
 
 #include "pseries.h"
 
@@ -499,6 +500,40 @@ static void __init find_and_init_phbs(void)
 	of_pci_check_probe_only();
 }
 
+static void init_cpu_char_feature_flags(struct h_cpu_char_result *result)
+{
+	if (result->character & H_CPU_CHAR_SPEC_BAR_ORI31)
+		security_ftr_set(SEC_FTR_SPEC_BAR_ORI31);
+
+	if (result->character & H_CPU_CHAR_BCCTRL_SERIALISED)
+		security_ftr_set(SEC_FTR_BCCTRL_SERIALISED);
+
+	if (result->character & H_CPU_CHAR_L1D_FLUSH_ORI30)
+		security_ftr_set(SEC_FTR_L1D_FLUSH_ORI30);
+
+	if (result->character & H_CPU_CHAR_L1D_FLUSH_TRIG2)
+		security_ftr_set(SEC_FTR_L1D_FLUSH_TRIG2);
+
+	if (result->character & H_CPU_CHAR_L1D_THREAD_PRIV)
+		security_ftr_set(SEC_FTR_L1D_THREAD_PRIV);
+
+	if (result->character & H_CPU_CHAR_COUNT_CACHE_DISABLED)
+		security_ftr_set(SEC_FTR_COUNT_CACHE_DISABLED);
+
+	/*
+	 * The features below are enabled by default, so we instead look to see
+	 * if firmware has *disabled* them, and clear them if so.
+	 */
+	if (!(result->character & H_CPU_BEHAV_FAVOUR_SECURITY))
+		security_ftr_clear(SEC_FTR_FAVOUR_SECURITY);
+
+	if (!(result->character & H_CPU_BEHAV_L1D_FLUSH_PR))
+		security_ftr_clear(SEC_FTR_L1D_FLUSH_PR);
+
+	if (!(result->character & H_CPU_BEHAV_BNDS_CHK_SPEC_BAR))
+		security_ftr_clear(SEC_FTR_BNDS_CHK_SPEC_BAR);
+}
+
 void pseries_setup_rfi_flush(void)
 {
 	struct h_cpu_char_result result;
@@ -512,6 +547,8 @@ void pseries_setup_rfi_flush(void)
 
 	rc = plpar_get_cpu_characteristics(&result);
 	if (rc == H_SUCCESS) {
+		init_cpu_char_feature_flags(&result);
+
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_TRIG2)
 			types |= L1D_FLUSH_MTTRIG;
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_ORI30)
@@ -522,6 +559,12 @@ void pseries_setup_rfi_flush(void)
 			enable = false;
 	}
 
+	/*
+	 * We're the guest so this doesn't apply to us, clear it to simplify
+	 * handling of it elsewhere.
+	 */
+	security_ftr_clear(SEC_FTR_L1D_FLUSH_HV);
+
 	setup_rfi_flush(types, enable);
 }
 
-- 
2.20.1

