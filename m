Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93856C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 01:27:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4BD2084F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 01:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="aw6Uc871"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4BD2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JHQR5XjPzDqDt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 12:27:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="aw6Uc871"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44JHLj2WQQzDqDt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 12:24:13 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id d25so554257pfn.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 18:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+RQIVfnUMsKEz60S7izUiCwaFGusTa+V/kfxFsADwUE=;
 b=aw6Uc871wMZh/pevMgNq9qA6RGN4jDwgdMlP8oyL+PZ+mEggtE5kwGa/zQXQKzydbd
 oXl2N9DblA9IUFc7KbaN1/vjlRJ19pbDL+5vophgomrRImM9YAKT8wk0hJdATSTMszkN
 1Upw0sUWfDeAtzkF9aW+0qTR2ManGQKmBi/rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+RQIVfnUMsKEz60S7izUiCwaFGusTa+V/kfxFsADwUE=;
 b=I6mfyXSkB+vp8d6hIS1X+gYFau1ybpmtZTSuR3tmCmO9x9KqwiBGeH6I3Qr5RD6OOV
 oK5t4+LR+b8zS/oHEGKmvlf0uQEMz43LRA+kqk8NAmj80zDFwMvkm1iWeDsMsjZ9+vI7
 onDUZ6CZmwhNYcCSCuJ3j3nTl5PY5+cC8oB+VmDRrMHLIOILRB++3IE1+6sRHjw0CrsS
 //E5V2dM3EgG0yecHmCsYH+vFFKkIyrfc6i/OPHDgjkUbBOrZF9T44Z4rtVyvhx0MEUA
 rVDOKIOYilwOup0nSUfDkAs3CAR6UgzHSYpdmU7ngBNAjOQPVrTjLm+JHMJ3qr0HmpoU
 OsTw==
X-Gm-Message-State: APjAAAV5UQewBzrE3XPe26/MBJA4j6cZbkvcdntG1O1ho4jZNji/60DK
 qC48AwZyHxNjSrxjb2r6HFtoQw==
X-Google-Smtp-Source: APXvYqz9fuwh7aBBquAZXRx30k5oSCEc8hBicnJbqhPFjnvI2TihMVMlcNqARniR+2KTczC6+Ph7DA==
X-Received: by 2002:a63:3d0e:: with SMTP id k14mr15095930pga.302.1552353849991; 
 Mon, 11 Mar 2019 18:24:09 -0700 (PDT)
Received: from localhost (124-171-102-1.dyn.iinet.net.au. [124.171.102.1])
 by smtp.gmail.com with ESMTPSA id r82sm11893229pfa.161.2019.03.11.18.24.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Mar 2019 18:24:09 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: aneesh.kumar@linux.ibm.com, christophe.leroy@c-s.fr, bsingharora@gmail.com
Subject: [RFCv2 PATCH 1/4] kasan: do not open-code addr_has_shadow
Date: Tue, 12 Mar 2019 12:23:45 +1100
Message-Id: <20190312012348.4854-2-dja@axtens.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190312012348.4854-1-dja@axtens.net>
References: <20190312012348.4854-1-dja@axtens.net>
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
Cc: linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We have a couple of places checking for the existence of a shadow
mapping for an address by open-coding the inverse of the check in
addr_has_shadow.

Replace the open-coded versions with the helper. This will be
needed in future to allow architectures to override the layout
of the shadow mapping.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 mm/kasan/generic.c | 3 +--
 mm/kasan/tags.c    | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index ccb6207276e3..ffc64a9a97a5 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -173,8 +173,7 @@ static __always_inline void check_memory_region_inline(unsigned long addr,
 	if (unlikely(size == 0))
 		return;
 
-	if (unlikely((void *)addr <
-		kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
+	if (unlikely(!addr_has_shadow((void *)addr))) {
 		kasan_report(addr, size, write, ret_ip);
 		return;
 	}
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 0777649e07c4..bc759f8f1c67 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -109,8 +109,7 @@ void check_memory_region(unsigned long addr, size_t size, bool write,
 		return;
 
 	untagged_addr = reset_tag((const void *)addr);
-	if (unlikely(untagged_addr <
-			kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
+	if (unlikely(!addr_has_shadow(untagged_addr))) {
 		kasan_report(addr, size, write, ret_ip);
 		return;
 	}
-- 
2.19.1

