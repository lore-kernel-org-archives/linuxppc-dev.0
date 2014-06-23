Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF3981A000E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 10:56:32 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 23 Jun 2014 10:56:26 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3758F2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 10:56:23 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5N0u6LV4194748
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 10:56:07 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5N0uM5e019698
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 10:56:22 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/kerenl: Enable EEH for IO accessors
Date: Mon, 23 Jun 2014 10:56:22 +1000
Message-Id: <1403484982-29100-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In arch/powerpc/kernel/iomap.c, lots of IO reading accessors missed
to check EEH error as Ben pointed. The patch fixes it.

For the writing accessors, we change the called functions only for
making them look similar to the reading counterparts.

Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/iomap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/iomap.c b/arch/powerpc/kernel/iomap.c
index b82227e..12e48d5 100644
--- a/arch/powerpc/kernel/iomap.c
+++ b/arch/powerpc/kernel/iomap.c
@@ -23,7 +23,7 @@ unsigned int ioread16(void __iomem *addr)
 }
 unsigned int ioread16be(void __iomem *addr)
 {
-	return in_be16(addr);
+	return readw_be(addr);
 }
 unsigned int ioread32(void __iomem *addr)
 {
@@ -31,7 +31,7 @@ unsigned int ioread32(void __iomem *addr)
 }
 unsigned int ioread32be(void __iomem *addr)
 {
-	return in_be32(addr);
+	return readl_be(addr);
 }
 EXPORT_SYMBOL(ioread8);
 EXPORT_SYMBOL(ioread16);
@@ -49,7 +49,7 @@ void iowrite16(u16 val, void __iomem *addr)
 }
 void iowrite16be(u16 val, void __iomem *addr)
 {
-	out_be16(addr, val);
+	writew_be(val, addr);
 }
 void iowrite32(u32 val, void __iomem *addr)
 {
@@ -57,7 +57,7 @@ void iowrite32(u32 val, void __iomem *addr)
 }
 void iowrite32be(u32 val, void __iomem *addr)
 {
-	out_be32(addr, val);
+	writel_be(val, addr);
 }
 EXPORT_SYMBOL(iowrite8);
 EXPORT_SYMBOL(iowrite16);
@@ -75,15 +75,15 @@ EXPORT_SYMBOL(iowrite32be);
  */
 void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
 {
-	_insb((u8 __iomem *) addr, dst, count);
+	readsb(addr, dst, count);
 }
 void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
 {
-	_insw_ns((u16 __iomem *) addr, dst, count);
+	readsw(addr, dst, count);
 }
 void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
 {
-	_insl_ns((u32 __iomem *) addr, dst, count);
+	readsl(addr, dst, count);
 }
 EXPORT_SYMBOL(ioread8_rep);
 EXPORT_SYMBOL(ioread16_rep);
@@ -91,15 +91,15 @@ EXPORT_SYMBOL(ioread32_rep);
 
 void iowrite8_rep(void __iomem *addr, const void *src, unsigned long count)
 {
-	_outsb((u8 __iomem *) addr, src, count);
+	writesb(addr, src, count);
 }
 void iowrite16_rep(void __iomem *addr, const void *src, unsigned long count)
 {
-	_outsw_ns((u16 __iomem *) addr, src, count);
+	writesw(addr, src, count);
 }
 void iowrite32_rep(void __iomem *addr, const void *src, unsigned long count)
 {
-	_outsl_ns((u32 __iomem *) addr, src, count);
+	writesl(addr, src, count);
 }
 EXPORT_SYMBOL(iowrite8_rep);
 EXPORT_SYMBOL(iowrite16_rep);
-- 
1.8.3.2
