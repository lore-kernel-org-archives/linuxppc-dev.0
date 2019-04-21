Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D259FC10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:42:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C0D520693
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0D520693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nDVb420HzDqJL
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 01:42:31 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBjT22ryzDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:21:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44nBjS2PrJz9sMQ; Mon, 22 Apr 2019 00:21:48 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBjR0ddYz9s5c; Mon, 22 Apr 2019 00:21:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.4 22/52] powerpc/pseries: Restore default security
 feature flags on setup
Date: Mon, 22 Apr 2019 00:20:07 +1000
Message-Id: <20190421142037.21881-23-mpe@ellerman.id.au>
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

commit 6232774f1599028a15418179d17f7df47ede770a upstream.

After migration the security feature flags might have changed (e.g.,
destination system with unpatched firmware), but some flags are not
set/clear again in init_cpu_char_feature_flags() because it assumes
the security flags to be the defaults.

Additionally, if the H_GET_CPU_CHARACTERISTICS hypercall fails then
init_cpu_char_feature_flags() does not run again, which potentially
might leave the system in an insecure or sub-optimal configuration.

So, just restore the security feature flags to the defaults assumed
by init_cpu_char_feature_flags() so it can set/clear them correctly,
and to ensure safe settings are in place in case the hypercall fail.

Fixes: f636c14790ea ("powerpc/pseries: Set or clear security feature flags")
Depends-on: 19887d6a28e2 ("powerpc: Move default security feature flags")
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/setup.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 0a2ca848b8db..9aa61b5e8568 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -502,6 +502,10 @@ static void __init find_and_init_phbs(void)
 
 static void init_cpu_char_feature_flags(struct h_cpu_char_result *result)
 {
+	/*
+	 * The features below are disabled by default, so we instead look to see
+	 * if firmware has *enabled* them, and set them if so.
+	 */
 	if (result->character & H_CPU_CHAR_SPEC_BAR_ORI31)
 		security_ftr_set(SEC_FTR_SPEC_BAR_ORI31);
 
@@ -541,6 +545,13 @@ void pseries_setup_rfi_flush(void)
 	bool enable;
 	long rc;
 
+	/*
+	 * Set features to the defaults assumed by init_cpu_char_feature_flags()
+	 * so it can set/clear again any features that might have changed after
+	 * migration, and in case the hypercall fails and it is not even called.
+	 */
+	powerpc_security_features = SEC_FTR_DEFAULT;
+
 	rc = plpar_get_cpu_characteristics(&result);
 	if (rc == H_SUCCESS)
 		init_cpu_char_feature_flags(&result);
-- 
2.20.1

