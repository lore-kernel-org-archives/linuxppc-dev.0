Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjdSQ1Bn0zDqp6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 17:09:58 +1000 (AEST)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rjdSP4hrwz9s5J
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Jul 2016 17:09:57 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id t190so15677036pfb.2
 for <linuxppc-dev@ozlabs.org>; Mon, 04 Jul 2016 00:09:57 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>
Subject: [PATCH 3/6] powerpc/xics: Fully qualify cast to silence sparse
Date: Mon,  4 Jul 2016 17:09:39 +1000
Message-Id: <1467616182-30886-3-git-send-email-dja@axtens.net>
In-Reply-To: <1467616182-30886-1-git-send-email-dja@axtens.net>
References: <1467616182-30886-1-git-send-email-dja@axtens.net>
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
 arch/powerpc/sysdev/xics/icp-native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index afdf62f2a695..e9cffb06cc01 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -176,7 +176,7 @@ void icp_native_cause_ipi_rm(int cpu)
 	 * causing the IPI.
 	 */
 	xics_phys = paca[cpu].kvm_hstate.xics_phys;
-	out_rm8((u8 *)(xics_phys + XICS_MFRR), IPI_PRIORITY);
+	out_rm8((volatile u8 __iomem *)(xics_phys + XICS_MFRR), IPI_PRIORITY);
 }
 #endif
 
-- 
2.1.4
