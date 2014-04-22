Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, hegdevasant@linux.vnet.ibm.com,
 stewart@linux.vnet.ibm.com
Subject: [PATCH 3/6] powerpc/powernv: Fix little endian issues with
 opal_do_notifier calls
Date: Tue, 22 Apr 2014 15:01:24 +1000
Message-Id: <1398142887-24109-3-git-send-email-anton@samba.org>
In-Reply-To: <1398142887-24109-1-git-send-email-anton@samba.org>
References: <1398142887-24109-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The bitmap in opal_poll_events and opal_handle_interrupt is
big endian, so we need to byteswap it on little endian builds.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/powernv/opal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 49d2f00..17cfc70 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -242,14 +242,14 @@ void opal_notifier_update_evt(uint64_t evt_mask,
 void opal_notifier_enable(void)
 {
 	int64_t rc;
-	uint64_t evt = 0;
+	__be64 evt = 0;
 
 	atomic_set(&opal_notifier_hold, 0);
 
 	/* Process pending events */
 	rc = opal_poll_events(&evt);
 	if (rc == OPAL_SUCCESS && evt)
-		opal_do_notifier(evt);
+		opal_do_notifier(be64_to_cpu(evt));
 }
 
 void opal_notifier_disable(void)
@@ -529,7 +529,7 @@ static irqreturn_t opal_interrupt(int irq, void *data)
 
 	opal_handle_interrupt(virq_to_hw(irq), &events);
 
-	opal_do_notifier(events);
+	opal_do_notifier(be64_to_cpu(events));
 
 	return IRQ_HANDLED;
 }
-- 
1.8.3.2
