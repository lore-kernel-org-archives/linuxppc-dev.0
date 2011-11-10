Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id 98672100C1E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 11:09:03 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 12/17] powerpc/e500: Separate e500mc CPU table entries
 from e500v1/e500v2
Date: Wed,  9 Nov 2011 19:07:10 -0500
Message-Id: <1320883635-17194-13-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <4E42AB6F.1050900@freescale.com>
References: <4E42AB6F.1050900@freescale.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Timur Tabi <B04825@freescale.com>,
 linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
 Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Kyle Moffett <Kyle.D.Moffett@boeing.com>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The e500mc CPUs have a classic FPU and are not compatible with e500v1 or
e500v2.  This patch fixes the 32-bit CPU feature tables so that e500mc
entries are not present on e500v1/e500v2 systems and vice versa.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/include/asm/cputable.h |   16 ++++++++++------
 arch/powerpc/kernel/cputable.c      |    8 +++++---
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index b69f255..c7c2582 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -480,9 +480,11 @@ enum {
 #ifdef CONFIG_E200
 	    CPU_FTRS_E200 |
 #endif
-#ifdef CONFIG_E500
-	    CPU_FTRS_E500 | CPU_FTRS_E500_2 | CPU_FTRS_E500MC |
-	    CPU_FTRS_E5500 |
+#ifdef CONFIG_FSL_E500_V1_V2
+	    CPU_FTRS_E500 | CPU_FTRS_E500_2 |
+#endif
+#ifdef CONFIG_FSL_E500MC
+	    CPU_FTRS_E500MC | CPU_FTRS_E5500 |
 #endif
 	    0,
 };
@@ -525,9 +527,11 @@ enum {
 #ifdef CONFIG_FSL_E200
 	    CPU_FTRS_E200 &
 #endif
-#ifdef CONFIG_E500
-	    CPU_FTRS_E500 & CPU_FTRS_E500_2 & CPU_FTRS_E500MC &
-	    CPU_FTRS_E5500 &
+#ifdef CONFIG_FSL_E500_V1_V2
+	    CPU_FTRS_E500 & CPU_FTRS_E500_2 &
+#endif
+#ifdef CONFIG_FSL_E500MC
+	    CPU_FTRS_E500MC & CPU_FTRS_E5500 &
 #endif
 	    CPU_FTRS_POSSIBLE,
 };
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index e5b142c..a6f2544 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1917,8 +1917,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 	}
 #endif /* CONFIG_FSL_E200 */
 #endif /* CONFIG_PPC32 */
-#ifdef CONFIG_E500
-#ifdef CONFIG_PPC32
+#ifdef CONFIG_FSL_E500_V1_V2
 	{	/* e500 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x80200000,
@@ -1956,6 +1955,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_e500,
 		.platform		= "ppc8548",
 	},
+#endif /* CONFIG_FSL_E500_V1_V2 */
+#ifdef CONFIG_FSL_E500MC
 	{	/* e500mc */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x80230000,
@@ -1973,7 +1974,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce500mc",
 	},
-#endif /* CONFIG_PPC32 */
+#endif /* CONFIG_FSL_E500MC */
+#ifdef CONFIG_E500 /* FIXME */
 	{	/* e5500 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x80240000,
-- 
1.7.2.5
