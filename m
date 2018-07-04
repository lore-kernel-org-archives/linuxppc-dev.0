Return-Path: <dan.carpenter@oracle.com>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LPSp0Rg9zF0ZD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 01:06:01 +1000 (AEST)
Date: Wed, 4 Jul 2018 17:40:50 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: vaibhav@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [bug report] cxl: Prevent adapter reset if an active context exists
Message-ID: <20180704144050.mjex2gg7hsarhc6x@kili.mountain>
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

Hello Vaibhav Jain,

The patch 70b565bbdb91: "cxl: Prevent adapter reset if an active
context exists" from Oct 14, 2016, leads to the following static
checker warning:

	drivers/misc/cxl/main.c:290 cxl_adapter_context_get()
	warn: 'atomic_inc_unless_negative(&adapter->contexts_num)' is unsigned

drivers/misc/cxl/main.c
   285  int cxl_adapter_context_get(struct cxl *adapter)
   286  {
   287          int rc;
   288  
   289          rc = atomic_inc_unless_negative(&adapter->contexts_num);
   290          return rc >= 0 ? 0 : -EBUSY;

atomic_inc_unless_negative() returns bool so it's always >= 0.

   291  }

regards,
dan carpenter
