Return-Path: <SRS0=lOLd=5O=de.ibm.com=abergman@srs.kundenserver.de>
Message-Id: <20060323203521.975925000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Date: Thu, 23 Mar 2006 00:00:07 +0100
From: Arnd Bergmann <abergman@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 07/13] powerpc: work around a cell interrupt HW bug
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Apparently we have found a bug in the CPU that causes
external interrupts to sometimes get disabled indefinitely.
This adds a workaround for the problem.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6.15.4/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linux-2.6.15.4.orig/arch/powerpc/platforms/cell/interrupt.c
+++ linux-2.6.15.4/arch/powerpc/platforms/cell/interrupt.c
@@ -63,7 +63,24 @@ static DEFINE_PER_CPU(struct iic, iic);
 
 void iic_local_enable(void)
 {
-	out_be64(&__get_cpu_var(iic).regs->prio, 0xff);
+	struct iic *iic = &__get_cpu_var(iic);
+	u64 tmp;
+
+	/*
+	 * There seems to be a bug that is present in DD2.x CPUs
+	 * and still only partially fixed in DD3.1.
+	 * This bug causes a value written to the priority register
+	 * not to make it there, resulting in a system hang unless we
+	 * write it again.
+	 * Masking with 0xf0 is done because the Cell BE does not
+	 * implement the lower four bits of the interrupt priority,
+	 * they always read back as zeroes, although future CPUs
+	 * might implement different bits.
+	 */
+	do {
+		out_be64(&iic->regs->prio, 0xff);
+		tmp = in_be64(&iic->regs->prio);
+	} while ((tmp & 0xf0) != 0xf0);
 }
 
 void iic_local_disable(void)

--
