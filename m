Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 85EB1B6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 01:26:36 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 01/37] powerpc/booke: Set CPU_FTR_DEBUG_LVL_EXC on 32-bit
Date: Fri, 24 Feb 2012 15:25:55 +0100
Message-Id: <1330093591-19523-2-git-send-email-agraf@suse.de>
In-Reply-To: <1330093591-19523-1-git-send-email-agraf@suse.de>
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Scott Wood <scottwood@freescale.com>

Currently 32-bit only cares about this for choice of exception
vector, which is done in core-specific code.  However, KVM will
want to distinguish as well.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/cputable.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index ad55a1c..6a034a2 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -376,7 +376,8 @@ extern const char *powerpc_base_platform;
 #define CPU_FTRS_47X	(CPU_FTRS_440x6)
 #define CPU_FTRS_E200	(CPU_FTR_USE_TB | CPU_FTR_SPE_COMP | \
 	    CPU_FTR_NODSISRALIGN | CPU_FTR_COHERENT_ICACHE | \
-	    CPU_FTR_UNIFIED_ID_CACHE | CPU_FTR_NOEXECUTE)
+	    CPU_FTR_UNIFIED_ID_CACHE | CPU_FTR_NOEXECUTE | \
+	    CPU_FTR_DEBUG_LVL_EXC)
 #define CPU_FTRS_E500	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
 	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN | \
 	    CPU_FTR_NOEXECUTE)
@@ -385,7 +386,7 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_E500MC	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | \
 	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
-	    CPU_FTR_DBELL)
+	    CPU_FTR_DBELL | CPU_FTR_DEBUG_LVL_EXC)
 #define CPU_FTRS_E5500	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | \
 	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
-- 
1.6.0.2
