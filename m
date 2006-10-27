Return-Path: <afleming@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 93E5667D88
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Oct 2006 10:27:07 +1000 (EST)
Date: Fri, 27 Oct 2006 14:31:07 -0500 (CDT)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: [PATCH] Switch rmb() to use the LWSYNC macro, instead of hardcoding it
Message-ID: <Pine.LNX.4.61.0610271427270.16510@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Andrew Fleming <afleming@freescale.com>
---
e500 threw an illop when rmb() was called.  It apparently *doesn't* treat 
lwsync as an msync

 include/asm-powerpc/system.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-powerpc/system.h b/include/asm-powerpc/system.h
index 4362759..f7b1227 100644
--- a/include/asm-powerpc/system.h
+++ b/include/asm-powerpc/system.h
@@ -25,8 +25,8 @@ #include <asm/atomic.h>
  *
  * We have to use the sync instructions for mb(), since lwsync doesn't
  * order loads with respect to previous stores.  Lwsync is fine for
- * rmb(), though.  Note that lwsync is interpreted as sync by
- * 32-bit and older 64-bit CPUs.
+ * rmb(), though. Note that rmb() actually uses a sync on 32-bit
+ * architectures.
  *
  * For wmb(), we use sync since wmb is used in drivers to order
  * stores to system memory with respect to writes to the device.
@@ -34,7 +34,7 @@ #include <asm/atomic.h>
  * SMP since it is only used to order updates to system memory.
  */
 #define mb()   __asm__ __volatile__ ("sync" : : : "memory")
-#define rmb()  __asm__ __volatile__ ("lwsync" : : : "memory")
+#define rmb()  __asm__ __volatile__ (__stringify(LWSYNC) : : : "memory")
 #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define read_barrier_depends()  do { } while(0)
 
-- 
1.4.2.3
