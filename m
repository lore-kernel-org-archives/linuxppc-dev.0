Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A20AB6F87
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2011 19:40:50 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/e500mc: Remove
	CPU_FTR_MAYBE_CAN_NAP/CPU_FTR_MAYBE_CAN_DOZE
Date: Fri,  8 Apr 2011 04:40:41 -0500
Message-Id: <1302255641-2478-1-git-send-email-galak@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Scott Wood <scottwood@freescale.com>

e500mc does not support the HID0/MSR mechanism that is used by e500_idle
(and there are also issues with waking on certain types of interrupts).

Further, even if napping is never actually enabled, just having
CPU_FTR_CAN_NAP will cause machine_init() to overwrite the board's supplied
ppc_md.power_save().

We drop CPU_FTR_MAYBE_CAN_DOZE becuase we should use 'wait' instead on
e500mc.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/cputable.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 6a7c8d9..7e9b831 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -383,8 +383,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTRS_E500_2	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
 	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | \
 	    CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
-#define CPU_FTRS_E500MC	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
-	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN | \
+#define CPU_FTRS_E500MC	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | \
 	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_DBELL)
 #define CPU_FTRS_E5500	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | \
-- 
1.7.3.4
