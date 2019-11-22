Return-Path: <SRS0=/SLd=ZO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CDEC43215
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Nov 2019 06:29:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B98520714
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Nov 2019 06:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IT+PJ+JM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B98520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47K6375dcrzDrBx
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Nov 2019 17:29:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="IT+PJ+JM"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47K5Ch47t0zDqwp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2019 16:51:44 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E9542207FC;
 Fri, 22 Nov 2019 05:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574401902;
 bh=j7KbmtmkT44bfLvNzW6tYCDaM4Eo1gsgtSpVmt6J7mM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IT+PJ+JM9EkzwJWJNeLnvbLzZCwSgM1WpUBM9U7m6R0XC9qKpwo1y3Y6jF5JRRQtG
 /c+QHlVonyyCO59B86XA3nITVjl8bDGmhwfB46Ud1YB/6IePSCQlzVEr2LXfw+bkkt
 Z60JZJkQ9rPMPMV//BWtva9EHiQVAOTxVkNEn4I8=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 134/219] powerpc: Fix HMIs on big-endian with
 CONFIG_RELOCATABLE=y
Date: Fri, 22 Nov 2019 00:47:46 -0500
Message-Id: <20191122054911.1750-127-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

[ Upstream commit 505a314fb28ce122091691c51426fa85c084e115 ]

HMIs will crash the kernel due to

	BRANCH_LINK_TO_FAR(hmi_exception_realmode)

Calling into the OPD instead of the actual code.

Fixes: 2337d207288f ("powerpc/64: CONFIG_RELOCATABLE support for hmi interrupts")
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[mpe: Use DOTSYM() rather than #ifdef]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/exceptions-64s.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 90af86f143a91..e1dab9b1e4478 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1123,7 +1123,7 @@ TRAMP_REAL_BEGIN(hmi_exception_early)
 	EXCEPTION_PROLOG_COMMON_2(PACA_EXGEN)
 	EXCEPTION_PROLOG_COMMON_3(0xe60)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	BRANCH_LINK_TO_FAR(hmi_exception_realmode) /* Function call ABI */
+	BRANCH_LINK_TO_FAR(DOTSYM(hmi_exception_realmode)) /* Function call ABI */
 	cmpdi	cr0,r3,0
 
 	/* Windup the stack. */
-- 
2.20.1

