Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 18/63] powerpc: Fix some endian issues in xics code
Date: Wed,  7 Aug 2013 02:01:35 +1000
Message-Id: <1375804940-22050-19-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/sysdev/xics/xics-common.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 9049d9f..fe0cca4 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -49,7 +49,7 @@ void xics_update_irq_servers(void)
 	int i, j;
 	struct device_node *np;
 	u32 ilen;
-	const u32 *ireg;
+	const __be32 *ireg;
 	u32 hcpuid;
 
 	/* Find the server numbers for the boot cpu. */
@@ -75,8 +75,8 @@ void xics_update_irq_servers(void)
 	 * default distribution server
 	 */
 	for (j = 0; j < i; j += 2) {
-		if (ireg[j] == hcpuid) {
-			xics_default_distrib_server = ireg[j+1];
+		if (be32_to_cpu(ireg[j]) == hcpuid) {
+			xics_default_distrib_server = be32_to_cpu(ireg[j+1]);
 			break;
 		}
 	}
@@ -383,7 +383,7 @@ void __init xics_register_ics(struct ics *ics)
 static void __init xics_get_server_size(void)
 {
 	struct device_node *np;
-	const u32 *isize;
+	const __be32 *isize;
 
 	/* We fetch the interrupt server size from the first ICS node
 	 * we find if any
@@ -394,7 +394,7 @@ static void __init xics_get_server_size(void)
 	isize = of_get_property(np, "ibm,interrupt-server#-size", NULL);
 	if (!isize)
 		return;
-	xics_interrupt_server_size = *isize;
+	xics_interrupt_server_size = be32_to_cpu(*isize);
 	of_node_put(np);
 }
 
-- 
1.8.1.2
