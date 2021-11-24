Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1683FC433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Nov 2021 09:43:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hzbfc5Sr0z3c50
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Nov 2021 20:43:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=pbQu0cKx;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzbdH2dsqz2yPP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Nov 2021 20:42:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=pbQu0cKx; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HzbdG19kyz4xZ4;
 Wed, 24 Nov 2021 20:42:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1637746930;
 bh=YZ8XS3yPwSuVoYmWQEpFzRCXVxcfSJByqItgujlr8OU=;
 h=From:To:Subject:Date:From;
 b=pbQu0cKxObcMxW+npo9U8yUbq+goYLvhPpYhI0s9LYNaGK/VSZEiXK/sbq2Z34n6M
 dwsfzaCqQavk9/JiXRfb0kR5R3YinoO3KkimQKiwkh+10Np+0fkUaSfrpZKybZKbeH
 Wz/HSG4nob4cb56j6XJKgK5Ad5LtIzzF4qWTcy1Jm3uzjolMO/lAdijW9ZUz93RsPE
 nCY9gJOXHRZHKMy/hWYdDenqn7Bkkbsm8iQfZAln38akc8+xMvLHzOVq0o3sfYDxrg
 2kbZp1nsH5TDdLb8XoJc9zgG+l+04Ah5hbAKFAuVFCGYkCxMoIcs8nbiOI1t9nNZ3f
 yQ9fjrGu70Ocw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/6] powerpc/85xx: Fix no previous prototype warning for
 mpc85xx_setup_pmc()
Date: Wed, 24 Nov 2021 20:32:49 +1100
Message-Id: <20211124093254.1054750-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.31.1
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

Fixes the following W=1 warning:
  arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c:89:12: warning: no previous prototype for 'mpc85xx_setup_pmc'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c b/arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c
index 4a8af80011a6..f7ac92a8ae97 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c
@@ -15,6 +15,8 @@
 #include <asm/io.h>
 #include <asm/fsl_pm.h>
 
+#include "smp.h"
+
 static struct ccsr_guts __iomem *guts;
 
 #ifdef CONFIG_FSL_PMC
-- 
2.31.1

