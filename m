Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zCNDr5wgLzDqxy
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jan 2018 09:45:48 +1100 (AEDT)
Received: by mail-oi0-f66.google.com with SMTP id t78so2033980oie.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jan 2018 14:45:48 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: pseries: use irq_of_parse_and_map helper
Date: Thu,  4 Jan 2018 16:45:42 -0600
Message-Id: <20180104224542.15333-4-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of calling both of_irq_parse_one and irq_create_of_mapping, call
of_irq_parse_and_map instead which does the same thing. This gets us closer
to making the former 2 functions static.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/platforms/pseries/event_sources.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/event_sources.c b/arch/powerpc/platforms/pseries/event_sources.c
index 6eeb0d4bab61..b0d8c146fe7b 100644
--- a/arch/powerpc/platforms/pseries/event_sources.c
+++ b/arch/powerpc/platforms/pseries/event_sources.c
@@ -16,7 +16,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */

-#include <asm/prom.h>
+#include <linux/interrupt.h>
+#include <linux/of_irq.h>

 #include "pseries.h"

@@ -25,15 +26,11 @@ void request_event_sources_irqs(struct device_node *np,
 				const char *name)
 {
 	int i, index, count = 0;
-	struct of_phandle_args oirq;
 	unsigned int virqs[16];

 	/* First try to do a proper OF tree parsing */
-	for (index = 0; of_irq_parse_one(np, index, &oirq) == 0;
-	     index++) {
-		if (count > 15)
-			break;
-		virqs[count] = irq_create_of_mapping(&oirq);
+	for (index = 0; count < 16; index++) {
+		virqs[count] = irq_of_parse_and_map(np, index);
 		if (!virqs[count]) {
 			pr_err("event-sources: Unable to allocate "
 			       "interrupt number for %pOF\n",
--
2.14.1
