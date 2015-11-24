Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44B941A0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 10:16:50 +1100 (AEDT)
Received: by pacej9 with SMTP id ej9so36307155pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 15:16:48 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: jwboyer@linux.vnet.ibm.com
Subject: [PATCH] powerpc: Fix xmon ml command to work with 64 bit values.
Date: Wed, 25 Nov 2015 10:16:33 +1100
Message-Id: <1448406993-7888-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ml command in xmon currently only works for 32-bit values and so fails
to find 64-bit values on a ppc64 machine. So change to work for 64-bit
values.

This is based off a patch by Josh Boyer.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---

Based off this patch: http://patchwork.ozlabs.org/patch/90309/

 arch/powerpc/xmon/xmon.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 786bf01691c9..df05bd2fca07 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -184,6 +184,12 @@ extern void xmon_leave(void);
 #define GETWORD(v)	(((v)[0] << 24) + ((v)[1] << 16) + ((v)[2] << 8) + (v)[3])
 #endif
 
+#if BITS_PER_LONG == 64
+#define GETLONG(v)	(((unsigned long) GETWORD(v)) << 32 | GETWORD(v+4))
+#else
+#define GETLONG(v)	GETWORD(v)
+#endif
+
 static char *help_string = "\
 Commands:\n\
   b	show breakpoints\n\
@@ -2447,14 +2453,15 @@ memdiffs(unsigned char *p1, unsigned char *p2, unsigned nb, unsigned maxpr)
 		printf("Total of %d differences\n", prt);
 }
 
-static unsigned mend;
-static unsigned mask;
+static unsigned long mend;
+static unsigned long mask;
 
 static void
 memlocate(void)
 {
-	unsigned a, n;
-	unsigned char val[4];
+	unsigned long a, n;
+	int size = sizeof(unsigned long);
+	unsigned char val[size];
 
 	last_cmd = "ml";
 	scanhex((void *)&mdest);
@@ -2470,10 +2477,10 @@ memlocate(void)
 		}
 	}
 	n = 0;
-	for (a = mdest; a < mend; a += 4) {
-		if (mread(a, val, 4) == 4
-			&& ((GETWORD(val) ^ mval) & mask) == 0) {
-			printf("%.16x:  %.16x\n", a, GETWORD(val));
+	for (a = mdest; a < mend; a += size) {
+		if (mread(a, val, size) == size
+			&& ((GETLONG(val) ^ mval) & mask) == 0){
+			printf("%.16lx:  %.16lx\n", a, GETLONG(val));
 			if (++n >= 10)
 				break;
 		}
-- 
2.5.0
