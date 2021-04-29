Return-Path: <SRS0=zlGz=J2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17107C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 07:31:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7B5613D9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 07:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7B5613D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bluescreens.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FW6cy5v59z30CS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 17:31:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bluescreens.de (client-ip=91.198.250.237;
 helo=mout-y-209.mailbox.org; envelope-from=cmr@bluescreens.de;
 receiver=<UNKNOWN>)
X-Greylist: delayed 570 seconds by postgrey-1.36 at boromir;
 Thu, 29 Apr 2021 17:31:10 AEST
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FW6cZ2CmGz2xdQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Apr 2021 17:31:09 +1000 (AEST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4FW6Pd0dgKzQjnd;
 Thu, 29 Apr 2021 09:21:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
 by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de
 [80.241.56.115]) (amavisd-new, port 10030)
 with ESMTP id KhKuAb7f_UxY; Thu, 29 Apr 2021 09:21:38 +0200 (CEST)
From: "Christopher M. Riedl" <cmr@bluescreens.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 09/11] lkdtm/powerpc: Fix code patching hijack test
Date: Thu, 29 Apr 2021 02:20:55 -0500
Message-Id: <20210429072057.8870-10-cmr@bluescreens.de>
In-Reply-To: <20210429072057.8870-1-cmr@bluescreens.de>
References: <20210429072057.8870-1-cmr@bluescreens.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: *
X-Rspamd-Score: 0.57 / 15.00 / 15.00
X-Rspamd-Queue-Id: 3642C17EF
X-Rspamd-UID: d1088b
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
Cc: tglx@linutronix.de, x86@kernel.org, linux-hardening@vger.kernel.org,
 keescook@chromium.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Code patching on powerpc with a STRICT_KERNEL_RWX uses a userspace
address in a temporary mm now. Use __put_user() to avoid write failures
due to KUAP when attempting a "hijack" on the patching address.

Signed-off-by: Christopher M. Riedl <cmr@bluescreens.de>
---
 drivers/misc/lkdtm/perms.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 55c3bec6d3b72..af9bf285fe326 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -268,16 +268,7 @@ static inline u32 lkdtm_read_patch_site(void)
 /* Returns True if the write succeeds */
 static inline bool lkdtm_try_write(u32 data, u32 *addr)
 {
-#ifdef CONFIG_PPC
-	__put_kernel_nofault(addr, &data, u32, err);
-	return true;
-
-err:
-	return false;
-#endif
-#ifdef CONFIG_X86_64
 	return !__put_user(data, addr);
-#endif
 }
 
 static int lkdtm_patching_cpu(void *data)
-- 
2.26.1

