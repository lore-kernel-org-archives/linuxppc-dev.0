Subject: /proc/sys/kernel/l2cr and the 750FX
From: "Guy M. Streeter" <streeter@redhat.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Content-Type: multipart/mixed; boundary="=-Y5txdtiSbH1mHbwZrc/A"
Message-Id: <1068824641.18764.7.camel@jarjar.hsv.redhat.com>
Mime-Version: 1.0
Date: 14 Nov 2003 09:44:01 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-Y5txdtiSbH1mHbwZrc/A
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

  In September I posted a version of this patch, which corrects the
formatted display of the L2CR register for 750FX processors.
Tom Rini suggested that it should use a cpu feature flag instead of the
processors version register, and also that the change might already have
been made in later kernel source.
  I have check all the 2.4.23+ and 2.6.0 source trees, and I don't see
any fix for this. I have changed the patch to use a feature flag instead
of checking the PVR. I would like to see this change considered for
inclusion.

thanks,
--Guy



--=-Y5txdtiSbH1mHbwZrc/A
Content-Disposition: attachment; filename=l2cr750fx.diff
Content-Type: text/plain; name=l2cr750fx.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- v2.4.22_linuxppc_2_4_devel-ac4-lolat/arch/ppc/kernel/cputable.c	2003-07-25 14:39:48.000000000 +0000
+++ ppmc750fx/arch/ppc/kernel/cputable.c	2003-10-27 22:40:46.000000000 +0000
@@ -167,7 +167,7 @@ struct cpu_spec	cpu_specs[] = {
     	0xffffff00, 0x70000100, "750FX",
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP |
-	CPU_FTR_DUAL_PLL_750FX | CPU_FTR_NO_DPM,
+	CPU_FTR_DUAL_PLL_750FX | CPU_FTR_NO_DPM | CPU_FTR_750FX_L2CR,
 	COMMON_PPC,
 	32, 32,
 	__setup_cpu_750
@@ -176,7 +176,8 @@ struct cpu_spec	cpu_specs[] = {
     	0xffffffff, 0x70000200, "750FX",
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP |
-	CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NO_DPM,
+	CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NO_DPM |
+	CPU_FTR_750FX_L2CR,
 	COMMON_PPC,
 	32, 32,
 	__setup_cpu_750
@@ -185,7 +186,7 @@ struct cpu_spec	cpu_specs[] = {
     	0xffff0000, 0x70000000, "750FX",
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP |
-	CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS,
+	CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_750FX_L2CR,
 	COMMON_PPC,
 	32, 32,
 	__setup_cpu_750fx
--- v2.4.22_linuxppc_2_4_devel-ac4-lolat/arch/ppc/kernel/ppc_htab.c	2003-07-25 14:11:21.000000000 +0000
+++ ppmc750fx/arch/ppc/kernel/ppc_htab.c	2003-10-27 22:44:02.000000000 +0000
@@ -503,40 +503,59 @@ int proc_dol2crvec(ctl_table *table, int
 			left -= len;
 			_set_L2CR(val);
 		} else {
+			int is750fx = cur_cpu_spec[0]->cpu_features & CPU_FTR_750FX_L2CR;
 			p = buf;
 			if (!first)
 				*p++ = '\t';
 			val = _get_L2CR();
 			p += sprintf(p, "0x%08x: ", val);
-			p += sprintf(p, " L2 %s", (val >> 31) & 1 ? "enabled" :
+			p += sprintf(p, " L2 %s, ", (val >> 31) & 1 ? "enabled" :
 				     	"disabled");
-			p += sprintf(p, ", %sparity", (val>>30)&1 ? "" : "no ");
+			if (!(val>>30&1))
+				p += sprintf(p, "no ");
+			if (is750fx)
+				p += sprintf(p, "ECC checkstop");
+			else
+				p += sprintf(p, "parity");

 			/* 75x & 74x0 have different L2CR than 745x */
 			if (!(cur_cpu_spec[0]->cpu_features &
 						CPU_FTR_SPEC7450)) {
-				p += sprintf(p, ", %s",
-					sizestrings[(val >> 28) & 3]);
-				p += sprintf(p, ", %s",
-					clockstrings[(val >> 25) & 7]);
-				p += sprintf(p, ", %s",
-					typestrings[(val >> 23) & 3]);
+				if (!is750fx) {
+					p += sprintf(p, ", %s",
+						     sizestrings[(val >> 28) & 3]);
+					p += sprintf(p, ", %s",
+						     clockstrings[(val >> 25) & 7]);
+					p += sprintf(p, ", %s",
+						     typestrings[(val >> 23) & 3]);
+				}
 				p += sprintf(p, "%s", (val>>22)&1 ?
-					", data only" : "");
-				p += sprintf(p, "%s", (val>>20)&1 ?
-					", ZZ enabled": "");
+					     ", data only" : "");
+				if (!is750fx) {
+					p += sprintf(p, "%s", (val>>20)&1 ?
+						     ", ZZ enabled": "");
+				}
 				p += sprintf(p, ", %s", (val>>19)&1 ?
 					"write-through" : "copy-back");
 				p += sprintf(p, "%s", (val>>18)&1 ?
 					", testing" : "");
-				p += sprintf(p, ", %sns hold",
-					holdstrings[(val>>16)&3]);
-				p += sprintf(p, "%s", (val>>15)&1 ?
-					", DLL slow" : "");
-				p += sprintf(p, "%s", (val>>14)&1 ?
-					", diff clock" :"");
-				p += sprintf(p, "%s", (val>>13)&1 ?
-					", DLL bypass" :"");
+				if (!is750fx) {
+					p += sprintf(p, ", %sns hold",
+						     holdstrings[(val>>16)&3]);
+					p += sprintf(p, "%s", (val>>15)&1 ?
+						     ", DLL slow" : "");
+					p += sprintf(p, "%s", (val>>14)&1 ?
+						     ", diff clock" :"");
+					p += sprintf(p, "%s", (val>>13)&1 ?
+						     ", DLL bypass" :"");
+				} else {
+					if ((val>>11)&1)
+						p += sprintf(p, ", lock way 0");
+					if ((val>>10)&1)
+						p += sprintf(p, ", lock way 1");
+					if ((val>>9)&1)
+						p += sprintf(p, ", Snoop Hit in Locked Line Error Enabled");
+				}
 			} else { /* 745x */
 				p += sprintf(p, ", %sinstn only", (val>>20)&1 ?
 					"" : "no ");
--- v2.4.22_linuxppc_2_4_devel-ac4-lolat/include/asm-ppc/cputable.h	2003-05-10 10:43:37.000000000 +0000
+++ ppmc750fx/include/asm-ppc/cputable.h	2003-10-27 22:40:38.000000000 +0000
@@ -75,6 +75,7 @@ extern struct cpu_spec		*cur_cpu_spec[];
 #define CPU_FTR_DUAL_PLL_750FX		0x00004000
 #define CPU_FTR_NO_DPM			0x00008000
 #define CPU_FTR_HAS_HIGH_BATS		0x00010000
+#define CPU_FTR_750FX_L2CR		0x00020000

 #ifdef __ASSEMBLY__


--=-Y5txdtiSbH1mHbwZrc/A--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
