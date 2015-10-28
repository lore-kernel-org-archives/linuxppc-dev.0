Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 865631A029A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 11:51:17 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/19] powerpc: Remove redundant mflr in _switch
Date: Wed, 28 Oct 2015 11:50:52 +1100
Message-Id: <1445993467-667-4-git-send-email-anton@samba.org>
In-Reply-To: <1445993467-667-1-git-send-email-anton@samba.org>
References: <1445993467-667-1-git-send-email-anton@samba.org>
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
index e84e5bc..c8b4225 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -452,9 +452,7 @@ _GLOBAL(_switch)
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
2.5.0
