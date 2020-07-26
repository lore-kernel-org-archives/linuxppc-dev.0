Return-Path: <SRS0=4CH2=BF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5063AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2020 00:49:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3FAD2070C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2020 00:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lp/m3pgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FAD2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BDkps1l37zF13G
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2020 10:49:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=lp/m3pgb; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BDkZP0tTfzDrDN
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2020 10:38:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=2T/PUN88Psz81W4kabGMSiLLMlk2kni8wR69pWFEh14=; b=lp/m3pgbKggIHxgb/4vtKt2yHt
 MEz6zLVrdzcqPbuYA/zmfqqG45pME8e4/RfeLeCFZo6ZJZdRdCdE2Gnqp0LUNagVVTyGCL5yTiKNG
 PjMf4/AdxtiaD3mQAFocEREMIF3Ulldosr7AIEHmgmAPeyR+qegZPDoIzNKnospWBj7Wbs/gKDe9R
 DSKMqz8x5X+HP2iKxnGmH2JS3hh392p8n2mnnFM6o6AVfPc2+7rQ8lfqw5y28BjfO8mO0/N60dtqs
 KoCKZhdCRWG8h0tX/pSGa8FVfJ+aVh2UM5DTGe96y3E/DyRVDJBtv+GUycjC73tt5sp6nJTlhhOMd
 Mnr9RAkA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzUgC-0003Cq-Aw; Sun, 26 Jul 2020 00:38:16 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] powerpc: book3s: radix-4k.h: delete duplicated word
Date: Sat, 25 Jul 2020 17:38:02 -0700
Message-Id: <20200726003809.20454-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726003809.20454-1-rdunlap@infradead.org>
References: <20200726003809.20454-1-rdunlap@infradead.org>
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
Cc: Randy Dunlap <rdunlap@infradead.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Drop the repeated word "per".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/book3s/64/radix-4k.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/powerpc/include/asm/book3s/64/radix-4k.h
+++ linux-next-20200720/arch/powerpc/include/asm/book3s/64/radix-4k.h
@@ -11,7 +11,7 @@
 #define RADIX_PGD_INDEX_SIZE  13  // size: 8B << 13 = 64KB, maps 2^13 x 512GB =   4PB
 
 /*
- * One fragment per per page
+ * One fragment per page
  */
 #define RADIX_PTE_FRAG_SIZE_SHIFT  (RADIX_PTE_INDEX_SIZE + 3)
 #define RADIX_PTE_FRAG_NR	(PAGE_SIZE >> RADIX_PTE_FRAG_SIZE_SHIFT)
