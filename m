Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 82FB02C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 10:19:22 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/mpic: Disable preemption when calling
 mpic_processor_id()
Date: Thu, 26 Sep 2013 19:18:18 -0500
Message-ID: <1380241098-7561-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Otherwise, we get a debug traceback due to the use of
smp_processor_id() (or get_paca()) inside hard_smp_processor_id().
mpic_host_map() is just looking for a default CPU, so it doesn't matter
if we migrate after getting the CPU ID.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/mpic.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 1be54fa..bdcb858 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1088,8 +1088,14 @@ static int mpic_host_map(struct irq_domain *h, unsigned int virq,
 	 * is done here.
 	 */
 	if (!mpic_is_ipi(mpic, hw) && (mpic->flags & MPIC_NO_RESET)) {
+		int cpu;
+
+		preempt_disable();
+		cpu = mpic_processor_id(mpic);
+		preempt_enable();
+
 		mpic_set_vector(virq, hw);
-		mpic_set_destination(virq, mpic_processor_id(mpic));
+		mpic_set_destination(virq, cpu);
 		mpic_irq_set_priority(virq, 8);
 	}
 
-- 
1.8.1.2
