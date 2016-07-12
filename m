Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpNmG0z3xzDqpQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 10:55:10 +1000 (AEST)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rpNmF4C8tz9sDk
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2016 10:55:09 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id c74so69510pfb.0
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Jul 2016 17:55:09 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: arnd@arndb.de,
	Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 2/5] powerpc/xics: Fully qualify cast to silence sparse
Date: Tue, 12 Jul 2016 10:54:49 +1000
Message-Id: <1468284892-27765-2-git-send-email-dja@axtens.net>
In-Reply-To: <1468284892-27765-1-git-send-email-dja@axtens.net>
References: <1468284892-27765-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make the cast fully line up with what out_rm8 expects.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

v2: Fix issues identified by Arnd.
---
 arch/powerpc/sysdev/xics/icp-native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index afdf62f2a695..6e47ddd374b2 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -176,7 +176,7 @@ void icp_native_cause_ipi_rm(int cpu)
 	 * causing the IPI.
 	 */
 	xics_phys = paca[cpu].kvm_hstate.xics_phys;
-	out_rm8((u8 *)(xics_phys + XICS_MFRR), IPI_PRIORITY);
+	out_rm8((u8 __iomem *)(xics_phys + XICS_MFRR), IPI_PRIORITY);
 }
 #endif
 
-- 
2.1.4
