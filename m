Return-Path: <SRS0=9qWD=TP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA89C04E53
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 May 2019 13:23:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08E620843
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 May 2019 13:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlgbVq8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08E620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 453wH23gPYzDqWK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 May 2019 23:23:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="JlgbVq8Q"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 453wDh1DnbzDqQl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2019 23:21:21 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id u17so1366155pfn.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2019 06:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9TwqGxcqAmiiOZF0fMbRhR1jD/62UPXQ1qlKx2sBgIw=;
 b=JlgbVq8Qjwpw9WAr3pAylhX1iQ/iYC2g7mT8uRosYuCwHSDM/yTMreG9tYBQVcVNyQ
 BC3/VjABCkHEHMUbtmJ1XRRTjFNlVYrx7pJY+4wKAQ2h1XQhtIWWQjes9+TUvLQY8GpZ
 0BHAGQH2GBe2dBQhPXIAuMQwphBBnD9R55zyuQcMkNaeHWS/m7jNtzmuAXPn0TPRyl1Z
 QtI3c2LEu81tkSQDEm6AJtJ/McHtOdQG8QyM9WvshOaHLKxHkdoyJ+r6XLKyi3M4W+eT
 6TcQq4blbNWTweaNiEeY0T+M83F934W5jcywJmVxHQcdxOlFCYLapC0SZlg61V7F44tT
 ZsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9TwqGxcqAmiiOZF0fMbRhR1jD/62UPXQ1qlKx2sBgIw=;
 b=Xl7g+igp18Vx0PY69WyPPie4RT5Wpohve3jW96RqlTadKaiNfRqUCe3UwDsxB61hRy
 xnDnx5OBgGlUIppX3EOcMOe/IGKfamThVDa5eAQ9bjHTtP+RuYgtmhu77waYSywVNfBk
 AdvrnTmxbXsxbDDx6fCgC1E6/+JTBvDsK5+pJWdP3mVezXcpmghyvH3MDVAMTBDH/Isx
 n5+2Fw0GnZJVKb6UBd7u3r8HHgCOd74nVQfVsUAuFfP18AMyq7ym7j09sdadXo61OPyZ
 W7YKAjSWFMbyCfOTyc9H09R3I6OSZj0T6UH79iqYPh89S2t0wdP/NUdtDty8DBF5Ez9/
 T2Fw==
X-Gm-Message-State: APjAAAXcV7zZK1GfThHBN0+ysze8xKbcjMX8q17qX6MKKHqleO1eu2yD
 L0Btje8oiNME794I3cMojXMc+rIC
X-Google-Smtp-Source: APXvYqxAXcfJTxXroa2Tygf/+OEh2WGaMRVJDDPwfEwlvrlt/aw5en3n2OvDBvWLLEnZ8lG6AVBaFg==
X-Received: by 2002:a63:8bc9:: with SMTP id
 j192mr43412507pge.212.1557926476914; 
 Wed, 15 May 2019 06:21:16 -0700 (PDT)
Received: from bobo.local0.net (115-64-240-98.tpgi.com.au. [115.64.240.98])
 by smtp.gmail.com with ESMTPSA id a19sm2784459pgm.46.2019.05.15.06.21.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 May 2019 06:21:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/5] mm: large system hash use vmalloc for size >
 MAX_ORDER when !hashdist
Date: Wed, 15 May 2019 23:19:40 +1000
Message-Id: <20190515131944.12489-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The kernel currently clamps large system hashes to MAX_ORDER when
hashdist is not set, which is rather arbitrary.

vmalloc space is limited on 32-bit machines, but this shouldn't
result in much more used because of small physical memory.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/page_alloc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 59661106da16..1683d54d6405 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7978,7 +7978,7 @@ void *__init alloc_large_system_hash(const char *tablename,
 			else
 				table = memblock_alloc_raw(size,
 							   SMP_CACHE_BYTES);
-		} else if (hashdist) {
+		} else if (get_order(size) >= MAX_ORDER || hashdist) {
 			table = __vmalloc(size, gfp_flags, PAGE_KERNEL);
 		} else {
 			/*
@@ -7986,10 +7986,8 @@ void *__init alloc_large_system_hash(const char *tablename,
 			 * some pages at the end of hash table which
 			 * alloc_pages_exact() automatically does
 			 */
-			if (get_order(size) < MAX_ORDER) {
-				table = alloc_pages_exact(size, gfp_flags);
-				kmemleak_alloc(table, size, 1, gfp_flags);
-			}
+			table = alloc_pages_exact(size, gfp_flags);
+			kmemleak_alloc(table, size, 1, gfp_flags);
 		}
 	} while (!table && size > PAGE_SIZE && --log2qty);
 
-- 
2.20.1

