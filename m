Return-Path: <galak@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 9F9E467F6E
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2005 08:00:45 +1000 (EST)
Date: Tue, 16 Aug 2005 17:00:39 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0508161700050.5751@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: removed usage of <asm/segment.h> 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Made <asm/segment.h> a dummy include like it is in ppc64 and removed any
users if it in arch/ppc.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit f63ab7e926d6c5e96de501ec9eac7f28af188a65
tree adcc67a572ec8e4d1520a7a5493ea909028e76f9
parent d88b795bc4c4b59c29a98e2a551c2ad4d65901c5
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 16 Aug 2005 16:59:22 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 16 Aug 2005 16:59:22 -0500

 arch/ppc/kernel/temp.c         |    1 -
 arch/ppc/kernel/time.c         |    1 -
 arch/ppc/platforms/chrp_time.c |    1 -
 include/asm-ppc/segment.h      |    7 ++++++-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/ppc/kernel/temp.c b/arch/ppc/kernel/temp.c
--- a/arch/ppc/kernel/temp.c
+++ b/arch/ppc/kernel/temp.c
@@ -21,7 +21,6 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/reg.h>
 #include <asm/nvram.h>
diff --git a/arch/ppc/kernel/time.c b/arch/ppc/kernel/time.c
--- a/arch/ppc/kernel/time.c
+++ b/arch/ppc/kernel/time.c
@@ -58,7 +58,6 @@
 #include <linux/init.h>
 #include <linux/profile.h>
 
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/nvram.h>
 #include <asm/cache.h>
diff --git a/arch/ppc/platforms/chrp_time.c b/arch/ppc/platforms/chrp_time.c
--- a/arch/ppc/platforms/chrp_time.c
+++ b/arch/ppc/platforms/chrp_time.c
@@ -22,7 +22,6 @@
 #include <linux/init.h>
 #include <linux/bcd.h>
 
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/nvram.h>
 #include <asm/prom.h>
diff --git a/include/asm-ppc/segment.h b/include/asm-ppc/segment.h
--- a/include/asm-ppc/segment.h
+++ b/include/asm-ppc/segment.h
@@ -1 +1,6 @@
-#include <asm/uaccess.h>
+#ifndef __PPC_SEGMENT_H
+#define __PPC_SEGMENT_H
+
+/* Only here because we have some old header files that expect it.. */
+
+#endif /* __PPC_SEGMENT_H */
