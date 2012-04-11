Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9D401B7077
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2012 06:28:48 +1000 (EST)
Date: Wed, 11 Apr 2012 15:27:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH] powerpc/e6500: add CPU_FTR_EMB_HV to CPU table
Message-ID: <20120411202752.GA12204@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

e6500 support (commit 10241842fbe900276634fee8d37ec48a7d8a762f, 
"powerpc: Add initial e6500 cpu support" and the introduction of
CPU_FTR_EMB_HV (commit 73196cd364a2d972d73fa08da9d81ca3215bed68,
"KVM: PPC: e500mc support") collided during merge, leaving e6500's CPU
table entry missing CPU_FTR_EMB_HV.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Fixup patch for the KVM merge as requested by Marcelo.

 arch/powerpc/include/asm/cputable.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 67c34af..50d82c8 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -395,7 +395,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTRS_E6500	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | \
 	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
-	    CPU_FTR_DEBUG_LVL_EXC)
+	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV)
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
 
 /* 64-bit CPUs */
-- 
1.7.7.rc3.4.g8d714
