Subject: [PATCH] Workaround for 745x data corruption bug
From: Adrian Cox <adrian@humboldt.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Content-Type: multipart/mixed; boundary="=-bHhE18tXgnOtKidU1h2l"
Message-Id: <1091291276.987.57.camel@localhost>
Mime-Version: 1.0
Date: Sat, 31 Jul 2004 17:27:56 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-bHhE18tXgnOtKidU1h2l
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Recently released errata documents show a new bug in all 745x family
processors. This can cause data corruption when memory is mapped
non-coherent and one of these conditions is true:
1) L2 hardware prefetch is enabled (as it is in Linux)
2) instructions and data are fetched from the same or adjacent cache
lines.

The attached patch adds a workaround, by setting CPU_FTR_NEED_COHERENT
on all 745x processors.

The bug is 7447A errata #16, 7457 errata #26, 7455 errata #33, 7450
errata #69.

Signed-off-by: Adrian Cox <adrian@humboldt.co.uk>

- Adrian Cox
Humboldt Solutions Ltd.



--=-bHhE18tXgnOtKidU1h2l
Content-Description: 
Content-Disposition: inline; filename=coherent.patch
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit

===== arch/ppc/kernel/cputable.c 1.32 vs edited =====
--- 1.32/arch/ppc/kernel/cputable.c	Sat Jun 19 03:39:25 2004
+++ edited/arch/ppc/kernel/cputable.c	Sat Jul 31 16:51:34 2004
@@ -263,7 +263,7 @@
 	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450,
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
@@ -274,7 +274,7 @@
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_L3_DISABLE_NAP,
+	CPU_FTR_L3_DISABLE_NAP | CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
@@ -284,7 +284,8 @@
 	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR,
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
+	CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
@@ -294,7 +295,8 @@
 	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_HAS_HIGH_BATS,
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_HAS_HIGH_BATS |
+	CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
@@ -305,7 +307,7 @@
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_L3_DISABLE_NAP | CPU_FTR_HAS_HIGH_BATS,
+	CPU_FTR_L3_DISABLE_NAP | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
@@ -316,7 +318,7 @@
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_HAS_HIGH_BATS,
+	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
@@ -327,7 +329,7 @@
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_HAS_HIGH_BATS,
+	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
@@ -338,7 +340,7 @@
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_HAS_HIGH_BATS,
+	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x

--=-bHhE18tXgnOtKidU1h2l--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
