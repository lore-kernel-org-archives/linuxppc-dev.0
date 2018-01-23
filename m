Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQfCT1x48zDr0b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 17:53:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: pseries: use irq_of_parse_and_map helper
In-Reply-To: <20180104224542.15333-4-robh@kernel.org>
References: <20180104224542.15333-4-robh@kernel.org>
Date: Tue, 23 Jan 2018 17:53:37 +1100
Message-ID: <878tcpoyku.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rob Herring <robh@kernel.org> writes:

> Instead of calling both of_irq_parse_one and irq_create_of_mapping, call
> of_irq_parse_and_map instead which does the same thing. This gets us closer
> to making the former 2 functions static.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/powerpc/platforms/pseries/event_sources.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Sorry NAK, this doesn't boot.

> diff --git a/arch/powerpc/platforms/pseries/event_sources.c b/arch/powerpc/platforms/pseries/event_sources.c
> index 6eeb0d4bab61..b0d8c146fe7b 100644
> --- a/arch/powerpc/platforms/pseries/event_sources.c
> +++ b/arch/powerpc/platforms/pseries/event_sources.c
> @@ -16,7 +16,8 @@
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
>   */
>
> -#include <asm/prom.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_irq.h>
>
>  #include "pseries.h"
>
> @@ -25,15 +26,11 @@ void request_event_sources_irqs(struct device_node *np,
>  				const char *name)
>  {
>  	int i, index, count = 0;
> -	struct of_phandle_args oirq;
>  	unsigned int virqs[16];
>
>  	/* First try to do a proper OF tree parsing */
> -	for (index = 0; of_irq_parse_one(np, index, &oirq) == 0;
> -	     index++) {
> -		if (count > 15)
> -			break;
> -		virqs[count] = irq_create_of_mapping(&oirq);
> +	for (index = 0; count < 16; index++) {
> +		virqs[count] = irq_of_parse_and_map(np, index);
>  		if (!virqs[count]) {
>  			pr_err("event-sources: Unable to allocate "
>  			       "interrupt number for %pOF\n",

                               np);
                        WARN_ON(1);
                } else {
                        count++;
                }
        }


Which is an infinite loop if we have less than 16 irqs, and spews the
warning continuously.

Are you trying to remove the low-level routines or is this just a
cleanup?

The patch below works, it loses the error handling if the interrupts
property is corrupt/empty, but that's probably overly paranoid anyway.

cheers

diff --git a/arch/powerpc/platforms/pseries/event_sources.c b/arch/powerpc/platforms/pseries/event_sources.c
index 6eeb0d4bab61..25c38077c894 100644
--- a/arch/powerpc/platforms/pseries/event_sources.c
+++ b/arch/powerpc/platforms/pseries/event_sources.c
@@ -16,7 +16,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-#include <asm/prom.h>
+#include <linux/interrupt.h>
+#include <linux/of_irq.h>
 
 #include "pseries.h"
 
@@ -24,34 +25,16 @@ void request_event_sources_irqs(struct device_node *np,
 				irq_handler_t handler,
 				const char *name)
 {
-	int i, index, count = 0;
-	struct of_phandle_args oirq;
-	unsigned int virqs[16];
+	unsigned int virq;
+	int i, rc;
 
-	/* First try to do a proper OF tree parsing */
-	for (index = 0; of_irq_parse_one(np, index, &oirq) == 0;
-	     index++) {
-		if (count > 15)
+	for (i = 0; i < 16; i++) {
+		virq = irq_of_parse_and_map(np, i);
+		if (!virq)
 			break;
-		virqs[count] = irq_create_of_mapping(&oirq);
-		if (!virqs[count]) {
-			pr_err("event-sources: Unable to allocate "
-			       "interrupt number for %pOF\n",
-			       np);
-			WARN_ON(1);
-		} else {
-			count++;
-		}
-	}
 
-	/* Now request them */
-	for (i = 0; i < count; i++) {
-		if (request_irq(virqs[i], handler, 0, name, NULL)) {
-			pr_err("event-sources: Unable to request interrupt "
-			       "%d for %pOF\n", virqs[i], np);
-			WARN_ON(1);
-			return;
-		}
+		rc = request_irq(virq, handler, 0, name, NULL);
+		WARN(rc, "event-sources: Unable to request interrupt %d for %pOF\n",
+		     virq, np);
 	}
 }
-
