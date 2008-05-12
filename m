Return-Path: <julia@diku.dk>
Received: from mgw1.diku.dk (mgw1.diku.dk [130.225.96.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw1.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 68835DDECA
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 00:12:03 +1000 (EST)
Date: Mon, 12 May 2008 15:38:26 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: pantelis.antoniou@gmail.com, vbordug@ru.mvista.com,
	linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 4/6] drivers/net/fs_enet: remove null pointer dereference
Message-ID: <Pine.LNX.4.64.0805121537590.3694@ask.diku.dk>
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

The following code appears in the function fs_init_instance in the file drivers/net/fs_enet/fs_enet-main.c.

	if (fep->ops == NULL) {
		printk(KERN_ERR DRV_MODULE_NAME
		       ": %s No matching ops found (%d).\n",
		       ndev->name, fpi->fs_no);
		err = -EINVAL;
		goto err;
	}

This code implies that at the point of err, fep->ops can be NULL, so an
extra test is needed before dereferencing this value.


This problem was found using the following semantic match
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@@
expression E, E1;
identifier f;
statement S1,S2,S3;
@@

* if (E == NULL)
{
  ... when != if (E == NULL) S1 else S2
      when != E = E1
* E->f
  ... when any
  return ...;
}
else S3
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---

diff -u -p a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
--- a/drivers/net/fs_enet/fs_enet-main.c	2008-04-27 11:41:11.000000000 +0200
+++ b/drivers/net/fs_enet/fs_enet-main.c	2008-05-12 09:41:52.000000000 +0200
@@ -1093,7 +1093,7 @@ err:
 		if (registered)
 			unregister_netdev(ndev);
 
-		if (fep != NULL) {
+		if (fep && fep->ops) {
 			(*fep->ops->free_bd)(ndev);
 			(*fep->ops->cleanup_data)(ndev);
 		}
