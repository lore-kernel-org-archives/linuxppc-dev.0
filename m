Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id 9715610109A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 11:09:17 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 16/17] powerpc/e500: Make __setup_cpu_{e200, e500, e500mc,
 e5500} optional
Date: Wed,  9 Nov 2011 19:07:14 -0500
Message-Id: <1320883635-17194-17-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <4E42AB6F.1050900@freescale.com>
References: <4E42AB6F.1050900@freescale.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Shaohui Xie <b21989@freescale.com>,
 Alexandre Bounine <alexandre.bounine@idt.com>,
 Timur Tabi <B04825@freescale.com>, linux-kernel@vger.kernel.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Kyle Moffett <Kyle.D.Moffett@boeing.com>,
 Scott Wood <scottwood@freescale.com>,
 Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Only build the setup functions when the corresponding entries are
included in the CPU table.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/kernel/cpu_setup_fsl_booke.S |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 8053db0..77721b2 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -17,6 +17,8 @@
 #include <asm/cputable.h>
 #include <asm/ppc_asm.h>
 
+#if defined(CONFIG_FSL_E500_V1_V2) || defined(CONFIG_FSL_E500MC) \
+		|| defined(CONFIG_FSL_E5500)
 _GLOBAL(__e500_icache_setup)
 	mfspr	r0, SPRN_L1CSR1
 	andi.	r3, r0, L1CSR1_ICE
@@ -50,14 +52,18 @@ _GLOBAL(__e500_dcache_setup)
 	mtspr	SPRN_L1CSR0, r0		/* Enable */
 	isync
 	blr
+#endif /* CONFIG_FSL_E500_V1_V2 || CONFIG_FSL_E500MC || CONFIG_FSL_E5500 */
 
-#ifdef CONFIG_PPC32
+#ifdef CONFIG_FSL_E200
 _GLOBAL(__setup_cpu_e200)
 	/* enable dedicated debug exception handling resources (Debug APU) */
 	mfspr	r3,SPRN_HID0
 	ori	r3,r3,HID0_DAPUEN@l
 	mtspr	SPRN_HID0,r3
 	b	__setup_e200_ivors
+#endif
+
+#ifdef CONFIG_FSL_E500_V1_V2
 _GLOBAL(__setup_cpu_e500v1)
 _GLOBAL(__setup_cpu_e500v2)
 	mflr	r4
@@ -72,6 +78,9 @@ _GLOBAL(__setup_cpu_e500v2)
 #endif
 	mtlr	r4
 	blr
+#endif
+
+#ifdef CONFIG_FSL_E500MC
 _GLOBAL(__setup_cpu_e500mc)
 	mflr	r4
 	bl	__e500_icache_setup
@@ -80,7 +89,9 @@ _GLOBAL(__setup_cpu_e500mc)
 	mtlr	r4
 	blr
 #endif
+
 /* Right now, restore and setup are the same thing */
+#ifdef CONFIG_FSL_E5500
 _GLOBAL(__restore_cpu_e5500)
 _GLOBAL(__setup_cpu_e5500)
 	mflr	r4
@@ -96,3 +107,4 @@ _GLOBAL(__setup_cpu_e5500)
 #endif
 	mtlr	r4
 	blr
+#endif
-- 
1.7.2.5
