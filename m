Return-Path: <Kyle.D.Moffett@boeing.com>
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 08/10] powerpc/mpic: Put "pic-no-reset" test back into the
 MPIC code
Date: Mon, 31 Oct 2011 17:10:09 -0400
Message-Id: <1320095411-20667-9-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <1320095411-20667-1-git-send-email-Kyle.D.Moffett@boeing.com>
References: <1320095411-20667-1-git-send-email-Kyle.D.Moffett@boeing.com>
Cc: devicetree-discuss@lists.ozlabs.org, Milton Miller <miltonm@bga.com>,
 Paul Mackerras <paulus@samba.org>, Kyle Moffett <Kyle.D.Moffett@boeing.com>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There's not really any reason to have this one-liner in a separate
static inline function, given that all the other similar tests are
already in the alloc_mpic() code.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/sysdev/mpic.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 0342ab8..8b4f022 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1120,11 +1120,6 @@ static struct irq_host_ops mpic_host_ops = {
 	.xlate = mpic_host_xlate,
 };
 
-static int mpic_reset_prohibited(struct device_node *node)
-{
-	return node && of_get_property(node, "pic-no-reset", NULL);
-}
-
 /*
  * Exported functions
  */
@@ -1269,7 +1264,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	/* When using a device-node, reset requests are only honored if the MPIC
 	 * is allowed to reset.
 	 */
-	if (mpic_reset_prohibited(node))
+	if (of_get_property(node, "pic-no-reset", NULL))
 		mpic->flags |= MPIC_NO_RESET;
 
 	if ((flags & MPIC_WANTS_RESET) && !(mpic->flags & MPIC_NO_RESET)) {
-- 
1.7.2.5
