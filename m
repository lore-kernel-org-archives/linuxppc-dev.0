Return-Path: <SRS0=hDs2=35=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A32CC35250
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Feb 2020 13:15:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2FD120733
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Feb 2020 13:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGX16Twk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FD120733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48FqKm4CRmzDqQn
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Feb 2020 00:15:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=ZGX16Twk; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Fpw34Y18zDqN8
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Feb 2020 23:57:07 +1100 (AEDT)
Received: from localhost (unknown [38.98.37.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5CA792081E;
 Sun,  9 Feb 2020 12:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581253025;
 bh=GZDs+2I8Zu/fkAf+zMYTdMQ6mWpB0sh+HmrhjqeNZpg=;
 h=From:To:Cc:Subject:Date:From;
 b=ZGX16Twk8Pz+EE4u2eqM+8EbdYsiuKKWGuWzdgzHlY/QQnjZQL9WZkAWA82l8Z6Lp
 W8C4yqkbHO2YyaSjMg73C/hyrhcqKWcc1XFA/1s5M84U4XWSIR3hCWYE0/58Wbwnv7
 SZtwray3/cEojve2FxyFkSS3YwBTrLoGbgTQpFaA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/6] powerpc: kernel: no need to check return value of
 debugfs_create functions
Date: Sun,  9 Feb 2020 11:58:56 +0100
Message-Id: <20200209105901.1620958-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hari Bathini <hbathini@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/fadump.c       |  9 ++-------
 arch/powerpc/kernel/setup-common.c |  3 +--
 arch/powerpc/kernel/traps.c        | 25 +++++--------------------
 3 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index ff0114aeba9b..b83fa42c19e1 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1432,7 +1432,6 @@ DEFINE_SHOW_ATTRIBUTE(fadump_region);
 
 static void fadump_init_files(void)
 {
-	struct dentry *debugfs_file;
 	int rc = 0;
 
 	rc = sysfs_create_file(kernel_kobj, &fadump_attr.attr);
@@ -1445,12 +1444,8 @@ static void fadump_init_files(void)
 		printk(KERN_ERR "fadump: unable to create sysfs file"
 			" fadump_registered (%d)\n", rc);
 
-	debugfs_file = debugfs_create_file("fadump_region", 0444,
-					powerpc_debugfs_root, NULL,
-					&fadump_region_fops);
-	if (!debugfs_file)
-		printk(KERN_ERR "fadump: unable to create debugfs file"
-				" fadump_region\n");
+	debugfs_create_file("fadump_region", 0444, powerpc_debugfs_root, NULL,
+			    &fadump_region_fops);
 
 	if (fw_dump.dump_active) {
 		rc = sysfs_create_file(kernel_kobj, &fadump_release_attr.attr);
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 7f8c890360fe..f9c0d888ce8a 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -787,8 +787,7 @@ EXPORT_SYMBOL(powerpc_debugfs_root);
 static int powerpc_debugfs_init(void)
 {
 	powerpc_debugfs_root = debugfs_create_dir("powerpc", NULL);
-
-	return powerpc_debugfs_root == NULL;
+	return 0;
 }
 arch_initcall(powerpc_debugfs_init);
 #endif
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 82a3438300fd..3fca22276bb1 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -2278,35 +2278,20 @@ void ppc_warn_emulated_print(const char *type)
 
 static int __init ppc_warn_emulated_init(void)
 {
-	struct dentry *dir, *d;
+	struct dentry *dir;
 	unsigned int i;
 	struct ppc_emulated_entry *entries = (void *)&ppc_emulated;
 
-	if (!powerpc_debugfs_root)
-		return -ENODEV;
-
 	dir = debugfs_create_dir("emulated_instructions",
 				 powerpc_debugfs_root);
-	if (!dir)
-		return -ENOMEM;
 
-	d = debugfs_create_u32("do_warn", 0644, dir,
-			       &ppc_warn_emulated);
-	if (!d)
-		goto fail;
+	debugfs_create_u32("do_warn", 0644, dir, &ppc_warn_emulated);
 
-	for (i = 0; i < sizeof(ppc_emulated)/sizeof(*entries); i++) {
-		d = debugfs_create_u32(entries[i].name, 0644, dir,
-				       (u32 *)&entries[i].val.counter);
-		if (!d)
-			goto fail;
-	}
+	for (i = 0; i < sizeof(ppc_emulated)/sizeof(*entries); i++)
+		debugfs_create_u32(entries[i].name, 0644, dir,
+				   (u32 *)&entries[i].val.counter);
 
 	return 0;
-
-fail:
-	debugfs_remove_recursive(dir);
-	return -ENOMEM;
 }
 
 device_initcall(ppc_warn_emulated_init);
-- 
2.25.0

