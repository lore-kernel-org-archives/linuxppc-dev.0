Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B5022DDF92
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 03:23:56 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org
Subject: [PATCH v2] powerpc: add defintion for MSR[GS] to list of MSR bits
Date: Tue,  3 Mar 2009 10:23:47 -0600
Message-Id: <1236097427-17977-1-git-send-email-timur@freescale.com>
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

v2: moved the definition from reg.h to reg_booke.h, where it belongs

 arch/powerpc/include/asm/reg_booke.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index c030741..cf1c41f 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -10,6 +10,7 @@
 #define __ASM_POWERPC_REG_BOOKE_H__
 
 /* Machine State Register (MSR) Fields */
+#define MSR_GS		(1<<28) /* Guest state */
 #define MSR_UCLE	(1<<26)	/* User-mode cache lock enable */
 #define MSR_SPE		(1<<25)	/* Enable SPE */
 #define MSR_DWE		(1<<10)	/* Debug Wait Enable */
-- 
1.5.5
