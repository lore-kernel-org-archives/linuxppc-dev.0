Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E377EDDE0F
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 10:15:05 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m490ExUL000989
	for <linuxppc-dev@ozlabs.org>; Thu, 8 May 2008 19:15:00 -0500
Subject: lsprop patch for little endian
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 09 May 2008 10:14:58 +1000
Message-Id: <1210292098.1421.93.camel@pasglop>
Mime-Version: 1.0
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm not sure who packages that, I think it's in powerpc-utils, anyway,
here's a patch that makes it work on device-tree tarballs lsprop'ed from
a LE machine.

--- /home/benh/grabbag/powerpc-utils-1.1.3/lsprop.c	2007-05-11 14:21:23.000000000 +1000
+++ lsprop.c	2008-05-09 10:13:49.000000000 +1000
@@ -7,10 +7,22 @@
  */
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <dirent.h>
+#include <endian.h>
+#include <byteswap.h>
+
+static inline unsigned int dt_swap_int(unsigned int data)
+{
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	return bswap_32(data);
+#else
+	return data;
+#endif
+}
 
 int recurse;
 int maxbytes = 128;
@@ -170,7 +182,7 @@
     } else if ((n & 3) == 0) {
 	nw = n >> 2;
 	if (nw == 1) {
-	    i = *(int *)buf;
+	    i = dt_swap_int(*(int *)buf);
 	    printf(" %.8x", i);
 	    if (i > -0x10000 && !(i >= 0 && i <= 9))
 		printf(" (%d)", i);
@@ -185,7 +197,7 @@
 		if (i != 0)
 		    printf("\n\t\t");
 		for (j = 0; j < npl && i + j < nw; ++j)
-		    printf(" %.8x", ((unsigned int *)buf)[i+j]);
+		    printf(" %.8x", dt_swap_int(((unsigned int *)buf)[i+j]));
 	    }
 	}
     } else {
