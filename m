Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <9ced345827498aa8d2061be5b94297810d945aa4.1302856271.git.michael@ellerman.id.au>
In-Reply-To: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
Subject: [PATCH 05/15] powerpc/xics: Move irq_host matching into the ics
	backend
Date: Fri, 15 Apr 2011 18:31:59 +1000 (EST)
From: michael@ozlabs.org (Michael Ellerman)
Cc: Jimi Xenidis <jimix@watson.ibm.com>, jack@codezen.org, imunsie@au.ibm.com,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>

An upcoming new ics backend will need to implement different matching
semantics to the current ones, which are essentially the RTAS ics
backends. So move the current match into the RTAS backend, and allow
other ics backends to override.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/xics.h        |    1 +
 arch/powerpc/sysdev/xics/ics-rtas.c    |   11 +++++++++++
 arch/powerpc/sysdev/xics/xics-common.c |   12 +++++++-----
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/xics.h b/arch/powerpc/include/asm/xics.h
index c4ed4c5..6c06306 100644
--- a/arch/powerpc/include/asm/xics.h
+++ b/arch/powerpc/include/asm/xics.h
@@ -59,6 +59,7 @@ struct ics {
 	int (*map)(struct ics *ics, unsigned int virq);
 	void (*mask_unknown)(struct ics *ics, unsigned long vec);
 	long (*get_server)(struct ics *ics, unsigned long vec);
+	int (*host_match)(struct ics *ics, struct device_node *node);
 	char data[];
 };
 
diff --git a/arch/powerpc/sysdev/xics/ics-rtas.c b/arch/powerpc/sysdev/xics/ics-rtas.c
index ff76268..dd713b0 100644
--- a/arch/powerpc/sysdev/xics/ics-rtas.c
+++ b/arch/powerpc/sysdev/xics/ics-rtas.c
@@ -26,12 +26,14 @@ static int ibm_int_off;
 static int ics_rtas_map(struct ics *ics, unsigned int virq);
 static void ics_rtas_mask_unknown(struct ics *ics, unsigned long vec);
 static long ics_rtas_get_server(struct ics *ics, unsigned long vec);
+static int ics_rtas_host_match(struct ics *ics, struct device_node *node);
 
 /* Only one global & state struct ics */
 static struct ics ics_rtas = {
 	.map		= ics_rtas_map,
 	.mask_unknown	= ics_rtas_mask_unknown,
 	.get_server	= ics_rtas_get_server,
+	.host_match	= ics_rtas_host_match,
 };
 
 static void ics_rtas_unmask_irq(struct irq_data *d)
@@ -202,6 +204,15 @@ static long ics_rtas_get_server(struct ics *ics, unsigned long vec)
 	return status[0];
 }
 
+static int ics_rtas_host_match(struct ics *ics, struct device_node *node)
+{
+	/* IBM machines have interrupt parents of various funky types for things
+	 * like vdevices, events, etc... The trick we use here is to match
+	 * everything here except the legacy 8259 which is compatible "chrp,iic"
+	 */
+	return !of_device_is_compatible(node, "chrp,iic");
+}
+
 int ics_rtas_init(void)
 {
 	ibm_get_xive = rtas_token("ibm,get-xive");
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 7c9cba3..dd7579a 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -331,11 +331,13 @@ int xics_get_irq_server(unsigned int virq, const struct cpumask *cpumask,
 
 static int xics_host_match(struct irq_host *h, struct device_node *node)
 {
-	/* IBM machines have interrupt parents of various funky types for things
-	 * like vdevices, events, etc... The trick we use here is to match
-	 * everything here except the legacy 8259 which is compatible "chrp,iic"
-	 */
-	return !of_device_is_compatible(node, "chrp,iic");
+	struct ics *ics;
+
+	list_for_each_entry(ics, &ics_list, link)
+		if (ics->host_match(ics, node))
+			return 1;
+
+	return 0;
 }
 
 /* Dummies */
-- 
1.7.1
