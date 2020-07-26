Return-Path: <SRS0=4CH2=BF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5599C433E1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2020 00:47:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FED2070C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2020 00:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tvOhN3pV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FED2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BDkmr5Qx7zF1QJ
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2020 10:47:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=tvOhN3pV; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BDkZM0CMlzDrcW
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2020 10:38:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=nykLTZWn1gv7h+c5D13sk5wem/+F6Ly2kQ0s//8/eTg=; b=tvOhN3pVaeDKpCyp1ryqTpovlw
 ItSknlLqkepENbopJuQg4D0oerCDfyaSIHWAMeoIhwKaTv27OAnk5GNBJib9dyzbWSGuCaRDAj7oB
 S9LZBLskKoWbAQO3OELg+TkkdYbP4qfTzOu9qQHJmbiLJRBqp/qZuIXUe9U9s3XEVDjU1IOkLLC8R
 anM/egy4Wt1kC3EiEDSTPzJcJPVux97LZHnutNde+0/JUabE4Yx3OFovWPtZuC3FxKzoj1A50YSiv
 kt0Svl856cKHLpjE9BtxL+PGTjLlbjHVdb/SQPXmtpEi38poNtQ4BIROep5wrwc1l1LYi7plQjNxV
 RYVucK/A==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzUgA-0003Cq-7E; Sun, 26 Jul 2020 00:38:14 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] powerpc: book3s: mmu-hash.h: delete duplicated word
Date: Sat, 25 Jul 2020 17:38:01 -0700
Message-Id: <20200726003809.20454-2-rdunlap@infradead.org>
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

Drop the repeated word "below".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ linux-next-20200720/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -793,7 +793,7 @@ static inline unsigned long get_vsid(uns
 }
 
 /*
- * For kernel space, we use context ids as below
+ * For kernel space, we use context ids as
  * below. Range is 512TB per context.
  *
  * 0x00001 -  [ 0xc000000000000000 - 0xc001ffffffffffff]
