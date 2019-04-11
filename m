Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F773C10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 12:40:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC23E2077C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 12:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC23E2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44g0wk6X73zDq83
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 22:40:06 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fzlj5WDvzDqQh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 21:47:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44fzlj1hFfz9sNp; Thu, 11 Apr 2019 21:47:13 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44fzlh6FSDz9sDn; Thu, 11 Apr 2019 21:47:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.9 27/35] powerpc/fsl: Add nospectre_v2 command line
 argument
Date: Thu, 11 Apr 2019 21:46:22 +1000
Message-Id: <20190411114630.4042-28-mpe@ellerman.id.au>
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

From: Diana Craciun <diana.craciun@nxp.com>

commit f633a8ad636efb5d4bba1a047d4a0f1ef719aa06 upstream.

When the command line argument is present, the Spectre variant 2
mitigations are disabled.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/setup.h |  5 +++++
 arch/powerpc/kernel/security.c   | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 23ee67e279ae..862ebce3ae54 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -65,6 +65,11 @@ void do_barrier_nospec_fixups_range(bool enable, void *start, void *end);
 static inline void do_barrier_nospec_fixups_range(bool enable, void *start, void *end) { };
 #endif
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+void setup_spectre_v2(void);
+#else
+static inline void setup_spectre_v2(void) {};
+#endif
 void do_btb_flush_fixups(void);
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index fc41bccd9ab6..6dc5cdc2b87c 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -27,6 +27,10 @@ static enum count_cache_flush_type count_cache_flush_type = COUNT_CACHE_FLUSH_NO
 
 bool barrier_nospec_enabled;
 static bool no_nospec;
+static bool btb_flush_enabled;
+#ifdef CONFIG_PPC_FSL_BOOK3E
+static bool no_spectrev2;
+#endif
 
 static void enable_barrier_nospec(bool enable)
 {
@@ -102,6 +106,23 @@ static __init int barrier_nospec_debugfs_init(void)
 device_initcall(barrier_nospec_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+static int __init handle_nospectre_v2(char *p)
+{
+	no_spectrev2 = true;
+
+	return 0;
+}
+early_param("nospectre_v2", handle_nospectre_v2);
+void setup_spectre_v2(void)
+{
+	if (no_spectrev2)
+		do_btb_flush_fixups();
+	else
+		btb_flush_enabled = true;
+}
+#endif /* CONFIG_PPC_FSL_BOOK3E */
+
 #ifdef CONFIG_PPC_BOOK3S_64
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
-- 
2.20.1

