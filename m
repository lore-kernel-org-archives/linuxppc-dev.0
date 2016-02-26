Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E1DA91A0035
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2016 05:41:01 +1100 (AEDT)
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EEDB2140307
 for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2016 05:41:00 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 11:40:58 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E67E019D804A
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:28:52 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u1QIeubd44499162
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:40:56 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1QIetbB016903
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:40:55 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH 01/14] powerpc: Add simple cache inhibited MMIO accessors
Date: Fri, 26 Feb 2016 12:40:19 -0600
Message-Id: <1456512032-31286-2-git-send-email-warrier@linux.vnet.ibm.com>
In-Reply-To: <1456512032-31286-1-git-send-email-warrier@linux.vnet.ibm.com>
References: <1456512032-31286-1-git-send-email-warrier@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add simple cache inhibited accessors for memory mapped I/O.
Unlike the accessors built from the DEF_MMIO_* macros, these
don't include any hardware memory barriers, callers need to
manage memory barriers on their own. These can only be called
in hypervisor mode.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/io.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 6c1297e..d329a01 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -241,6 +241,34 @@ static inline void out_be64(volatile u64 __iomem *addr, u64 val)
 #endif
 #endif /* __powerpc64__ */
 
+
+/*
+ * Simple Cache inhibited accessors
+ * Unlike the DEF_MMIO_* macros, these don't include any h/w memory
+ * barriers, callers need to manage memory barriers on their own.
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
1.8.3.4
