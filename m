Return-Path: <fenkes@de.ibm.com>
Received: from mtagate8.uk.ibm.com (mtagate8.uk.ibm.com [195.212.29.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9D10EDDE26
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 00:44:27 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate8.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l8CEiMXH275066
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 14:44:22 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8CEiMiq3006688
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 15:44:22 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8CEiFJu015303
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 15:44:16 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 08/12] IB/ehca: Replace get_paca()->paca_index by the more
	portable raw_smp_processor_id()
Date: Wed, 12 Sep 2007 16:44:11 +0200
References: <200709111518.26276.fenkes@de.ibm.com>
	<200709111533.14333.fenkes@de.ibm.com>
In-Reply-To: <200709111533.14333.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709121644.12717.fenkes@de.ibm.com>
Cc: Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We can use raw_smp_processor_id() here because the processor ID is only used
for debug output and may therefore be preemption-unsafe.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---

This is the same patch, but with smp_processor_id() replaced by
raw_smp_processor_id(), as kindly pointed out to me by Nathan. Thanks!

 drivers/infiniband/hw/ehca/ehca_tools.h |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_tools.h b/drivers/infiniband/hw/ehca/ehca_tools.h
index f9b264b..4a8346a 100644
--- a/drivers/infiniband/hw/ehca/ehca_tools.h
+++ b/drivers/infiniband/hw/ehca/ehca_tools.h
@@ -73,37 +73,37 @@ extern int ehca_debug_level;
 		if (unlikely(ehca_debug_level)) \
 			dev_printk(KERN_DEBUG, (ib_dev)->dma_device, \
 				   "PU%04x EHCA_DBG:%s " format "\n", \
-				   get_paca()->paca_index, __FUNCTION__, \
+				   raw_smp_processor_id(), __FUNCTION__, \
 				   ## arg); \
 	} while (0)
 
 #define ehca_info(ib_dev, format, arg...) \
 	dev_info((ib_dev)->dma_device, "PU%04x EHCA_INFO:%s " format "\n", \
-		 get_paca()->paca_index, __FUNCTION__, ## arg)
+		 raw_smp_processor_id(), __FUNCTION__, ## arg)
 
 #define ehca_warn(ib_dev, format, arg...) \
 	dev_warn((ib_dev)->dma_device, "PU%04x EHCA_WARN:%s " format "\n", \
-		 get_paca()->paca_index, __FUNCTION__, ## arg)
+		 raw_smp_processor_id(), __FUNCTION__, ## arg)
 
 #define ehca_err(ib_dev, format, arg...) \
 	dev_err((ib_dev)->dma_device, "PU%04x EHCA_ERR:%s " format "\n", \
-		get_paca()->paca_index, __FUNCTION__, ## arg)
+		raw_smp_processor_id(), __FUNCTION__, ## arg)
 
 /* use this one only if no ib_dev available */
 #define ehca_gen_dbg(format, arg...) \
 	do { \
 		if (unlikely(ehca_debug_level)) \
 			printk(KERN_DEBUG "PU%04x EHCA_DBG:%s " format "\n", \
-			       get_paca()->paca_index, __FUNCTION__, ## arg); \
+			       raw_smp_processor_id(), __FUNCTION__, ## arg); \
 	} while (0)
 
 #define ehca_gen_warn(format, arg...) \
 	printk(KERN_INFO "PU%04x EHCA_WARN:%s " format "\n", \
-	       get_paca()->paca_index, __FUNCTION__, ## arg)
+	       raw_smp_processor_id(), __FUNCTION__, ## arg)
 
 #define ehca_gen_err(format, arg...) \
 	printk(KERN_ERR "PU%04x EHCA_ERR:%s " format "\n", \
-	       get_paca()->paca_index, __FUNCTION__, ## arg)
+	       raw_smp_processor_id(), __FUNCTION__, ## arg)
 
 /**
  * ehca_dmp - printk a memory block, whose length is n*8 bytes.
-- 
1.5.2
