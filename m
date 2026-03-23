Return-Path: <linuxppc-dev+bounces-18588-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A31CFC72A8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 07:02:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffPHs3CYVz2yYy;
	Mon, 23 Mar 2026 18:02:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774249353;
	cv=none; b=NAnqadlWVjd31O21hswyA4UcFmku694bQIzYJKr2ei0pzvduXESBdJWmcvM4fy4hi5kdRuv5d5m4GlI8OS3Km6qEtVK0i7eTJ5cOIceMD2ynjeWjQwRBLjec+KSO/M9ADXNXLY/rpmkXPdoIhNDFCaHsBguvSTFqKQwBQc9iup9h3C240eHtZ/lNLTr2o2IXYn6/Nol9n0G6HDAWTMNYExWLnhFo/ZqKww4Evq+aupXCcs+9WzwLHOeZo6qFlczFTyTzjfMSqyWTxqCMWcC3SRXaEFvo9arZ0Olye5+lDkKRP07R+QyGBVhkX4sWnthb3/XmdUGgjnfIqP44gGccOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774249353; c=relaxed/relaxed;
	bh=Wlkrm0myB9P5DBDaclzihXCLak0GcKolkRDqx8ZruQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXDZ/VoI3lHbSayR4XJzq28HMRlnlvSM4hCT/NKF34bhs3vJOh6usJH+4j0YKI299edhlWq1KQv6104ZyGhb+dJwMaCjyT2ULoIUtkijlO74DjfZlnSCi4nSWpkdNPwIbzKsegfIn2G8W2L85Cd1MmAK2N6nyCgswcNiL+LmpxUa2ppj/mEidX13KdZupJ1/t5v16C/ulPmHfYSO+TluMAxMebtMzY/w01g5pY6VfWtf0jBX/2OOLfQ5uq8TYCZD/IbsLm+8Tg4DJtqCZ1aNmdkabCHP7pFWRissSxa/b1WVtAiHBDtKs6R7qSp/BIMvA530v6w3epE4TFqRx50Upw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TRdqtC3V; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+58733bf867d043cbf217+8247+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TRdqtC3V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+58733bf867d043cbf217+8247+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffPHr5CTfz2ySb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 18:02:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Wlkrm0myB9P5DBDaclzihXCLak0GcKolkRDqx8ZruQ0=; b=TRdqtC3V4JFkKzclMhRAwPhHvy
	haVphzi2M7zk2uFS2hNi2cvsdo3KRHQNhivSBcXRnQY04c/UZFTQUTWRBCRGlYddGLskEQJv3Y+62
	SDFsbVLO+EL5tXadw1l46vFGdvKD9ppMVDE/hUbqjPRgrSFgAcAWkNETxhTUOlzZz9cuyrHZU9svb
	+kW/i3TienruQ8EuClSUwk/Y+uSNWjzooEsCpDUbTCywABz1EyUkpWPW3kxAyRx3/MCoQfpRUNwzs
	vhXUJmOuK5THFvsbqDy0IQ/jjLSkS0FvtgFwEY30dC0kyDFHrH8AkLvYUqfmJUz0Zd3bfW+Njpl7X
	r2vG4dnA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ZIz-0000000G9lB-1wml;
	Mon, 23 Mar 2026 07:02:30 +0000
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
Subject: [PATCH 3/3] fs: remove do_sys_truncate
Date: Mon, 23 Mar 2026 08:01:46 +0100
Message-ID: <20260323070205.2939118-4-hch@lst.de>
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

do_sys_truncate ist only used to implement ksys_truncate and the native
truncate syscalls.  Merge do_sys_truncate into ksys_truncate and return
int from it as it only returns 0 or negative errnos.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/open.c                | 8 ++++----
 include/linux/syscalls.h | 8 +-------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 181c1597e73c..681d405bc61e 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -126,7 +126,7 @@ int vfs_truncate(const struct path *path, loff_t length)
 }
 EXPORT_SYMBOL_GPL(vfs_truncate);
 
-int do_sys_truncate(const char __user *pathname, loff_t length)
+int ksys_truncate(const char __user *pathname, loff_t length)
 {
 	unsigned int lookup_flags = LOOKUP_FOLLOW;
 	struct path path;
@@ -151,13 +151,13 @@ int do_sys_truncate(const char __user *pathname, loff_t length)
 
 SYSCALL_DEFINE2(truncate, const char __user *, path, long, length)
 {
-	return do_sys_truncate(path, length);
+	return ksys_truncate(path, length);
 }
 
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(truncate, const char __user *, path, compat_off_t, length)
 {
-	return do_sys_truncate(path, length);
+	return ksys_truncate(path, length);
 }
 #endif
 
@@ -222,7 +222,7 @@ COMPAT_SYSCALL_DEFINE2(ftruncate, unsigned int, fd, compat_off_t, length)
 #if BITS_PER_LONG == 32
 SYSCALL_DEFINE2(truncate64, const char __user *, path, loff_t, length)
 {
-	return do_sys_truncate(path, length);
+	return ksys_truncate(path, length);
 }
 
 SYSCALL_DEFINE2(ftruncate64, unsigned int, fd, loff_t, length)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 8787b3511c86..f5639d5ac331 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1285,13 +1285,7 @@ static inline long ksys_lchown(const char __user *filename, uid_t user,
 
 #define FTRUNCATE_LFS	(1u << 0)	/* allow truncating > 32-bit */
 int ksys_ftruncate(unsigned int fd, loff_t length, unsigned int flags);
-
-int do_sys_truncate(const char __user *pathname, loff_t length);
-
-static inline long ksys_truncate(const char __user *pathname, loff_t length)
-{
-	return do_sys_truncate(pathname, length);
-}
+int ksys_truncate(const char __user *pathname, loff_t length);
 
 static inline unsigned int ksys_personality(unsigned int personality)
 {
-- 
2.47.3


