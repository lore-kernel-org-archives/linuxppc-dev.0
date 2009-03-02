Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 94F3FDDF5F
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 05:20:11 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org
Subject: [PATCH] powerpc: add defintion for MSR[GS] to list of MSR bits
Date: Mon,  2 Mar 2009 12:20:01 -0600
Message-Id: <1236018001-3206-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add macros for the GS (guest state) bit to the list of MSR bit definitions.
On PowerPC cores that support embedded hypervisor mode, GS is cleared if
the system is running in hypervisor state (and MSR[PR] is cleared), and set
if it's running in guest state.  See the Power ISA 2.06 specification for
more information.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/include/asm/reg.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index c6d1ab6..ca5c7f8 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -29,6 +29,7 @@
 #define MSR_SF_LG	63              /* Enable 64 bit mode */
 #define MSR_ISF_LG	61              /* Interrupt 64b mode valid on 630 */
 #define MSR_HV_LG 	60              /* Hypervisor state */
+#define MSR_GS_LG	28		/* Guest state */
 #define MSR_VEC_LG	25	        /* Enable AltiVec */
 #define MSR_VSX_LG	23		/* Enable VSX */
 #define MSR_POW_LG	18		/* Enable Power Management */
@@ -71,6 +72,7 @@
 #define MSR_HV		0
 #endif
 
+#define MSR_GS		__MASK(MSR_GS_LG)	/* Guest state */
 #define MSR_VEC		__MASK(MSR_VEC_LG)	/* Enable AltiVec */
 #define MSR_VSX		__MASK(MSR_VSX_LG)	/* Enable VSX */
 #define MSR_POW		__MASK(MSR_POW_LG)	/* Enable Power Management */
-- 
1.5.5
