Return-Path: <julia@diku.dk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 11CDCB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 06:04:59 +1000 (EST)
Received: from mgw1.diku.dk (mgw1.diku.dk [130.225.96.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw1.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 06234DDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 06:04:57 +1000 (EST)
Date: Thu, 6 Aug 2009 22:04:28 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: benh@kernel.crashing.org, paulus@samba.org,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 1/3] arch/powerpc: Add kmalloc NULL tests
Message-ID: <Pine.LNX.4.64.0908062203380.19100@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

Check that the result of kmalloc/kzalloc is not NULL before dereferencing it.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression *x;
identifier f;
constant char *C;
@@

x = \(kmalloc\|kcalloc\|kzalloc\)(...);
... when != x == NULL
    when != x != NULL
    when != (x || ...)
(
kfree(x)
|
f(...,C,...,x,...)
|
*f(...,x,...)
|
*x->f
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/powerpc/sysdev/fsl_rio.c       |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index cbb3bed..598789c 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -1057,6 +1057,10 @@ int fsl_rio_setup(struct of_device *dev)
 			law_start, law_size);
 
 	ops = kmalloc(sizeof(struct rio_ops), GFP_KERNEL);
+	if (!ops) {
+		rc = -ENOMEM;
+		goto err_ops;
+	}
 	ops->lcread = fsl_local_config_read;
 	ops->lcwrite = fsl_local_config_write;
 	ops->cread = fsl_rio_config_read;
@@ -1064,6 +1068,10 @@ int fsl_rio_setup(struct of_device *dev)
 	ops->dsend = fsl_rio_doorbell_send;
 
 	port = kzalloc(sizeof(struct rio_mport), GFP_KERNEL);
+	if (!port) {
+		rc = -ENOMEM;
+		goto err_port;
+	}
 	port->id = 0;
 	port->index = 0;
 
@@ -1071,7 +1079,7 @@ int fsl_rio_setup(struct of_device *dev)
 	if (!priv) {
 		printk(KERN_ERR "Can't alloc memory for 'priv'\n");
 		rc = -ENOMEM;
-		goto err;
+		goto err_priv;
 	}
 
 	INIT_LIST_HEAD(&port->dbells);
@@ -1169,13 +1177,15 @@ int fsl_rio_setup(struct of_device *dev)
 
 	return 0;
 err:
-	if (priv)
-		iounmap(priv->regs_win);
-	kfree(ops);
+	iounmap(priv->regs_win);
+err_priv:
 	kfree(priv);
+err_port:
 	kfree(port);
+err_ops:
+	kfree(ops);
 	return rc;
 }
 
