Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CA59FDDEC9
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 01:50:32 +1000 (EST)
Date: Sun, 13 May 2007 17:50:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: boutcher@us.ibm.com, linuxppc-dev@ozlabs.org
Subject: [PATCH] viopath: use completion
Message-ID: <20070513155027.GB9218@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use a completion instead of abusing a semaphore for hypervisor event
completion in viopath.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/powerpc/platforms/iseries/viopath.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/iseries/viopath.c	2007-05-10 10:53:13.000000000 +0200
+++ linux-2.6/arch/powerpc/platforms/iseries/viopath.c	2007-05-13 16:37:04.000000000 +0200
@@ -37,6 +37,7 @@
 #include <linux/wait.h>
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
+#include <linux/completion.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -115,7 +116,7 @@ static int proc_viopath_show(struct seq_
 	u16 vlanMap;
 	dma_addr_t handle;
 	HvLpEvent_Rc hvrc;
-	DECLARE_MUTEX_LOCKED(Semaphore);
+	DECLARE_COMPLETION(done);
 	struct device_node *node;
 	const char *sysid;
 
@@ -132,13 +133,13 @@ static int proc_viopath_show(struct seq_
 			HvLpEvent_AckInd_DoAck, HvLpEvent_AckType_ImmediateAck,
 			viopath_sourceinst(viopath_hostLp),
 			viopath_targetinst(viopath_hostLp),
-			(u64)(unsigned long)&Semaphore, VIOVERSION << 16,
+			(u64)(unsigned long)&done, VIOVERSION << 16,
 			((u64)handle) << 32, HW_PAGE_SIZE, 0, 0);
 
 	if (hvrc != HvLpEvent_Rc_Good)
 		printk(VIOPATH_KERN_WARN "hv error on op %d\n", (int)hvrc);
 
-	down(&Semaphore);
+	wait_for_completion(&done);
 
 	vlanMap = HvLpConfig_getVirtualLanIndexMap();
 
@@ -353,7 +354,7 @@ static void handleConfig(struct HvLpEven
 		return;
 	}
 
-	up((struct semaphore *)event->xCorrelationToken);
+	complete((struct completion *)event->xCorrelationToken);
 }
 
 /*
