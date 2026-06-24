Return-Path: <linuxppc-dev+bounces-22957-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510E2CDB470
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2026 08:21:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glZdr4Y5qz2yYq;
	Wed, 24 Jun 2026 18:21:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782289280;
	cv=none; b=c2TPvUIpmOAmxYd5WrElG9Km3qqkv9IWwW//l1jhM/ciCS+ol6tEVwDwHB1Y84c7tIeaY4jN8me8XliaQS8g6WuWckon9xsBw+TmztF/iBvGOf7EXfbNFIo3/ZhRWLIRumc043UDuTjCux9L1Btd2hEAGoWcaTcE9J8JdWAbXxnb8sDYvmaAKyAwHmHNeH+CuaTGxwmp0uFvVhu+dQVZSb6kzEX1suOZhYImCKfFVixs3qdrbX5N98tCeUE3iSK7xe8HpoVblTUW1LFWw9ZmhAXo2rzHc4ZLxQEAd8QE91qnCsB+Cuw4EmHP1AstpagU5PQ0M6Y4Zsev7s82fkbyvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782289280; c=relaxed/relaxed;
	bh=wYU5y3iKWVXlfoAIUliIxIimI5JY/5sSaGoKEeHbSXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I//4+uBIWai4uifrIhv2QXrNM9UWNoRLNF1ZwFgeBXdM6YqXCdt40cS8HTDtt5rIWO17Fqb20gfhl1qs2YDP1HyLUqnUsNHVGNqrVCnr9WjCrV8S/nrCTqYTU22dJ80WiyxjV6RVJgH9WdlMIWAnGVCAjY+vVmuVua0FUw/VDKnlijRadSu+NZuCG7+NrUyH88NtBjuK3MbLH5Btvl4+w5dZYlX+FQeQtkKA4KoYNY+/DvdbtosWahb01c0dTv+EMrVe+XZx3/JENly2IVAfrb1cbn5bkzWd6GJDSNbh0FruVLytsOWY8UJW/Po4yGobVlCk3UsrDKxQneVU/Sbsng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 347 seconds by postgrey-1.37 at boromir; Wed, 24 Jun 2026 18:21:19 AEST
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glZdq2HHrz2yRF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 18:21:18 +1000 (AEST)
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowAAnBp0ckjtqMACwFQ--.11655S2;
	Wed, 24 Jun 2026 16:15:24 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/uaccess: Check CONFIG_PPC_E500
Date: Wed, 24 Jun 2026 16:15:23 +0800
Message-ID: <20260624081523.88025-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnBp0ckjtqMACwFQ--.11655S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFW3Zr18WF4DAry8Cw1DAwb_yoWDtFc_Ca
	n2qw4vgw4kursFkFnrXa4FkF1xt3y7Gr1DJw1Iqw17ZasxJry7Jrn7J34rZr4UW3yjkr4D
	uFWxWr9xC3sayjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUeL05UU
	UUU
X-Originating-IP: [111.196.245.140]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The powerpc CPU Kconfig defines `PPC_E500`.  There is no generated
`CONFIG_E500` symbol for `IS_ENABLED()` to test here.

`mask_user_address()` therefore checks an impossible symbol before
choosing the E500-specific masking helper.  Use `CONFIG_PPC_E500`, which
matches the actual Kconfig provider for this CPU family.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/powerpc/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -537,7 +537,7 @@ static __always_inline unsigned long mask_user_address(const void __user *ptr)
 
 	if (IS_ENABLED(CONFIG_PPC64))
 		return mask_user_address_simple(ptr);
-	if (IS_ENABLED(CONFIG_E500))
+	if (IS_ENABLED(CONFIG_PPC_E500))
 		return mask_user_address_isel(ptr);
 	if (TASK_SIZE <= UL(SZ_2G) && border >= UL(SZ_2G))
 		return mask_user_address_simple(ptr);


