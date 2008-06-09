Return-Path: <julia@diku.dk>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 951A8DE218
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jun 2008 22:22:01 +1000 (EST)
Date: Mon, 9 Jun 2008 14:21:51 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 4/4] drivers/macintosh/therm_adt746x.c: add missing of_node_put
Message-ID: <Pine.LNX.4.64.0806091421200.16009@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

of_node_put is needed before discarding a value received from
of_find_node_by_name, eg in error handling code.

The semantic patch that makes the change is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@@
struct device_node *n;
struct device_node *n1;
statement S;
identifier f;
expression E;
constant C;
@@

n = of_find_node_by_name(...)
...
if (!n) S
... when != of_node_put(n)
    when != n1 = f(n,...)
    when != E = n
    when any
    when strict
(
+ of_node_put(n);
  return -C;
|
  of_node_put(n);
|
  n1 = f(n,...)
|
  E = n
|
  return ...;
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---

diff -u -p a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -562,18 +562,24 @@ thermostat_init(void)
 		therm_type = ADT7460;
 	else if (of_device_is_compatible(np, "adt7467"))
 		therm_type = ADT7467;
-	else
+	else {
+		of_node_put(np);
 		return -ENODEV;
+	}
 
 	prop = of_get_property(np, "hwsensor-params-version", NULL);
 	printk(KERN_INFO "adt746x: version %d (%ssupported)\n", *prop,
 			 (*prop == 1)?"":"un");
-	if (*prop != 1)
+	if (*prop != 1) {
+		of_node_put(np);
 		return -ENODEV;
+	}
 
 	prop = of_get_property(np, "reg", NULL);
-	if (!prop)
+	if (!prop) {
+		of_node_put(np);
 		return -ENODEV;
+	}
 
 	/* look for bus either by path or using "reg" */
 	if (strstr(np->full_name, "/i2c-bus@") != NULL) {
@@ -610,5 +616,6 @@ thermostat_init(void)
 	
 	if (of_dev == NULL) {
 		printk(KERN_ERR "Can't register temperatures device !\n");
+		of_node_put(np);
 		return -ENODEV;
 	}
