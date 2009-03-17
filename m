Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.232])
	by ozlabs.org (Postfix) with ESMTP id B556FDDF95
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 15:59:12 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id l9so3100032rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 21:59:10 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC] powerpc/8xxx: Clean up setting of CPU_FTR_NEED_COHERENT
To: galak@kernel.crashing.org, benh@kernel.crashing.org,
	linuxppc-dev@ozlabs.org
Date: Mon, 16 Mar 2009 22:59:07 -0600
Message-ID: <20090317045815.27319.62728.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Method used to set CPU_FTR_NEED_COHERENT was unfriendly for multiplatform
kernels.  This patch cleans it up.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

I haven't even compile tested this.  But I want to see if there are any
objections before I do the legwork.

g.

 arch/powerpc/include/asm/cputable.h |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)


diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 48d7f5f..a36494e 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -242,8 +242,7 @@ extern const char *powerpc_base_platform;
  * 74[45]x and an MPC107 host bridge. Also 83xx and PowerQUICC II
  * require it for PCI "streaming/prefetch" to work properly.
  */
-#if defined(CONFIG_SMP) || defined(CONFIG_MPC10X_BRIDGE) \
-	|| defined(CONFIG_PPC_83xx) || defined(CONFIG_8260)
+#if defined(CONFIG_SMP) || defined(CONFIG_MPC10X_BRIDGE)
 #define CPU_FTR_COMMON                  CPU_FTR_NEED_COHERENT
 #else
 #define CPU_FTR_COMMON                  0
@@ -347,7 +346,7 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR | \
 	    CPU_FTR_PPC_LE | CPU_FTR_NEED_PAIRED_STWCX)
 #define CPU_FTRS_82XX	(CPU_FTR_COMMON | \
-	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB)
+	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_NEED_COHERENT)
 
 #if defined(CONFIG_PPC_MPC52xx)
 #define CPU_FTRS_G2_LE	(CPU_FTR_COMMON | CPU_FTR_MAYBE_CAN_DOZE | \
@@ -359,10 +358,10 @@ extern const char *powerpc_base_platform;
 
 #define CPU_FTRS_E300	(CPU_FTR_MAYBE_CAN_DOZE | \
 	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | \
-	    CPU_FTR_COMMON)
+	    CPU_FTR_COMMON | CPU_FTR_NEED_COHERENT)
 #define CPU_FTRS_E300C2	(CPU_FTR_MAYBE_CAN_DOZE | \
 	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | \
-	    CPU_FTR_COMMON | CPU_FTR_FPU_UNAVAILABLE)
+	    CPU_FTR_COMMON | CPU_FTR_FPU_UNAVAILABLE | CPU_FTR_NEED_COHERENT)
 #define CPU_FTRS_CLASSIC32	(CPU_FTR_COMMON | CPU_FTR_USE_TB)
 #define CPU_FTRS_8XX	(CPU_FTR_USE_TB)
 #define CPU_FTRS_40X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
