Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA65C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 00:08:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB95E2175B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 00:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="p7euoJqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB95E2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440trX6QYLzDqW8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 11:08:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="p7euoJqP"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440tmp0mQ8zDqTj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 11:04:58 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id n22so3931743pfa.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 16:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=69XOFaUt1Sn73qwRTNzOBLCHHueomRAslHtiV5tNof4=;
 b=p7euoJqPQFQkISmJHLegGwf3FVJobCyfd3R88dyHZAAn706p+Qd9QDwRjtUxQ24A+1
 TkMu2vTWdbWmyi7MOu7RNDduyYBxhSHZymYAWBeo6A6cAoEZ+eTTgq8tWVHLi9vKvdRK
 8Ii/QtMJO83g6IsLSh7YSwyW6ZuXHSiErJzFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=69XOFaUt1Sn73qwRTNzOBLCHHueomRAslHtiV5tNof4=;
 b=a619MpkSRaYCF7E4aKTSNJJdvaiXEmjoIll2CDYX6IASLhu1qDOi0E18YQdlreTvfD
 bOyB9+57M9RNRTVrNIGu8Oh9gmyeEUiKbVFZeh9ltlrP13TzvPcyiTYpP3kgk/olzSqT
 H8hfXw2e5u+YTVewg51QF9lIUd5Zo5LxWxxfqM9r4bclvFMQ5wdppO9ak/PFNprFJkd5
 U3S1VqGwYwkMnC9XL+25Gegf7VUfMYE975PdGJbe6GlpHZbfwqk7ECHrDoJa7PxQ/DU8
 t4yCdOzKX6lwrKNfSBU3yN75ZSq1zZy+audlPghHgTC+oYZFvgpuXCoMluzvpgMy9Tqo
 pRoA==
X-Gm-Message-State: AHQUAubEl8f0RySa8qz47EClgeqUNtP1Z/nbBTle/lOfrMOlBfPDrGK9
 8tps4Vt8G4viTnt/JoHIzh5c0aooxa4=
X-Google-Smtp-Source: AHgI3IanI2WiJzv/j2O1y0gD2M6CMVbp5eSMjzsZPO2QASpXjYNn5GDm8rGRD9b72J02f53id7D8+Q==
X-Received: by 2002:a63:2c8a:: with SMTP id s132mr2549442pgs.440.1550189096253; 
 Thu, 14 Feb 2019 16:04:56 -0800 (PST)
Received: from localhost (124-171-165-212.dyn.iinet.net.au. [124.171.165.212])
 by smtp.gmail.com with ESMTPSA id
 j5sm4386120pfe.84.2019.02.14.16.04.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 16:04:55 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: aneesh.kumar@linux.ibm.com, christophe.leroy@c-s.fr, bsingharora@gmail.com
Subject: [RFC PATCH 1/5] kasan: do not open-code addr_has_shadow
Date: Fri, 15 Feb 2019 11:04:37 +1100
Message-Id: <20190215000441.14323-2-dja@axtens.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215000441.14323-1-dja@axtens.net>
References: <20190215000441.14323-1-dja@axtens.net>
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

