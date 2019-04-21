Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A77C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:29:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7622E20833
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7622E20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nDCL6lGJzDqFJ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 01:29:18 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBj44nz4zDqMg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:21:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44nBj25LM1z9sB3; Mon, 22 Apr 2019 00:21:26 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBj12CvSz9sML; Mon, 22 Apr 2019 00:21:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.4 13/52] powerpc/powernv: Set or clear security
 feature flags
Date: Mon, 22 Apr 2019 00:19:58 +1000
Message-Id: <20190421142037.21881-14-mpe@ellerman.id.au>
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

commit 77addf6e95c8689e478d607176b399a6242a777e upstream.

Now that we have feature flags for security related things, set or
clear them based on what we see in the device tree provided by
firmware.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/setup.c | 56 ++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index fdc5f25a1b4a..1edb4e05921c 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -37,9 +37,63 @@
 #include <asm/smp.h>
 #include <asm/tm.h>
 #include <asm/setup.h>
+#include <asm/security_features.h>
 
 #include "powernv.h"
 
+
+static bool fw_feature_is(const char *state, const char *name,
+			  struct device_node *fw_features)
+{
+	struct device_node *np;
+	bool rc = false;
+
+	np = of_get_child_by_name(fw_features, name);
+	if (np) {
+		rc = of_property_read_bool(np, state);
+		of_node_put(np);
+	}
+
+	return rc;
+}
+
+static void init_fw_feat_flags(struct device_node *np)
+{
+	if (fw_feature_is("enabled", "inst-spec-barrier-ori31,31,0", np))
+		security_ftr_set(SEC_FTR_SPEC_BAR_ORI31);
+
+	if (fw_feature_is("enabled", "fw-bcctrl-serialized", np))
+		security_ftr_set(SEC_FTR_BCCTRL_SERIALISED);
+
+	if (fw_feature_is("enabled", "inst-spec-barrier-ori31,31,0", np))
+		security_ftr_set(SEC_FTR_L1D_FLUSH_ORI30);
+
+	if (fw_feature_is("enabled", "inst-l1d-flush-trig2", np))
+		security_ftr_set(SEC_FTR_L1D_FLUSH_TRIG2);
+
+	if (fw_feature_is("enabled", "fw-l1d-thread-split", np))
+		security_ftr_set(SEC_FTR_L1D_THREAD_PRIV);
+
+	if (fw_feature_is("enabled", "fw-count-cache-disabled", np))
+		security_ftr_set(SEC_FTR_COUNT_CACHE_DISABLED);
+
+	/*
+	 * The features below are enabled by default, so we instead look to see
+	 * if firmware has *disabled* them, and clear them if so.
+	 */
+	if (fw_feature_is("disabled", "speculation-policy-favor-security", np))
+		security_ftr_clear(SEC_FTR_FAVOUR_SECURITY);
+
+	if (fw_feature_is("disabled", "needs-l1d-flush-msr-pr-0-to-1", np))
+		security_ftr_clear(SEC_FTR_L1D_FLUSH_PR);
+
+	if (fw_feature_is("disabled", "needs-l1d-flush-msr-hv-1-to-0", np))
+		security_ftr_clear(SEC_FTR_L1D_FLUSH_HV);
+
+	if (fw_feature_is("disabled", "needs-spec-barrier-for-bound-checks", np))
+		security_ftr_clear(SEC_FTR_BNDS_CHK_SPEC_BAR);
+}
+
 static void pnv_setup_rfi_flush(void)
 {
 	struct device_node *np, *fw_features;
@@ -55,6 +109,8 @@ static void pnv_setup_rfi_flush(void)
 	of_node_put(np);
 
 	if (fw_features) {
+		init_fw_feat_flags(fw_features);
+
 		np = of_get_child_by_name(fw_features, "inst-l1d-flush-trig2");
 		if (np && of_property_read_bool(np, "enabled"))
 			type = L1D_FLUSH_MTTRIG;
-- 
2.20.1

