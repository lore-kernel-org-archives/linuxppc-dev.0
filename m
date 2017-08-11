Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTW1g2lZVzDr4K
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 02:39:35 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id u185so3514952pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 09:39:35 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 03/14] powerpc/64s: masked interrupt returns to kernel so
 avoid r13 restore
Date: Sat, 12 Aug 2017 02:39:01 +1000
Message-Id: <20170811163912.28783-4-npiggin@gmail.com>
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
2.13.3
