Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTW1Y5dnCzDqkX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 02:39:29 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 123so3489256pga.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 09:39:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 01/14] powerpc/64s: masked interrupt avoid branch
Date: Sat, 12 Aug 2017 02:38:59 +1000
Message-Id: <20170811163912.28783-2-npiggin@gmail.com>
In-Reply-To: <20170811163912.28783-1-npiggin@gmail.com>
References: <20170811163912.28783-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Interrupts which do not require EE to be cleared can all
be tested with a single bitwise test.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index f14f3c04ec7e..f8ad3f0eb383 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1370,10 +1370,8 @@ masked_##_H##interrupt:					\
 	ori	r10,r10,0xffff;				\
 	mtspr	SPRN_DEC,r10;				\
 	b	MASKED_DEC_HANDLER_LABEL;		\
-1:	cmpwi	r10,PACA_IRQ_DBELL;			\
-	beq	2f;					\
-	cmpwi	r10,PACA_IRQ_HMI;			\
-	beq	2f;					\
+1:	andi.	r10,r10,(PACA_IRQ_DBELL|PACA_IRQ_HMI);	\
+	bne	2f;					\
 	mfspr	r10,SPRN_##_H##SRR1;			\
 	rldicl	r10,r10,48,1; /* clear MSR_EE */	\
 	rotldi	r10,r10,16;				\
-- 
2.13.3
