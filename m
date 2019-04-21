Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A52C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:33:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E4CC20869
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4CC20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nDJR0gNyzDqDm
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 01:33:43 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBjB4h7XzDqMg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:21:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44nBjB1xj5z9sB3; Mon, 22 Apr 2019 00:21:34 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBj91DXtz9sML; Mon, 22 Apr 2019 00:21:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.4 16/52] powerpc/powernv: Use the security flags in
 pnv_setup_rfi_flush()
Date: Mon, 22 Apr 2019 00:20:01 +1000
Message-Id: <20190421142037.21881-17-mpe@ellerman.id.au>
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

commit 37c0bdd00d3ae83369ab60a6712c28e11e6458d5 upstream.

Now that we have the security flags we can significantly simplify the
code in pnv_setup_rfi_flush(), because we can use the flags instead of
checking device tree properties and because the security flags have
pessimistic defaults.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/setup.c | 41 +++++++-------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 1edb4e05921c..a91330f79f66 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -65,7 +65,7 @@ static void init_fw_feat_flags(struct device_node *np)
 	if (fw_feature_is("enabled", "fw-bcctrl-serialized", np))
 		security_ftr_set(SEC_FTR_BCCTRL_SERIALISED);
 
-	if (fw_feature_is("enabled", "inst-spec-barrier-ori31,31,0", np))
+	if (fw_feature_is("enabled", "inst-l1d-flush-ori30,30,0", np))
 		security_ftr_set(SEC_FTR_L1D_FLUSH_ORI30);
 
 	if (fw_feature_is("enabled", "inst-l1d-flush-trig2", np))
@@ -98,11 +98,10 @@ static void pnv_setup_rfi_flush(void)
 {
 	struct device_node *np, *fw_features;
 	enum l1d_flush_type type;
-	int enable;
+	bool enable;
 
 	/* Default to fallback in case fw-features are not available */
 	type = L1D_FLUSH_FALLBACK;
-	enable = 1;
 
 	np = of_find_node_by_name(NULL, "ibm,opal");
 	fw_features = of_get_child_by_name(np, "fw-features");
@@ -110,40 +109,20 @@ static void pnv_setup_rfi_flush(void)
 
 	if (fw_features) {
 		init_fw_feat_flags(fw_features);
+		of_node_put(fw_features);
 
-		np = of_get_child_by_name(fw_features, "inst-l1d-flush-trig2");
-		if (np && of_property_read_bool(np, "enabled"))
+		if (security_ftr_enabled(SEC_FTR_L1D_FLUSH_TRIG2))
 			type = L1D_FLUSH_MTTRIG;
 
-		of_node_put(np);
-
-		np = of_get_child_by_name(fw_features, "inst-l1d-flush-ori30,30,0");
-		if (np && of_property_read_bool(np, "enabled"))
+		if (security_ftr_enabled(SEC_FTR_L1D_FLUSH_ORI30))
 			type = L1D_FLUSH_ORI;
-
-		of_node_put(np);
-
-		/* Enable unless firmware says NOT to */
-		enable = 2;
-		np = of_get_child_by_name(fw_features, "needs-l1d-flush-msr-hv-1-to-0");
-		if (np && of_property_read_bool(np, "disabled"))
-			enable--;
-
-		of_node_put(np);
-
-		np = of_get_child_by_name(fw_features, "needs-l1d-flush-msr-pr-0-to-1");
-		if (np && of_property_read_bool(np, "disabled"))
-			enable--;
-
-		np = of_get_child_by_name(fw_features, "speculation-policy-favor-security");
-		if (np && of_property_read_bool(np, "disabled"))
-			enable = 0;
-
-		of_node_put(np);
-		of_node_put(fw_features);
 	}
 
-	setup_rfi_flush(type, enable > 0);
+	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) && \
+		 (security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR)   || \
+		  security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV));
+
+	setup_rfi_flush(type, enable);
 }
 
 static void __init pnv_setup_arch(void)
-- 
2.20.1

