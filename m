Return-Path: <SRS0=gB3U=IH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FA9C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Mar 2021 15:56:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249B165242
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Mar 2021 15:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249B165242
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dw0F93dWFz3dRw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Mar 2021 02:56:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Vjun9SYZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+5fd0a10d8842976b880f+6407+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=Vjun9SYZ; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dw0CX3RdFz3cPj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Mar 2021 02:55:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=7nuDahRSmYJ6PThyWDr7Xu918vQCfVTiqk1yVO8AeRg=; b=Vjun9SYZDP9JrvLc48F11Twd4e
 R5XJpfUwpMyzQ7LtqixDEwkdoeqMTSNnJdErVwe0Gzw90B+bXKlQrQtVddfTJjnxrXXk9GJdmnkLG
 JWtTCjj1tN3tRiy5QVYGaGk4mgMQDl7FurXRb5D9u2XjIb0BBWxIW2/CEBaVK1OQH9jbs+X8Xd9SG
 CQBblQ+dHU5PcnYPQf4yUg5m2Jit6/wznYXt69OGzneI5IxXDIsKy0DIl2KrOqddiHgFmAS6r1eUq
 afS57DyaEcVHy1jBTyC8xHx/LlT6dBW1HchxjZs5WfYY5xaJbcPB/sgk69m8QFMOAW8SbI69fEk8h
 JaExt8Tg==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lJegk-000lND-Rr; Tue, 09 Mar 2021 15:54:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 3/9] powerpc/pseries: remove the ppc-cmm file system
Date: Tue,  9 Mar 2021 16:53:42 +0100
Message-Id: <20210309155348.974875-4-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309155348.974875-1-hch@lst.de>
References: <20210309155348.974875-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Jason Gunthorpe <jgg@nvidia.com>, David Hildenbrand <david@redhat.com>,
 "VMware, Inc." <pv-drivers@vmware.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Minchan Kim <minchan@kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
 Nadav Amit <namit@vmware.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Nitin Gupta <ngupta@vflare.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Just use the generic anon_inode file system.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/pseries/cmm.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 6d36b858b14df1..9d07e6bea7126c 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -6,6 +6,7 @@
  * Author(s): Brian King (brking@linux.vnet.ibm.com),
  */
 
+#include <linux/anon_inodes.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
@@ -502,19 +503,6 @@ static struct notifier_block cmm_mem_nb = {
 };
 
 #ifdef CONFIG_BALLOON_COMPACTION
-static struct vfsmount *balloon_mnt;
-
-static int cmm_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, PPC_CMM_MAGIC) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type balloon_fs = {
-	.name = "ppc-cmm",
-	.init_fs_context = cmm_init_fs_context,
-	.kill_sb = kill_anon_super,
-};
-
 static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 			   struct page *newpage, struct page *page,
 			   enum migrate_mode mode)
@@ -573,19 +561,10 @@ static int cmm_balloon_compaction_init(void)
 	balloon_devinfo_init(&b_dev_info);
 	b_dev_info.migratepage = cmm_migratepage;
 
-	balloon_mnt = kern_mount(&balloon_fs);
-	if (IS_ERR(balloon_mnt)) {
-		rc = PTR_ERR(balloon_mnt);
-		balloon_mnt = NULL;
-		return rc;
-	}
-
-	b_dev_info.inode = alloc_anon_inode_sb(balloon_mnt->mnt_sb);
+	b_dev_info.inode = alloc_anon_inode();
 	if (IS_ERR(b_dev_info.inode)) {
 		rc = PTR_ERR(b_dev_info.inode);
 		b_dev_info.inode = NULL;
-		kern_unmount(balloon_mnt);
-		balloon_mnt = NULL;
 		return rc;
 	}
 
@@ -597,8 +576,6 @@ static void cmm_balloon_compaction_deinit(void)
 	if (b_dev_info.inode)
 		iput(b_dev_info.inode);
 	b_dev_info.inode = NULL;
-	kern_unmount(balloon_mnt);
-	balloon_mnt = NULL;
 }
 #else /* CONFIG_BALLOON_COMPACTION */
 static int cmm_balloon_compaction_init(void)
-- 
2.30.1

