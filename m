Return-Path: <SRS0=j/g1=IY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD63C433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 14:41:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041A861A05
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 14:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041A861A05
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6Pmy2BJwz3c4g
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Mar 2021 01:41:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=btDOhdv9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+31783f3a8021f30233dc+6424+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=btDOhdv9; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6Pkg2JKNz3c2V
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Mar 2021 01:39:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=/jKV/Gy/+fs6Gymuc4/KOBeEW5L+yZioO5xj7LGmOvk=; b=btDOhdv9dVGM1bGt10zskeqyPc
 IJAjY5J3M0V2Ssi7NNgeil59DhlO7E6oivZQivAq28Yc/KdK5u93ZUzDZoVMRBaqlxf7Hzy6oPSFM
 Gc7pPPsejd0I1/ziak6y+NLOOzg/pHXRIHbvit+wD4AvJYsnF0HfOWu5pwz5GIOWq8HdAkje6X7N3
 TUJFPYXDjR9Q79HD9E3nT09I7Kla49p7nnSeVcJQ8d4upVPhE6fnygZAebM1joGOA27iFFm/o0+/B
 mCSb1li1OrgAlMOR/k7wZ8wo7QJW5gJo0hZgzjjtivcofkbuzF9JLCQDLtOI6vcJLBXrOv9eI7Fih
 ZqqU60vg==;
Received: from [213.208.157.35] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lPncI-005U87-0D; Fri, 26 Mar 2021 14:39:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4/4] exec: move the call to getname_flags into do_execveat
Date: Fri, 26 Mar 2021 15:38:31 +0100
Message-Id: <20210326143831.1550030-5-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210326143831.1550030-1-hch@lst.de>
References: <20210326143831.1550030-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-parisc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Brian Gerst <brgerst@gmail.com>, x86@kernel.org, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Remove the duplicated copying of the pathname into the common helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exec.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index b34c1eb9e7ad8e..5c0dd8f85fe7b5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1843,13 +1843,16 @@ static int bprm_execve(struct linux_binprm *bprm,
 	return retval;
 }
 
-static int do_execveat(int fd, struct filename *filename,
+static int do_execveat(int fd, const char __user *pathname,
 		const char __user *const __user *argv,
 		const char __user *const __user *envp, int flags)
 {
+	int lookup_flags = (flags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
+	struct filename *filename;
 	struct linux_binprm *bprm;
 	int retval;
 
+	filename = getname_flags(pathname, lookup_flags, NULL);
 	if (IS_ERR(filename))
 		return PTR_ERR(filename);
 
@@ -1993,7 +1996,7 @@ SYSCALL_DEFINE3(execve,
 		const char __user *const __user *, argv,
 		const char __user *const __user *, envp)
 {
-	return do_execveat(AT_FDCWD, getname(filename), argv, envp, 0);
+	return do_execveat(AT_FDCWD, filename, argv, envp, 0);
 }
 
 SYSCALL_DEFINE5(execveat,
@@ -2002,9 +2005,5 @@ SYSCALL_DEFINE5(execveat,
 		const char __user *const __user *, envp,
 		int, flags)
 {
-	int lookup_flags = (flags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
-
-	return do_execveat(fd,
-			   getname_flags(filename, lookup_flags, NULL),
-			   argv, envp, flags);
+	return do_execveat(fd, filename, argv, envp, flags);
 }
-- 
2.30.1

