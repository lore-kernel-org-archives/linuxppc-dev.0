Return-Path: <B40534@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 915A92C035B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 19:22:15 +1000 (EST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <benh@kernel.crashing.org>, <scottwood@freescale.com>,
 <galak@kernel.crashing.org>
Subject: [RFC 2/2] powerpc/cputable: add wait feature for CPU kernel features
Date: Wed, 10 Jul 2013 16:31:51 +0800
Message-ID: <1373445111-7866-2-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1373445111-7866-1-git-send-email-dongsheng.wang@freescale.com>
References: <1373445111-7866-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, chenhui.zhao@freescale.com,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 6f3887d..0a8d0cb 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -138,6 +138,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTR_NOEXECUTE		ASM_CONST(0x10000000)
 #define CPU_FTR_INDEXED_DCR		ASM_CONST(0x20000000)
 #define CPU_FTR_EMB_HV			ASM_CONST(0x40000000)
+#define CPU_FTR_CAN_WAIT		ASM_CONST(0x80000000)
 
 /*
  * Add the 64-bit processor unique features in the top half of the word;
@@ -250,9 +251,11 @@ extern const char *powerpc_base_platform;
 #ifndef CONFIG_BDI_SWITCH
 #define CPU_FTR_MAYBE_CAN_DOZE	CPU_FTR_CAN_DOZE
 #define CPU_FTR_MAYBE_CAN_NAP	CPU_FTR_CAN_NAP
+#define CPU_FTR_MAYBE_CAN_WAIT	CPU_FTR_CAN_WAIT
 #else
 #define CPU_FTR_MAYBE_CAN_DOZE	0
 #define CPU_FTR_MAYBE_CAN_NAP	0
+#define CPU_FTR_MAYBE_CAN_WAIT	0
 #endif
 
 #define CLASSIC_PPC (!defined(CONFIG_8xx) && !defined(CONFIG_4xx) && \
@@ -370,15 +373,17 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_E500MC	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | \
 	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
-	    CPU_FTR_DBELL | CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV)
+	    CPU_FTR_DBELL | CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV | \
+	    CPU_FTR_MAYBE_CAN_WAIT)
 #define CPU_FTRS_E5500	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | \
 	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
-	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV)
+	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV | CPU_FTR_MAYBE_CAN_WAIT)
 #define CPU_FTRS_E6500	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | \
 	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
-	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV | CPU_FTR_ALTIVEC_COMP)
+	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV | CPU_FTR_ALTIVEC_COMP | \
+	    CPU_FTR_MAYBE_CAN_WAIT)
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
 
 /* 64-bit CPUs */
-- 
1.8.0
