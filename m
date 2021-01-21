Return-Path: <SRS0=iciS=GY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D17C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Jan 2021 08:14:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A632395B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Jan 2021 08:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A632395B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DLwCg5JwzzDr6P
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Jan 2021 19:14:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+5b2bf2cc950c4867fd89+6360+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=VJgiX3rO; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DLvpt2t7gzDqnT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2021 18:56:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=vzLkuMf82/aWxii/Oync9Hqdb/cDk0SHw40dy3Repg0=; b=VJgiX3rOi2+FvYX5K5bZdmJKbV
 KmbjKxv/yhVynbQ7YxZjphpBXnAb9lcS8Rm2DWl0XO5d7lbUNmsSJ4iiecBH1ptIEV1DzaF/tDYcX
 40Fc3Q93GDV/NSPdipbTiWzTuYSjJ3S/ljICeomlVqQNnENFw4OSbarDQcAaUnUOZvoeKuvR3Ocqi
 g1RH5DmKsuETnSyhbKuOPUkYKh0aTiYF4rSpIymKGKNuJcvkQo0JEt1kMD9RHcHM1bUNJso5wzyQT
 oTCpvteHfm8HTp1ikJRrPxgT/MA3ey7JlWDMT+gUyKMJG7F0kp2M7rT18zJPkmynaYm5STnNt7R6V
 V/mRJgbw==;
Received: from [2001:4bb8:188:1954:d5b3:2657:287:e45f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l2UoB-00GmEr-Go; Thu, 21 Jan 2021 07:55:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Frederic Barrat <fbarrat@linux.ibm.com>,
 Andrew Donnellan <ajd@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Jessica Yu <jeyu@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
 Joe Lawrence <joe.lawrence@redhat.com>
Subject: [PATCH 09/13] module: remove each_symbol_in_section
Date: Thu, 21 Jan 2021 08:49:55 +0100
Message-Id: <20210121074959.313333-10-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121074959.313333-1-hch@lst.de>
References: <20210121074959.313333-1-hch@lst.de>
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
Cc: Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, live-patching@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

each_symbol_in_section just contains a trivial loop over its arguments.
Just open code the loop in the two callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/module.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index d163c78ca8ed69..a9d092765c4eab 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -433,30 +433,13 @@ extern const s32 __start___kcrctab_unused_gpl[];
 #define symversion(base, idx) ((base != NULL) ? ((base) + (idx)) : NULL)
 #endif
 
-static bool each_symbol_in_section(const struct symsearch *arr,
-				   unsigned int arrsize,
-				   struct module *owner,
-				   bool (*fn)(const struct symsearch *syms,
-					      struct module *owner,
-					      void *data),
-				   void *data)
-{
-	unsigned int j;
-
-	for (j = 0; j < arrsize; j++) {
-		if (fn(&arr[j], owner, data))
-			return true;
-	}
-
-	return false;
-}
-
 /* Returns true as soon as fn returns true, otherwise false. */
 static bool each_symbol_section(bool (*fn)(const struct symsearch *arr,
 				    struct module *owner,
 				    void *data),
 			 void *data)
 {
+	unsigned int i;
 	struct module *mod;
 	static const struct symsearch arr[] = {
 		{ __start___ksymtab, __stop___ksymtab, __start___kcrctab,
@@ -479,8 +462,9 @@ static bool each_symbol_section(bool (*fn)(const struct symsearch *arr,
 
 	module_assert_mutex_or_preempt();
 
-	if (each_symbol_in_section(arr, ARRAY_SIZE(arr), NULL, fn, data))
-		return true;
+	for (i = 0; i < ARRAY_SIZE(arr); i++)
+		if (fn(&arr[i], NULL, data))
+			return true;
 
 	list_for_each_entry_rcu(mod, &modules, list,
 				lockdep_is_held(&module_mutex)) {
@@ -509,8 +493,9 @@ static bool each_symbol_section(bool (*fn)(const struct symsearch *arr,
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
 
-		if (each_symbol_in_section(arr, ARRAY_SIZE(arr), mod, fn, data))
-			return true;
+		for (i = 0; i < ARRAY_SIZE(arr); i++)
+			if (fn(&arr[i], mod, data))
+				return true;
 	}
 	return false;
 }
-- 
2.29.2

