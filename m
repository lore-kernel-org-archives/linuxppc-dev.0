Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C23A1A0372
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Aug 2014 11:36:52 +1000 (EST)
Date: Fri, 22 Aug 2014 11:36:52 +1000
From: Anton Blanchard <anton@samba.org>
To: santil@linux.vnet.ibm.com, paulus@samba.org
Subject: [PATCH] ibmveth: Fix endian issues with rx_no_buffer statistic
Message-ID: <20140822113652.7e4bdc78@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hidden away in the last 8 bytes of the buffer_list page is a solitary
statistic. It needs to be byte swapped or else ethtool -S will
produce numbers that terrify the user.

Since we do this in multiple places, create a helper function with a
comment explaining what is going on.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: stable@vger.kernel.org
---

Index: b/drivers/net/ethernet/ibm/ibmveth.c
===================================================================
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -292,6 +292,18 @@ failure:
 	atomic_add(buffers_added, &(pool->available));
 }
 
+/*
+ * The final 8 bytes of the buffer list is a counter of frames dropped
+ * because there was not a buffer in the buffer list capable of holding
+ * the frame.
+ */
+static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
+{
+	__be64 *p = adapter->buffer_list_addr + 4096 - 8;
+
+	adapter->rx_no_buffer = be64_to_cpup(p);
+}
+
 /* replenish routine */
 static void ibmveth_replenish_task(struct ibmveth_adapter *adapter)
 {
@@ -307,8 +319,7 @@ static void ibmveth_replenish_task(struc
 			ibmveth_replenish_buffer_pool(adapter, pool);
 	}
 
-	adapter->rx_no_buffer = *(u64 *)(((char*)adapter->buffer_list_addr) +
-						4096 - 8);
+	ibmveth_update_rx_no_buffer(adapter);
 }
 
 /* empty and free ana buffer pool - also used to do cleanup in error paths */
@@ -698,8 +709,7 @@ static int ibmveth_close(struct net_devi
 
 	free_irq(netdev->irq, netdev);
 
-	adapter->rx_no_buffer = *(u64 *)(((char *)adapter->buffer_list_addr) +
-						4096 - 8);
+	ibmveth_update_rx_no_buffer(adapter);
 
 	ibmveth_cleanup(adapter);
 
