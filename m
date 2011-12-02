Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id 28747100955
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2011 03:29:17 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 08/10] powerpc/mpic: Put "pic-no-reset" test back into the
 MPIC code
Date: Fri,  2 Dec 2011 11:28:05 -0500
Message-Id: <1322843287-2745-9-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <1322795058.3729.48.camel@pasglop>
References: <1322795058.3729.48.camel@pasglop>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <michaele@au1.ibm.com>,
 Kyle Moffett <Kyle.D.Moffett@boeing.com>
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
index 1e7584b..3240bba 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1118,11 +1118,6 @@ static struct irq_host_ops mpic_host_ops = {
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
@@ -1272,7 +1267,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	/* When using a device-node, reset requests are only honored if the MPIC
 	 * is allowed to reset.
 	 */
-	if (mpic_reset_prohibited(node))
+	if (of_get_property(node, "pic-no-reset", NULL))
 		mpic->flags |= MPIC_NO_RESET;
 
 	if ((flags & MPIC_WANTS_RESET) && !(mpic->flags & MPIC_NO_RESET)) {
-- 
1.7.2.5
