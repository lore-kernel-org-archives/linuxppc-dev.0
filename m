Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xPqqZ2JVDzDqlB
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Aug 2017 03:03:06 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id 83so4724864pgb.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Aug 2017 10:03:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 02/13] powerpc/64s: masked interrupt avoid instruction
Date: Sun,  6 Aug 2017 03:02:30 +1000
Message-Id: <20170805170241.22966-3-npiggin@gmail.com>
In-Reply-To: <20170805170241.22966-1-npiggin@gmail.com>
References: <20170805170241.22966-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

EE is always enabled in SRR1 for masked interrupts, so clearing
it can use xor.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index f8ad3f0eb383..c4f50a9e2ab5 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1373,8 +1373,7 @@ masked_##_H##interrupt:					\
 1:	andi.	r10,r10,(PACA_IRQ_DBELL|PACA_IRQ_HMI);	\
 	bne	2f;					\
 	mfspr	r10,SPRN_##_H##SRR1;			\
-	rldicl	r10,r10,48,1; /* clear MSR_EE */	\
-	rotldi	r10,r10,16;				\
+	xori	r10,r10,MSR_EE; /* clear MSR_EE */	\
 	mtspr	SPRN_##_H##SRR1,r10;			\
 2:	mtcrf	0x80,r9;				\
 	ld	r9,PACA_EXGEN+EX_R9(r13);		\
-- 
2.11.0
