Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC27C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:32:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97BB120833
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BB120833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nDGg5Ld3zDqTX
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 01:32:11 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBjB1wmKzDqFL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:21:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44nBj558m3z9sNB; Mon, 22 Apr 2019 00:21:29 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBj40LXMz9sLt; Mon, 22 Apr 2019 00:21:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.4 14/52] powerpc/64s: Move cpu_show_meltdown()
Date: Mon, 22 Apr 2019 00:19:59 +1000
Message-Id: <20190421142037.21881-15-mpe@ellerman.id.au>
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

commit 8ad33041563a10b34988800c682ada14b2612533 upstream.

This landed in setup_64.c for no good reason other than we had nowhere
else to put it. Now that we have a security-related file, that is a
better place for it so move it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/security.c | 11 +++++++++++
 arch/powerpc/kernel/setup_64.c |  8 --------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 4ccba00d224c..564e7f182a16 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -5,6 +5,8 @@
 // Copyright 2018, Michael Ellerman, IBM Corporation.
 
 #include <linux/kernel.h>
+#include <linux/device.h>
+
 #include <asm/security_features.h>
 
 
@@ -13,3 +15,12 @@ unsigned long powerpc_security_features __read_mostly = \
 	SEC_FTR_L1D_FLUSH_PR | \
 	SEC_FTR_BNDS_CHK_SPEC_BAR | \
 	SEC_FTR_FAVOUR_SECURITY;
+
+
+ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	if (rfi_flush)
+		return sprintf(buf, "Mitigation: RFI Flush\n");
+
+	return sprintf(buf, "Vulnerable\n");
+}
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index e975f2533767..41c537d8a688 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -961,12 +961,4 @@ static __init int rfi_flush_debugfs_init(void)
 }
 device_initcall(rfi_flush_debugfs_init);
 #endif
-
-ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	if (rfi_flush)
-		return sprintf(buf, "Mitigation: RFI Flush\n");
-
-	return sprintf(buf, "Vulnerable\n");
-}
 #endif /* CONFIG_PPC_BOOK3S_64 */
-- 
2.20.1

