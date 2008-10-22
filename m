Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id 5337BDDE19
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 01:36:47 +1100 (EST)
Date: Wed, 22 Oct 2008 16:36:32 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: linux-ppc <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: XICS - fix getting the server number size
Message-ID: <20081022163632.2c67a53d@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Tim Chavez <tinytim@us.ibm.com>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


  The 'ibm,interrupt-server#-size' properties are not cpu nodes properties,
but rather live under the interrupt source controller nodes (compatible
ibm,ppc-xics).

  Therefore, this patch moves the detection of this property outside of
xics_update_irq_servers() and into xics_init_IRQ().

  Also this adds a check for mismatched sizes across the interrupt source
controller nodes. Not sure this is necessary as in this case the firmware
might be seriously busted.

Signed-off-by: Sebastien Dugue <sebastien.dugue@bull.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Milton Miller <miltonm@bga.com>
---
 arch/powerpc/platforms/pseries/xics.c |   28 ++++++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index e190477..75a289b 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -579,7 +579,7 @@ static void xics_update_irq_servers(void)
 	int i, j;
 	struct device_node *np;
 	u32 ilen;
-	const u32 *ireg, *isize;
+	const u32 *ireg;
 	u32 hcpuid;
 
 	/* Find the server numbers for the boot cpu. */
@@ -607,11 +607,6 @@ static void xics_update_irq_servers(void)
 		}
 	}
 
-	/* get the bit size of server numbers */
-	isize = of_get_property(np, "ibm,interrupt-server#-size", NULL);
-	if (isize)
-		interrupt_server_size = *isize;
-
 	of_node_put(np);
 }
 
@@ -682,6 +677,7 @@ void __init xics_init_IRQ(void)
 	struct device_node *np;
 	u32 indx = 0;
 	int found = 0;
+	const u32 *isize;
 
 	ppc64_boot_msg(0x20, "XICS Init");
 
@@ -701,6 +697,26 @@ void __init xics_init_IRQ(void)
 	if (found == 0)
 		return;
 
+	/* get the bit size of server numbers */
+	found = 0;
+
+	for_each_compatible_node(np, NULL, "ibm,ppc-xics") {
+		isize = of_get_property(np, "ibm,interrupt-server#-size", NULL);
+
+		if (!isize)
+			continue;
+
+		if (!found) {
+			interrupt_server_size = *isize;
+			found = 1;
+		} else if (*isize != interrupt_server_size) {
+			printk(KERN_WARNING "XICS: "
+			       "mismatched ibm,interrupt-server#-size\n");
+			interrupt_server_size = max(*isize,
+						    interrupt_server_size);
+		}
+	}
+
 	xics_update_irq_servers();
 	xics_init_host();
 
-- 
1.6.0.1.308.gede4c
