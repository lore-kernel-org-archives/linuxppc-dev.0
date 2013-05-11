Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D8A232C00DB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 May 2013 09:26:39 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: [PATCH 3/4] powerpc: use patch_exception to update the debug
 exception handler
Date: Sun, 12 May 2013 07:26:23 +0800
Message-ID: <1368314784-971-4-git-send-email-haokexin@gmail.com>
In-Reply-To: <1368314784-971-1-git-send-email-haokexin@gmail.com>
References: <1368314784-971-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/kernel/setup_64.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index e379d3f..59dffd0 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -505,9 +505,6 @@ static void __init irqstack_early_init(void)
 #ifdef CONFIG_PPC_BOOK3E
 static void __init exc_lvl_early_init(void)
 {
-	extern unsigned int interrupt_base_book3e;
-	extern unsigned int exc_debug_debug_book3e;
-
 	unsigned int i;
 
 	for_each_possible_cpu(i) {
@@ -520,8 +517,7 @@ static void __init exc_lvl_early_init(void)
 	}
 
 	if (cpu_has_feature(CPU_FTR_DEBUG_LVL_EXC))
-		patch_branch(&interrupt_base_book3e + (0x040 / 4) + 1,
-			     (unsigned long)&exc_debug_debug_book3e, 0);
+		patch_exception(0x040, exc_debug_debug_book3e);
 }
 #else
 #define exc_lvl_early_init()
-- 
1.8.1.4
