Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqtKV2BqLzDqyG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 21:10:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sasha Levin  <sasha.levin@oracle.com> 
Cc: Christian Zigotzky <chzigotzky@bayern-mail.de>,
 linuxppc-dev@lists.ozlabs.org <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard  <anton@samba.org>, <stable@vger.kernel.org>
Subject: [4.1.28 PATCH] powerpc: Fix build break due to missing
 PPC_FEATURE2_HTM_NOSC
Date: Thu, 14 Jul 2016 21:10:37 +1000
Message-ID: <87bn20a30y.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The backport of 4705e02498d6 ("powerpc: Update TM user feature bits in
scan_features()") (f49eb503f0f9), missed the fact that 4.1 doesn't
include the commit that added PPC_FEATURE2_HTM_NOSC.

The correct fix is simply to omit PPC_FEATURE2_HTM_NOSC.

Fixes: f49eb503f0f9 ("powerpc: Update TM user feature bits in scan_features()")
Reported-by: Christian Zigotzky <chzigotzky@bayern-mail.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 28dbbb0d12c4..9b19d96e9562 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -166,8 +166,7 @@ static struct ibm_pa_feature {
 	 * we don't want to turn on TM here, so we use the *_COMP versions
 	 * which are 0 if the kernel doesn't support TM.
 	 */
-	{CPU_FTR_TM_COMP, 0, 0,
-	 PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0, 0},
+	{CPU_FTR_TM_COMP, 0, 0, PPC_FEATURE2_HTM_COMP, 22, 0, 0},
 };
 
 static void __init scan_features(unsigned long node, const unsigned char *ftrs,
-- 
2.7.4
