Return-Path: <SRS0=kIvJ=ER=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F61C56201
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2020 12:08:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB6A206C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2020 12:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMts/cP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB6A206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CWNm637mPzDqpG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2020 23:08:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::543;
 helo=mail-pg1-x543.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=lMts/cP1; dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CWNd766jLzDqRk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2020 23:02:02 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id f38so1331221pgm.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2020 04:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rbdCVAOolt9MnqBJD2ZRjlsOz1LExceZmimIg4W31YY=;
 b=lMts/cP1VmQxK4+cCu32JRtsp7bA9hBZlMjk8p4nKbtsSttCBq8PUs4Ezvbcyuh7SL
 af3wiKRoc+JmsMe8VaeAHSRLxOgxssU09scTP5fgXGxuTfUgT93wCxJacz4sXo8MaWjA
 Uj27k9k/AXXX90PtI0+r/YTtsg8mF5APlJz3QLGO7bDXOvnFyO8G81MTfN2eo2dF3EEL
 O84XaqHRGvdGcFr0mnzrwd6bZsTfT2rDRj/AmV0XltaXzYlf07Ka4NqkOKUlSc4hlBD0
 M8vvddAp1BleshGY+1zcmTfogiKJG/eoExH9VCSPQr/ya67ZbZQpblrvqxNJluYY36ZX
 /7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rbdCVAOolt9MnqBJD2ZRjlsOz1LExceZmimIg4W31YY=;
 b=kab1vJWGU+78gP4QIzwW4uWXtoizgBcdc56gUpE6SBkG+kBrYi4D+GrVcPfQCP/3ii
 K3kKwhQrE3Mc+0TxbQVdaK8lRry4oiY1e/gvb5JUQ1e5g0VkFU+fjaKnHvtsSbeTVqLa
 MKf6gtkxY6gbESBEcmwKftvuMUjALgHbzgdqIABN3ToRm1w2QH77uXXWJAAObx1o23FE
 K2ohxyY0fJFcKUBbtl/E48di7fVGPZ8lt1ORPDYoO5v8vUaLMXMuIIKoN4eLp3i5cHRA
 l80UP7Z7lMsHTindnsbQ6wkKdBI4YCDLEDzZPbgxyg6/eyoTYRabjkPi6azk4u9MbZdT
 iuiQ==
X-Gm-Message-State: AOAM531OS9yKYhdYlI4/Wm0gtUv+/cwULpIYW6zDGwPCzKzdAmJ8Kn/v
 OaDkJtYBsl03T/+a2OP0rIcUVDFyG7o=
X-Google-Smtp-Source: ABdhPJziK+Cqqe/vii4wKW+XBhJsQqLNYT0sAC4rGNYFh2DQO/nxIPhtJdtzseU6hX2nQKEKNJXCQA==
X-Received: by 2002:a65:4bc8:: with SMTP id p8mr22235285pgr.335.1605096117974; 
 Wed, 11 Nov 2020 04:01:57 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (27-32-36-31.tpgi.com.au. [27.32.36.31])
 by smtp.gmail.com with ESMTPSA id s11sm2261447pjm.4.2020.11.11.04.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 04:01:57 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64s/perf: perf interrupt does not have to
 get_user_pages to access user memory
Date: Wed, 11 Nov 2020 22:01:51 +1000
Message-Id: <20201111120151.3150658-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

read_user_stack_slow that walks user address translation by hand is
only required on hash, because a hash fault can not be serviced from
"NMI" context (to avoid re-entering the hash code) so the user stack
can be mapped into Linux page tables but not accessible by the CPU.

Radix MMU mode does not have this restriction. A page fault failure
would indicate the page is not accessible via get_user_pages either,
so avoid this on radix.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/perf/callchain.h    | 2 +-
 arch/powerpc/perf/callchain_64.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/callchain.h b/arch/powerpc/perf/callchain.h
index ae24d4a00da6..d6fa6e25234f 100644
--- a/arch/powerpc/perf/callchain.h
+++ b/arch/powerpc/perf/callchain.h
@@ -33,7 +33,7 @@ static inline int __read_user_stack(const void __user *ptr, void *ret,
 
 	rc = copy_from_user_nofault(ret, ptr, size);
 
-	if (IS_ENABLED(CONFIG_PPC64) && rc)
+	if (IS_ENABLED(CONFIG_PPC64) && !radix_enabled() && rc)
 		return read_user_stack_slow(ptr, ret, size);
 
 	return rc;
diff --git a/arch/powerpc/perf/callchain_64.c b/arch/powerpc/perf/callchain_64.c
index fed90e827f3a..0777b04a0c56 100644
--- a/arch/powerpc/perf/callchain_64.c
+++ b/arch/powerpc/perf/callchain_64.c
@@ -21,7 +21,8 @@
 /*
  * On 64-bit we don't want to invoke hash_page on user addresses from
  * interrupt context, so if the access faults, we read the page tables
- * to find which page (if any) is mapped and access it directly.
+ * to find which page (if any) is mapped and access it directly. Radix
+ * has no need for this so it doesn't use read_user_stack_slow.
  */
 int read_user_stack_slow(const void __user *ptr, void *buf, int nb)
 {
-- 
2.23.0

