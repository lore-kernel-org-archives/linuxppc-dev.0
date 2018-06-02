Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ydkM3cJzzF0mQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 21:09:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH stable 4.9 01/23] powerpc/rfi-flush: Move out of
 HARDLOCKUP_DETECTOR #ifdef
Date: Sat,  2 Jun 2018 21:08:46 +1000
Message-Id: <20180602110908.29773-2-mpe@ellerman.id.au>
In-Reply-To: <20180602110908.29773-1-mpe@ellerman.id.au>
References: <20180602110908.29773-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The backport of the RFI flush support, done by me, has a minor bug in
that the code is inside an #ifdef CONFIG_HARDLOCKUP_DETECTOR, which is
incorrect.

This doesn't matter with common configs because we enable
HARDLOCKUP_DETECTOR, but with future patches it will break the build.
So fix it.

Fixes: c3b82ebee6e0 ("powerpc/64s: Add support for RFI flush of L1-D cache")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/setup_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 5243501d95ef..1746639c4dcd 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -679,6 +679,7 @@ static int __init disable_hardlockup_detector(void)
 	return 0;
 }
 early_initcall(disable_hardlockup_detector);
+#endif /* CONFIG_HARDLOCKUP_DETECTOR */
 
 #ifdef CONFIG_PPC_BOOK3S_64
 static enum l1d_flush_type enabled_flush_types;
@@ -806,4 +807,3 @@ ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, cha
 	return sprintf(buf, "Vulnerable\n");
 }
 #endif /* CONFIG_PPC_BOOK3S_64 */
-#endif
-- 
2.14.1
