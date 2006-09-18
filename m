Return-Path: <michael@ellerman.id.au>
Subject: [PATCH] powerpc: ibmveth: Harden driver initilisation for kexec
From: Michael Ellerman <michael@ellerman.id.au>
To: jgarzik <jgarzik@pobox.com>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 14:31:11 +1000
Message-Id: <1158553872.32015.17.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Anton Blanchard <anton@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jeff,

This patch has been floating around for a while now, Santi originally
sent it in March: http://www.spinics.net/lists/netdev/msg00471.html

You replied saying you thought it was "bonkers", I think I explained why
it wasn't, perhaps you disagree.

I'm resending it now in the hope you can either give us more info on
your objections, or merge it.


After a kexec the ibmveth driver will fail when trying to register with
the Hypervisor because the previous kernel has not unregistered.

So if the registration fails, we unregister and then try again.

We don't unconditionally unregister, because we don't want to disturb the
regular code path for 99% of users.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Acked-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Santiago Leon <santil@us.ibm.com>

---
 ibmveth.c |   31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

Index: to-merge/drivers/net/ibmveth.c
===================================================================
--- to-merge.orig/drivers/net/ibmveth.c
+++ to-merge/drivers/net/ibmveth.c
@@ -437,6 +437,31 @@ static void ibmveth_cleanup(struct ibmve
 						 &adapter->rx_buff_pool[i]);
 }
 
+static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
+        union ibmveth_buf_desc rxq_desc, u64 mac_address)
+{
+	int rc, try_again = 1;
+
+	/* After a kexec the adapter will still be open, so our attempt to
+	* open it will fail. So if we get a failure we free the adapter and
+	* try again, but only once. */
+retry:
+	rc = h_register_logical_lan(adapter->vdev->unit_address,
+				    adapter->buffer_list_dma, rxq_desc.desc,
+				    adapter->filter_list_dma, mac_address);
+
+	if (rc != H_SUCCESS && try_again) {
+		do {
+			rc = h_free_logical_lan(adapter->vdev->unit_address);
+		} while (H_IS_LONG_BUSY(rc) || (rc == H_BUSY));
+
+		try_again = 0;
+		goto retry;
+	}
+
+	return rc;
+}
+
 static int ibmveth_open(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev->priv;
@@ -503,11 +528,7 @@ static int ibmveth_open(struct net_devic
 	ibmveth_debug_printk("receive q   @ 0x%p\n", adapter->rx_queue.queue_addr);
 

-	lpar_rc = h_register_logical_lan(adapter->vdev->unit_address,
-					 adapter->buffer_list_dma,
-					 rxq_desc.desc,
-					 adapter->filter_list_dma,
-					 mac_address);
+	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
 
 	if(lpar_rc != H_SUCCESS) {
 		ibmveth_error_printk("h_register_logical_lan failed with %ld\n", lpar_rc);
