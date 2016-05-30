Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJ5zs0RgMzDqZ2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 16:19:05 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id gp3so13599640pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 May 2016 23:19:04 -0700 (PDT)
From: Rashmica Gupta <rashmicy@gmail.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 nfont@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/5] powerpc/pseries: Remove MPIC from pseries event sources
Date: Mon, 30 May 2016 16:18:15 +1000
Message-Id: <1464589095-442-5-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1464589095-442-1-git-send-email-rashmicy@gmail.com>
References: <1464589095-442-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPIC was only used by Power3 which is now unsupported, so remove MPIC
code. XICS is now the only supported interrupt controller for
pSeries so do some cleanups too.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 arch/powerpc/platforms/pseries/event_sources.c | 53 +++++++-------------------
 1 file changed, 13 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/event_sources.c b/arch/powerpc/platforms/pseries/event_sources.c
index 18380e8f6dfe..a6ddca833119 100644
--- a/arch/powerpc/platforms/pseries/event_sources.c
+++ b/arch/powerpc/platforms/pseries/event_sources.c
@@ -26,48 +26,21 @@ void request_event_sources_irqs(struct device_node *np,
 {
 	int i, index, count = 0;
 	struct of_phandle_args oirq;
-	const u32 *opicprop;
-	unsigned int opicplen;
 	unsigned int virqs[16];
 
-	/* Check for obsolete "open-pic-interrupt" property. If present, then
-	 * map those interrupts using the default interrupt host and default
-	 * trigger
-	 */
-	opicprop = of_get_property(np, "open-pic-interrupt", &opicplen);
-	if (opicprop) {
-		opicplen /= sizeof(u32);
-		for (i = 0; i < opicplen; i++) {
-			if (count > 15)
-				break;
-			virqs[count] = irq_create_mapping(NULL, *(opicprop++));
-			if (virqs[count] == NO_IRQ) {
-				pr_err("event-sources: Unable to allocate "
-				       "interrupt number for %s\n",
-				       np->full_name);
-				WARN_ON(1);
-			}
-			else
-				count++;
-
-		}
-	}
-	/* Else use normal interrupt tree parsing */
-	else {
-		/* First try to do a proper OF tree parsing */
-		for (index = 0; of_irq_parse_one(np, index, &oirq) == 0;
-		     index++) {
-			if (count > 15)
-				break;
-			virqs[count] = irq_create_of_mapping(&oirq);
-			if (virqs[count] == NO_IRQ) {
-				pr_err("event-sources: Unable to allocate "
-				       "interrupt number for %s\n",
-				       np->full_name);
-				WARN_ON(1);
-			}
-			else
-				count++;
+	/* First try to do a proper OF tree parsing */
+	for (index = 0; of_irq_parse_one(np, index, &oirq) == 0;
+	     index++) {
+		if (count > 15)
+			break;
+		virqs[count] = irq_create_of_mapping(&oirq);
+		if (virqs[count] == NO_IRQ) {
+			pr_err("event-sources: Unable to allocate "
+			       "interrupt number for %s\n",
+			       np->full_name);
+			WARN_ON(1);
+		} else {
+			count++;
 		}
 	}
 
-- 
2.5.0
