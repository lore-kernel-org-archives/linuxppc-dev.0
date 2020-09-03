Return-Path: <SRS0=NZKl=CM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302B2C433E9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:33:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444CD208C7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QMX94UFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444CD208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bj3FF1sLVzDr6Y
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2020 00:33:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+0324f78733eae8ed4bec+6220+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=QMX94UFc; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bj31W17CPzDr3j
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Sep 2020 00:22:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=a0ZdxEmc4Ya6AVRsiFgEwXG4tBh4LjkqZ1uo+PU8+e4=; b=QMX94UFc9yqTHvC0XKzCDJqHCO
 PQ2j49kyyeDnBRj5wWH5+BHFTqV0K26mV6+Nz0wDHJ6g7ucosqy0PkrqIpJf3wCRa6OziORzSMOZf
 FV8rvubo7rcjapO3kY1PJEzFoDzvuzm+DCTVtttCazTw1Q4An3/651tpb0e1AU9cGtAhkYM5ZuSed
 foP2WQfSsgBLwztr9Krp6bGrBynwZf/WlsXNs7asaSRyrsyQ9ucsMXmBQ0inrpFT4z8IDVqxvA0Oc
 YQhg6fNYg5Gg4BI6aiJ8XOThTUhhCBonzONn8NOvHqhTh5acxpUgYAy9XRP0xG1fIoGY10WP8uqND
 GwwSGXuA==;
Received: from [2001:4bb8:184:af1:c70:4a89:bc61:2] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDq8T-0004a6-4P; Thu, 03 Sep 2020 14:22:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org
Subject: [PATCH 01/14] proc: remove a level of indentation in proc_get_inode
Date: Thu,  3 Sep 2020 16:22:29 +0200
Message-Id: <20200903142242.925828-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903142242.925828-1-hch@lst.de>
References: <20200903142242.925828-1-hch@lst.de>
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
Cc: linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alexey Dobriyan <adobriyan@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Just return early on inode allocation failure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/inode.c | 72 +++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 28d6105e908e4c..016b1302cbabc0 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -619,42 +619,44 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 {
 	struct inode *inode = new_inode(sb);
 
-	if (inode) {
-		inode->i_ino = de->low_ino;
-		inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
-		PROC_I(inode)->pde = de;
-
-		if (is_empty_pde(de)) {
-			make_empty_dir_inode(inode);
-			return inode;
-		}
-		if (de->mode) {
-			inode->i_mode = de->mode;
-			inode->i_uid = de->uid;
-			inode->i_gid = de->gid;
-		}
-		if (de->size)
-			inode->i_size = de->size;
-		if (de->nlink)
-			set_nlink(inode, de->nlink);
-
-		if (S_ISREG(inode->i_mode)) {
-			inode->i_op = de->proc_iops;
-			inode->i_fop = &proc_reg_file_ops;
+	if (!inode) {
+		pde_put(de);
+		return NULL;
+	}
+
+	inode->i_ino = de->low_ino;
+	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	PROC_I(inode)->pde = de;
+	if (is_empty_pde(de)) {
+		make_empty_dir_inode(inode);
+		return inode;
+	}
+
+	if (de->mode) {
+		inode->i_mode = de->mode;
+		inode->i_uid = de->uid;
+		inode->i_gid = de->gid;
+	}
+	if (de->size)
+		inode->i_size = de->size;
+	if (de->nlink)
+		set_nlink(inode, de->nlink);
+
+	if (S_ISREG(inode->i_mode)) {
+		inode->i_op = de->proc_iops;
+		inode->i_fop = &proc_reg_file_ops;
 #ifdef CONFIG_COMPAT
-			if (!de->proc_ops->proc_compat_ioctl) {
-				inode->i_fop = &proc_reg_file_ops_no_compat;
-			}
+		if (!de->proc_ops->proc_compat_ioctl)
+			inode->i_fop = &proc_reg_file_ops_no_compat;
 #endif
-		} else if (S_ISDIR(inode->i_mode)) {
-			inode->i_op = de->proc_iops;
-			inode->i_fop = de->proc_dir_ops;
-		} else if (S_ISLNK(inode->i_mode)) {
-			inode->i_op = de->proc_iops;
-			inode->i_fop = NULL;
-		} else
-			BUG();
-	} else
-	       pde_put(de);
+	} else if (S_ISDIR(inode->i_mode)) {
+		inode->i_op = de->proc_iops;
+		inode->i_fop = de->proc_dir_ops;
+	} else if (S_ISLNK(inode->i_mode)) {
+		inode->i_op = de->proc_iops;
+		inode->i_fop = NULL;
+	} else {
+		BUG();
+	}
 	return inode;
 }
-- 
2.28.0

