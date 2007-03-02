Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id A42DDDDF0A
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Mar 2007 11:33:06 +1100 (EST)
Date: Thu, 1 Mar 2007 17:09:30 -0700
From: Dave Jiang <djiang@mvista.com>
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: [patch 1/1] powerpc: ppc EDAC ECC software scrubber
Message-ID: <20070302000930.GA8426@blade.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: norsk5@yahoo.com, bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Implements the per arch atomic_scrub() function that EDAC uses for 
software ECC scrubbing. It scrubs 32bit chunks of memory by using the
PPC memory reservation instructions. It reads the memory location and
does a memory reservation. When it attempts to write back the same value
and thus "scrub" the memory, the operation fails if the memory is dirty.
It will continue to retry until it succeeds at "scrubbing".

Signed-off-by: Dave Jiang <djiang@mvista.com>

---

diff --git a/include/asm-powerpc/edac.h b/include/asm-powerpc/edac.h
new file mode 100644
index 0000000..0b7ac4d
--- /dev/null
+++ b/include/asm-powerpc/edac.h
@@ -0,0 +1,45 @@
+/*
+ * PPC EDAC common defs
+ *
+ * Author: Dave Jiang <djiang@mvista.com>
+ *
+ * (C) 2007 MontaVista Software
+ * This file may be distributed under the terms of the
+ * GNU General Public License Version 2.
+ */
+#ifndef ASM_EDAC_H
+#define ASM_EDAC_H
+/* ECC atomic, DMA, SMP and interrupt safe scrub function */
+
+/*
+ * This routine must provide a way to atomically read and then write
+ * back the value it reads to the same memory location in order to 
+ * "scrub" the memory. On x86 it is possible to do this in a single 
+ * instruction with the appropriate prefix. On PPC it is not possible
+ * because of the RISC instruction set. PPC instructions allow one to place 
+ * a reservation on the memory location during the read. And if the 
+ * location is dirtied by somebody else when the scrubber attempt the write, 
+ * the scrubber just have to try again.
+ */
+static __inline__ void atomic_scrub(void *va, u32 size)
+{
+    unsigned int *virt_addr = va;
+	unsigned int temp;
+    unsigned int i;
+
+    for (i = 0; i < size / 4; i++, virt_addr++) {
+        /* Very carefully read and write to memory atomically
+         * so we are interrupt, DMA and SMP safe.
+         */
+		__asm__ __volatile__ ("\n\
+				1:	lwarx	%0,0,%1\n\
+					stwcx.	%0,0,%1\n\
+					bne-	1b\n\
+					isync"
+					: "=&r"(temp)
+					: "r"(virt_addr)
+					: "cr0", "memory");
+	}
+}
+
+#endif
