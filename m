Message-ID: <3ED56579.80609@mvista.com>
Date: Wed, 28 May 2003 18:42:17 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: linuxppc_2_4_devel patch for ppc_htab.c (/proc/sys/kernel/l2cr)
Content-Type: multipart/mixed;
 boundary="------------090207030902050402090306"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------090207030902050402090306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds 745x support to /proc/sys/kernel/l2cr.

Mark
--

--------------090207030902050402090306
Content-Type: text/plain;
 name="l2cr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="l2cr.patch"

===== arch/ppc/kernel/ppc_htab.c 1.31 vs edited =====
--- 1.31/arch/ppc/kernel/ppc_htab.c	Thu Feb 27 12:40:15 2003
+++ edited/arch/ppc/kernel/ppc_htab.c	Wed May 28 17:41:45 2003
@@ -441,18 +441,18 @@
     }
 }

+#define TMPBUFLEN 512
 int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
 		  void *buffer, size_t *lenp)
 {
 	int vleft, first=1, len, left, val;
-	#define TMPBUFLEN 256
 	char buf[TMPBUFLEN], *p;
 	static const char *sizestrings[4] = {
 		"2MB", "256KB", "512KB", "1MB"
 	};
 	static const char *clockstrings[8] = {
-		"clock disabled", "+1 clock", "+1.5 clock", "reserved(3)",
-		"+2 clock", "+2.5 clock", "+3 clock", "reserved(7)"
+		"clock disabled", "+1 clock", "+1.5 clock", "+3.5 clock",
+		"+2 clock", "+2.5 clock", "+3 clock", "+4 clock"
 	};
 	static const char *typestrings[4] = {
 		"flow-through burst SRAM", "reserved SRAM",
@@ -508,21 +508,43 @@
 				*p++ = '\t';
 			val = _get_L2CR();
 			p += sprintf(p, "0x%08x: ", val);
-			p += sprintf(p, " %s", (val >> 31) & 1 ? "enabled" :
+			p += sprintf(p, " L2 %s", (val >> 31) & 1 ? "enabled" :
 				     	"disabled");
 			p += sprintf(p, ", %sparity", (val>>30)&1 ? "" : "no ");
-			p += sprintf(p, ", %s", sizestrings[(val >> 28) & 3]);
-			p += sprintf(p, ", %s", clockstrings[(val >> 25) & 7]);
-			p += sprintf(p, ", %s", typestrings[(val >> 23) & 2]);
-			p += sprintf(p, "%s", (val>>22)&1 ? ", data only" : "");
-			p += sprintf(p, "%s", (val>>20)&1 ? ", ZZ enabled": "");
-			p += sprintf(p, ", %s", (val>>19)&1 ? "write-through" :
-					"copy-back");
-			p += sprintf(p, "%s", (val>>18)&1 ? ", testing" : "");
-			p += sprintf(p, ", %sns hold",holdstrings[(val>>16)&3]);
-			p += sprintf(p, "%s", (val>>15)&1 ? ", DLL slow" : "");
-			p += sprintf(p, "%s", (val>>14)&1 ? ", diff clock" :"");
-			p += sprintf(p, "%s", (val>>13)&1 ? ", DLL bypass" :"");
+
+			/* 75x & 74x0 have different L2CR than 745x */
+			if (!(cur_cpu_spec[0]->cpu_features &
+						CPU_FTR_SPEC7450)) {
+				p += sprintf(p, ", %s",
+					sizestrings[(val >> 28) & 3]);
+				p += sprintf(p, ", %s",
+					clockstrings[(val >> 25) & 7]);
+				p += sprintf(p, ", %s",
+					typestrings[(val >> 23) & 3]);
+				p += sprintf(p, "%s", (val>>22)&1 ?
+					", data only" : "");
+				p += sprintf(p, "%s", (val>>20)&1 ?
+					", ZZ enabled": "");
+				p += sprintf(p, ", %s", (val>>19)&1 ?
+					"write-through" : "copy-back");
+				p += sprintf(p, "%s", (val>>18)&1 ?
+					", testing" : "");
+				p += sprintf(p, ", %sns hold",
+					holdstrings[(val>>16)&3]);
+				p += sprintf(p, "%s", (val>>15)&1 ?
+					", DLL slow" : "");
+				p += sprintf(p, "%s", (val>>14)&1 ?
+					", diff clock" :"");
+				p += sprintf(p, "%s", (val>>13)&1 ?
+					", DLL bypass" :"");
+			} else { /* 745x */
+				p += sprintf(p, ", %sinstn only", (val>>20)&1 ?
+					"" : "no ");
+				p += sprintf(p, ", %sdata only", (val>>16)&1 ?
+					"" : "no ");
+				p += sprintf(p, ", %s replacement",
+					(val>>12)&1 ?  "secondary" : "default");
+			}

 			p += sprintf(p,"\n");


--------------090207030902050402090306--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
