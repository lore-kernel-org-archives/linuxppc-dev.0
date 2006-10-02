Return-Path: <hnguyen@de.ibm.com>
Received: from mtagate5.uk.ibm.com (mtagate5.uk.ibm.com [195.212.29.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D478467BEC
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 06:36:23 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate5.uk.ibm.com (8.13.8/8.13.8) with ESMTP id k92KaJJs086978
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 20:36:19 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k92KceQQ1917144
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 21:38:40 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k92KaITM024216
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 21:36:18 +0100
From: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
To: rolandd@cisco.com
Subject: [PATCH 2.6.19-rc1 1/2] ehca: fix ehca device registration
Date: Mon, 2 Oct 2006 22:32:49 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xdXIFb16LD7PgHy"
Message-Id: <200610022232.49540.hnguyen@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	openib-general@openib.org, openfabrics-ewg@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_xdXIFb16LD7PgHy
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Roland!
Below is a patch of ehca, which fixes a bug (crash) that occured when ib_ehca
is loaded after ib_ipoib. This patch initializes struct ehca_shca with
struct device*, then creates internal resources and finally registers the
ehca IB device. And that is the proper sequence to do.
Thanks!
Nam Nguyen


Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_main.c |   36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)


diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_main.c infiniband_work/drivers/infiniband/hw/ehca/ehca_main.c
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_main.c 2006-10-02 22:08:57.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_main.c 2006-10-02 18:29:53.000000000 +0200
@@ -49,7 +49,7 @@
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
 MODULE_DESCRIPTION("IBM eServer HCA InfiniBand Device Driver");
-MODULE_VERSION("SVNEHCA_0016");
+MODULE_VERSION("SVNEHCA_0017");
 
 int ehca_open_aqp1     = 0;
 int ehca_debug_level   = 0;
@@ -239,7 +239,7 @@ init_node_guid1:
  return ret;
 }
 
-int ehca_register_device(struct ehca_shca *shca)
+int ehca_init_device(struct ehca_shca *shca)
 {
  int ret;
 
@@ -317,11 +317,6 @@ int ehca_register_device(struct ehca_shc
  /* shca->ib_device.process_mad     = ehca_process_mad;     */
  shca->ib_device.mmap      = ehca_mmap;
 
- ret = ib_register_device(&shca->ib_device);
- if (ret)
-  ehca_err(&shca->ib_device,
-    "ib_register_device() failed ret=%x", ret);
-
  return ret;
 }
 
@@ -561,9 +556,9 @@ static int __devinit ehca_probe(struct i
   goto probe1;
  }
 
- ret = ehca_register_device(shca);
+ ret = ehca_init_device(shca);
  if (ret) {
-  ehca_gen_err("Cannot register Infiniband device");
+  ehca_gen_err("Cannot init ehca  device struct");
   goto probe1;
  }
 
@@ -571,7 +566,7 @@ static int __devinit ehca_probe(struct i
  ret = ehca_create_eq(shca, &shca->eq, EHCA_EQ, 2048);
  if (ret) {
   ehca_err(&shca->ib_device, "Cannot create EQ.");
-  goto probe2;
+  goto probe1;
  }
 
  ret = ehca_create_eq(shca, &shca->neq, EHCA_NEQ, 513);
@@ -600,6 +595,13 @@ static int __devinit ehca_probe(struct i
   goto probe5;
  }
 
+ ret = ib_register_device(&shca->ib_device);
+ if (ret) {
+  ehca_err(&shca->ib_device,
+    "ib_register_device() failed ret=%x", ret);
+  goto probe6;
+ }
+
  /* create AQP1 for port 1 */
  if (ehca_open_aqp1 == 1) {
   shca->sport[0].port_state = IB_PORT_DOWN;
@@ -607,7 +609,7 @@ static int __devinit ehca_probe(struct i
   if (ret) {
    ehca_err(&shca->ib_device,
      "Cannot create AQP1 for port 1.");
-   goto probe6;
+   goto probe7;
   }
  }
 
@@ -618,7 +620,7 @@ static int __devinit ehca_probe(struct i
   if (ret) {
    ehca_err(&shca->ib_device,
      "Cannot create AQP1 for port 2.");
-   goto probe7;
+   goto probe8;
   }
  }
 
@@ -630,12 +632,15 @@ static int __devinit ehca_probe(struct i
 
  return 0;
 
-probe7:
+probe8:
  ret = ehca_destroy_aqp1(&shca->sport[0]);
  if (ret)
   ehca_err(&shca->ib_device,
     "Cannot destroy AQP1 for port 1. ret=%x", ret);
 
+probe7:
+ ib_unregister_device(&shca->ib_device);
+
 probe6:
  ret = ehca_dereg_internal_maxmr(shca);
  if (ret)
@@ -660,9 +665,6 @@ probe3:
   ehca_err(&shca->ib_device,
     "Cannot destroy EQ. ret=%x", ret);
 
-probe2:
- ib_unregister_device(&shca->ib_device);
-
 probe1:
  ib_dealloc_device(&shca->ib_device);
 
@@ -750,7 +752,7 @@ int __init ehca_module_init(void)
  int ret;
 
  printk(KERN_INFO "eHCA Infiniband Device Driver "
-                  "(Rel.: SVNEHCA_0016)\n");
+                  "(Rel.: SVNEHCA_0017)\n");
  idr_init(&ehca_qp_idr);
  idr_init(&ehca_cq_idr);
  spin_lock_init(&ehca_qp_idr_lock);

--Boundary-00=_xdXIFb16LD7PgHy
Content-Type: text/x-diff;
  charset="us-ascii";
  name="svnehca_0017_roland_git.patch1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="svnehca_0017_roland_git.patch1"

diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_main.c infiniband_work/drivers/infiniband/hw/ehca/ehca_main.c
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_main.c	2006-10-02 22:08:57.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_main.c	2006-10-02 18:29:53.000000000 +0200
@@ -49,7 +49,7 @@
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
 MODULE_DESCRIPTION("IBM eServer HCA InfiniBand Device Driver");
-MODULE_VERSION("SVNEHCA_0016");
+MODULE_VERSION("SVNEHCA_0017");
 
 int ehca_open_aqp1     = 0;
 int ehca_debug_level   = 0;
@@ -239,7 +239,7 @@ init_node_guid1:
 	return ret;
 }
 
-int ehca_register_device(struct ehca_shca *shca)
+int ehca_init_device(struct ehca_shca *shca)
 {
 	int ret;
 
@@ -317,11 +317,6 @@ int ehca_register_device(struct ehca_shc
 	/* shca->ib_device.process_mad	    = ehca_process_mad;	    */
 	shca->ib_device.mmap		    = ehca_mmap;
 
-	ret = ib_register_device(&shca->ib_device);
-	if (ret)
-		ehca_err(&shca->ib_device,
-			 "ib_register_device() failed ret=%x", ret);
-
 	return ret;
 }
 
@@ -561,9 +556,9 @@ static int __devinit ehca_probe(struct i
 		goto probe1;
 	}
 
-	ret = ehca_register_device(shca);
+	ret = ehca_init_device(shca);
 	if (ret) {
-		ehca_gen_err("Cannot register Infiniband device");
+		ehca_gen_err("Cannot init ehca  device struct");
 		goto probe1;
 	}
 
@@ -571,7 +566,7 @@ static int __devinit ehca_probe(struct i
 	ret = ehca_create_eq(shca, &shca->eq, EHCA_EQ, 2048);
 	if (ret) {
 		ehca_err(&shca->ib_device, "Cannot create EQ.");
-		goto probe2;
+		goto probe1;
 	}
 
 	ret = ehca_create_eq(shca, &shca->neq, EHCA_NEQ, 513);
@@ -600,6 +595,13 @@ static int __devinit ehca_probe(struct i
 		goto probe5;
 	}
 
+	ret = ib_register_device(&shca->ib_device);
+	if (ret) {
+		ehca_err(&shca->ib_device,
+			 "ib_register_device() failed ret=%x", ret);
+		goto probe6;
+	}
+
 	/* create AQP1 for port 1 */
 	if (ehca_open_aqp1 == 1) {
 		shca->sport[0].port_state = IB_PORT_DOWN;
@@ -607,7 +609,7 @@ static int __devinit ehca_probe(struct i
 		if (ret) {
 			ehca_err(&shca->ib_device,
 				 "Cannot create AQP1 for port 1.");
-			goto probe6;
+			goto probe7;
 		}
 	}
 
@@ -618,7 +620,7 @@ static int __devinit ehca_probe(struct i
 		if (ret) {
 			ehca_err(&shca->ib_device,
 				 "Cannot create AQP1 for port 2.");
-			goto probe7;
+			goto probe8;
 		}
 	}
 
@@ -630,12 +632,15 @@ static int __devinit ehca_probe(struct i
 
 	return 0;
 
-probe7:
+probe8:
 	ret = ehca_destroy_aqp1(&shca->sport[0]);
 	if (ret)
 		ehca_err(&shca->ib_device,
 			 "Cannot destroy AQP1 for port 1. ret=%x", ret);
 
+probe7:
+	ib_unregister_device(&shca->ib_device);
+
 probe6:
 	ret = ehca_dereg_internal_maxmr(shca);
 	if (ret)
@@ -660,9 +665,6 @@ probe3:
 		ehca_err(&shca->ib_device,
 			 "Cannot destroy EQ. ret=%x", ret);
 
-probe2:
-	ib_unregister_device(&shca->ib_device);
-
 probe1:
 	ib_dealloc_device(&shca->ib_device);
 
@@ -750,7 +752,7 @@ int __init ehca_module_init(void)
 	int ret;
 
 	printk(KERN_INFO "eHCA Infiniband Device Driver "
-	                 "(Rel.: SVNEHCA_0016)\n");
+	                 "(Rel.: SVNEHCA_0017)\n");
 	idr_init(&ehca_qp_idr);
 	idr_init(&ehca_cq_idr);
 	spin_lock_init(&ehca_qp_idr_lock);

--Boundary-00=_xdXIFb16LD7PgHy--
