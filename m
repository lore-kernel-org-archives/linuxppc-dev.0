Return-Path: <SRS0=k+Co=77=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70C1C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 02:32:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8D220720
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 02:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wgMO+u0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8D220720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49nQtz01rrzDr32
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 12:32:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=wgMO+u0m; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49nP9X3VPGzDqxG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2020 11:14:40 +1000 (AEST)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6398D21D90;
 Thu, 18 Jun 2020 01:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592442878;
 bh=ySCvOEhxd8UpgYwhmu3TXkszZl1O6dsa4nyS8gl6vYI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=wgMO+u0mF4GiTgN6yjXZcDsqTSGQO8CbDzOtGyJ/aFu3LZaabM78p8dFy4nQD0JbG
 10XaQhkivkUzyR9QnZqBz3eifMtH6IiL7FAm8EmBlgUxIADxXjJ9Z48fEpxAnwvGCM
 0cU3S5ImDi7YGaVm+LBXHlD7hegdLTZs6hXQlDUQ=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 303/388] powerpc/64s/kuap: Add missing isync to
 KUAP restore paths
Date: Wed, 17 Jun 2020 21:06:40 -0400
Message-Id: <20200618010805.600873-303-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit cb2b53cbffe3c388cd676b63f34e54ceb2643ae2 ]

Writing the AMR register is documented to require context
synchronizing operations before and after, for it to take effect as
expected. The KUAP restore at interrupt exit time deliberately avoids
the isync after the AMR update because it only needs to take effect
after the context synchronizing RFID that soon follows. Add a comment
for this.

The missing isync before the update doesn't have an obvious
justification, and seems it could theoretically allow a rogue user
access to leak past the AMR update. Add isyncs for these.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200429065654.1677541-3-npiggin@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/book3s/64/kup-radix.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/kup-radix.h b/arch/powerpc/include/asm/book3s/64/kup-radix.h
index 3bcef989a35d..101d60f16d46 100644
--- a/arch/powerpc/include/asm/book3s/64/kup-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/kup-radix.h
@@ -16,7 +16,9 @@
 #ifdef CONFIG_PPC_KUAP
 	BEGIN_MMU_FTR_SECTION_NESTED(67)
 	ld	\gpr, STACK_REGS_KUAP(r1)
+	isync
 	mtspr	SPRN_AMR, \gpr
+	/* No isync required, see kuap_restore_amr() */
 	END_MMU_FTR_SECTION_NESTED_IFSET(MMU_FTR_RADIX_KUAP, 67)
 #endif
 .endm
@@ -62,8 +64,15 @@
 
 static inline void kuap_restore_amr(struct pt_regs *regs)
 {
-	if (mmu_has_feature(MMU_FTR_RADIX_KUAP))
+	if (mmu_has_feature(MMU_FTR_RADIX_KUAP)) {
+		isync();
 		mtspr(SPRN_AMR, regs->kuap);
+		/*
+		 * No isync required here because we are about to RFI back to
+		 * previous context before any user accesses would be made,
+		 * which is a CSI.
+		 */
+	}
 }
 
 static inline void kuap_check_amr(void)
-- 
2.25.1

