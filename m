Return-Path: <paul.gortmaker@windriver.com>
Received: from yow-pgortmak-d1.corp.ad.wrs.com (unknown [209.5.119.169])
	by ozlabs.org (Postfix) with ESMTP id 9E13BDDECA
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 09:03:59 +1100 (EST)
Date: Thu, 17 Jan 2008 17:03:58 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/7] powerpc: allow localbus compatible serial ports
	for console device
Message-ID: <20080117220357.GC4122@windriver.com>
References: <11997159321859-git-send-email-paul.gortmaker@windriver.com>
	<200801071533.47018.arnd@arndb.de> <47824641.8090208@windriver.com>
	<200801071704.23151.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200801071704.23151.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message: Re: [PATCH 2/7] powerpc: allow localbus compatible serial ports for console device
on 07/01/2008 Arnd Bergmann wrote:

> On Monday 07 January 2008, Paul Gortmaker wrote:
> > 
> > I'd thought about doing that, but there are slight differences
> > in each test.  To remain 100% faithful to the original implementation
> > you'd have to have a table or similar that had these various fields
> > and loop over that -- something like:
> > 
> > compat      parent   pnt-compat  pnt-type   add-fcn
> > ---------------------------------------------------------------
> > ns16550     NULL     NULL        soc        add_legacy_soc_port
> > NULL        isa      NULL        NULL       add_legacy_isa_port
> > ns16550     NULL     NULL        tsi-bridge add_legacy_soc_port
> > ns16550     NULL     ibm,opb     opb        add_legacy_soc_port
> > ns16550     NULL     localbus    NULL       add_legacy_soc_port
> > 
> > But, if we were willing to move away from checks based on
> > the parent->type and stick with parent->compat, then the
> > unification would be a lot cleaner and easier to implement.
> 
> Unfortunately, some of our cell blades don't have the right
> 'compatible' property, so you still need to check the type for
> the opb case.
> 
> > (we could also leave the ISA one out as an oddball, and then
> > not have to carry an add-fcn either).
> 
> yes, that seems reasonable.

Have a look at this and see if it seems OK to you. It collapses the soc,
tsi-bridge, opb and localbus code blocks into one.  The patch is layered
on my previous patch that did the for_each cleanup on the np's but if folks
are OK with the general implementation, I'll spin an equivalent patch
for direct application to the origin/for-2.6.25 branch with signed off etc.

Thanks,
Paul.

---

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index d0b8e35..16a4ef1 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -31,6 +31,21 @@ static struct legacy_serial_info {
 	int				irq_check_parent;
 	phys_addr_t			taddr;
 } legacy_serial_infos[MAX_LEGACY_SERIAL_PORTS];
+
+struct serial_parent {
+	char *type;
+	char *compat;
+};
+
+static struct __init serial_parent parents[] = {
+	{"soc", NULL},
+	{"tsi-bridge", NULL},
+	{"opb", "ibm,opb"},
+	{NULL, "wrs,epld-localbus"},
+};
+
+#define NUM_PARENTS sizeof(parents)/sizeof(struct serial_parent)
+
 static unsigned int legacy_serial_count;
 static int legacy_serial_console = -1;
 
@@ -292,6 +307,7 @@ void __init find_legacy_serial_ports(void)
 {
 	struct device_node *np, *stdout = NULL;
 	const char *path;
+	struct serial_parent *sp, *end = parents + NUM_PARENTS;
 	int index;
 
 	DBG(" -> find_legacy_serial_port()\n");
@@ -306,15 +322,24 @@ void __init find_legacy_serial_ports(void)
 		DBG(" no linux,stdout-path !\n");
 	}
 
-	/* First fill our array with SOC ports */
-	for_each_compatible_node(np, "serial", "ns16550") {
-		struct device_node *soc = of_get_parent(np);
-		if (soc && !strcmp(soc->type, "soc")) {
-			index = add_legacy_soc_port(np, np);
-			if (index >= 0 && np == stdout)
-				legacy_serial_console = index;
+	for (sp = parents; sp != end; sp++) {
+		for_each_compatible_node(np, "serial", "ns16550") {
+			struct device_node *parent = of_get_parent(np);
+			int p_type_ok = 0, p_is_compat = 0;
+			if (!parent)
+				continue;
+			if (sp->type && !strcmp(parent->type, sp->type))
+				p_type_ok = 1;
+			if (sp->compat && of_device_is_compatible(parent, sp->compat))
+				p_is_compat = 1;
+			if (p_type_ok || p_is_compat) {
+				index = add_legacy_soc_port(np, np);
+				if (index >= 0 && np == stdout)
+					legacy_serial_console = index;
+			}
+			of_node_put(parent);
 		}
-		of_node_put(soc);
+		
 	}
 
 	/* Next, fill our array with ISA ports */
@@ -328,40 +353,6 @@ void __init find_legacy_serial_ports(void)
 		of_node_put(isa);
 	}
 
-	/* Next, fill our array with tsi-bridge ports */
-	for_each_compatible_node(np, "serial", "ns16550") {
-		struct device_node *tsi = of_get_parent(np);
-		if (tsi && !strcmp(tsi->type, "tsi-bridge")) {
-			index = add_legacy_soc_port(np, np);
-			if (index >= 0 && np == stdout)
-				legacy_serial_console = index;
-		}
-		of_node_put(tsi);
-	}
-
-	/* Next, fill our array with opb bus ports */
-	for_each_compatible_node(np, "serial", "ns16550") {
-		struct device_node *opb = of_get_parent(np);
-		if (opb && (!strcmp(opb->type, "opb") ||
-			    of_device_is_compatible(opb, "ibm,opb"))) {
-			index = add_legacy_soc_port(np, np);
-			if (index >= 0 && np == stdout)
-				legacy_serial_console = index;
-		}
-		of_node_put(opb);
-	}
-
-	/* Next, fill our array with any localbus serial ports */
-	for_each_compatible_node(np, "serial", "ns16550") {
-		struct device_node *lbs = of_get_parent(np);
-		if (lbs && of_device_is_compatible(lbs, "localbus")) {
-			index = add_legacy_soc_port(np, np);
-			if (index >= 0 && np == stdout)
-				legacy_serial_console = index;
-		}
-		of_node_put(lbs);
-	}
-
 #ifdef CONFIG_PCI
 	/* Next, try to locate PCI ports */
 	for (np = NULL; (np = of_find_all_nodes(np));) {
