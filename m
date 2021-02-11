Return-Path: <SRS0=2rmQ=HN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799ABC433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 13:56:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2538E64DEE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 13:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2538E64DEE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dbypd0TltzDqFD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 00:56:25 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dbyjc2RwRzDwjd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2021 00:52:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Yu5Cvbr8; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Dbyjb4CdMz9sVS; Fri, 12 Feb 2021 00:52:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1613051523;
 bh=Azb/DSqiPmFTd+JAPfJG9TRsjdyBse5SSQffE8T0VcE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Yu5Cvbr8qdZBEUCrIjzG2S/DBdJ7rLHYnBigLTDIySs6KL05E/R5tETQVAb2Ieat3
 XLlbGRC1nJCC5W/+4SA5YaKb4rBBB8CoR791ickIq4g3Hg5opE0Lql+USbqr/pio1/
 LhJrBYOJLfX9ToX+Eb2vNj1MIWixyg6rjd6aa5XElB0PlU0xI/+yr3v2MsZyA7sVbq
 IwbLK4xVj5mLHsp6BZmyjAFjaHh1vY3rHX/6wQwJ7uIIdDGz4HegUWnxzNYP8Wh/3Z
 qM8Y1AKcKOoDsboXtRanGZweHz4qOxhd8J1+A8U4hjCnn3R4aAl0HjC7exbEVZ3nBs
 wYiB3Od9KscvA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/6] powerpc/64s: Use htab_convert_pte_flags() in
 hash__mark_rodata_ro()
Date: Fri, 12 Feb 2021 00:51:27 +1100
Message-Id: <20210211135130.3474832-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211135130.3474832-1-mpe@ellerman.id.au>
References: <20210211135130.3474832-1-mpe@ellerman.id.au>
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
Cc: aneesh.kumar@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In hash__mark_rodata_ro() we pass the raw PP_RXXX value to
hash__change_memory_range(). That has the effect of setting the key to
zero, because PP_RXXX contains no key value.

Fix it by using htab_convert_pte_flags(), which knows how to convert a
pgprot into a pp value, including the key.

Fixes: d94b827e89dc ("powerpc/book3s64/kuap: Use Key 3 for kernel mapping with hash translation")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/book3s64/hash_pgtable.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_pgtable.c b/arch/powerpc/mm/book3s64/hash_pgtable.c
index 567e0c6b3978..03819c259f0a 100644
--- a/arch/powerpc/mm/book3s64/hash_pgtable.c
+++ b/arch/powerpc/mm/book3s64/hash_pgtable.c
@@ -428,12 +428,14 @@ static bool hash__change_memory_range(unsigned long start, unsigned long end,
 
 void hash__mark_rodata_ro(void)
 {
-	unsigned long start, end;
+	unsigned long start, end, pp;
 
 	start = (unsigned long)_stext;
 	end = (unsigned long)__init_begin;
 
-	WARN_ON(!hash__change_memory_range(start, end, PP_RXXX));
+	pp = htab_convert_pte_flags(pgprot_val(PAGE_KERNEL_ROX), HPTE_USE_KERNEL_KEY);
+
+	WARN_ON(!hash__change_memory_range(start, end, pp));
 }
 
 void hash__mark_initmem_nx(void)
-- 
2.25.1

