Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C622606A33F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KIilknYp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMhC6YMTz2yD3;
	Tue, 17 Nov 2026 22:19:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794914379;
	cv=none; b=e+KuBe8uElHka6nzJ3lLKMVBX6djbvyIZJSt5IRbk5w3YgixOs/CCDaYY9mm2CnHgNPVxGQ+YC7OamVlTaAAf69mBauDEfKCHm1Mqt701raElB4vuL6yoP80c1RsjKAxGtkq2TNIQ0gNoU5qyf62M1v786g7RtXnB6cuH1a/3zR8zH+laYUAxrHmRsBwJ/lvHKGVNjb1IWpgQUxSmX23ekw2/xh5tdWxEYh+3bohtXgyOyc/6WOV4au6SYTAL+OcwtgvkTr6qJ6Rao/MnEx8BUCObQH3WqDqq0CGpeKG5UQ+k/mk61BVPBnOeOJjMV3uIJn3/mRnbIfwDnYg+F7pmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794914379; c=relaxed/relaxed;
	bh=RYSQ5kLa3H9TG5xUvnHteU+yhk15bteC+s8cksoZucI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSStIXbemrUVn2xOfwSgJiW8VPTkWA3sz0k3e1pzUQkFdq5Uh5OJXNhAv2Jz85A2b3s4DZdZSdwsY8kkh2Tn+84EyL/joKrRyB7Vb5tzV2SKdr+3b1psF1WcxsbOcEbFIfSeDyNychDVgClWgChH5gifyd/j11xMOxa17XDNz8BIQ93ezjXkH9KQCGQljWrTlWXNGYocB1tbmQU6TT/BfIM1jEtB+dFcac5b8ROicL0hKqS7g3cM5qAerAeqoRtdEjAxpYUoWFirsZnDCYiV2fZQYvuybeO/hvQAknR+Z6BctEzx5JdpQUOenWyANoSaRw/mb3RHLSugxDsFKRs/Jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KIilknYp; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KIilknYp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMhC1TsJz2y8r
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 22:19:39 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36FC11BF3;
	Tue, 17 Nov 2026 03:19:05 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D3B23F763;
	Tue, 17 Nov 2026 03:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914348; bh=VdWsKyGxR5ZeDlLk4op5RqTNUGJF8BnYRHcAvnh4Am4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KIilknYp8+I1cTjeiTHP1GTtDiTp4mHC9hqjewZSm0iB4PaisNIudYj4+XfprI/k1
	 vOv4ttJW2ITxrTrKKdc0PSgVO2K5gGB9AQaUN+UammfdEOhmHjKg/MkXE3yEodqteg
	 9SOdha/CFNR4QZy6gBJZC52RbPRv8FnqlnSduUqY=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 11/19] RAS: Remove unused ras_userspace_consumers()
Date: Tue, 17 Nov 2026 12:10:21 +0100
Message-ID: <20261117111444.4185512-12-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117111444.4185512-1-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove the unused ras_userspace_consumers() and atomic
trace_count as the previous patch made extlog select
CPER console output by severity.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/ras/debugfs.c | 10 ----------
 include/linux/ras.h   |  2 --
 2 files changed, 12 deletions(-)

diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index 42afd3de68b22..838cc689b9989 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -5,20 +5,12 @@
 
 static struct dentry *ras_debugfs_dir;
 
-static atomic_t trace_count = ATOMIC_INIT(0);
-
 struct dentry *ras_get_debugfs_root(void)
 {
 	return ras_debugfs_dir;
 }
 EXPORT_SYMBOL_GPL(ras_get_debugfs_root);
 
-int ras_userspace_consumers(void)
-{
-	return atomic_read(&trace_count);
-}
-EXPORT_SYMBOL_GPL(ras_userspace_consumers);
-
 static int trace_show(struct seq_file *m, void *v)
 {
 	return 0;
@@ -26,13 +18,11 @@ static int trace_show(struct seq_file *m, void *v)
 
 static int trace_open(struct inode *inode, struct file *file)
 {
-	atomic_inc(&trace_count);
 	return single_open(file, trace_show, NULL);
 }
 
 static int trace_release(struct inode *inode, struct file *file)
 {
-	atomic_dec(&trace_count);
 	return single_release(inode, file);
 }
 
diff --git a/include/linux/ras.h b/include/linux/ras.h
index 468941bfe855f..3159f9a0877ed 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -7,11 +7,9 @@
 #include <linux/cper.h>
 
 #ifdef CONFIG_DEBUG_FS
-int ras_userspace_consumers(void);
 void ras_debugfs_init(void);
 int ras_add_daemon_trace(void);
 #else
-static inline int ras_userspace_consumers(void) { return 0; }
 static inline void ras_debugfs_init(void) { }
 static inline int ras_add_daemon_trace(void) { return 0; }
 #endif
-- 
2.43.0


