Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 06 Nov 2006 18:05:54 +1100
Subject: [PATCH 22/27] s2io ppc64 fix for readq/writeq
In-Reply-To: <1162796738.274582.277491064706.qpush@grosgo>
Message-Id: <20061106070710.ACCF167E00@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ppc642io driver is redefining it's own readq/writeq based on
readl/writel when the platform doesn't provide native ones. However, it
currently does so by testing #ifndef readq. While that works for now, we
are about to change ppc64 to use inline functions rather that macros for
all those IO accessors which will break that test. This fixes it. I
don't have anything less ugly at hand unfortunately.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 drivers/net/s2io.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux-cell/drivers/net/s2io.h
===================================================================
--- linux-cell.orig/drivers/net/s2io.h	2006-10-13 17:23:49.000000000 +1000
+++ linux-cell/drivers/net/s2io.h	2006-11-06 13:19:32.000000000 +1100
@@ -862,8 +862,10 @@ struct s2io_nic {
 #define RESET_ERROR 1;
 #define CMD_ERROR   2;
 
-/*  OS related system calls */
-#ifndef readq
+/* OS related system calls. Note that ppc64 has readq defined as
+ * an inline, not a macro
+ */
+#if !defined(CONFIG_PPC64) && !defined(readq)
 static inline u64 readq(void __iomem *addr)
 {
 	u64 ret = 0;
@@ -875,7 +877,7 @@ static inline u64 readq(void __iomem *ad
 }
 #endif
 
-#ifndef writeq
+#if !defined(CONFIG_PPC64) && !defined(writeq)
 static inline void writeq(u64 val, void __iomem *addr)
 {
 	writel((u32) (val), addr);
