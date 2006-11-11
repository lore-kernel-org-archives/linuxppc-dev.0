Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 11 Nov 2006 17:24:42 +1100
Subject: [PATCH 1/32] ibmveth: Remove ibmveth "liobn" field
In-Reply-To: <1163226282.72526.823314634857.qpush@butch>
Message-Id: <20061111062513.81F5E680F4@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove the now unused "liobn" field in ibmveth which also avoids
having insider knowledge of the iommu table in that driver.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Santiago Leon <santil@us.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---

Already in Jeff's queue.

 drivers/net/ibmveth.c |    4 ----
 drivers/net/ibmveth.h |    1 -
 2 files changed, 5 deletions(-)

Index: linux-cell/drivers/net/ibmveth.c
===================================================================
--- linux-cell.orig/drivers/net/ibmveth.c	2006-10-23 14:41:38.000000000 +1000
+++ linux-cell/drivers/net/ibmveth.c	2006-10-25 14:12:05.000000000 +1000
@@ -50,7 +50,6 @@
 #include <asm/semaphore.h>
 #include <asm/hvcall.h>
 #include <asm/atomic.h>
-#include <asm/iommu.h>
 #include <asm/vio.h>
 #include <asm/uaccess.h>
 #include <linux/seq_file.h>
@@ -1000,8 +999,6 @@ static int __devinit ibmveth_probe(struc
 	adapter->mac_addr = 0;
 	memcpy(&adapter->mac_addr, mac_addr_p, 6);
 
-	adapter->liobn = dev->iommu_table->it_index;
-
 	netdev->irq = dev->irq;
 	netdev->open               = ibmveth_open;
 	netdev->poll               = ibmveth_poll;
@@ -1115,7 +1112,6 @@ static int ibmveth_seq_show(struct seq_f
 	seq_printf(seq, "%s %s\n\n", ibmveth_driver_string, ibmveth_driver_version);
 
 	seq_printf(seq, "Unit Address:    0x%x\n", adapter->vdev->unit_address);
-	seq_printf(seq, "LIOBN:           0x%lx\n", adapter->liobn);
 	seq_printf(seq, "Current MAC:     %02X:%02X:%02X:%02X:%02X:%02X\n",
 		   current_mac[0], current_mac[1], current_mac[2],
 		   current_mac[3], current_mac[4], current_mac[5]);
Index: linux-cell/drivers/net/ibmveth.h
===================================================================
--- linux-cell.orig/drivers/net/ibmveth.h	2006-10-06 13:48:09.000000000 +1000
+++ linux-cell/drivers/net/ibmveth.h	2006-10-25 14:10:39.000000000 +1000
@@ -118,7 +118,6 @@ struct ibmveth_adapter {
     struct net_device_stats stats;
     unsigned int mcastFilterSize;
     unsigned long mac_addr;
-    unsigned long liobn;
     void * buffer_list_addr;
     void * filter_list_addr;
     dma_addr_t buffer_list_dma;
