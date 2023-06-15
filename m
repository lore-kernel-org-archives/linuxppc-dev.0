Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3E6EB64D9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Jun 2023 13:26:41 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ydu4lOUp;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qhjk62ncXz3bm5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Jun 2023 23:26:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ydu4lOUp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=naveen@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qhjj66B45z2xq5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2023 23:25:46 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 75EC260EB2
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2023 13:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC47C433C8;
	Thu, 15 Jun 2023 13:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686835543;
	bh=F6EvGHLsjLKWujQ733adPpR8Psp041v4cCwWpaQ++cI=;
	h=From:To:Subject:Date:From;
	b=Ydu4lOUpu/GtP+7PaMq9GIhYA/UavRqPfxMPQjQHdnJtSdPAXUg4YxsQpJsfMhbZH
	 NogNWJY3P6YUnwYbsAbO7ZiF7GrDh0dbX2h1gv3Lb4e+sToOAJxgNpH9ynnMCzWVhJ
	 6lHMKQ4UMQI5/4CmSxQzca0WXJCFVzD799RZnNhhrKroopheiKl43rhD0aXJ/XoqeK
	 i91wh1+YrpAFITLr2AGcFTkokB0yQuL4LGq96WVMBXfZEvPrf44tqcZVXvOxwIygTu
	 ZmpOYv8ZW21JzO04fzjVeKesHzPmZAoyOac5RoSsoX/jFJNCZKEP+oW39lXvBakKcn
	 kKGMDMwFjbtJQ==
From: Naveen N Rao <naveen@kernel.org>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/ftrace: Fix dropping weak symbols with older toolchains
Date: Thu, 15 Jun 2023 18:48:29 +0530
Message-Id: <20230615131829.2814538-1-naveen@kernel.org>
X-Mailer: git-send-email 2.40.1
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
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The minimum level of gcc supported for building the kernel is v5.1.
v5.x releases of gcc emitted a three instruction sequence for
-mprofile-kernel:
	mflr	r0
	std	r0, 16(r1)
	bl	_mcount

It is only with the v6.x releases that gcc started emitting the two
instruction sequence for -mprofile-kernel, omitting the second store
instruction.

With the older three instruction sequence, the actual ftrace location
can be the 5th instruction into a function. Update the allowed offset
for ftrace location from 12 to 16 to accommodate the same.

Cc: stable@vger.kernel.org
Fixes: 7af82ff90a2b06 ("powerpc/ftrace: Ignore weak functions")
Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/include/asm/ftrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 91c049d51d0e10..2edc6269b1a357 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -12,7 +12,7 @@
 
 /* Ignore unused weak functions which will have larger offsets */
 #ifdef CONFIG_MPROFILE_KERNEL
-#define FTRACE_MCOUNT_MAX_OFFSET	12
+#define FTRACE_MCOUNT_MAX_OFFSET	16
 #elif defined(CONFIG_PPC32)
 #define FTRACE_MCOUNT_MAX_OFFSET	8
 #endif

base-commit: bd517a8442b6c6646a136421cd4c1b95bf4ce32b
-- 
2.40.1

