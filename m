Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id B4CA6DDF63
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Mar 2007 07:36:24 +1100 (EST)
Date: Fri, 2 Mar 2007 13:36:21 -0700
From: Dave Jiang <djiang@mvista.com>
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: Re: [patch 1/1] powerpc: ppc EDAC ECC software scrubber
Message-ID: <20070302203621.GA14737@blade.az.mvista.com>
References: <20070302000930.GA8426@blade.az.mvista.com>
	<20070302190220.GA9656@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20070302190220.GA9656@mvista.com>
Cc: norsk5@yahoo.com, dfarnsworth@mvista.com,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Resubmit of patch. Fixed whitespace issues.

---

Implements the per arch atomic_scrub() that EDAC use for software
ECC scrubbing.  It reads memory and then writes back the original
value, allowing the hardware to detect and correct memory errors.

Signed-off-by: Dave Jiang <djiang@mvista.com>
---

 include/asm-powerpc/edac.h |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/edac.h b/include/asm-powerpc/edac.h
new file mode 100644
index 0000000..384b37d
--- /dev/null
+++ b/include/asm-powerpc/edac.h
@@ -0,0 +1,40 @@
+/*
+ * PPC EDAC common defs
+ *
+ * Author: Dave Jiang <djiang@mvista.com>
+ *
+ * 2007 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef ASM_EDAC_H
+#define ASM_EDAC_H
+/* 
+ * ECC atomic, DMA, SMP and interrupt safe scrub function.
+ * Implements the per arch atomic_scrub() that EDAC use for software
+ * ECC scrubbing.  It reads memory and then writes back the original
+ * value, allowing the hardware to detect and correct memory errors.
+ */
+static __inline__ void atomic_scrub(void *va, u32 size)
+{
+	unsigned int *virt_addr = va;
+	unsigned int temp;
+	unsigned int i;
+
+	for (i = 0; i < size / sizeof(*virt_addr); i++, virt_addr++) {
+		/* Very carefully read and write to memory atomically
+		 * so we are interrupt, DMA and SMP safe.
+		 */
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
