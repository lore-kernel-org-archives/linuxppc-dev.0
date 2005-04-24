Return-Path: <viro@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 897B467A2E
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Apr 2005 07:30:52 +1000 (EST)
To: torvalds@osdl.org
Message-Id: <E1DPogn-0004jL-MU@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Sun, 24 Apr 2005 22:30:53 +0100
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc trivial iomem annotations: pmac_time.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc3-sent/arch/ppc/platforms/pmac_time.c RC12-rc3-pmac_time/arch/ppc/platforms/pmac_time.c
--- RC12-rc3-sent/arch/ppc/platforms/pmac_time.c	Fri Sep 10 01:46:30 2004
+++ RC12-rc3-pmac_time/arch/ppc/platforms/pmac_time.c	Sun Apr 24 16:20:03 2005
@@ -165,7 +165,7 @@
 via_calibrate_decr(void)
 {
 	struct device_node *vias;
-	volatile unsigned char *via;
+	volatile unsigned char __iomem *via;
 	int count = VIA_TIMER_FREQ_6 / 100;
 	unsigned int dstart, dend;
 
@@ -176,8 +176,7 @@
 		vias = find_devices("via");
 	if (vias == 0 || vias->n_addrs == 0)
 		return 0;
-	via = (volatile unsigned char *)
-		ioremap(vias->addrs[0].address, vias->addrs[0].size);
+	via = ioremap(vias->addrs[0].address, vias->addrs[0].size);
 
 	/* set timer 1 for continuous interrupts */
 	out_8(&via[ACR], (via[ACR] & ~T1MODE) | T1MODE_CONT);
@@ -202,7 +201,7 @@
 	printk(KERN_INFO "via_calibrate_decr: ticks per jiffy = %u (%u ticks)\n",
 	       tb_ticks_per_jiffy, dstart - dend);
 
-	iounmap((void*)via);
+	iounmap(via);
 	
 	return 1;
 }
