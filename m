Return-Path: <SRS0=gB3U=IH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE866C433E6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Mar 2021 15:58:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E2E65242
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Mar 2021 15:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E2E65242
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dw0H75HmHz3dnG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Mar 2021 02:58:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=iK2JlFyh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+5fd0a10d8842976b880f+6407+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=iK2JlFyh; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dw0Dz1r4Bz3dQp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Mar 2021 02:56:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=H2ld+QgidDGzgxm+N1lJ7nVSOxHC57yc0v6xTacIbY4=; b=iK2JlFyhSt2fAxdUtndJ31jjUd
 hNycyMaLROgr5IP/6Vd9G0ejFwt4PjtbUOIllT6lpcyNO5JSrh2jzNp2gMWO+ruzsynjop/tobJfY
 Ktw36wP3bjGaJFUqad8boRQbzSj/WVqC2vdDF1erI4/UR8j/TiljW5ZWLiSLDSKyNVvtr+fZ51EBV
 pCBrYUDXEQT4MqRPo4dXzQFXnfTWXGQxciUvtoMiNYfJ8YId0Jxl0+zNdyZ/Wd4dtmXuU6KZ77azt
 BWf2kqMD8H4xw36e5pyhM+5SVtwMNqv43fs7ARRc/rD1HyYU5hEmwq8fHIT4tm/rith+FefXPeIqW
 /gsKX6iQ==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lJehM-000lUZ-SR; Tue, 09 Mar 2021 15:55:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 7/9] iomem: remove the iomem file system
Date: Tue,  9 Mar 2021 16:53:46 +0100
Message-Id: <20210309155348.974875-8-hch@lst.de>
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
 kernel/resource.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 0fd091a3f2fc66..12560553c26796 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -26,6 +26,7 @@
 #include <linux/mm.h>
 #include <linux/mount.h>
 #include <linux/resource_ext.h>
+#include <linux/anon_inodes.h>
 #include <uapi/linux/magic.h>
 #include <asm/io.h>
 
@@ -1838,37 +1839,14 @@ static int __init strict_iomem(char *str)
 	return 1;
 }
 
-static int iomem_fs_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, DEVMEM_MAGIC) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type iomem_fs_type = {
-	.name		= "iomem",
-	.owner		= THIS_MODULE,
-	.init_fs_context = iomem_fs_init_fs_context,
-	.kill_sb	= kill_anon_super,
-};
-
 static int __init iomem_init_inode(void)
 {
-	static struct vfsmount *iomem_vfs_mount;
-	static int iomem_fs_cnt;
 	struct inode *inode;
-	int rc;
-
-	rc = simple_pin_fs(&iomem_fs_type, &iomem_vfs_mount, &iomem_fs_cnt);
-	if (rc < 0) {
-		pr_err("Cannot mount iomem pseudo filesystem: %d\n", rc);
-		return rc;
-	}
 
-	inode = alloc_anon_inode_sb(iomem_vfs_mount->mnt_sb);
+	inode = alloc_anon_inode();
 	if (IS_ERR(inode)) {
-		rc = PTR_ERR(inode);
-		pr_err("Cannot allocate inode for iomem: %d\n", rc);
-		simple_release_fs(&iomem_vfs_mount, &iomem_fs_cnt);
-		return rc;
+		pr_err("Cannot allocate inode for iomem: %zd\n", PTR_ERR(inode));
+		return PTR_ERR(inode);
 	}
 
 	/*
-- 
2.30.1

