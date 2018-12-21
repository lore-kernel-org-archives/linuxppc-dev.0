Return-Path: <SRS0=o62n=O6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49B2C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 17:33:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4280321917
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 17:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4280321917
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Lwh917l0zDrFm
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 04:33:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.21; helo=inva021.nxp.com;
 envelope-from=diana.craciun@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Lwdy27LyzDr2y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 04:31:17 +1100 (AEDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1B50B200064;
 Fri, 21 Dec 2018 18:31:14 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0FB6C200002;
 Fri, 21 Dec 2018 18:31:14 +0100 (CET)
Received: from fsr-ub1664-009.ea.freescale.net
 (fsr-ub1664-009.ea.freescale.net [10.171.71.77])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D5539205E9;
 Fri, 21 Dec 2018 18:31:13 +0100 (CET)
From: Diana Craciun <diana.craciun@nxp.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/11 v2] powerpc/fsl: Add nospectre_v2 command line argument
Date: Fri, 21 Dec 2018 19:30:31 +0200
Message-Id: <1545413437-5538-6-git-send-email-diana.craciun@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545413437-5538-1-git-send-email-diana.craciun@nxp.com>
References: <1545413437-5538-1-git-send-email-diana.craciun@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
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
Cc: Diana Craciun <diana.craciun@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When the command line argument is present, the Spectre variant 2
mitigations are disabled.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
---
v1-->v2
- no changes

 arch/powerpc/include/asm/setup.h |  5 +++++
 arch/powerpc/kernel/security.c   | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index c941c8c..65676e2 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -67,6 +67,11 @@ void do_barrier_nospec_fixups_range(bool enable, void *start, void *end);
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
index 1b395b8..4393a38 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -26,6 +26,10 @@ static enum count_cache_flush_type count_cache_flush_type = COUNT_CACHE_FLUSH_NO
 
 bool barrier_nospec_enabled;
 static bool no_nospec;
+static bool btb_flush_enabled;
+#ifdef CONFIG_PPC_FSL_BOOK3E
+static bool no_spectrev2;
+#endif
 
 static void enable_barrier_nospec(bool enable)
 {
@@ -101,6 +105,23 @@ static __init int barrier_nospec_debugfs_init(void)
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
2.5.5

