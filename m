Return-Path: <pc@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C9DB1A0CC3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Feb 2015 06:39:16 +1100 (AEDT)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Fri, 13 Feb 2015 12:39:14 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id A273619D804E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 12:30:20 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1DJdB7U19398772
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 12:39:11 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1DJckSS015324
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 12:38:46 -0700
Message-ID: <54DE52BC.3020303@us.ibm.com>
Date: Fri, 13 Feb 2015 13:38:36 -0600
From: Paul Clarke <pc@us.ibm.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: re-enable dynticks
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

implement arch_irq_work_has_interrupt() for powerpc

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

CC: Frederic Weisbecker <fweisbec@gmail.com>
CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Paul A. Clarke <pc@us.ibm.com>

diff --git a/arch/powerpc/include/asm/irq_work.h 
b/arch/powerpc/include/asm/irq_work.h
new file mode 100644
index 0000000..18365ec
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
+	return 1;
+}
+
+#endif /* _ASM_IRQ_WORK_H */

--
Regards,
Paul Clarke, IBM
