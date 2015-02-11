Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47D0E1A057D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 15:55:49 +1100 (AEDT)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 1/5 v2] powerpc/boot/fdt: Use unsigned long for pointer casts
Message-Id: <1423630544.752188.889982625387.1.gpush@pablo>
To: linuxppc-dev@lists.ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 11 Feb 2015 12:55:44 +0800
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that the wrapper supports 64-bit builds, we see warnings when
attempting to cast pointers to int. Use unsigned long instead.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/boot/libfdt-wrapper.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/libfdt-wrapper.c b/arch/powerpc/boot/libfdt-wrapper.c
index bb8b9b3..535e8fd 100644
--- a/arch/powerpc/boot/libfdt-wrapper.c
+++ b/arch/powerpc/boot/libfdt-wrapper.c
@@ -44,12 +44,12 @@
 
 #define offset_devp(off)	\
 	({ \
-		int _offset = (off); \
+		unsigned long _offset = (off); \
 		check_err(_offset) ? NULL : (void *)(_offset+1); \
 	})
 
-#define devp_offset_find(devp)	(((int)(devp))-1)
-#define devp_offset(devp)	(devp ? ((int)(devp))-1 : 0)
+#define devp_offset_find(devp)	(((unsigned long)(devp))-1)
+#define devp_offset(devp)	(devp ? ((unsigned long)(devp))-1 : 0)
 
 static void *fdt;
 static void *buf; /* = NULL */
