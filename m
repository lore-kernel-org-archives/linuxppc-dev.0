Return-Path: <dan.carpenter@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rr8by5nZxzDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 07:54:06 +1000 (AEST)
Date: Fri, 15 Jul 2016 00:53:52 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: clombard@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [bug report] cxl: Add guest-specific code
Message-ID: <20160714215352.GA19749@mwanda>
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

Hello Christophe Lombard,

The patch 14baf4d9c739: "cxl: Add guest-specific code" from Mar 4,
2016, leads to the following static checker warning:

	drivers/misc/cxl/guest.c:1115 cxl_guest_init_adapter()
	error: we previously assumed 'adapter->guest' could be null (see line 1114)

drivers/misc/cxl/guest.c
  1105  struct cxl *cxl_guest_init_adapter(struct device_node *np, struct platform_device *pdev)
  1106  {
  1107          struct cxl *adapter;
  1108          bool free = true;
  1109          int rc;
  1110  
  1111          if (!(adapter = cxl_alloc_adapter()))
  1112                  return ERR_PTR(-ENOMEM);
  1113  
  1114          if (!(adapter->guest = kzalloc(sizeof(struct cxl_guest), GFP_KERNEL))) {
  1115                  free_adapter(adapter);
                        ^^^^^^^^^^^^^^^^^^^^^
We can't call free_adapter() if adapter->guest is NULL.

  1116                  return ERR_PTR(-ENOMEM);
  1117          }


	drivers/misc/cxl/guest.c:919 afu_properties_look_ok()
	warn: unsigned 'afu->crs_len' is never less than zero.

drivers/misc/cxl/guest.c
   907  static int afu_properties_look_ok(struct cxl_afu *afu)
   908  {
   909          if (afu->pp_irqs < 0) {
   910                  dev_err(&afu->dev, "Unexpected per-process minimum interrupt value\n");
   911                  return -EINVAL;
   912          }
   913  
   914          if (afu->max_procs_virtualised < 1) {
   915                  dev_err(&afu->dev, "Unexpected max number of processes virtualised value\n");
   916                  return -EINVAL;
   917          }
   918  
   919          if (afu->crs_len < 0) {
                    ^^^^^^^^^^^^^^^^
Remove this test.  Unsigned is never less than zero.

   920                  dev_err(&afu->dev, "Unexpected configuration record size value\n");
   921                  return -EINVAL;
   922          }
   923  
   924          return 0;
   925  }


regards,
dan carpenter
