Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3588EC7619A
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Apr 2023 14:04:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ptxml3t4yz3fcQ
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Apr 2023 00:04:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aAFWvUzO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=pali@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aAFWvUzO;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ptxkv02Zfz3fFV
	for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Apr 2023 00:02:30 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1146961594;
	Sat,  8 Apr 2023 14:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59ED7C4339C;
	Sat,  8 Apr 2023 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680962548;
	bh=JyNl4ARckRodp1O8pkh/0UW7Q6hGHn4B98FxtpuA1Dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aAFWvUzOXYu18nPeredW7o6B3Fa9NCeR9t0aWYkUFruuCfIl5mv2wOOjnSZO/9JBU
	 JTo0nEZEu+tEXfY1BlYSXhYMcRpEWqBP41/oxdrve1dAan2Chh+iWSLfefRQTElU16
	 5DXmVRnUbdT+7Uv94BjavuD/SPD7LQJ8oEQkNT6FKd6buxiEgluzPfosVMesHSTxKb
	 qXhQc+kXEHpWf+wOyz57N246mb/Eb3IGlr4NKUHIANRKeY1VVmEAU/spRniEFZjsVx
	 wvzgkvrKJor8awTg+FyGOu1fB2o/OtwO65EdEK+yxGANxvBaMoQe5w5+V9/WHqNHzc
	 Go1R6+MbULNXw==
Received: by pali.im (Postfix)
	id 010B52047; Sat,  8 Apr 2023 16:02:25 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v5 03/13] powerpc/85xx: mpc85xx_{ds/rdb} replace BUG_ON() by WARN_ON()
Date: Sat,  8 Apr 2023 16:01:12 +0200
Message-Id: <20230408140122.25293-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230408140122.25293-1-pali@kernel.org>
References: <20230408140122.25293-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Christophe Leroy <christophe.leroy@csgroup.eu>

No need to BUG() in case mpic_alloc() fails. Use WARN_ON().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c  | 4 +++-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index c6016915264c..98cca1102e0b 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -62,7 +62,9 @@ void __init mpc85xx_ds_pic_init(void)
 
 	mpic = mpic_alloc(NULL, 0, flags, 0, 256, " OpenPIC  ");
 
-	BUG_ON(mpic == NULL);
+	if (WARN_ON(!mpic))
+		return;
+
 	mpic_init(mpic);
 
 #ifdef CONFIG_PPC_I8259
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index c7ce8a79992d..a802053b37b3 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -39,7 +39,9 @@ void __init mpc85xx_rdb_pic_init(void)
 
 	mpic = mpic_alloc(NULL, 0, flags, 0, 256, " OpenPIC  ");
 
-	BUG_ON(mpic == NULL);
+	if (WARN_ON(!mpic))
+		return;
+
 	mpic_init(mpic);
 }
 
-- 
2.20.1

