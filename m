Return-Path: <grant.likely@gmail.com>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 7C67567E63
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Oct 2006 03:15:43 +1000 (EST)
From: Grant Likely <grant.likely@gmail.com>
To: Nicolas DET <nd@bplan-gmbh.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [POWERPC] Cleanup pegasos i8259 not in device tree workaround.
Date: Fri, 27 Oct 2006 10:42:09 -0600
Message-Id: <116196732980-git-send-email-grant.likely@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Only make assumptions about i8259 presence if ppc_md.get_irq is not set.
Previous workaround only checked chrp_mpic value.

Nicolas, please verify that this patch fixes your mpc52xx pic problems.
Ben, I got tired of how often this question was being raised, so I just
wrote this patch; I've compiled, but cannot test it.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/platforms/chrp/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 49b8dab..a5466ed 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -451,7 +451,7 @@ static void __init chrp_find_8259(void)
 	 * we have a pegasos that claims to be chrp but doesn't have
 	 * a proper interrupt tree
 	 */
-	if (pic == NULL && chrp_mpic != NULL) {
+	if (pic == NULL && ppc_md.get_irq != NULL) {
 		printk(KERN_ERR "i8259: Not found in device-tree"
 		       " assuming no legacy interrupts\n");
 		return;
-- 
1.4.3.rc2.g0503
