Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640C3C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:30:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6CB20833
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6CB20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nDF333bBzDqSw
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 01:30:47 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBjB2PLtzDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:21:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44nBj91DSbz9s5c; Mon, 22 Apr 2019 00:21:33 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBj5584Tz9sNK; Mon, 22 Apr 2019 00:21:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.4 15/52] powerpc/64s: Enhance the information in
 cpu_show_meltdown()
Date: Mon, 22 Apr 2019 00:20:00 +1000
Message-Id: <20190421142037.21881-16-mpe@ellerman.id.au>
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

commit ff348355e9c72493947be337bb4fae4fc1a41eba upstream.

Now that we have the security feature flags we can make the
information displayed in the "meltdown" file more informative.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/security_features.h |  1 +
 arch/powerpc/kernel/security.c               | 30 ++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/security_features.h b/arch/powerpc/include/asm/security_features.h
index db00ad2c72c2..400a9050e035 100644
--- a/arch/powerpc/include/asm/security_features.h
+++ b/arch/powerpc/include/asm/security_features.h
@@ -10,6 +10,7 @@
 
 
 extern unsigned long powerpc_security_features;
+extern bool rfi_flush;
 
 static inline void security_ftr_set(unsigned long feature)
 {
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 564e7f182a16..865db6f8bcca 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -6,6 +6,7 @@
 
 #include <linux/kernel.h>
 #include <linux/device.h>
+#include <linux/seq_buf.h>
 
 #include <asm/security_features.h>
 
@@ -19,8 +20,33 @@ unsigned long powerpc_security_features __read_mostly = \
 
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	if (rfi_flush)
-		return sprintf(buf, "Mitigation: RFI Flush\n");
+	bool thread_priv;
+
+	thread_priv = security_ftr_enabled(SEC_FTR_L1D_THREAD_PRIV);
+
+	if (rfi_flush || thread_priv) {
+		struct seq_buf s;
+		seq_buf_init(&s, buf, PAGE_SIZE - 1);
+
+		seq_buf_printf(&s, "Mitigation: ");
+
+		if (rfi_flush)
+			seq_buf_printf(&s, "RFI Flush");
+
+		if (rfi_flush && thread_priv)
+			seq_buf_printf(&s, ", ");
+
+		if (thread_priv)
+			seq_buf_printf(&s, "L1D private per thread");
+
+		seq_buf_printf(&s, "\n");
+
+		return s.len;
+	}
+
+	if (!security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV) &&
+	    !security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR))
+		return sprintf(buf, "Not affected\n");
 
 	return sprintf(buf, "Vulnerable\n");
 }
-- 
2.20.1

