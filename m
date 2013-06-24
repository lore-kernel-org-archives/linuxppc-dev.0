Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/hw_brk: Fix clearing of extraneous IRQ
Date: Mon, 24 Jun 2013 15:47:23 +1000
Message-Id: <1372052843-19109-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1372052843-19109-1-git-send-email-mikey@neuling.org>
References: <1372052843-19109-1-git-send-email-mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In 9422de3 "powerpc: Hardware breakpoints rewrite to handle non DABR breakpoint
registers" we changed the way we mark extraneous irqs with this:

-	info->extraneous_interrupt = !((bp->attr.bp_addr <= dar) &&
-			(dar - bp->attr.bp_addr < bp->attr.bp_len));
+	if (!((bp->attr.bp_addr <= dar) &&
+	      (dar - bp->attr.bp_addr < bp->attr.bp_len)))
+		info->type |= HW_BRK_TYPE_EXTRANEOUS_IRQ;

Unfortunately this is bogus as it never clears extraneous IRQ if it's already
set.

This correctly clears extraneous IRQ before possibly setting it.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Reported-by: Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
---
 arch/powerpc/kernel/hw_breakpoint.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index a949bdf..1150ae7 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -250,6 +250,7 @@ int __kprobes hw_breakpoint_handler(struct die_args *args)
 	 * we still need to single-step the instruction, but we don't
 	 * generate an event.
 	 */
+	info->type &= ~HW_BRK_TYPE_EXTRANEOUS_IRQ;
 	if (!((bp->attr.bp_addr <= dar) &&
 	      (dar - bp->attr.bp_addr < bp->attr.bp_len)))
 		info->type |= HW_BRK_TYPE_EXTRANEOUS_IRQ;
-- 
1.7.10.4
