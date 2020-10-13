Return-Path: <SRS0=68fk=DU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2E6C433E7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2020 05:18:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B56CE20872
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2020 05:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="BEhshRqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56CE20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C9P2k2VP4zDqk5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2020 16:18:22 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C9NwS6N5fzDqg4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2020 16:12:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.a=rsa-sha256
 header.s=201811 header.b=BEhshRqj; dkim-atps=neutral
Received: from neuling.org (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 4C9NwR6BqZz9sS8;
 Tue, 13 Oct 2020 16:12:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1602565976;
 bh=Upm3YHeWjavWhY2f/aGvlXp+ccdKU/8n71IQMcqWZzw=;
 h=From:To:Cc:Subject:Date:From;
 b=BEhshRqjqe4ENXx0xkSW0OkGaA8Rox6pao9eTao+ojG5YGfgD3tfcczl3vUSQoEYR
 UfQJvccbbPK3X4rJVkd4TYxHTB8XmxmtJFEKh4mIdhTriB6AatIrsgw+1F+jJK9tmH
 JBQ3Ws/wR6gLqpV/WxNovg5984tsTrlt/Emxw+lJVcNjk37yqr+ZX6ka1QXyTgRvay
 32evNkWQtNUsLhc7yGCPHYUuV1b5GQGbuZQ99rwxugWaTYuNFk3U86G6kxN4I0Rh0w
 H/cfxRzjDG78RgseSkFGSlmPBkPT9+nyAGLMqD5Lo91jWcJ/dD39AzklxU2B63Lk8k
 fDFuBPVUZ0QDg==
Received: by neuling.org (Postfix, from userid 1000)
 id 2A5EB2C06AD; Tue, 13 Oct 2020 15:37:43 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Subject: [PATCH 1/2] powerpc: Fix user data corruption with P9N DD2.1 VSX CI
 load workaround emulation
Date: Tue, 13 Oct 2020 15:37:40 +1100
Message-Id: <20201013043741.743413-1-mikey@neuling.org>
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

__get_user_atomic_128_aligned() stores to kaddr using stvx which is a
VMX store instruction, hence kaddr must be 16 byte aligned otherwise
the store won't occur as expected.

Unfortunately when we call __get_user_atomic_128_aligned() in
p9_hmi_special_emu(), the buffer we pass as kaddr (ie. vbuf) isn't
guaranteed to be 16B aligned. This means that the write to vbuf in
__get_user_atomic_128_aligned() has the bottom bits of the address
truncated. This results in other local variables being
overwritten. Also vbuf will not contain the correct data which results
in the userspace emulation being wrong and hence user data corruption.

In the past we've been mostly lucky as vbuf has ended up aligned but
this is fragile and isn't always true. CONFIG_STACKPROTECTOR in
particular can change the stack arrangement enough that our luck runs
out.

This issue only occurs on POWER9 Nimbus <= DD2.1 bare metal.

The fix is to align vbuf to a 16 byte boundary.

Fixes: 5080332c2c89 ("powerpc/64s: Add workaround for P9 vector CI load issue")
Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: <stable@vger.kernel.org> # v4.15+
---
 arch/powerpc/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index c5f39f13e96e..5006dcbe1d9f 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -885,7 +885,7 @@ static void p9_hmi_special_emu(struct pt_regs *regs)
 {
 	unsigned int ra, rb, t, i, sel, instr, rc;
 	const void __user *addr;
-	u8 vbuf[16], *vdst;
+	u8 vbuf[16] __aligned(16), *vdst;
 	unsigned long ea, msr, msr_mask;
 	bool swap;
 
-- 
2.26.2

