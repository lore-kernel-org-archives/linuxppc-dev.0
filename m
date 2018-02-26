Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqQNJ5v8FzF1LC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 13:13:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	greg@kroah.com
Cc: linuxppc-dev@ozlabs.org,
	bernhard.kaindl@thalesgroup.com
Subject: [PATCH stable v4.4] powerpc/64s: Fix RFI flush dependency on
 HARDLOCKUP_DETECTOR
Date: Mon, 26 Feb 2018 13:13:17 +1100
Message-Id: <20180226021317.28767-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The backport of commit aa8a5e0062ac ("powerpc/64s: Add support for RFI
flush of L1-D cache"), incorrectly placed the new RFI flush code
inside an existing #ifdef CONFIG_HARDLOCKUP_DETECTOR block.

This has the obvious effect of requiring HARDLOCKUP_DETECTOR to be
enabled in order for RFI flush to be enabled, which is a bug.

Fix it by moving the #endif up to where it belongs.

Fixes: c3892946315e ("powerpc/64s: Add support for RFI flush of L1-D cache")
Reported-by: Bernhard Kaindl <bernhard.kaindl@thalesgroup.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/setup_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index df4a87eb8da4..9eb469bed22b 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -835,6 +835,7 @@ static int __init disable_hardlockup_detector(void)
 	return 0;
 }
 early_initcall(disable_hardlockup_detector);
+#endif
 
 #ifdef CONFIG_PPC_BOOK3S_64
 static enum l1d_flush_type enabled_flush_types;
@@ -973,4 +974,3 @@ ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, cha
 	return sprintf(buf, "Vulnerable\n");
 }
 #endif /* CONFIG_PPC_BOOK3S_64 */
-#endif
-- 
2.14.1
