Return-Path: <SRS0=l6JL=FV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6E3C4361B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Dec 2020 00:54:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38902235FD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Dec 2020 00:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38902235FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CxD6M1KVHzDqSd
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Dec 2020 11:54:35 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CxD4j5Q4mzDqNs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2020 11:53:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Tr+csHdn; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4CxD4j4wNmz9sSC; Thu, 17 Dec 2020 11:53:09 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CxD4j41STz9sTK; Thu, 17 Dec 2020 11:53:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1608166389;
 bh=AAuyZdbb8StTce5WPqR04EltV5yZoBk88U5H9yI0nsE=;
 h=From:To:Cc:Subject:Date:From;
 b=Tr+csHdnIB+f71kNMFtkFvPW/u25dFK8owc0tfx0GDPMgok88NmERQJ2qgxLxvG0b
 bYa7JYV3DL71QDdCs4bH6Y5n89Xa3X1lzVFLjsJOWPFe53YJHjy04oTqXiCABUeVug
 7eCkaLAsMxs8c0cNNLc2oy8A2RWlm9AnR2oOpm6mOleQ/sqVwTOV7Y1kovM2XPMqy4
 wN8sRswSIA1PEaI6wHmqZG2ZiE+UfxdwLV0PJM0Ftl766Rqd+DM6B+2VAqz2ayGezU
 mcO66WBdAfBMOV/qR2CGYhAkyhI5UbeFlUhn4CJz3Cw5GxEiij5RFBK+yTRtq+m/lZ
 wDjHYR+XmnqLg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/64s/kuap: Use mmu_has_feature()
Date: Thu, 17 Dec 2020 11:53:06 +1100
Message-Id: <20201217005306.895685-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In commit 8150a153c013 ("powerpc/64s: Use early_mmu_has_feature() in
set_kuap()") we switched the KUAP code to use early_mmu_has_feature(),
to avoid a bug where we called set_kuap() before feature patching had
been done, leading to recursion and crashes.

That path, which called probe_kernel_read() from printk(), has since
been removed, see commit 2ac5a3bf7042 ("vsprintf: Do not break early
boot with probing addresses").

Additionally probe_kernel_read() no longer invokes any KUAP routines,
since commit fe557319aa06 ("maccess: rename probe_kernel_{read,write}
to copy_{from,to}_kernel_nofault") and c33165253492 ("powerpc: use
non-set_fs based maccess routines").

So it should now be safe to use mmu_has_feature() in the KUAP
routines, because we shouldn't invoke them prior to feature patching.

This is essentially a revert of commit 8150a153c013 ("powerpc/64s: Use
early_mmu_has_feature() in set_kuap()"), but we've since added a
second usage of early_mmu_has_feature() in get_kuap(), so we convert
that to use mmu_has_feature() as well.

Depends-on: c33165253492 ("powerpc: use non-set_fs based maccess routines").
Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/kup.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/kup.h b/arch/powerpc/include/asm/book3s/64/kup.h
index f50f72e535aa..2298eac49763 100644
--- a/arch/powerpc/include/asm/book3s/64/kup.h
+++ b/arch/powerpc/include/asm/book3s/64/kup.h
@@ -333,7 +333,7 @@ static inline unsigned long get_kuap(void)
 	 * This has no effect in terms of actually blocking things on hash,
 	 * so it doesn't break anything.
 	 */
-	if (!early_mmu_has_feature(MMU_FTR_BOOK3S_KUAP))
+	if (!mmu_has_feature(MMU_FTR_BOOK3S_KUAP))
 		return AMR_KUAP_BLOCKED;
 
 	return mfspr(SPRN_AMR);
@@ -341,7 +341,7 @@ static inline unsigned long get_kuap(void)
 
 static inline void set_kuap(unsigned long value)
 {
-	if (!early_mmu_has_feature(MMU_FTR_BOOK3S_KUAP))
+	if (!mmu_has_feature(MMU_FTR_BOOK3S_KUAP))
 		return;
 
 	/*
-- 
2.25.1

