Return-Path: <anton@samba.org>
Date: Thu, 27 Mar 2014 16:20:21 +1100
From: Anton Blanchard <anton@samba.org>
To: stewart@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 3/4] powerpc/powernv: Fix little endian issues with
 opal_do_notifier calls
Message-ID: <20140327162021.4510477c@kryten>
In-Reply-To: <20140327161849.791432d0@kryten>
References: <20140327161849.791432d0@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Index: b/arch/powerpc/platforms/powernv/opal.c
===================================================================
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -216,14 +216,14 @@ void opal_notifier_update_evt(uint64_t e
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
@@ -501,7 +501,7 @@ static irqreturn_t opal_interrupt(int ir
 
 	opal_handle_interrupt(virq_to_hw(irq), &events);
 
-	opal_do_notifier(events);
+	opal_do_notifier(be64_to_cpu(events));
 
 	return IRQ_HANDLED;
 }
