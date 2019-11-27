Return-Path: <SRS0=SG0q=ZT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BAEC432C3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Nov 2019 22:13:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2A4216F4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Nov 2019 22:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2A4216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47NZlj2PX8zDqy1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Nov 2019 09:13:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47NZhJ6bqkzDqx1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Nov 2019 09:10:07 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 395CFB3DC;
 Wed, 27 Nov 2019 22:10:03 +0000 (UTC)
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: add link stack flush mitigation status in debugfs.
Date: Wed, 27 Nov 2019 23:09:59 +0100
Message-Id: <20191127220959.6208-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Anthony Steinhauser <asteinhauser@google.com>,
 "Gustavo L. F. Walbon" <gwalbon@linux.ibm.com>,
 "Christopher M. Riedl" <cmr@informatik.wtf>,
 YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
 Diana Craciun <diana.craciun@nxp.com>, Paul Mackerras <paulus@samba.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Michal Suchanek <msuchanek@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The link stack flush status is not visible in debugfs. It can be enabled
even when count cache flush is disabled. Add separate file for its
status.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/security.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 7d4b2080a658..56dce4798a4d 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -446,14 +446,26 @@ static int count_cache_flush_get(void *data, u64 *val)
 	return 0;
 }
 
+static int link_stack_flush_get(void *data, u64 *val)
+{
+	*val = link_stack_flush_enabled;
+
+	return 0;
+}
+
 DEFINE_DEBUGFS_ATTRIBUTE(fops_count_cache_flush, count_cache_flush_get,
 			 count_cache_flush_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_link_stack_flush, link_stack_flush_get,
+			 count_cache_flush_set, "%llu\n");
 
 static __init int count_cache_flush_debugfs_init(void)
 {
 	debugfs_create_file_unsafe("count_cache_flush", 0600,
 				   powerpc_debugfs_root, NULL,
 				   &fops_count_cache_flush);
+	debugfs_create_file_unsafe("link_stack_flush", 0600,
+				   powerpc_debugfs_root, NULL,
+				   &fops_link_stack_flush);
 	return 0;
 }
 device_initcall(count_cache_flush_debugfs_init);
-- 
2.23.0

