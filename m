Return-Path: <linuxppc-dev+bounces-18587-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CC0D58CDC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 07:02:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffPHl35kRz2ygl;
	Mon, 23 Mar 2026 18:02:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774249347;
	cv=none; b=N80xBaWb8tBfVBWgg20R2UdFyPPes8jGyjxMymxEgx9ITWbq0t2Aiwfu/SYqBbdXOa26/o6aQzmY1JEcAC0mHPcqRjEXCzk981cG6QTYh3NnrEJHTNY9BFdx/eAS3p8sl3nXIZt301fXKbKz4SlhmzXXGn2US2DBOgf4oWWNXWAyEDewqqYKHhITXgaf0kwY8k7yI9yK4Wze9C1fkgTgHQi73Rim2upo1xwy0KLpCRzZdAYeDHMuXtTVtQP3ar1jQLbEy3j+EJeHAb5vgLZutqo6n304ZtUqFIaFcPNvEugQrR2ju0q+h+vROtfCAsQaVObAhSp06nTe7+EWxYkKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774249347; c=relaxed/relaxed;
	bh=K4orJb2U7jo77rJOM/60B2idHYzibFtexOIXEJjzLmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=je5BE/bWMuxuoYMNNberH1tf4nOkMq9wGL8VB7juDURiznhT5oMzbI4L6BTve3ouCqEgPYm8Zhf1AncwkvLwj/JAWP7D1dHjoEK5EdxFPqRKAo5Sm31Ql5NOZP6e/gyBPr+zvXk8zremYjg6aMmLv3ANK/sMeJ1IY8Lb3bztzHgaGOGGBgWhZHAUSXqeejI5HIQ2r8puGAPIgha8NX0Kp55FEJ3hhHYPK1L4HOMGBEJrTJFdI3l5OZnB/cP9fbcKq9uEtqF3wJ+uvBTm0/zREdgERwFFRlmUhCgtHlKvnxt8dNvaDc1xwHMWqap6ljVrgCLVr1zK+z3hhLBuJq138A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YdkQ84WT; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+58733bf867d043cbf217+8247+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YdkQ84WT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+58733bf867d043cbf217+8247+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffPHk3xVdz2yYy
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 18:02:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=K4orJb2U7jo77rJOM/60B2idHYzibFtexOIXEJjzLmY=; b=YdkQ84WTBNdlag+U1IP4PCep8i
	Px0qdWy9rfMDEzJnnG/DvDXj1xVgKt1CHjjpnz07nUKX9y5fBx/xS6CMPoH79C2gJC9kt0apBdeAU
	0bRmYOmF6PEgyZCRpz//N12NFmjSof1H35Nir05Dp9vCf0imRSWdgX+sqiEn1QimU07Y35BtUqqPz
	Aci6mUH0QMnOnnS5Ns6iWFVBWfmzHkZnbtjHoPWzca4kxS3t6wEoAYfNsPj0+IyllEdBC2Pqt9hmx
	zSb46hWvGaVYH8DdsA37I61Ice/zkXSKiIRL7O48zKvr52WQrAEDlAiHMCjN4IZ3vW5wozbgmAQTk
	6JyrsbPQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ZIt-0000000G9jb-03ST;
	Mon, 23 Mar 2026 07:02:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: [PATCH 2/3] fs: pass on FTRUNCATE_* flags to do_truncate
Date: Mon, 23 Mar 2026 08:01:45 +0100
Message-ID: <20260323070205.2939118-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323070205.2939118-1-hch@lst.de>
References: <20260323070205.2939118-1-hch@lst.de>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Pass the flags one level down to replace the somewhat confusing small
argument, and clean up do_truncate as a result.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/internal.h       |  2 +-
 fs/open.c           | 22 ++++++++++------------
 io_uring/truncate.c |  2 +-
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 2663823e273a..52e4c354e7a4 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -198,7 +198,7 @@ extern struct open_how build_open_how(int flags, umode_t mode);
 extern int build_open_flags(const struct open_how *how, struct open_flags *op);
 struct file *file_close_fd_locked(struct files_struct *files, unsigned fd);
 
-int do_ftruncate(struct file *file, loff_t length, int small);
+int do_ftruncate(struct file *file, loff_t length, unsigned int flags);
 int chmod_common(const struct path *path, umode_t mode);
 int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 		int flag);
diff --git a/fs/open.c b/fs/open.c
index 412d0d6fbaa7..181c1597e73c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -161,23 +161,21 @@ COMPAT_SYSCALL_DEFINE2(truncate, const char __user *, path, compat_off_t, length
 }
 #endif
 
-int do_ftruncate(struct file *file, loff_t length, int small)
+int do_ftruncate(struct file *file, loff_t length, unsigned int flags)
 {
-	struct inode *inode;
-	struct dentry *dentry;
+	struct dentry *dentry = file->f_path.dentry;
+	struct inode *inode = dentry->d_inode;
 	int error;
 
-	/* explicitly opened as large or we are on 64-bit box */
-	if (file->f_flags & O_LARGEFILE)
-		small = 0;
-
-	dentry = file->f_path.dentry;
-	inode = dentry->d_inode;
 	if (!S_ISREG(inode->i_mode) || !(file->f_mode & FMODE_WRITE))
 		return -EINVAL;
 
-	/* Cannot ftruncate over 2^31 bytes without large file support */
-	if (small && length > MAX_NON_LFS)
+	/*
+	 * Cannot ftruncate over 2^31 bytes without large file support, either
+	 * through opening with O_LARGEFILE or by using ftruncate64().
+	 */
+	if (length > MAX_NON_LFS &&
+	    !(file->f_flags & O_LARGEFILE) && !(flags & FTRUNCATE_LFS))
 		return -EINVAL;
 
 	/* Check IS_APPEND on real upper inode */
@@ -205,7 +203,7 @@ int ksys_ftruncate(unsigned int fd, loff_t length, unsigned int flags)
 	if (fd_empty(f))
 		return -EBADF;
 
-	return do_ftruncate(fd_file(f), length, !(flags & FTRUNCATE_LFS));
+	return do_ftruncate(fd_file(f), length, flags);
 }
 
 SYSCALL_DEFINE2(ftruncate, unsigned int, fd, off_t, length)
diff --git a/io_uring/truncate.c b/io_uring/truncate.c
index 487baf23b44e..c88d8bd8d20e 100644
--- a/io_uring/truncate.c
+++ b/io_uring/truncate.c
@@ -41,7 +41,7 @@ int io_ftruncate(struct io_kiocb *req, unsigned int issue_flags)
 
 	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
 
-	ret = do_ftruncate(req->file, ft->len, 1);
+	ret = do_ftruncate(req->file, ft->len, 0);
 
 	io_req_set_res(req, ret, 0);
 	return IOU_COMPLETE;
-- 
2.47.3


