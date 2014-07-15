Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD7D01A0B92
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 21:15:44 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/3] powerpc: Document register clobbering in
 EXCEPTION_COMMON()
Date: Tue, 15 Jul 2014 21:15:37 +1000
Message-Id: <1405422938-27608-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1405422938-27608-1-git-send-email-mpe@ellerman.id.au>
References: <1405422938-27608-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/exception-64s.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 8f35cd7d59cc..066c15cd2837 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -532,6 +532,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 	.globl label##_common;					\
 label##_common:							\
 	EXCEPTION_PROLOG_COMMON(trap, PACA_EXGEN);		\
+	/* Volatile regs are potentially clobbered here */	\
 	additions;						\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
 	bl	hdlr;						\
-- 
1.9.1
