Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjBKD5CQhzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 02:48:32 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id r62so1890382pfj.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 09:48:32 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: mpe@ellerman.id.au,
	paulus@samba.org,
	benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: 4xx: constify platform_suspend_ops
Date: Wed, 30 Aug 2017 22:18:20 +0530
Message-Id: <bfb43496252dc11b95ef7e744206c2a7ad17a734.1504111164.git.arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

platform_suspend_ops are not supposed to change at runtime.
Functions suspend_set_ops working with const platform_suspend_ops.
So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 arch/powerpc/sysdev/ppc4xx_cpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_cpm.c b/arch/powerpc/sysdev/ppc4xx_cpm.c
index ba95adf..6483675 100644
--- a/arch/powerpc/sysdev/ppc4xx_cpm.c
+++ b/arch/powerpc/sysdev/ppc4xx_cpm.c
@@ -240,7 +240,7 @@ static int cpm_suspend_enter(suspend_state_t state)
 	return 0;
 }
 
-static struct platform_suspend_ops cpm_suspend_ops = {
+static const struct platform_suspend_ops cpm_suspend_ops = {
 	.valid		= cpm_suspend_valid,
 	.enter		= cpm_suspend_enter,
 };
-- 
2.7.4
