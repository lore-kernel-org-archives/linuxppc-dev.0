Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CDF8367A2E
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 23:46:53 +1100 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH] Change H_StudlyCaps to H_SHOUTING_CAPS
To: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Message-Id: <20060330124940.C341D211C50@Schermpje.local>
Date: Thu, 30 Mar 2006 14:49:40 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[I hope I got my mailer script to work okay, don't kill me please.]

Also cleans up some nearby whitespace problems.

Signed-of-by: Segher Boessenkool <segher@kernel.crashing.org>

---
 arch/powerpc/kernel/lparcfg.c              |   22 ++---
 arch/powerpc/kernel/rtas.c                 |   12 +-
 arch/powerpc/platforms/pseries/hvconsole.c |    6 -
 arch/powerpc/platforms/pseries/hvcserver.c |   22 ++---
 arch/powerpc/platforms/pseries/lpar.c      |   28 +++---
 arch/powerpc/platforms/pseries/setup.c     |    2 
 arch/powerpc/platforms/pseries/vio.c       |    4 
 arch/powerpc/platforms/pseries/xics.c      |    8 -
 drivers/char/hvcs.c                        |    2 
 drivers/net/ibmveth.c                      |   30 +++----
 drivers/scsi/ibmvscsi/rpa_vscsi.c          |   10 +-
 include/asm-powerpc/hvcall.h               |   85 +++++++++++----------
 12 files changed, 119 insertions(+), 112 deletions(-)

Index: linux-2.6/arch/powerpc/kernel/lparcfg.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/lparcfg.c
+++ linux-2.6/arch/powerpc/kernel/lparcfg.c
@@ -149,17 +149,17 @@
 	if (rc == 0)		/* success, return */
 		return;
 /* check for null tag ? */
-	if (rc == H_Hardware)
+	if (rc == H_HARDWARE)
 		printk(KERN_INFO
 		       "plpar-hcall (%s) failed with hardware fault\n", tag);
-	else if (rc == H_Function)
+	else if (rc == H_FUNCTION)
 		printk(KERN_INFO
 		       "plpar-hcall (%s) failed; function not allowed\n", tag);
-	else if (rc == H_Authority)
+	else if (rc == H_AUTHORITY)
 		printk(KERN_INFO
-		       "plpar-hcall (%s) failed; not authorized to this function\n",
-		       tag);
-	else if (rc == H_Parameter)
+		       "plpar-hcall (%s) failed; not authorized to this"
+		       " function\n", tag);
+	else if (rc == H_PARAMETER)
 		printk(KERN_INFO "plpar-hcall (%s) failed; Bad parameter(s)\n",
 		       tag);
 	else
@@ -209,7 +209,7 @@
 	unsigned long dummy;
 	rc = plpar_hcall(H_PIC, 0, 0, 0, 0, pool_idle_time, num_procs, &dummy);
 
-	if (rc != H_Authority)
+	if (rc != H_AUTHORITY)
 		log_plpar_hcall_return(rc, "H_PIC");
 }
 
@@ -529,13 +529,13 @@
 	retval = plpar_hcall_norets(H_SET_PPP, *new_entitled_ptr,
 				    *new_weight_ptr);
 
-	if (retval == H_Success || retval == H_Constrained) {
+	if (retval == H_SUCCESS || retval == H_CONSTRAINED) {
 		retval = count;
-	} else if (retval == H_Busy) {
+	} else if (retval == H_BUSY) {
 		retval = -EBUSY;
-	} else if (retval == H_Hardware) {
+	} else if (retval == H_HARDWARE) {
 		retval = -EIO;
-	} else if (retval == H_Parameter) {
+	} else if (retval == H_PARAMETER) {
 		retval = -EINVAL;
 	} else {
 		printk(KERN_WARNING "%s: received unknown hv return code %ld",
Index: linux-2.6/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/rtas.c
+++ linux-2.6/arch/powerpc/kernel/rtas.c
@@ -578,18 +578,18 @@
 	 * We use "waiting" to indicate our state.  As long
 	 * as it is >0, we are still trying to all join up.
 	 * If it goes to 0, we have successfully joined up and
-	 * one thread got H_Continue.  If any error happens,
+	 * one thread got H_CONTINUE.  If any error happens,
 	 * we set it to <0.
 	 */
 	local_irq_save(flags);
 	do {
 		rc = plpar_hcall_norets(H_JOIN);
 		smp_rmb();
-	} while (rc == H_Success && data->waiting > 0);
-	if (rc == H_Success)
+	} while (rc == H_SUCCESS && data->waiting > 0);
+	if (rc == H_SUCCESS)
 		goto out;
 
-	if (rc == H_Continue) {
+	if (rc == H_CONTINUE) {
 		data->waiting = 0;
 		data->args->args[data->args->nargs] =
 			rtas_call(ibm_suspend_me_token, 0, 1, NULL);
@@ -597,7 +597,7 @@
 			plpar_hcall_norets(H_PROD,i);
 	} else {
 		data->waiting = -EBUSY;
-		printk(KERN_ERR "Error on H_Join hypervisor call\n");
+		printk(KERN_ERR "Error on H_JOIN hypervisor call\n");
 	}
 
 out:
@@ -624,7 +624,7 @@
 		printk(KERN_ERR "Error doing global join\n");
 
 	/* Prod each CPU.  This won't hurt, and will wake
-	 * anyone we successfully put to sleep with H_Join
+	 * anyone we successfully put to sleep with H_JOIN.
 	 */
 	for_each_possible_cpu(i)
 		plpar_hcall_norets(H_PROD, i);
Index: linux-2.6/arch/powerpc/platforms/pseries/hvconsole.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/hvconsole.c
+++ linux-2.6/arch/powerpc/platforms/pseries/hvconsole.c
@@ -41,7 +41,7 @@
 	unsigned long got;
 
 	if (plpar_hcall(H_GET_TERM_CHAR, vtermno, 0, 0, 0, &got,
-		(unsigned long *)buf, (unsigned long *)buf+1) == H_Success)
+		(unsigned long *)buf, (unsigned long *)buf+1) == H_SUCCESS)
 		return got;
 	return 0;
 }
@@ -69,9 +69,9 @@
 
 	ret = plpar_hcall_norets(H_PUT_TERM_CHAR, vtermno, count, lbuf[0],
 				 lbuf[1]);
-	if (ret == H_Success)
+	if (ret == H_SUCCESS)
 		return count;
-	if (ret == H_Busy)
+	if (ret == H_BUSY)
 		return 0;
 	return -EIO;
 }
Index: linux-2.6/arch/powerpc/platforms/pseries/hvcserver.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/hvcserver.c
+++ linux-2.6/arch/powerpc/platforms/pseries/hvcserver.c
@@ -43,21 +43,21 @@
 static int hvcs_convert(long to_convert)
 {
 	switch (to_convert) {
-		case H_Success:
+		case H_SUCCESS:
 			return 0;
-		case H_Parameter:
+		case H_PARAMETER:
 			return -EINVAL;
-		case H_Hardware:
+		case H_HARDWARE:
 			return -EIO;
-		case H_Busy:
-		case H_LongBusyOrder1msec:
-		case H_LongBusyOrder10msec:
-		case H_LongBusyOrder100msec:
-		case H_LongBusyOrder1sec:
-		case H_LongBusyOrder10sec:
-		case H_LongBusyOrder100sec:
+		case H_BUSY:
+		case H_LONG_BUSY_ORDER_1_MSEC:
+		case H_LONG_BUSY_ORDER_10_MSEC:
+		case H_LONG_BUSY_ORDER_100_MSEC:
+		case H_LONG_BUSY_ORDER_1_SEC:
+		case H_LONG_BUSY_ORDER_10_SEC:
+		case H_LONG_BUSY_ORDER_100_SEC:
 			return -EBUSY;
-		case H_Function: /* fall through */
+		case H_FUNCTION: /* fall through */
 		default:
 			return -EPERM;
 	}
Index: linux-2.6/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/lpar.c
+++ linux-2.6/arch/powerpc/platforms/pseries/lpar.c
@@ -72,7 +72,7 @@
 
 	do {
 		rc = plpar_put_term_char(vtermno, sizeof(packet), packet);
-	} while (rc == H_Busy);
+	} while (rc == H_BUSY);
 }
 
 static long hvsi_udbg_buf_len;
@@ -85,7 +85,7 @@
 
 	if (hvsi_udbg_buf_len == 0) {
 		rc = plpar_get_term_char(vtermno, &hvsi_udbg_buf_len, hvsi_udbg_buf);
-		if (rc != H_Success || hvsi_udbg_buf[0] != 0xff) {
+		if (rc != H_SUCCESS || hvsi_udbg_buf[0] != 0xff) {
 			/* bad read or non-data packet */
 			hvsi_udbg_buf_len = 0;
 		} else {
@@ -139,7 +139,7 @@
 	buf[0] = c;
 	do {
 		rc = plpar_put_term_char(vtermno, 1, buf);
-	} while(rc == H_Busy);
+	} while(rc == H_BUSY);
 }
 
 /* Buffered chars getc */
@@ -158,7 +158,7 @@
 		/* get some more chars. */
 		inbuflen = 0;
 		rc = plpar_get_term_char(vtermno, &inbuflen, buf);
-		if (rc != H_Success)
+		if (rc != H_SUCCESS)
 			inbuflen = 0;	/* otherwise inbuflen is garbage */
 	}
 	if (inbuflen <= 0 || inbuflen > 16) {
@@ -304,7 +304,7 @@
 
 	lpar_rc = plpar_hcall(H_ENTER, flags, hpte_group, hpte_v,
 			      hpte_r, &slot, &dummy0, &dummy1);
-	if (unlikely(lpar_rc == H_PTEG_Full)) {
+	if (unlikely(lpar_rc == H_PTEG_FULL)) {
 		if (!(vflags & HPTE_V_BOLTED))
 			DBG_LOW(" full\n");
 		return -1;
@@ -315,7 +315,7 @@
 	 * will fail. However we must catch the failure in hash_page
 	 * or we will loop forever, so return -2 in this case.
 	 */
-	if (unlikely(lpar_rc != H_Success)) {
+	if (unlikely(lpar_rc != H_SUCCESS)) {
 		if (!(vflags & HPTE_V_BOLTED))
 			DBG_LOW(" lpar err %d\n", lpar_rc);
 		return -2;
@@ -346,9 +346,9 @@
 		/* don't remove a bolted entry */
 		lpar_rc = plpar_pte_remove(H_ANDCOND, hpte_group + slot_offset,
 					   (0x1UL << 4), &dummy1, &dummy2);
-		if (lpar_rc == H_Success)
+		if (lpar_rc == H_SUCCESS)
 			return i;
-		BUG_ON(lpar_rc != H_Not_Found);
+		BUG_ON(lpar_rc != H_NOT_FOUND);
 
 		slot_offset++;
 		slot_offset &= 0x7;
@@ -391,14 +391,14 @@
 
 	lpar_rc = plpar_pte_protect(flags, slot, want_v & HPTE_V_AVPN);
 
-	if (lpar_rc == H_Not_Found) {
+	if (lpar_rc == H_NOT_FOUND) {
 		DBG_LOW("not found !\n");
 		return -1;
 	}
 
 	DBG_LOW("ok\n");
 
-	BUG_ON(lpar_rc != H_Success);
+	BUG_ON(lpar_rc != H_SUCCESS);
 
 	return 0;
 }
@@ -417,7 +417,7 @@
 
 	lpar_rc = plpar_pte_read(flags, slot, &dword0, &dummy_word1);
 
-	BUG_ON(lpar_rc != H_Success);
+	BUG_ON(lpar_rc != H_SUCCESS);
 
 	return dword0;
 }
@@ -468,7 +468,7 @@
 	flags = newpp & 7;
 	lpar_rc = plpar_pte_protect(flags, slot, 0);
 
-	BUG_ON(lpar_rc != H_Success);
+	BUG_ON(lpar_rc != H_SUCCESS);
 }
 
 static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long va,
@@ -484,10 +484,10 @@
 	want_v = hpte_encode_v(va, psize);
 	lpar_rc = plpar_pte_remove(H_AVPN, slot, want_v & HPTE_V_AVPN,
 				   &dummy1, &dummy2);
-	if (lpar_rc == H_Not_Found)
+	if (lpar_rc == H_NOT_FOUND)
 		return;
 
-	BUG_ON(lpar_rc != H_Success);
+	BUG_ON(lpar_rc != H_SUCCESS);
 }
 
 /*
Index: linux-2.6/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/setup.c
+++ linux-2.6/arch/powerpc/platforms/pseries/setup.c
@@ -463,7 +463,7 @@
 	 * very low priority.  The cede enables interrupts, which
 	 * doesn't matter here.
 	 */
-	if (!lppaca[cpu ^ 1].idle || poll_pending() == H_Pending)
+	if (!lppaca[cpu ^ 1].idle || poll_pending() == H_PENDING)
 		cede_processor();
 
 out:
Index: linux-2.6/arch/powerpc/platforms/pseries/vio.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/vio.c
+++ linux-2.6/arch/powerpc/platforms/pseries/vio.c
@@ -258,7 +258,7 @@
 int vio_enable_interrupts(struct vio_dev *dev)
 {
 	int rc = h_vio_signal(dev->unit_address, VIO_IRQ_ENABLE);
-	if (rc != H_Success)
+	if (rc != H_SUCCESS)
 		printk(KERN_ERR "vio: Error 0x%x enabling interrupts\n", rc);
 	return rc;
 }
@@ -267,7 +267,7 @@
 int vio_disable_interrupts(struct vio_dev *dev)
 {
 	int rc = h_vio_signal(dev->unit_address, VIO_IRQ_DISABLE);
-	if (rc != H_Success)
+	if (rc != H_SUCCESS)
 		printk(KERN_ERR "vio: Error 0x%x disabling interrupts\n", rc);
 	return rc;
 }
Index: linux-2.6/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/xics.c
+++ linux-2.6/arch/powerpc/platforms/pseries/xics.c
@@ -168,7 +168,7 @@
 	unsigned long return_value;
 
 	lpar_rc = plpar_xirr(&return_value);
-	if (lpar_rc != H_Success)
+	if (lpar_rc != H_SUCCESS)
 		panic(" bad return code xirr - rc = %lx \n", lpar_rc);
 	return (int)return_value;
 }
@@ -179,7 +179,7 @@
 	unsigned long val64 = value & 0xffffffff;
 
 	lpar_rc = plpar_eoi(val64);
-	if (lpar_rc != H_Success)
+	if (lpar_rc != H_SUCCESS)
 		panic("bad return code EOI - rc = %ld, value=%lx\n", lpar_rc,
 		      val64);
 }
@@ -189,7 +189,7 @@
 	unsigned long lpar_rc;
 
 	lpar_rc = plpar_cppr(value);
-	if (lpar_rc != H_Success)
+	if (lpar_rc != H_SUCCESS)
 		panic("bad return code cppr - rc = %lx\n", lpar_rc);
 }
 
@@ -198,7 +198,7 @@
 	unsigned long lpar_rc;
 
 	lpar_rc = plpar_ipi(get_hard_smp_processor_id(n_cpu), value);
-	if (lpar_rc != H_Success)
+	if (lpar_rc != H_SUCCESS)
 		panic("bad return code qirr - rc = %lx\n", lpar_rc);
 }
 
Index: linux-2.6/drivers/char/hvcs.c
===================================================================
--- linux-2.6.orig/drivers/char/hvcs.c
+++ linux-2.6/drivers/char/hvcs.c
@@ -904,7 +904,7 @@
 		 * It is possible the vty-server was removed after the irq was
 		 * requested but before we have time to enable interrupts.
 		 */
-		if (vio_enable_interrupts(vdev) == H_Success)
+		if (vio_enable_interrupts(vdev) == H_SUCCESS)
 			return 0;
 		else {
 			printk(KERN_ERR "HVCS: int enable failed for"
Index: linux-2.6/drivers/net/ibmveth.c
===================================================================
--- linux-2.6.orig/drivers/net/ibmveth.c
+++ linux-2.6/drivers/net/ibmveth.c
@@ -235,7 +235,7 @@
 
 		lpar_rc = h_add_logical_lan_buffer(adapter->vdev->unit_address, desc.desc);
 		    
-		if(lpar_rc != H_Success) {
+		if(lpar_rc != H_SUCCESS) {
 			pool->free_map[free_index] = index;
 			pool->skbuff[index] = NULL;
 			pool->consumer_index--;
@@ -373,7 +373,7 @@
 
 	lpar_rc = h_add_logical_lan_buffer(adapter->vdev->unit_address, desc.desc);
 		    
-	if(lpar_rc != H_Success) {
+	if(lpar_rc != H_SUCCESS) {
 		ibmveth_debug_printk("h_add_logical_lan_buffer failed during recycle rc=%ld", lpar_rc);
 		ibmveth_remove_buffer_from_pool(adapter, adapter->rx_queue.queue_addr[adapter->rx_queue.index].correlator);
 	}
@@ -511,7 +511,7 @@
 					 adapter->filter_list_dma,
 					 mac_address);
 
-	if(lpar_rc != H_Success) {
+	if(lpar_rc != H_SUCCESS) {
 		ibmveth_error_printk("h_register_logical_lan failed with %ld\n", lpar_rc);
 		ibmveth_error_printk("buffer TCE:0x%lx filter TCE:0x%lx rxq desc:0x%lx MAC:0x%lx\n",
 				     adapter->buffer_list_dma,
@@ -527,7 +527,7 @@
 		ibmveth_error_printk("unable to request irq 0x%x, rc %d\n", netdev->irq, rc);
 		do {
 			rc = h_free_logical_lan(adapter->vdev->unit_address);
-		} while (H_isLongBusy(rc) || (rc == H_Busy));
+		} while (H_IS_LONG_BUSY(rc) || (rc == H_BUSY));
 
 		ibmveth_cleanup(adapter);
 		return rc;
@@ -556,9 +556,9 @@
 
 	do {
 		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
-	} while (H_isLongBusy(lpar_rc) || (lpar_rc == H_Busy));
+	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
 
-	if(lpar_rc != H_Success)
+	if(lpar_rc != H_SUCCESS)
 	{
 		ibmveth_error_printk("h_free_logical_lan failed with %lx, continuing with close\n",
 				     lpar_rc);
@@ -693,9 +693,9 @@
 					     desc[4].desc,
 					     desc[5].desc,
 					     correlator);
-	} while ((lpar_rc == H_Busy) && (retry_count--));
+	} while ((lpar_rc == H_BUSY) && (retry_count--));
     
-	if(lpar_rc != H_Success && lpar_rc != H_Dropped) {
+	if(lpar_rc != H_SUCCESS && lpar_rc != H_DROPPED) {
 		int i;
 		ibmveth_error_printk("tx: h_send_logical_lan failed with rc=%ld\n", lpar_rc);
 		for(i = 0; i < 6; i++) {
@@ -786,14 +786,14 @@
 	/* we think we are done - reenable interrupts, then check once more to make sure we are done */
 	lpar_rc = h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_ENABLE);
 
-	ibmveth_assert(lpar_rc == H_Success);
+	ibmveth_assert(lpar_rc == H_SUCCESS);
 
 	netif_rx_complete(netdev);
 
 	if(ibmveth_rxq_pending_buffer(adapter) && netif_rx_reschedule(netdev, frames_processed))
 	{
 		lpar_rc = h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
-		ibmveth_assert(lpar_rc == H_Success);
+		ibmveth_assert(lpar_rc == H_SUCCESS);
 		more_work = 1;
 		goto restart_poll;
 	}
@@ -813,7 +813,7 @@
 
 	if(netif_rx_schedule_prep(netdev)) {
 		lpar_rc = h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
-		ibmveth_assert(lpar_rc == H_Success);
+		ibmveth_assert(lpar_rc == H_SUCCESS);
 		__netif_rx_schedule(netdev);
 	}
 	return IRQ_HANDLED;
@@ -835,7 +835,7 @@
 					   IbmVethMcastEnableRecv |
 					   IbmVethMcastDisableFiltering,
 					   0);
-		if(lpar_rc != H_Success) {
+		if(lpar_rc != H_SUCCESS) {
 			ibmveth_error_printk("h_multicast_ctrl rc=%ld when entering promisc mode\n", lpar_rc);
 		}
 	} else {
@@ -847,7 +847,7 @@
 					   IbmVethMcastDisableFiltering |
 					   IbmVethMcastClearFilterTable,
 					   0);
-		if(lpar_rc != H_Success) {
+		if(lpar_rc != H_SUCCESS) {
 			ibmveth_error_printk("h_multicast_ctrl rc=%ld when attempting to clear filter table\n", lpar_rc);
 		}
 		/* add the addresses to the filter table */
@@ -858,7 +858,7 @@
 			lpar_rc = h_multicast_ctrl(adapter->vdev->unit_address,
 						   IbmVethMcastAddFilter,
 						   mcast_addr);
-			if(lpar_rc != H_Success) {
+			if(lpar_rc != H_SUCCESS) {
 				ibmveth_error_printk("h_multicast_ctrl rc=%ld when adding an entry to the filter table\n", lpar_rc);
 			}
 		}
@@ -867,7 +867,7 @@
 		lpar_rc = h_multicast_ctrl(adapter->vdev->unit_address,
 					   IbmVethMcastEnableFiltering,
 					   0);
-		if(lpar_rc != H_Success) {
+		if(lpar_rc != H_SUCCESS) {
 			ibmveth_error_printk("h_multicast_ctrl rc=%ld when enabling filtering\n", lpar_rc);
 		}
 	}
Index: linux-2.6/drivers/scsi/ibmvscsi/rpa_vscsi.c
===================================================================
--- linux-2.6.orig/drivers/scsi/ibmvscsi/rpa_vscsi.c
+++ linux-2.6/drivers/scsi/ibmvscsi/rpa_vscsi.c
@@ -80,7 +80,7 @@
 	tasklet_kill(&hostdata->srp_task);
 	do {
 		rc = plpar_hcall_norets(H_FREE_CRQ, vdev->unit_address);
-	} while ((rc == H_Busy) || (H_isLongBusy(rc)));
+	} while ((rc == H_BUSY) || (H_IS_LONG_BUSY(rc)));
 	dma_unmap_single(hostdata->dev,
 			 queue->msg_token,
 			 queue->size * sizeof(*queue->msgs), DMA_BIDIRECTIONAL);
@@ -230,7 +230,7 @@
 	rc = plpar_hcall_norets(H_REG_CRQ,
 				vdev->unit_address,
 				queue->msg_token, PAGE_SIZE);
-	if (rc == H_Resource) 
+	if (rc == H_RESOURCE)
 		/* maybe kexecing and resource is busy. try a reset */
 		rc = ibmvscsi_reset_crq_queue(queue,
 					      hostdata);
@@ -269,7 +269,7 @@
       req_irq_failed:
 	do {
 		rc = plpar_hcall_norets(H_FREE_CRQ, vdev->unit_address);
-	} while ((rc == H_Busy) || (H_isLongBusy(rc)));
+	} while ((rc == H_BUSY) || (H_IS_LONG_BUSY(rc)));
       reg_crq_failed:
 	dma_unmap_single(hostdata->dev,
 			 queue->msg_token,
@@ -295,7 +295,7 @@
 	/* Re-enable the CRQ */
 	do {
 		rc = plpar_hcall_norets(H_ENABLE_CRQ, vdev->unit_address);
-	} while ((rc == H_InProgress) || (rc == H_Busy) || (H_isLongBusy(rc)));
+	} while ((rc == H_IN_PROGRESS) || (rc == H_BUSY) || (H_IS_LONG_BUSY(rc)));
 
 	if (rc)
 		printk(KERN_ERR "ibmvscsi: Error %d enabling adapter\n", rc);
@@ -317,7 +317,7 @@
 	/* Close the CRQ */
 	do {
 		rc = plpar_hcall_norets(H_FREE_CRQ, vdev->unit_address);
-	} while ((rc == H_Busy) || (H_isLongBusy(rc)));
+	} while ((rc == H_BUSY) || (H_IS_LONG_BUSY(rc)));
 
 	/* Clean out the queue */
 	memset(queue->msgs, 0x00, PAGE_SIZE);
Index: linux-2.6/include/asm-powerpc/hvcall.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/hvcall.h
+++ linux-2.6/include/asm-powerpc/hvcall.h
@@ -4,47 +4,54 @@
 
 #define HVSC			.long 0x44000022
 
-#define H_Success	0
-#define H_Busy		1	/* Hardware busy -- retry later */
-#define H_Closed	2	/* Resource closed */
-#define H_Constrained	4	/* Resource request constrained to max allowed */
-#define H_InProgress   14	/* Kind of like busy */
-#define H_Pending      17	/* returned from H_POLL_PENDING */
-#define H_Continue     18	/* Returned from H_Join on success */
-#define H_LongBusyStartRange   9900  /* Start of long busy range */
-#define H_LongBusyOrder1msec   9900  /* Long busy, hint that 1msec is a good time to retry */
-#define H_LongBusyOrder10msec  9901  /* Long busy, hint that 10msec is a good time to retry */
-#define H_LongBusyOrder100msec 9902  /* Long busy, hint that 100msec is a good time to retry */
-#define H_LongBusyOrder1sec    9903  /* Long busy, hint that 1sec is a good time to retry */
-#define H_LongBusyOrder10sec   9904  /* Long busy, hint that 10sec is a good time to retry */
-#define H_LongBusyOrder100sec  9905  /* Long busy, hint that 100sec is a good time to retry */
-#define H_LongBusyEndRange     9905  /* End of long busy range */
-#define H_Hardware	-1	/* Hardware error */
-#define H_Function	-2	/* Function not supported */
-#define H_Privilege	-3	/* Caller not privileged */
-#define H_Parameter	-4	/* Parameter invalid, out-of-range or conflicting */
-#define H_Bad_Mode	-5	/* Illegal msr value */
-#define H_PTEG_Full	-6	/* PTEG is full */
-#define H_Not_Found	-7	/* PTE was not found" */
-#define H_Reserved_DABR	-8	/* DABR address is reserved by the hypervisor on this processor" */
-#define H_NoMem                 -9
-#define H_Authority            -10
-#define H_Permission           -11
-#define H_Dropped              -12
-#define H_SourceParm           -13
-#define H_DestParm             -14
-#define H_RemoteParm           -15
-#define H_Resource             -16
+#define H_SUCCESS	0
+#define H_BUSY		1	/* Hardware busy -- retry later */
+#define H_CLOSED	2	/* Resource closed */
+#define H_CONSTRAINED	4	/* Resource request constrained to max allowed */
+#define H_IN_PROGRESS	14	/* Kind of like busy */
+#define H_PENDING	17	/* returned from H_POLL_PENDING */
+#define H_CONTINUE	18	/* Returned from H_Join on success */
+#define H_LONG_BUSY_START_RANGE		9900  /* Start of long busy range */
+#define H_LONG_BUSY_ORDER_1_MSEC	9900  /* Long busy, hint that 1msec \
+						 is a good time to retry */
+#define H_LONG_BUSY_ORDER_10_MSEC	9901  /* Long busy, hint that 10msec \
+						 is a good time to retry */
+#define H_LONG_BUSY_ORDER_100_MSEC 	9902  /* Long busy, hint that 100msec \
+						 is a good time to retry */
+#define H_LONG_BUSY_ORDER_1_SEC		9903  /* Long busy, hint that 1sec \
+						 is a good time to retry */
+#define H_LONG_BUSY_ORDER_10_SEC	9904  /* Long busy, hint that 10sec \
+						 is a good time to retry */
+#define H_LONG_BUSY_ORDER_100_SEC	9905  /* Long busy, hint that 100sec \
+						 is a good time to retry */
+#define H_LONG_BUSY_END_RANGE		9905  /* End of long busy range */
+#define H_HARDWARE	-1	/* Hardware error */
+#define H_FUNCTION	-2	/* Function not supported */
+#define H_PRIVILEGE	-3	/* Caller not privileged */
+#define H_PARAMETER	-4	/* Parameter invalid, out-of-range or conflicting */
+#define H_BAD_MODE	-5	/* Illegal msr value */
+#define H_PTEG_FULL	-6	/* PTEG is full */
+#define H_NOT_FOUND	-7	/* PTE was not found" */
+#define H_RESERVED_DABR	-8	/* DABR address is reserved by the hypervisor on this processor" */
+#define H_NO_MEM	-9
+#define H_AUTHORITY	-10
+#define H_PERMISSION	-11
+#define H_DROPPED	-12
+#define H_SOURCE_PARM	-13
+#define H_DEST_PARM	-14
+#define H_REMOTE_PARM	-15
+#define H_RESOURCE	-16
 
 /* Long Busy is a condition that can be returned by the firmware
  * when a call cannot be completed now, but the identical call
  * should be retried later.  This prevents calls blocking in the
- * firmware for long periods of time. Annoyingly the firmware can return
+ * firmware for long periods of time.  Annoyingly the firmware can return
  * a range of return codes, hinting at how long we should wait before
  * retrying.  If you don't care for the hint, the macro below is a good
  * way to check for the long_busy return codes
  */
-#define H_isLongBusy(x)  ((x >= H_LongBusyStartRange) && (x <= H_LongBusyEndRange))
+#define H_IS_LONG_BUSY(x)  ((x >= H_LONG_BUSY_START_RANGE) \
+			     && (x <= H_LONG_BUSY_END_RANGE))
 
 /* Flags */
 #define H_LARGE_PAGE		(1UL<<(63-16))
@@ -99,25 +106,25 @@
 #define H_PERFMON		0x7c
 #define H_MIGRATE_DMA		0x78
 #define H_REGISTER_VPA		0xDC
-#define H_CEDE		        0xE0
+#define H_CEDE			0xE0
 #define H_CONFER		0xE4
-#define H_PROD		        0xE8
+#define H_PROD			0xE8
 #define H_GET_PPP		0xEC
 #define H_SET_PPP		0xF0
 #define H_PURR			0xF4
-#define H_PIC		        0xF8
+#define H_PIC			0xF8
 #define H_REG_CRQ		0xFC
 #define H_FREE_CRQ		0x100
 #define H_VIO_SIGNAL		0x104
 #define H_SEND_CRQ		0x108
-#define H_COPY_RDMA             0x110
+#define H_COPY_RDMA		0x110
 #define H_SET_XDABR		0x134
 #define H_STUFF_TCE		0x138
 #define H_PUT_TCE_INDIRECT	0x13C
 #define H_VTERM_PARTNER_INFO	0x150
 #define H_REGISTER_VTERM	0x154
 #define H_FREE_VTERM		0x158
-#define H_POLL_PENDING	        0x1D8
+#define H_POLL_PENDING		0x1D8
 #define H_JOIN			0x298
 #define H_ENABLE_CRQ		0x2B0
 
@@ -152,7 +159,7 @@
  */
 long plpar_hcall_8arg_2ret(unsigned long opcode,
 			   unsigned long arg1,
-		  	   unsigned long arg2,
+			   unsigned long arg2,
 			   unsigned long arg3,
 			   unsigned long arg4,
 			   unsigned long arg5,
