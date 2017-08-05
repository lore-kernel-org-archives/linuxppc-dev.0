Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xPqqc46wxzDqk9
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Aug 2017 03:03:08 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id p13so4852647pfd.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Aug 2017 10:03:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 03/13] powerpc/64s: masked interrupt returns to kernel so
 avoid r13 restore
Date: Sun,  6 Aug 2017 03:02:31 +1000
Message-Id: <20170805170241.22966-4-npiggin@gmail.com>
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

Places in the kernel where r13 is not the PACA pointer must have
maskable interrupts disabled, so r13 does not have to be restored
when returning from a soft-masked interrupt.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index c4f50a9e2ab5..67321be3122c 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1379,7 +1379,7 @@ masked_##_H##interrupt:					\
 	ld	r9,PACA_EXGEN+EX_R9(r13);		\
 	ld	r10,PACA_EXGEN+EX_R10(r13);		\
 	ld	r11,PACA_EXGEN+EX_R11(r13);		\
-	GET_SCRATCH0(r13);				\
+	/* returns to kernel where r13 must be set up, so don't restore it */ \
 	##_H##rfid;					\
 	b	.;					\
 	MASKED_DEC_HANDLER(_H)
-- 
2.11.0
