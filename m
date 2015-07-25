Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 094041A0616
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2015 02:57:56 +1000 (AEST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyril.bur@au1.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc: Remove redundant mflr in _switch
Date: Sun, 26 Jul 2015 02:57:45 +1000
Message-Id: <1437843465-1577-3-git-send-email-anton@samba.org>
In-Reply-To: <1437843465-1577-1-git-send-email-anton@samba.org>
References: <1437843465-1577-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No need to execute mflr twice.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/entry_64.S | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 8428280..f8779f2 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -440,9 +440,7 @@ _GLOBAL(_switch)
 	/* r3-r13 are caller saved -- Cort */
 	SAVE_8GPRS(14, r1)
 	SAVE_10GPRS(22, r1)
-	mflr	r20		/* Return to switch caller */
-
-	std	r20,_NIP(r1)
+	std	r0,_NIP(r1)	/* Return to switch caller */
 	mfcr	r23
 	std	r23,_CCR(r1)
 	std	r1,KSP(r3)	/* Set old stack pointer */
-- 
2.1.4
