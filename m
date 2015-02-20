Return-Path: <pc@us.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0DEA61A10A2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 04:13:38 +1100 (AEDT)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Fri, 20 Feb 2015 12:13:36 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 2CA096E8048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 12:05:26 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1KHDYmk28835972
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 17:13:34 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1KHDXPH004935
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 12:13:34 -0500
Message-ID: <54E76B3D.1010909@us.ibm.com>
Date: Fri, 20 Feb 2015 11:13:33 -0600
From: Paul Clarke <pc@us.ibm.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] powerpc: re-enable dynticks
References: <54DE52BC.3020303@us.ibm.com>
 <1424045319.3018.2.camel@ellerman.id.au>
In-Reply-To: <1424045319.3018.2.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


implement arch_irq_work_has_interrupt() for powerpc

(resending because I messed up the e-mail addresses)

Commit 9b01f5bf3 introduced a dependency on "IRQ work self-IPIs" for 
full dynamic ticks to be enabled, by expecting architectures to 
implement a suitable arch_irq_work_has_interrupt() routine.

Several arches have implemented this routine, including x86 (3010279f) 
and arm (09f6edd4), but powerpc was omitted.

This patch implements this routine for powerpc.

The symptom, at boot (on powerpc arch systems) with "nohz_full=<CPU 
list>" is displayed:
     NO_HZ: Can't run full dynticks because arch doesn't support irq 
work self-IPIs

after this patch:
     NO_HZ: Full dynticks CPUs: <CPU list>.

Tested against 3.19.

v2: changed "return 1" to "return true", per Michael Ellerman

CC: Frederic Weisbecker <fweisbec@gmail.com>
CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Paul A. Clarke <pc@us.ibm.com>

diff --git a/arch/powerpc/include/asm/irq_work.h 
b/arch/powerpc/include/asm/irq_work.h
new file mode 100644
index 0000000..99cc0aa
--- /dev/null
+++ b/arch/powerpc/include/asm/irq_work.h
@@ -0,0 +1,11 @@
+#ifndef _ASM_IRQ_WORK_H
+#define _ASM_IRQ_WORK_H
+
+#include <asm/processor.h>
+
+static inline bool arch_irq_work_has_interrupt(void)
+{
+    return true;
+}
+
+#endif /* _ASM_IRQ_WORK_H */
