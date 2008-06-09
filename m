Return-Path: <julia@diku.dk>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5075BDE20A
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jun 2008 22:20:48 +1000 (EST)
Date: Mon, 9 Jun 2008 14:20:42 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/4] drivers/macintosh/smu.c: add missing of_node_put
Message-ID: <Pine.LNX.4.64.0806091420080.16009@ask.diku.dk>
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
of_find_node_by_type, eg in error handling code.

The semantic patch that makes the change is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@@
struct device_node *n;
struct device_node *n1;
struct device_node *n2;
statement S;
identifier f1,f2;
expression E1,E2;
constant C;
@@

n = of_find_node_by_type(...)
...
if (!n) S
... when != of_node_put(n)
    when != n1 = f1(n,...)
    when != E1 = n
    when any
    when strict
(
+ of_node_put(n);
  return -C;
|
  of_node_put(n);
|
  n2 = f2(n,...)
|
  E2 = n
|
  return ...;
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---

diff -u -p a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -483,12 +483,15 @@ int __init smu_init (void)
 
 	if (smu_cmdbuf_abs == 0) {
 		printk(KERN_ERR "SMU: Command buffer not allocated !\n");
+		of_node_put(np);
 		return -EINVAL;
 	}
 
 	smu = alloc_bootmem(sizeof(struct smu_device));
-	if (smu == NULL)
+	if (smu == NULL) {
+		of_node_put(np);
 		return -ENOMEM;
+	}
 	memset(smu, 0, sizeof(*smu));
 
 	spin_lock_init(&smu->lock);
