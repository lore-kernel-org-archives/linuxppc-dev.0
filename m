Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqFCK1HfxzDvqM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 20:18:04 +1000 (AEST)
Date: Wed, 13 Jul 2016 13:13:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: clombard@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [bug report] cxl: sysfs support for guests
Message-ID: <20160713101339.GH29468@mwanda>
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

The patch 4752876c7170: "cxl: sysfs support for guests" from Mar 4,
2016, leads to the following static checker warning:

	drivers/misc/cxl/sysfs.c:681 cxl_sysfs_afu_add()
	warn: if statement not indented

drivers/misc/cxl/sysfs.c
   672  err1:
   673          cxl_sysfs_afu_remove(afu);
   674          return rc;
   675  err:
   676          /* reset the eb_len as we havent created the bin attr */
   677          afu->eb_len = 0;
   678  
   679          for (i--; i >= 0; i--) {
   680                  dev_attr = &afu_attrs[i];
   681                  if (cxl_ops->support_attributes(dev_attr->attr.name,
   682                                                  CXL_AFU_ATTRS))
   683                  device_remove_file(&afu->dev, &afu_attrs[i]);

It's tempting to add a tab but I *think* actually there is a line
missing here?  I'm not sure.

   684          }
   685          return rc;
   686  }

regards,
dan carpenter
