Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 58B3E1A00D6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 15:05:01 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9E2A6140078
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2014 15:04:59 +1000 (EST)
Message-ID: <1402376680.14780.12.camel@pasglop>
Subject: [PATCH] powerpc: Add AT_HWCAP2 to indicate V.CRYPTO category support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Date: Tue, 10 Jun 2014 15:04:40 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Diane Brent <drbrent@us.ibm.com>,
 Adhemerval Zanella <azanella@linux.vnet.ibm.com>,
 Jeffrey Scheel <scheel@us.ibm.com>, Steve Munroe <sjmunroe@us.ibm.com>,
 Hanns-Joachim Uhl <hannsj_uhl@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Vector Crypto category instructions are supported by current POWER8
chips, advertise them to userspace using a specific bit to properly
differentiate with chips of the same architecture level that might not
have them.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: <stable@vger.kernel.org> [v3.10+]
--

diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/powerpc/include/uapi/asm/cputable.h
index 5b76579..de2c0e4 100644
--- a/arch/powerpc/include/uapi/asm/cputable.h
+++ b/arch/powerpc/include/uapi/asm/cputable.h
@@ -41,5 +41,6 @@
 #define PPC_FEATURE2_EBB		0x10000000
 #define PPC_FEATURE2_ISEL		0x08000000
 #define PPC_FEATURE2_TAR		0x04000000
+#define PPC_FEATURE2_VEC_CRYPTO		0x02000000
 
 #endif /* _UAPI__ASM_POWERPC_CPUTABLE_H */
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index c1faade..11da04a 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -109,7 +109,8 @@ extern void __restore_cpu_e6500(void);
 				 PPC_FEATURE_PSERIES_PERFMON_COMPAT)
 #define COMMON_USER2_POWER8	(PPC_FEATURE2_ARCH_2_07 | \
 				 PPC_FEATURE2_HTM_COMP | PPC_FEATURE2_DSCR | \
-				 PPC_FEATURE2_ISEL | PPC_FEATURE2_TAR)
+				 PPC_FEATURE2_ISEL | PPC_FEATURE2_TAR | \
+				 PPC_FEATURE2_VEC_CRYPTO)
 #define COMMON_USER_PA6T	(COMMON_USER_PPC64 | PPC_FEATURE_PA6T |\
 				 PPC_FEATURE_TRUE_LE | \
 				 PPC_FEATURE_HAS_ALTIVEC_COMP)
