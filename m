Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D2FC10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 12:07:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804C0206B7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 12:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804C0206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44g0BZ39SQzDqRY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 22:07:02 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fzlJ4rtbzDqQh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 21:46:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44fzlJ2vRtz9sBr; Thu, 11 Apr 2019 21:46:52 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44fzlJ1FfVz9sCF; Thu, 11 Apr 2019 21:46:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.9 10/35] powerpc64s: Show ori31 availability in
 spectre_v1 sysfs file not v2
Date: Thu, 11 Apr 2019 21:46:05 +1000
Message-Id: <20190411114630.4042-11-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411114630.4042-1-mpe@ellerman.id.au>
References: <20190411114630.4042-1-mpe@ellerman.id.au>
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
Cc: diana.craciun@nxp.com, linuxppc-dev@ozlabs.org, msuchanek@suse.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

commit 6d44acae1937b81cf8115ada8958e04f601f3f2e upstream.

When I added the spectre_v2 information in sysfs, I included the
availability of the ori31 speculation barrier.

Although the ori31 barrier can be used to mitigate v2, it's primarily
intended as a spectre v1 mitigation. Spectre v2 is mitigated by
hardware changes.

So rework the sysfs files to show the ori31 information in the
spectre_v1 file, rather than v2.

Currently we display eg:

  $ grep . spectre_v*
  spectre_v1:Mitigation: __user pointer sanitization
  spectre_v2:Mitigation: Indirect branch cache disabled, ori31 speculation barrier enabled

After:

  $ grep . spectre_v*
  spectre_v1:Mitigation: __user pointer sanitization, ori31 speculation barrier enabled
  spectre_v2:Mitigation: Indirect branch cache disabled

Fixes: d6fbe1c55c55 ("powerpc/64s: Wire up cpu_show_spectre_v2()")
Cc: stable@vger.kernel.org # v4.17+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/security.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index f189f946d935..bf298d0c475f 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -118,25 +118,35 @@ ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, cha
 
 ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	if (!security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR))
-		return sprintf(buf, "Not affected\n");
+	struct seq_buf s;
+
+	seq_buf_init(&s, buf, PAGE_SIZE - 1);
 
-	if (barrier_nospec_enabled)
-		return sprintf(buf, "Mitigation: __user pointer sanitization\n");
+	if (security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR)) {
+		if (barrier_nospec_enabled)
+			seq_buf_printf(&s, "Mitigation: __user pointer sanitization");
+		else
+			seq_buf_printf(&s, "Vulnerable");
 
-	return sprintf(buf, "Vulnerable\n");
+		if (security_ftr_enabled(SEC_FTR_SPEC_BAR_ORI31))
+			seq_buf_printf(&s, ", ori31 speculation barrier enabled");
+
+		seq_buf_printf(&s, "\n");
+	} else
+		seq_buf_printf(&s, "Not affected\n");
+
+	return s.len;
 }
 
 ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	bool bcs, ccd, ori;
 	struct seq_buf s;
+	bool bcs, ccd;
 
 	seq_buf_init(&s, buf, PAGE_SIZE - 1);
 
 	bcs = security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED);
 	ccd = security_ftr_enabled(SEC_FTR_COUNT_CACHE_DISABLED);
-	ori = security_ftr_enabled(SEC_FTR_SPEC_BAR_ORI31);
 
 	if (bcs || ccd) {
 		seq_buf_printf(&s, "Mitigation: ");
@@ -152,9 +162,6 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, c
 	} else
 		seq_buf_printf(&s, "Vulnerable");
 
-	if (ori)
-		seq_buf_printf(&s, ", ori31 speculation barrier enabled");
-
 	seq_buf_printf(&s, "\n");
 
 	return s.len;
-- 
2.20.1

