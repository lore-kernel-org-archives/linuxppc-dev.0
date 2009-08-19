Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9B21FB7C0A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 15:08:45 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9884DDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 15:08:44 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/5] powerpc/book3e-64: Add helper function to setup IVORs
Date: Wed, 19 Aug 2009 00:08:32 -0500
Message-Id: <1250658513-13009-4-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1250658513-13009-3-git-send-email-galak@kernel.crashing.org>
References: <1250658513-13009-1-git-send-email-galak@kernel.crashing.org>
	<1250658513-13009-2-git-send-email-galak@kernel.crashing.org>
	<1250658513-13009-3-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Not all 64-bit Book-3E parts will have fixed IVORs so add a function that
cpusetup code can call to setup the base IVORs (0..15) to match the fixed
offsets.  We need to 'or' part of interrupt_base_book3e into the IVORs
since on parts that have them the IVPR doesn't extend as far down.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/exception-64e.h |    4 ++++
 arch/powerpc/kernel/exceptions-64e.S     |   19 +++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/include/asm/exception-64e.h
index 94cb3d7..6d53f31 100644
--- a/arch/powerpc/include/asm/exception-64e.h
+++ b/arch/powerpc/include/asm/exception-64e.h
@@ -196,6 +196,10 @@ exc_##label##_book3e:
 #define TLB_MISS_STATS_SAVE_INFO
 #endif
 
+#define SET_IVOR(vector_number, vector_offset)	\
+	li	r3,vector_offset@l; 		\
+	ori	r3,r3,interrupt_base_book3e@l;	\
+	mtspr	SPRN_IVOR##vector_number,r3;
 
 #endif /* _ASM_POWERPC_EXCEPTION_64E_H */
 
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 3611b0e..662236c 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -782,5 +782,24 @@ _STATIC(init_thread_book3e)
 
 	blr
 
+_GLOBAL(__setup_base_ivors)
+	SET_IVOR(0, 0x020) /* Critical Input */
+	SET_IVOR(1, 0x000) /* Machine Check */
+	SET_IVOR(2, 0x060) /* Data Storage */ 
+	SET_IVOR(3, 0x080) /* Instruction Storage */
+	SET_IVOR(4, 0x0a0) /* External Input */ 
+	SET_IVOR(5, 0x0c0) /* Alignment */ 
+	SET_IVOR(6, 0x0e0) /* Program */ 
+	SET_IVOR(7, 0x100) /* FP Unavailable */ 
+	SET_IVOR(8, 0x120) /* System Call */ 
+	SET_IVOR(9, 0x140) /* Auxiliary Processor Unavailable */ 
+	SET_IVOR(10, 0x160) /* Decrementer */ 
+	SET_IVOR(11, 0x180) /* Fixed Interval Timer */ 
+	SET_IVOR(12, 0x1a0) /* Watchdog Timer */ 
+	SET_IVOR(13, 0x1c0) /* Data TLB Error */ 
+	SET_IVOR(14, 0x1e0) /* Instruction TLB Error */
+	SET_IVOR(15, 0x040) /* Debug */
 
+	sync
 
+	blr
-- 
1.6.0.6
