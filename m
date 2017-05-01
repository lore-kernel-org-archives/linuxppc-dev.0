Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGjgt2HfzzDqH7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 May 2017 22:01:30 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id v14so27486756pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 May 2017 05:01:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 2/2] powerpc/64s: Fix OPAL_CALL non-maskable interrupt
 reentrancy
Date: Mon,  1 May 2017 22:01:10 +1000
Message-Id: <20170501120110.21888-3-npiggin@gmail.com>
In-Reply-To: <20170501120110.21888-1-npiggin@gmail.com>
References: <20170501120110.21888-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OPAL_CALL uses SRR[01] with MSR_RI=1, which gets corrupted if there
is an interleaving system reset or machine check interrupt.

Use HSRR[01] instead, which does not require MSR_RI=0.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-wrappers.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index f620572f891f..4ca6c26a56d5 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -99,10 +99,10 @@ opal_return:
 	lwz	r4,8(r1);
 	ld	r5,PPC_LR_STKOFF(r1);
 	ld	r6,PACASAVEDMSR(r13);
-	mtspr	SPRN_SRR0,r5;
-	mtspr	SPRN_SRR1,r6;
 	mtcr	r4;
-	rfid
+	mtspr	SPRN_HSRR0,r5;
+	mtspr	SPRN_HSRR1,r6;
+	hrfid
 
 opal_real_call:
 	mfcr	r11
-- 
2.11.0
