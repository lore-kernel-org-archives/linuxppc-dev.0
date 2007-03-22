Return-Path: <fenkes@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E5768DDFDD
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 02:55:24 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l2MFtJ82127234
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 15:55:19 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l2MFtJal1519776
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 16:55:19 +0100
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l2MFtI4p007870
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 16:55:19 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: rolandd@cisco.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	general@lists.openfabrics.org
Subject: [PATCH] eHCA: Make scaling code also work without CPU hotplug
Date: Thu, 22 Mar 2007 16:52:13 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200703221652.13216.fenkes@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

eHCA scaling code must not depend on register_cpu_notifier() if
CONFIG_HOTPLUG_CPU is not set, so put all related code into #ifdefs.


Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---


 ehca_irq.c |    8 ++++++++
 1 file changed, 8 insertions(+)


diff --git a/drivers/infiniband/hw/ehca/ehca_irq.c b/drivers/infiniband/hw/ehca/ehca_irq.c
index 20f36bf..f284be1 100644
--- a/drivers/infiniband/hw/ehca/ehca_irq.c
+++ b/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -66,7 +66,9 @@ #define ERROR_DATA_TYPE        EHCA_BMAS
 static void queue_comp_task(struct ehca_cq *__cq);
 
 static struct ehca_comp_pool* pool;
+#ifdef CONFIG_HOTPLUG_CPU
 static struct notifier_block comp_pool_callback_nb;
+#endif
 
 static inline void comp_event_callback(struct ehca_cq *cq)
 {
@@ -733,6 +735,7 @@ static void take_over_work(struct ehca_c
 
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 static int comp_pool_callback(struct notifier_block *nfb,
 			      unsigned long action,
 			      void *hcpu)
@@ -775,6 +778,7 @@ static int comp_pool_callback(struct not
 
 	return NOTIFY_OK;
 }
+#endif
 
 int ehca_create_comp_pool(void)
 {
@@ -805,9 +809,11 @@ int ehca_create_comp_pool(void)
 		}
 	}
 
+#ifdef CONFIG_HOTPLUG_CPU
 	comp_pool_callback_nb.notifier_call = comp_pool_callback;
 	comp_pool_callback_nb.priority =0;
 	register_cpu_notifier(&comp_pool_callback_nb);
+#endif
 
 	printk(KERN_INFO "eHCA scaling code enabled\n");
 
@@ -821,7 +827,9 @@ void ehca_destroy_comp_pool(void)
 	if (!ehca_scaling_code)
 		return;
 
+#ifdef CONFIG_HOTPLUG_CPU
 	unregister_cpu_notifier(&comp_pool_callback_nb);
+#endif
 
 	for (i = 0; i < NR_CPUS; i++) {
 		if (cpu_online(i))
