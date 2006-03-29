Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (unknown [213.151.39.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C82D1679F7
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 23:36:54 +1100 (EST)
Received: from [131.234.74.199] (helo=dhcp-74-199.uni-paderborn.de)
	by sipsolutions.net with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.60) (envelope-from <johannes@sipsolutions.net>)
	id 1FOZz8-0006qT-4O
	for linuxppc-dev@ozlabs.org; Wed, 29 Mar 2006 13:41:14 +0100
Subject: [PATCH] PowerMac11,2 i2c-bus@0 duplicate dev-tree workaround
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 29 Mar 2006 13:30:15 +0200
Message-Id: <1143631816.9481.5.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On a PowerMac11,2, there are two i2c-bus@0 nodes of which only the first
is correct. This patch makes the device tree unflattening code ignore
the second one on those machines.

Signed-Off-By: Johannes Berg <johannes@sipsolutions.net>

--- 
I'm not sure this is the right way to do it. Maybe we should have some
'dev-tree quirks fixer' that makes a third pass through the device tree
after the allnodes chain has been set up, and fixes it up. On the other
hand, as long as there aren't too many workarounds, this works fine.

The patch looks longer than it is because some code changed indentation
level.

--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -624,6 +624,11 @@ static void *__init unflatten_dt_alloc(u
 	return res;
 }
 
+/* PowerMac11,2 has a bug in the device tree where
+ * an i2c-bus@0 shows up twice. We ignore the second
+ * one since it is the bogus one */
+static __initdata int powermac_i2c_bus_0_workaround = 0;
+
 static unsigned long __init unflatten_dt_node(unsigned long mem,
 					      unsigned long *p,
 					      struct device_node *dad,
@@ -695,17 +700,31 @@ static unsigned long __init unflatten_dt
 			memcpy(p, pathp, l);
 		} else
 			memcpy(np->full_name, pathp, l);
+		DBG("node %s found\n", np->full_name);
 		prev_pp = &np->properties;
-		**allnextpp = np;
-		*allnextpp = &np->allnext;
-		if (dad != NULL) {
-			np->parent = dad;
-			/* we temporarily use the next field as `last_child'*/
-			if (dad->next == 0)
-				dad->child = np;
-			else
-				dad->next->sibling = np;
-			dad->next = np;
+		/* so if the workaround is in effect, and we have the right
+		 * node found, we increase the workaround count (we use the
+		 * same variable) and then set allnextpp to NULL on the second
+		 * one around so the node isn't added to the allnodes list */
+		if (powermac_i2c_bus_0_workaround &&
+		    strcmp(np->full_name,
+		           "/ht@0,f2000000/pci@8/mac-io@7/i2c@18000/i2c-bus@0") == 0) {
+			powermac_i2c_bus_0_workaround++;
+			if (powermac_i2c_bus_0_workaround == 3)
+				allnextpp = NULL;
+		}
+		if (allnextpp) {
+			**allnextpp = np;
+			*allnextpp = &np->allnext;
+			if (dad != NULL) {
+				np->parent = dad;
+				/* we temporarily use the next field as `last_child'*/
+				if (dad->next == 0)
+					dad->child = np;
+				else
+					dad->next->sibling = np;
+				dad->next = np;
+			}
 		}
 		kref_init(&np->kref);
 	}
@@ -745,6 +764,14 @@ static unsigned long __init unflatten_dt
 			}
 			if (strcmp(pname, "ibm,phandle") == 0)
 				np->linux_phandle = *((u32 *)*p);
+			/* we check the root node's compatible property
+			 * to see if we need to start the powermac i2c
+			 * workaround */
+			if ((pathp[0] == '\0') &&
+			    (strcmp(pname, "compatible") == 0) &&
+			    (strncmp((char*)*p, "PowerMac11,2", sz) == 0)) {
+				powermac_i2c_bus_0_workaround = 1;
+			}
 			pp->name = pname;
 			pp->length = sz;
 			pp->value = (void *)*p;
