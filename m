Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 61DFD2C00D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 09:19:58 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 3 May 2013 17:19:50 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 5A3E93E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 17:19:27 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r43NJf6M109418
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 17:19:41 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r43NJf9v021353
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 17:19:41 -0600
Date: Fri, 3 May 2013 16:19:34 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] arch/powerpc: advertise ISA2.07, HTM, DSCR, EBB and ISEL
 bits in HWCAP2
Message-ID: <20130503231933.GA29436@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <michael.neuling@au1.ibm.com>,
 Michael R Meissner <mrmeissn@us.ibm.com>, sjmunroe@us.ibm.com,
 bergner@us.ibm.com, Ryan Arnold <ryanarn@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have AT_HWCAP2 support, start exposing some of the new
POWER8 features via it.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---
Note: there are, I think, some Freescale processors that also should be
updated to indicate they support ISEL, but I don't know which ones.
Since this is a new feature bit (and vector), it seems like we can fix
that up in a follow-on patch. Also, this is my first patch trying to
manipulate these bits, so please let me know if I'm doing something
wrong (for instance, I don't see any particular order to the bits in
PPC_FEATURE_*)

diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/powerpc/include/uapi/asm/cputable.h
index ed9dd81..78db4e2 100644
--- a/arch/powerpc/include/uapi/asm/cputable.h
+++ b/arch/powerpc/include/uapi/asm/cputable.h
@@ -1,6 +1,7 @@
 #ifndef _UAPI__ASM_POWERPC_CPUTABLE_H
 #define _UAPI__ASM_POWERPC_CPUTABLE_H
 
+/* in AT_HWCAP */
 #define PPC_FEATURE_32			0x80000000
 #define PPC_FEATURE_64			0x40000000
 #define PPC_FEATURE_601_INSTR		0x20000000
@@ -33,4 +34,11 @@
 #define PPC_FEATURE_TRUE_LE		0x00000002
 #define PPC_FEATURE_PPC_LE		0x00000001
 
+/* in AT_HWCAP2 */
+#define PPC_FEATURE2_ARCH_2_07		0x80000000
+#define PPC_FEATURE2_HTM		0x40000000
+#define PPC_FEATURE2_DSCR		0x20000000
+#define PPC_FEATURE2_EBB		0x10000000
+#define PPC_FEATURE2_ISEL		0x08000000
+
 #endif /* _UAPI__ASM_POWERPC_CPUTABLE_H */
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index ae9f433..871c741 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -102,6 +102,9 @@ extern void __restore_cpu_e6500(void);
 				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
 				 PPC_FEATURE_TRUE_LE | \
 				 PPC_FEATURE_PSERIES_PERFMON_COMPAT)
+#define COMMON_USER2_POWER8	(PPC_FEATURE2_ARCH_2_07 | PPC_FEATURE2_HTM | \
+				 PPC_FEATURE2_DSCR | PPC_FEATURE2_EBB | \
+				 PPC_FEATURE2_ISEL)
 #define COMMON_USER_PA6T	(COMMON_USER_PPC64 | PPC_FEATURE_PA6T |\
 				 PPC_FEATURE_TRUE_LE | \
 				 PPC_FEATURE_HAS_ALTIVEC_COMP)
@@ -443,6 +446,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER8 (architected)",
 		.cpu_features		= CPU_FTRS_POWER8,
 		.cpu_user_features	= COMMON_USER_POWER8,
+		.cpu_user_features2	= COMMON_USER2_POWER8,
 		.mmu_features		= MMU_FTRS_POWER8,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
@@ -492,6 +496,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER8 (raw)",
 		.cpu_features		= CPU_FTRS_POWER8,
 		.cpu_user_features	= COMMON_USER_POWER8,
+		.cpu_user_features2	= COMMON_USER2_POWER8,
 		.mmu_features		= MMU_FTRS_POWER8,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
