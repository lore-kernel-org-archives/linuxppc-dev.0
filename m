Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341E3C282C4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 02:39:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9231222C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 02:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA7vJHlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9231222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zkJS0ZHKzDqQd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 13:39:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="CA7vJHlD"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zkBn4gpjzDqNj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 13:34:57 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0819F222CC;
 Wed, 13 Feb 2019 02:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550025295;
 bh=PAh9v9Y+8U4QDfjmor9mETtMhMST8EQwLv/B/xeWvog=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CA7vJHlDTJ+PPvt9hy49aOcvGt8LlS7VuBtGrK33gfE8CCbwDfvxccWTiSrw7UrAe
 yUsbBiy3Y7UDBbo3sUXlZkb6+tBrhdC6EvZ4WVQPxUMhuZXpxXZsTvlq8voHpQ2Woj
 qALM0yPLMfUDjM70mtXZUcLKzSjjYReUSnwpFs3g=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 051/105] powerpc/8xx: fix setting of pagetable
 for Abatron BDI debug tool.
Date: Tue, 12 Feb 2019 21:32:42 -0500
Message-Id: <20190213023336.19019-51-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
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
Cc: linuxppc-dev@lists.ozlabs.org, Sasha Levin <sashal@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit fb0bdec51a4901b7dd088de0a1e365e1b9f5cd21 ]

Commit 8c8c10b90d88 ("powerpc/8xx: fix handling of early NULL pointer
dereference") moved the loading of r6 earlier in the code. As some
functions are called inbetween, r6 needs to be loaded again with the
address of swapper_pg_dir in order to set PTE pointers for
the Abatron BDI.

Fixes: 8c8c10b90d88 ("powerpc/8xx: fix handling of early NULL pointer dereference")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/head_8xx.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 3b67b9533c82..438512759e82 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -927,11 +927,12 @@ start_here:
 
 	/* set up the PTE pointers for the Abatron bdiGDB.
 	*/
-	tovirt(r6,r6)
 	lis	r5, abatron_pteptrs@h
 	ori	r5, r5, abatron_pteptrs@l
 	stw	r5, 0xf0(0)	/* Must match your Abatron config file */
 	tophys(r5,r5)
+	lis	r6, swapper_pg_dir@h
+	ori	r6, r6, swapper_pg_dir@l
 	stw	r6, 0(r5)
 
 /* Now turn on the MMU for real! */
-- 
2.19.1

