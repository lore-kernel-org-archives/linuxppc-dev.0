Return-Path: <SRS0=WC9B=B3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319D9C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 07:41:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D567220738
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 07:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mDbBIzqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D567220738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BVQvc14F0zDqN3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 17:41:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+1cabf852a0fb828109f5+6203+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=mDbBIzqp; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BVQjp277ZzDqND
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 17:32:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Y/gPSrkcO0WTBRy6i45H6VgYWvtoV6CDlRazRsDykmI=; b=mDbBIzqpRFZmPKJME9zJ5B6R80
 fAir7UfNE2GI1NIAug65/QMmCPxR8FLQLYWm2LtvqDRk0UOz/OsfX6aM6ILoUjPONfhm/Owd4xyEO
 XHyPQZmphYMb2tzsOd5O015Fm4+he404d4ul0XJHyfUGOUYHKSq1nrrhsgbLQeBcJkMgFbO++HYv7
 nIIgiAWsUb5Z2doPvKSiUNRZY5InCEefBFmun51u9FHVm/KL1BmdUv4X04LpmI6xZUwIFs66tKBpj
 TQNxZWavJtci0faEGIVLJOePM6jbSorgyIS/q9vkKYsPq5NyRZf6FqV8tHuF/oPLFGvbW2Vcl4OJo
 QnegHBKQ==;
Received: from [2001:4bb8:188:3918:4550:cdf7:3d45:afb9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7Zd1-0000wH-QO; Mon, 17 Aug 2020 07:32:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org
Subject: [PATCH 06/11] lkdtm: disable set_fs-based tests for !CONFIG_SET_FS
Date: Mon, 17 Aug 2020 09:32:07 +0200
Message-Id: <20200817073212.830069-7-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817073212.830069-1-hch@lst.de>
References: <20200817073212.830069-1-hch@lst.de>
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
Cc: linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Once we can't manipulate the address limit, we also can't test what
happens when the manipulation is abused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/misc/lkdtm/bugs.c     | 2 ++
 drivers/misc/lkdtm/core.c     | 4 ++++
 drivers/misc/lkdtm/usercopy.c | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 4dfbfd51bdf774..66f1800b1cb82d 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -312,6 +312,7 @@ void lkdtm_CORRUPT_LIST_DEL(void)
 		pr_err("list_del() corruption not detected!\n");
 }
 
+#ifdef CONFIG_SET_FS
 /* Test if unbalanced set_fs(KERNEL_DS)/set_fs(USER_DS) check exists. */
 void lkdtm_CORRUPT_USER_DS(void)
 {
@@ -321,6 +322,7 @@ void lkdtm_CORRUPT_USER_DS(void)
 	/* Make sure we do not keep running with a KERNEL_DS! */
 	force_sig(SIGKILL);
 }
+#endif
 
 /* Test that VMAP_STACK is actually allocating with a leading guard page */
 void lkdtm_STACK_GUARD_PAGE_LEADING(void)
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index a5e344df916632..aae08b33a7ee2a 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -112,7 +112,9 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(CORRUPT_STACK_STRONG),
 	CRASHTYPE(CORRUPT_LIST_ADD),
 	CRASHTYPE(CORRUPT_LIST_DEL),
+#ifdef CONFIG_SET_FS
 	CRASHTYPE(CORRUPT_USER_DS),
+#endif
 	CRASHTYPE(STACK_GUARD_PAGE_LEADING),
 	CRASHTYPE(STACK_GUARD_PAGE_TRAILING),
 	CRASHTYPE(UNSET_SMEP),
@@ -172,7 +174,9 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(USERCOPY_STACK_FRAME_FROM),
 	CRASHTYPE(USERCOPY_STACK_BEYOND),
 	CRASHTYPE(USERCOPY_KERNEL),
+#ifdef CONFIG_SET_FS
 	CRASHTYPE(USERCOPY_KERNEL_DS),
+#endif
 	CRASHTYPE(STACKLEAK_ERASING),
 	CRASHTYPE(CFI_FORWARD_PROTO),
 #ifdef CONFIG_X86_32
diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index b833367a45d053..4b632fe79ab6bb 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -325,6 +325,7 @@ void lkdtm_USERCOPY_KERNEL(void)
 	vm_munmap(user_addr, PAGE_SIZE);
 }
 
+#ifdef CONFIG_SET_FS
 void lkdtm_USERCOPY_KERNEL_DS(void)
 {
 	char __user *user_ptr =
@@ -339,6 +340,7 @@ void lkdtm_USERCOPY_KERNEL_DS(void)
 		pr_err("copy_to_user() to noncanonical address succeeded!?\n");
 	set_fs(old_fs);
 }
+#endif
 
 void __init lkdtm_usercopy_init(void)
 {
-- 
2.28.0

