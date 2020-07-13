Return-Path: <SRS0=XY74=AY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC93C433E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2020 08:37:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE38A2065D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2020 08:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="Vjl9nIyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE38A2065D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B4xqK5PS5zDqVK
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2020 18:37:49 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B4xnM3R84zDqRb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2020 18:36:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=Vjl9nIyR; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1010)
 id 4B4xnM14zpz9sR4; Mon, 13 Jul 2020 18:36:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1594629367; bh=ElIrqaH6qRmr9CgaLy5QVe/6myDnceibJ6gcA90M+kI=;
 h=From:To:Cc:Subject:Date:From;
 b=Vjl9nIyRBYd9uloEbWshuNtUQBzpo8IPIC/xBlCLnrCMtK0XeWWXXAoUNhDTTr54P
 h0wRbyzKd2MCCS99fitWL3B2LAieBIL3TwwR95TrhqFu2oDefugcp4mpjCfGonmXTs
 V4P+WswT+D4gPjFFzLRUTzUeGZvdXU2eSs6ciZsxn8LfsVt3qu+lbNEwEO3l/SeClO
 PKirjt9FQ15kQdVkaLvNgU6Em5AhLVDZ/1ZGtNEvDhKo4gOrz/mBvoI+sCuuv/Z6Jo
 e/K1Rln/YTYvYwroMh6S+U7aqdCXhWWW7JKiaErsO1mMjuVrZSGnmgoPFsqu9uZ/sE
 jXkghn9etCtpA==
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com
Subject: [PATCH] powerpc: Add cputime_to_nsecs()
Date: Mon, 13 Jul 2020 18:36:01 +1000
Message-Id: <20200713083601.1103978-1-anton@ozlabs.org>
X-Mailer: git-send-email 2.26.2
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Generic code has a wrapper to implement cputime_to_nsecs() on top of
cputime_to_usecs() but we can easily return the full nanosecond
resolution directly.

Signed-off-by: Anton Blanchard <anton@ozlabs.org>
---
 arch/powerpc/include/asm/cputime.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index 0fccd5ea1e9a..9335b93924b4 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -36,6 +36,8 @@ static inline unsigned long cputime_to_usecs(const cputime_t ct)
 	return mulhdu((__force u64) ct, __cputime_usec_factor);
 }
 
+#define cputime_to_nsecs(cputime) tb_to_ns((__force u64)cputime)
+
 /*
  * PPC64 uses PACA which is task independent for storing accounting data while
  * PPC32 uses struct thread_info, therefore at task switch the accounting data
-- 
2.26.2

