Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJk4Z0LNwzDvd7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 23:25:49 +1100 (AEDT)
Date: Wed, 16 Nov 2016 15:25:32 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: tlfalcon@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [bug report] Driver for IBM System i/p VNIC protocol
Message-ID: <20161116122532.GA12147@mwanda>
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

Hello Thomas Falcon,

The patch 032c5e82847a: "Driver for IBM System i/p VNIC protocol"
from Dec 21, 2015, leads to the following static checker warning:

	drivers/net/ethernet/ibm/ibmvnic.c:2957 error_level_write()
	why cast 'kstrtoul()?'

drivers/net/ethernet/ibm/ibmvnic.c
  2946  static ssize_t error_level_write(struct file *file, const char __user *user_buf,
  2947                                   size_t len, loff_t *ppos)
  2948  {
  2949          struct ibmvnic_fw_comp_internal *ras_comp_int = file->private_data;
  2950          struct ibmvnic_adapter *adapter = ras_comp_int->adapter;
  2951          int num = ras_comp_int->num;
  2952          union ibmvnic_crq crq;
  2953          unsigned long val;
  2954          char buff[9]; /* decimal max int plus \n and \0 */
  2955  
  2956          copy_from_user(buff, user_buf, sizeof(buff));

No error checking.

  2957          val = kstrtoul(buff, 10, NULL);

This is a wrong conversion from simple_strtoul().  The code has clearly
never been tested.  There are four other buggy untested calls to
kstrtoul() in this file.

  2958  
  2959          if (val > 9)
  2960                  val = 9;
  2961  
  2962          memset(&crq, 0, sizeof(crq));
  2963          crq.control_ras.first = IBMVNIC_CRQ_CMD;
  2964          crq.control_ras.cmd = CONTROL_RAS;
  2965          crq.control_ras.correlator = adapter->ras_comps[num].correlator;
  2966          crq.control_ras.op = IBMVNIC_ERROR_LEVEL;
  2967          crq.control_ras.level = val;
  2968          ibmvnic_send_crq(adapter, &crq);
  2969  
  2970          return len;
  2971  }

regards,
dan carpenter
