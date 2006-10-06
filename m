Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 62CF767EB9
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Oct 2006 13:55:27 +1000 (EST)
Date: Fri, 6 Oct 2006 13:55:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] fix iseries/smp.c for irq breakage
Message-Id: <20061006135526.0c7cccc1.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/irq.c |    7 ++-----
 arch/powerpc/platforms/iseries/smp.c |    6 ++++--
 arch/powerpc/platforms/iseries/smp.h |    6 ++++++
 3 files changed, 12 insertions(+), 7 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/irq.c b/arch/powerpc/platforms/iseries/irq.c
index e324468..44c2456 100644
--- a/arch/powerpc/platforms/iseries/irq.c
+++ b/arch/powerpc/platforms/iseries/irq.c
@@ -43,10 +43,7 @@ #include <asm/iseries/it_lp_queue.h>
 #include "irq.h"
 #include "pci.h"
 #include "call_pci.h"
-
-#if defined(CONFIG_SMP)
-extern void iSeries_smp_message_recv(struct pt_regs *);
-#endif
+#include "smp.h"
 
 #ifdef CONFIG_PCI
 
@@ -315,7 +312,7 @@ unsigned int iSeries_get_irq(struct pt_r
 #ifdef CONFIG_SMP
 	if (get_lppaca()->int_dword.fields.ipi_cnt) {
 		get_lppaca()->int_dword.fields.ipi_cnt = 0;
-		iSeries_smp_message_recv(regs);
+		iSeries_smp_message_recv();
 	}
 #endif /* CONFIG_SMP */
 	if (hvlpevent_is_pending())
diff --git a/arch/powerpc/platforms/iseries/smp.c b/arch/powerpc/platforms/iseries/smp.c
index 2eb095e..aee5908 100644
--- a/arch/powerpc/platforms/iseries/smp.c
+++ b/arch/powerpc/platforms/iseries/smp.c
@@ -43,9 +43,11 @@ #include <asm/machdep.h>
 #include <asm/cputable.h>
 #include <asm/system.h>
 
+#include "smp.h"
+
 static unsigned long iSeries_smp_message[NR_CPUS];
 
-void iSeries_smp_message_recv(struct pt_regs *regs)
+void iSeries_smp_message_recv(void)
 {
 	int cpu = smp_processor_id();
 	int msg;
@@ -55,7 +57,7 @@ void iSeries_smp_message_recv(struct pt_
 
 	for (msg = 0; msg < 4; msg++)
 		if (test_and_clear_bit(msg, &iSeries_smp_message[cpu]))
-			smp_message_recv(msg, regs);
+			smp_message_recv(msg);
 }
 
 static inline void smp_iSeries_do_message(int cpu, int msg)
diff --git a/arch/powerpc/platforms/iseries/smp.h b/arch/powerpc/platforms/iseries/smp.h
new file mode 100644
index 0000000..d501f7d
--- /dev/null
+++ b/arch/powerpc/platforms/iseries/smp.h
@@ -0,0 +1,6 @@
+#ifndef _PLATFORMS_ISERIES_SMP_H
+#define _PLATFORMS_ISERIES_SMP_H
+
+extern void iSeries_smp_message_recv(void);
+
+#endif	/* _PLATFORMS_ISERIES_SMP_H */
-- 
1.4.2.1
