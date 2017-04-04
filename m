Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy7jl6lTGzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 22:35:39 +1000 (AEST)
Date: Tue, 4 Apr 2017 15:35:23 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: nfont@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [bug report] ibmvnic: Cleanup failure path in ibmvnic_open
Message-ID: <20170404123523.GA12843@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[  This patch changed the code from using multiple come-from label names
   to using a single err label.  Both are terrible ways to do error
   handling.

   Come-From Labels:

   Come-from labels look like this:

	foo = alloc();
	if (!foo)
		goto alloc_failed;

   The "alloc_failed" name is infuriating to look at because you can
   easily see that alloc_failed because you literally just read that on
   the line before.  It looks like it is useful information but it's a
   trick.  What we want to know is what does the goto do?  The label
   name should be verb based.

   One Err Style Error Handling:

   This is the most bug prone way of handling errors.  You can easily
   see that if you count the number of bugs from static checkers.  These
   labels try to handle every possible condition which is more difficult
   than handling a specific error state.  Plus, the label names for
   these are always vague and annoying.

   This patch introduces a classic One Err Bug.

   Kernel Style Error Handling:

   It's best if you use a string of error labels that each unwind a
   specific thing.  Never free something that hasn't been allocated.
   Choose verb based labels like:

	err_release_bar:
		release_bar(bar);
	err_free_foo:
		kfree(foo);

   When you're reviewing code that uses this style of error handling you
   only need to track the most recently allocated thing.  It works like
   this:

	foo = alloc();
	if (!foo)
		return -ENOMEM;
	bar = get_bar();
	if (!bar)
		goto err_free_foo;

   With this code you don't have to scroll up and down the function.
   It's obviously correct just from looking at those 6 lines.

	- dan ]

Hello Nathan Fontenot,

The patch 1b8955ee5f6c: "ibmvnic: Cleanup failure path in
ibmvnic_open" from Mar 30, 2017, leads to the following static
checker warning:

	drivers/net/ethernet/ibm/ibmvnic.c:672 ibmvnic_open()
	error: we previously assumed 'adapter->napi' could be null (see line 626)

drivers/net/ethernet/ibm/ibmvnic.c
   593  static int ibmvnic_open(struct net_device *netdev)
   594  {
   595          struct ibmvnic_adapter *adapter = netdev_priv(netdev);
   596          struct device *dev = &adapter->vdev->dev;
   597          union ibmvnic_crq crq;
   598          int rc = 0;
   599          int i;
   600  
   601          if (adapter->is_closed) {
   602                  rc = ibmvnic_init(adapter);
   603                  if (rc)
   604                          return rc;
   605          }
   606  
   607          rc = ibmvnic_login(netdev);
   608          if (rc)
   609                  return rc;
                        ^^^^^^^^^^
See?  We didn't clean up form ibmvnic_init() so this is buggy already.
It should be goto uninit;  The One Err Style error handling is too
complicated so people just give up.  But Kernel Style error handling
methodically writes itself.

   610  
   611          rc = netif_set_real_num_tx_queues(netdev, adapter->req_tx_queues);
   612          if (rc) {
   613                  dev_err(dev, "failed to set the number of tx queues\n");
   614                  return -1;
   615          }
   616  
   617          rc = init_sub_crq_irqs(adapter);
   618          if (rc) {
   619                  dev_err(dev, "failed to initialize sub crq irqs\n");
   620                  return -1;
   621          }
   622  
   623          adapter->map_id = 1;
   624          adapter->napi = kcalloc(adapter->req_rx_queues,
   625                                  sizeof(struct napi_struct), GFP_KERNEL);
   626          if (!adapter->napi)
   627                  goto ibmvnic_open_fail;
                        ^^^^^^^^^^^^^^^^^^^^^^
If we hit this goto then we will Oops.

   628          for (i = 0; i < adapter->req_rx_queues; i++) {
   629                  netif_napi_add(netdev, &adapter->napi[i], ibmvnic_poll,
   630                                 NAPI_POLL_WEIGHT);
   631                  napi_enable(&adapter->napi[i]);
   632          }
   633  
   634          send_map_query(adapter);
   635  
   636          rc = init_rx_pools(netdev);
   637          if (rc)
   638                  goto ibmvnic_open_fail;
   639  
   640          rc = init_tx_pools(netdev);
   641          if (rc)
   642                  goto ibmvnic_open_fail;
   643  
   644          rc = init_bounce_buffer(netdev);
   645          if (rc)
   646                  goto ibmvnic_open_fail;
   647  
   648          replenish_pools(adapter);
   649  
   650          /* We're ready to receive frames, enable the sub-crq interrupts and
   651           * set the logical link state to up
   652           */
   653          for (i = 0; i < adapter->req_rx_queues; i++)
   654                  enable_scrq_irq(adapter, adapter->rx_scrq[i]);
   655  
   656          for (i = 0; i < adapter->req_tx_queues; i++)
   657                  enable_scrq_irq(adapter, adapter->tx_scrq[i]);
   658  
   659          memset(&crq, 0, sizeof(crq));
   660          crq.logical_link_state.first = IBMVNIC_CRQ_CMD;
   661          crq.logical_link_state.cmd = LOGICAL_LINK_STATE;
   662          crq.logical_link_state.link_state = IBMVNIC_LOGICAL_LNK_UP;
   663          ibmvnic_send_crq(adapter, &crq);
   664  
   665          netif_tx_start_all_queues(netdev);
   666          adapter->is_closed = false;
   667  
   668          return 0;
   669  
   670  ibmvnic_open_fail:
   671          for (i = 0; i < adapter->req_rx_queues; i++)
   672                  napi_disable(&adapter->napi[i]);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Oops.

   673          release_resources(adapter);
   674          return -ENOMEM;
   675  }

regards,
dan carpenter
