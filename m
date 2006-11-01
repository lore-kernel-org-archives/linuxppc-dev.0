Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id DFFC967BFF
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Nov 2006 19:40:22 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: Sylvain Munaut <tnt@246tnt.com>, linuxppc-embedded@ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] [POWERPC] Cleanup pegasos i8259 not in device tree workaround.
Date: Wed,  1 Nov 2006 01:39:52 -0700
Message-Id: <11623704071131-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11623704063907-git-send-email-grant.likely@secretlab.ca>
References: <11623703962380-git-send-email-grant.likely@secretlab.ca>
	<11623704061869-git-send-email-grant.likely@secretlab.ca>
	<11623704063907-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Only make assumptions about i8259 presence if ppc_md.get_irq is not set.
Previous workaround only checked chrp_mpic value.

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
