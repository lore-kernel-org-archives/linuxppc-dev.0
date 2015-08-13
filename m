Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22c.google.com (mail-yk0-x22c.google.com
 [IPv6:2607:f8b0:4002:c07::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0EC991A1D59
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 21:51:51 +1000 (AEST)
Received: by ykdt205 with SMTP id t205so38739403ykd.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 04:51:49 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc/e6500: remove the stale TCD_LOCK macro
Date: Thu, 13 Aug 2015 19:51:35 +0800
Message-Id: <1439466697-18989-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since we moved the "lock" to be the first element of
struct tlb_core_data in commit 82d86de25b9c ("powerpc/e6500: Make TLB
lock recursive), this macro is not used by any code. Just delete it.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/kernel/asm-offsets.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 98230579d99c..810f433731dc 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -213,7 +213,6 @@ int main(void)
 		offsetof(struct tlb_core_data, esel_max));
 	DEFINE(TCD_ESEL_FIRST,
 		offsetof(struct tlb_core_data, esel_first));
-	DEFINE(TCD_LOCK, offsetof(struct tlb_core_data, lock));
 #endif /* CONFIG_PPC_BOOK3E */
 
 #ifdef CONFIG_PPC_STD_MMU_64
-- 
2.1.0
