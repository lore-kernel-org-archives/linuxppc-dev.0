Return-Path: <marcelo@kvack.org>
Received: from kanga.kvack.org (kanga.kvack.org [66.96.29.28])
	by ozlabs.org (Postfix) with ESMTP id A7411679E1
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 May 2006 06:22:12 +1000 (EST)
Date: Fri, 5 May 2006 17:22:11 -0300
From: Marcelo Tosatti <marcelo@kvack.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] ppc32 8xx: Fix r3 thrashing due to 8MB TLB page instantiation
	(!CONFIG_8xx_CPU6)
Message-ID: <20060505202211.GA18136@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Jander <david.jander@protonic.nl>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


(please ignore last patch, its incomplete)

Instantiation of 8MB pages on the TLB cache for the kernel static
mapping thrashes r3 register on !CONFIG_8xx_CPU6 configurations.

Signed-off-by: Marcelo Tosatti <marcelo@kvack.org>

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index ec53c7d..09b3adc 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -355,9 +355,7 @@ #endif
 
 	. = 0x1200
 DataStoreTLBMiss:
-#ifdef CONFIG_8xx_CPU6
 	stw	r3, 8(r0)
-#endif
 	DO_8xx_CPU6(0x3f80, r3)
 	mtspr	SPRN_M_TW, r10	/* Save a couple of working registers */
 	mfcr	r10
@@ -417,9 +415,7 @@ #endif
 	lwz	r11, 0(r0)
 	mtcr	r11
 	lwz	r11, 4(r0)
-#ifdef CONFIG_8xx_CPU6
 	lwz	r3, 8(r0)
-#endif
 	rfi
 
 /* This is an instruction TLB error on the MPC8xx.  This could be due
@@ -500,9 +496,7 @@ LoadLargeDTLB:
 	lwz	r11, 4(r0)
 
 	lwz	r12, 16(r0)
-#ifdef CONFIG_8xx_CPU6
 	lwz	r3, 8(r0)
-#endif
 	rfi
 
 /* This is the data TLB error on the MPC8xx.  This could be due to
