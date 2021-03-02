Return-Path: <SRS0=ynH/=IA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C721C433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 11:56:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C32B64F43
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 11:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C32B64F43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DqbFn5ycxz3dB5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 22:56:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iv4cCGaW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=iv4cCGaW; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DqbDy22CSz30Jh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Mar 2021 22:56:02 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAC5764F0E;
 Tue,  2 Mar 2021 11:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614686160;
 bh=pyvkKG6xNO25r+4NNTsksYyuERDmsedBHxXCzBO9PFA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iv4cCGaWqWZoPq3INuBTIf7aDQqupQWv77lowlhEslG4iatiMa5s1h4ErP9hI3YRN
 jk2ggcvgYINkDhDWbf5oMXWlNjbv3SMs3FqqINsDtGVJXg7ZpZpqU/sy//yIRSvlJn
 PJ04T3N4fIzLMJmPRuOQDc0GnGDjZRD+GlBy0OOt9N3hdQ+mT9pmc95g69iDKzLccJ
 AeMxsvTtPL/WVsZ0VtTNhvBPtaHWvdn0EFpxjaQGVzfO/Dxb9IbcWpBCfTyPUle8ib
 /OG1Rwi0tcz3GWw7wZEYJ8KAtrwkF+yXKyasTZTYsy4heYEEQRGB9r873aLxMH+fxX
 KQLU+4314uf4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 19/52] powerpc: improve handling of unrecoverable
 system reset
Date: Tue,  2 Mar 2021 06:55:00 -0500
Message-Id: <20210302115534.61800-19-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302115534.61800-1-sashal@kernel.org>
References: <20210302115534.61800-1-sashal@kernel.org>
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

[ Upstream commit 11cb0a25f71818ca7ab4856548ecfd83c169aa4d ]

If an unrecoverable system reset hits in process context, the system
does not have to panic. Similar to machine check, call nmi_exit()
before die().

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20210130130852.2952424-26-npiggin@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/traps.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 3ec7b443fe6b..4be05517f2db 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -503,8 +503,11 @@ out:
 		die("Unrecoverable nested System Reset", regs, SIGABRT);
 #endif
 	/* Must die if the interrupt is not recoverable */
-	if (!(regs->msr & MSR_RI))
+	if (!(regs->msr & MSR_RI)) {
+		/* For the reason explained in die_mce, nmi_exit before die */
+		nmi_exit();
 		die("Unrecoverable System Reset", regs, SIGABRT);
+	}
 
 	if (saved_hsrrs) {
 		mtspr(SPRN_HSRR0, hsrr0);
-- 
2.30.1

