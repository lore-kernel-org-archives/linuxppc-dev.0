Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122C0C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 16:26:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 907C62077C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 16:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907C62077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nFTr5KT7zDqQg
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 02:26:56 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBkg3PsFzDqDp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:22:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44nBkf3yhVz9sBZ; Mon, 22 Apr 2019 00:22:50 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBkd5QTHz9sLt; Mon, 22 Apr 2019 00:22:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.4 51/52] powerpc/security: Fix spectre_v2 reporting
Date: Mon, 22 Apr 2019 00:20:36 +1000
Message-Id: <20190421142037.21881-52-mpe@ellerman.id.au>
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

commit 92edf8df0ff2ae86cc632eeca0e651fd8431d40d upstream.

When I updated the spectre_v2 reporting to handle software count cache
flush I got the logic wrong when there's no software count cache
enabled at all.

The result is that on systems with the software count cache flush
disabled we print:

  Mitigation: Indirect branch cache disabled, Software count cache flush

Which correctly indicates that the count cache is disabled, but
incorrectly says the software count cache flush is enabled.

The root of the problem is that we are trying to handle all
combinations of options. But we know now that we only expect to see
the software count cache flush enabled if the other options are false.

So split the two cases, which simplifies the logic and fixes the bug.
We were also missing a space before "(hardware accelerated)".

The result is we see one of:

  Mitigation: Indirect branch serialisation (kernel only)
  Mitigation: Indirect branch cache disabled
  Mitigation: Software count cache flush
  Mitigation: Software count cache flush (hardware accelerated)

Fixes: ee13cb249fab ("powerpc/64s: Add support for software count cache flush")
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Michael Neuling <mikey@neuling.org>
Reviewed-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/security.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 523466345d79..58f0602a92b9 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -190,29 +190,22 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, c
 	bcs = security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED);
 	ccd = security_ftr_enabled(SEC_FTR_COUNT_CACHE_DISABLED);
 
-	if (bcs || ccd || count_cache_flush_type != COUNT_CACHE_FLUSH_NONE) {
-		bool comma = false;
+	if (bcs || ccd) {
 		seq_buf_printf(&s, "Mitigation: ");
 
-		if (bcs) {
+		if (bcs)
 			seq_buf_printf(&s, "Indirect branch serialisation (kernel only)");
-			comma = true;
-		}
 
-		if (ccd) {
-			if (comma)
-				seq_buf_printf(&s, ", ");
-			seq_buf_printf(&s, "Indirect branch cache disabled");
-			comma = true;
-		}
-
-		if (comma)
+		if (bcs && ccd)
 			seq_buf_printf(&s, ", ");
 
-		seq_buf_printf(&s, "Software count cache flush");
+		if (ccd)
+			seq_buf_printf(&s, "Indirect branch cache disabled");
+	} else if (count_cache_flush_type != COUNT_CACHE_FLUSH_NONE) {
+		seq_buf_printf(&s, "Mitigation: Software count cache flush");
 
 		if (count_cache_flush_type == COUNT_CACHE_FLUSH_HW)
-			seq_buf_printf(&s, "(hardware accelerated)");
+			seq_buf_printf(&s, " (hardware accelerated)");
 	} else if (btb_flush_enabled) {
 		seq_buf_printf(&s, "Mitigation: Branch predictor state flush");
 	} else {
-- 
2.20.1

