Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F2CE02C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 10:48:08 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 3 May 2013 18:48:05 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 32A2619D803E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 18:47:56 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r440m19s129600
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 18:48:01 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r440m1UO001069
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 18:48:01 -0600
Date: Fri, 3 May 2013 17:47:56 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: [PATCH v2 1/4] powerpc/cputable: reserve bits in HWCAP2 for new
 features
Message-ID: <20130504004756.GA3532@linux.vnet.ibm.com>
References: <20130503231933.GA29436@linux.vnet.ibm.com>
 <2889.1367625894@ale.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2889.1367625894@ale.ozlabs.ibm.com>
Cc: Michael R Meissner <mrmeissn@us.ibm.com>,
 Steve Munroe <sjmunroe@us.ibm.com>, Peter Bergner <bergner@us.ibm.com>,
 Ryan Arnold <ryanarn@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Also, make HTM's presence dependent on the .config option.
    
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---
Changes since v1:
 - Add TAR.
 - Make HTM config dependent.

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index fcc54ad..26807e5 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -224,8 +224,10 @@ extern const char *powerpc_base_platform;
 /* We only set the TM feature if the kernel was compiled with TM supprt */
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 #define CPU_FTR_TM_COMP		CPU_FTR_TM
+#define PPC_FEATURE2_HTM_COMP	PPC_FEATURE2_HTM
 #else
 #define CPU_FTR_TM_COMP		0
+#define PPC_FEATURE2_HTM_COMP	0
 #endif
 
 /* We need to mark all pages as being coherent if we're SMP or we have a
diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/powerpc/include/uapi/asm/cputable.h
index ed9dd81..5b76579 100644
--- a/arch/powerpc/include/uapi/asm/cputable.h
+++ b/arch/powerpc/include/uapi/asm/cputable.h
@@ -1,6 +1,7 @@
 #ifndef _UAPI__ASM_POWERPC_CPUTABLE_H
 #define _UAPI__ASM_POWERPC_CPUTABLE_H
 
+/* in AT_HWCAP */
 #define PPC_FEATURE_32			0x80000000
 #define PPC_FEATURE_64			0x40000000
 #define PPC_FEATURE_601_INSTR		0x20000000
@@ -33,4 +34,12 @@
 #define PPC_FEATURE_TRUE_LE		0x00000002
 #define PPC_FEATURE_PPC_LE		0x00000001
 
+/* in AT_HWCAP2 */
+#define PPC_FEATURE2_ARCH_2_07		0x80000000
+#define PPC_FEATURE2_HTM		0x40000000
+#define PPC_FEATURE2_DSCR		0x20000000
+#define PPC_FEATURE2_EBB		0x10000000
+#define PPC_FEATURE2_ISEL		0x08000000
+#define PPC_FEATURE2_TAR		0x04000000
+
 #endif /* _UAPI__ASM_POWERPC_CPUTABLE_H */
