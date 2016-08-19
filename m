Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFsBv2kwQzDr8p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 15:36:07 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH 01/13] powerpc: Add simple cache inhibited MMIO accessors
Date: Fri, 19 Aug 2016 15:35:45 +1000
Message-Id: <1471584957-21484-2-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1471584957-21484-1-git-send-email-paulus@ozlabs.org>
References: <1471584957-21484-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Suresh Warrier <warrier@linux.vnet.ibm.com>

Add simple cache inhibited accessors for memory mapped I/O.
Unlike the accessors built from the DEF_MMIO_* macros, these
don't include any hardware memory barriers, callers need to
manage memory barriers on their own. These can only be called
in hypervisor real mode.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
[paulus@ozlabs.org - added line to comment]
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/io.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 2fd1690..f6fda84 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -241,6 +241,35 @@ static inline void out_be64(volatile u64 __iomem *addr, u64 val)
 #endif
 #endif /* __powerpc64__ */
 
+
+/*
+ * Simple Cache inhibited accessors
+ * Unlike the DEF_MMIO_* macros, these don't include any h/w memory
+ * barriers, callers need to manage memory barriers on their own.
+ * These can only be used in hypervisor real mode.
+ */
+
+static inline u32 _lwzcix(unsigned long addr)
+{
+	u32 ret;
+
+	__asm__ __volatile__("lwzcix %0,0, %1"
+			     : "=r" (ret) : "r" (addr) : "memory");
+	return ret;
+}
+
+static inline void _stbcix(u64 addr, u8 val)
+{
+	__asm__ __volatile__("stbcix %0,0,%1"
+		: : "r" (val), "r" (addr) : "memory");
+}
+
+static inline void _stwcix(u64 addr, u32 val)
+{
+	__asm__ __volatile__("stwcix %0,0,%1"
+		: : "r" (val), "r" (addr) : "memory");
+}
+
 /*
  * Low level IO stream instructions are defined out of line for now
  */
-- 
2.8.1
