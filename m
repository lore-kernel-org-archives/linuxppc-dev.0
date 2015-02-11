Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2CA351A0150
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 15:55:49 +1100 (AEDT)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 3/5 v2] powerpc/boot/wrapper: use the pseries wrapper for
 zImage.epapr
Message-Id: <1423630544.752933.250238755494.3.gpush@pablo>
In-Reply-To: <1423630544.752188.889982625387.1.gpush@pablo>
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

We'll likely be entering the zImage.epapr as BE, so include the pseries
implementation of _zimage_start, which adds the endian fixup magic.

Although the endian fixup won't work on Book III-E machines starting LE,
the current entry point doesn't support LE anyway, so we shouldn't be
breaking anything.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/boot/wrapper |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index ae0f88e..3f50c27 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -277,7 +277,7 @@ treeboot-iss4xx-mpic)
     platformo="$object/treeboot-iss4xx.o"
     ;;
 epapr)
-    platformo="$object/epapr.o $object/epapr-wrapper.o"
+    platformo="$object/pseries-head.o $object/epapr.o $object/epapr-wrapper.o"
     link_address='0x20000000'
     pie=-pie
     ;;
