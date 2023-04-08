Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA0DC7619A
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Apr 2023 14:03:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ptxlq1gs8z3fbn
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Apr 2023 00:03:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BX/RaH8w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=pali@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BX/RaH8w;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ptxkt6HHNz3fDD
	for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Apr 2023 00:02:30 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B9A5661586;
	Sat,  8 Apr 2023 14:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F25CC4339B;
	Sat,  8 Apr 2023 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680962548;
	bh=j6cuKCL8daQ4YjtlzqbN7C113FAR+BvOj+ptz+yrr+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BX/RaH8wjzhP+zDsQEIBv8GZ4xZ7X4mioXuKhKe09FxtjmZw1MbKvEe+4cJX11164
	 zT8nNldgw3qrmW2ILjuldN3n4yIg1Q3BqREGSUOziM2poySlU/asXG2dRboejZY7Xb
	 ItUV3ybPI4TzXgMucWgjWKwgCCegPlgbxmoT4JeqqI2NvjQQ4Q7oO3YHYi9v3PTRkd
	 uV4Cfn8CnygHmlr+ElnS6fD8+addmvf5qzPVHzE82H9BDNRNvhPplCbdZ/lBWbb6ZU
	 LH1fKgYzYnbmiEKcwl1N7xXVLrzKkQ+/SRTJ8m52a0cGCptW4L8rG8STOscdKXd90t
	 tNDwrcynHh5WA==
Received: by pali.im (Postfix)
	id A90771BE4; Sat,  8 Apr 2023 16:02:25 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v5 01/13] powerpc/85xx: Remove DBG() macro
Date: Sat,  8 Apr 2023 16:01:10 +0200
Message-Id: <20230408140122.25293-2-pali@kernel.org>
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

DBG() macro is defined at three places while used only
one time at one place.

Replace its only use by a pr_debug() and remove the macro.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c  | 10 +---------
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |  7 -------
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |  9 ---------
 3 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index c474da3eeea8..25edfe1b8ae1 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -34,14 +34,6 @@
 
 #include "mpc85xx.h"
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
-#else
-#define DBG(fmt, args...)
-#endif
-
 #ifdef CONFIG_PPC_I8259
 static void mpc85xx_8259_cascade(struct irq_desc *desc)
 {
@@ -98,7 +90,7 @@ void __init mpc85xx_ds_pic_init(void)
 		return;
 	}
 
-	DBG("mpc85xxds: cascade mapped to irq %d\n", cascade_irq);
+	pr_debug("mpc85xxds: cascade mapped to irq %d\n", cascade_irq);
 
 	i8259_init(cascade_node, 0);
 	of_node_put(cascade_node);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 28a04928250f..0546f19416c2 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -49,13 +49,6 @@
 
 #include "mpc85xx.h"
 
-#undef DEBUG
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 #if IS_BUILTIN(CONFIG_PHYLIB)
 
 #define MV88E1111_SCR	0x10
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index aa24793ad25c..acc4145adcf7 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -29,15 +29,6 @@
 
 #include "mpc85xx.h"
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
-#else
-#define DBG(fmt, args...)
-#endif
-
-
 void __init mpc85xx_rdb_pic_init(void)
 {
 	struct mpic *mpic;
-- 
2.20.1

