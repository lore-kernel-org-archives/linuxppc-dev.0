Subject: /proc/sys/kernel/l2cr and the 750FX
From: "Guy M. Streeter" <streeter@redhat.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Content-Type: multipart/mixed; boundary="=-BMbIJBP2xYQkN5E+PZQa"
Message-Id: <1064506838.1037.11.camel@jarjar.hsv.redhat.com>
Mime-Version: 1.0
Date: 25 Sep 2003 11:20:39 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-BMbIJBP2xYQkN5E+PZQa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The 750FX has a different L2CR register layout than other processors.
The attached patch against 2.4.22 makes /proc/sys/kernel/l2cr show a
better decode of the register for the 750FX.

--Guy



--=-BMbIJBP2xYQkN5E+PZQa
Content-Disposition: attachment; filename=l2cr750fx.diff
Content-Type: text/plain; name=l2cr750fx.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- tmp/arch/ppc/kernel/ppc_htab.c	2003-07-25 09:11:21.000000000 -0500
+++ ppmc750fx/arch/ppc/kernel/ppc_htab.c	2003-09-24 11:21:47.000000000 -0500
@@ -503,40 +503,59 @@ int proc_dol2crvec(ctl_table *table, int
 			left -= len;
 			_set_L2CR(val);
 		} else {
+			int is750fx = PVR_VER(mfspr(PVR)) == PVR_VER(PVR_750FX);
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
--- tmp/include/asm-ppc/processor.h	2003-07-25 09:11:30.000000000 -0500
+++ ppmc750fx/include/asm-ppc/processor.h	2003-09-25 11:14:59.000000000 -0500
@@ -685,6 +685,7 @@
 #define	PVR_750		PVR_740
 #define	PVR_740P	0x10080000
 #define	PVR_750P	PVR_740P
+#define	PVR_750FX	0x70000000
 #define	PVR_7400	0x000C0000
 #define	PVR_7410	0x800C0000
 #define	PVR_7450	0x80000000

--=-BMbIJBP2xYQkN5E+PZQa--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
