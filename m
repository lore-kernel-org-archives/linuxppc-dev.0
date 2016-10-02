Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3smlt074FCzDrSh
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Oct 2016 11:09:44 +1100 (AEDT)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 gwshan@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/eeh: Quieten EEH message when no adapters are found
Date: Sun,  2 Oct 2016 11:09:38 +1100
Message-Id: <1475366978-18713-1-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

No real need for this to be pr_warn(), reduce it to pr_info().

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/eeh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index c9bc78e..3f0ca80 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1044,7 +1044,7 @@ int eeh_init(void)
 	if (eeh_enabled())
 		pr_info("EEH: PCI Enhanced I/O Error Handling Enabled\n");
 	else
-		pr_warn("EEH: No capable adapters found\n");
+		pr_info("EEH: No capable adapters found\n");
 
 	return ret;
 }
-- 
2.7.4
