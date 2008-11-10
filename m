Return-Path: <sonny@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3A0FEDDDF9
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2008 11:15:18 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id mAA0FClV020574
	for <linuxppc-dev@ozlabs.org>; Sun, 9 Nov 2008 19:15:12 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAA0FCuJ144452
	for <linuxppc-dev@ozlabs.org>; Sun, 9 Nov 2008 19:15:12 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAA0FBNp009308
	for <linuxppc-dev@ozlabs.org>; Sun, 9 Nov 2008 19:15:12 -0500
Date: Sun, 9 Nov 2008 18:15:11 -0600
From: Sonny Rao <sonnyrao@us.ibm.com>
To: paulus@samba.org
Subject: [PATCH] powerpc: BSR: support multiple OF-node description of BSR
Message-ID: <20081110001511.GI16240@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add support for multiple BSR nodes in the device tree.

Previously, the BSR driver only supported a single OF node describing
a BSR.  Apparently when an LPAR is set to use "all system resources"
the BSR appears as a single node, but when it is handed out in pieces,
each 8 byte piece gets its own node.  So, keep a list of bsr devices
instead of the array and include all nodes.

Also, be more inclusive of what BSR devices we accept by only checking
compatibility and not the device name property (which might change in 
the future versions of BSR).

Signed-off-by: Sonny Rao <sonnyrao@us.ibm.com>

Index: common/drivers/char/bsr.c
===================================================================
--- common.orig/drivers/char/bsr.c	2008-11-09 17:21:47.000000000 -0600
+++ common/drivers/char/bsr.c	2008-11-09 17:36:22.000000000 -0600
@@ -61,6 +61,8 @@
 	unsigned bsr_num;      /* bsr id number for its type */
 	int      bsr_minor;
 
+	struct list_head bsr_list;
+
 	dev_t    bsr_dev;
 	struct cdev bsr_cdev;
 	struct device *bsr_device;
@@ -68,8 +70,8 @@
 
 };
 
-static unsigned num_bsr_devs;
-static struct bsr_dev *bsr_devs;
+static unsigned total_bsr_devs;
+static struct list_head bsr_devs = LIST_HEAD_INIT(bsr_devs);
 static struct class *bsr_class;
 static int bsr_major;
 
@@ -155,24 +157,25 @@
 
 static void bsr_cleanup_devs(void)
 {
-	int i;
-	for (i=0 ; i < num_bsr_devs; i++) {
-		struct bsr_dev *cur = bsr_devs + i;
+	struct bsr_dev *cur, *n;
+
+	list_for_each_entry_safe(cur, n, &bsr_devs, bsr_list) {
 		if (cur->bsr_device) {
 			cdev_del(&cur->bsr_cdev);
 			device_del(cur->bsr_device);
 		}
+		list_del(&cur->bsr_list);
+		kfree(cur);
 	}
-
-	kfree(bsr_devs);
 }
 
-static int bsr_create_devs(struct device_node *bn)
+static int bsr_add_node(struct device_node *bn)
 {
-	int bsr_stride_len, bsr_bytes_len;
+	int bsr_stride_len, bsr_bytes_len, num_bsr_devs;
 	const u32 *bsr_stride;
 	const u32 *bsr_bytes;
 	unsigned i;
+	int ret = -ENODEV;
 
 	bsr_stride = of_get_property(bn, "ibm,lock-stride", &bsr_stride_len);
 	bsr_bytes  = of_get_property(bn, "ibm,#lock-bytes", &bsr_bytes_len);
@@ -180,35 +183,36 @@
 	if (!bsr_stride || !bsr_bytes ||
 	    (bsr_stride_len != bsr_bytes_len)) {
 		printk(KERN_ERR "bsr of-node has missing/incorrect property\n");
-		return -ENODEV;
+		return ret;
 	}
 
 	num_bsr_devs = bsr_bytes_len / sizeof(u32);
 
-	/* only a warning, its informational since we'll fail and exit */
-	WARN_ON(num_bsr_devs > BSR_MAX_DEVS);
-
-	bsr_devs = kzalloc(sizeof(struct bsr_dev) * num_bsr_devs, GFP_KERNEL);
-	if (!bsr_devs)
-		return -ENOMEM;
-
 	for (i = 0 ; i < num_bsr_devs; i++) {
-		struct bsr_dev *cur = bsr_devs + i;
+		struct bsr_dev *cur = kzalloc(sizeof(struct bsr_dev),
+					      GFP_KERNEL);
 		struct resource res;
 		int result;
 
+		if (!cur) {
+			printk(KERN_ERR "Unable to alloc bsr dev\n");
+			ret = -ENOMEM;
+			goto out_err;
+		}
+
 		result = of_address_to_resource(bn, i, &res);
 		if (result < 0) {
-			printk(KERN_ERR "bsr of-node has invalid reg property\n");
-			goto out_err;
+			printk(KERN_ERR "bsr of-node has invalid reg property, skipping\n");
+			kfree(cur);
+			continue;
 		}
 
-		cur->bsr_minor  = i;
+		cur->bsr_minor  = i + total_bsr_devs;
 		cur->bsr_addr   = res.start;
 		cur->bsr_len    = res.end - res.start + 1;
 		cur->bsr_bytes  = bsr_bytes[i];
 		cur->bsr_stride = bsr_stride[i];
-		cur->bsr_dev    = MKDEV(bsr_major, i);
+		cur->bsr_dev    = MKDEV(bsr_major, i + total_bsr_devs);
 
 		switch(cur->bsr_bytes) {
 		case 8:
@@ -229,14 +233,15 @@
 		}
 
 		cur->bsr_num = bsr_types[cur->bsr_type];
-		bsr_types[cur->bsr_type] = cur->bsr_num + 1;
 		snprintf(cur->bsr_name, 32, "bsr%d_%d",
 			 cur->bsr_bytes, cur->bsr_num);
 
 		cdev_init(&cur->bsr_cdev, &bsr_fops);
 		result = cdev_add(&cur->bsr_cdev, cur->bsr_dev, 1);
-		if (result)
+		if (result) {
+			kfree(cur);
 			goto out_err;
+		}
 
 		cur->bsr_device = device_create_drvdata(bsr_class, NULL,
 							cur->bsr_dev,
@@ -245,16 +250,37 @@
 			printk(KERN_ERR "device_create failed for %s\n",
 			       cur->bsr_name);
 			cdev_del(&cur->bsr_cdev);
+			kfree(cur);
 			goto out_err;
 		}
+
+		bsr_types[cur->bsr_type] = cur->bsr_num + 1;
+		list_add_tail(&cur->bsr_list, &bsr_devs);
 	}
 
+	total_bsr_devs += num_bsr_devs;
+
 	return 0;
 
  out_err:
 
 	bsr_cleanup_devs();
-	return -ENODEV;
+	return ret;
+}
+
+static int bsr_create_devs(struct device_node *bn)
+{
+	int ret;
+
+	while (bn) {
+		ret = bsr_add_node(bn);
+		if (ret) {
+			of_node_put(bn);
+			return ret;
+		}
+		bn = of_find_compatible_node(bn, NULL, "ibm,bsr");
+	}
+	return 0;
 }
 
 static int __init bsr_init(void)
@@ -264,7 +290,7 @@
 	int ret = -ENODEV;
 	int result;
 
-	np = of_find_compatible_node(NULL, "ibm,bsr", "ibm,bsr");
+	np = of_find_compatible_node(NULL, NULL, "ibm,bsr");
 	if (!np)
 		goto out_err;
 
@@ -282,10 +308,10 @@
 		goto out_err_2;
 	}
 
-	if ((ret = bsr_create_devs(np)) < 0)
+	if ((ret = bsr_create_devs(np)) < 0) {
+		np = NULL;
 		goto out_err_3;
-
-	of_node_put(np);
+	}
 
 	return 0;
 
