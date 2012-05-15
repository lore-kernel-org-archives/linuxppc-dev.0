Return-Path: <dan.carpenter@oracle.com>
Received: from acsinet14.oracle.com (acsinet14.oracle.com [141.146.126.236])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "acsinet14.oracle.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2CD5FB6FA7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2012 18:48:09 +1000 (EST)
Received: from acsinet15.oracle.com (acsinet15.oracle.com [141.146.126.227])
 by acsinet14.oracle.com (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with ESMTP id
 q4F8m7LZ032668
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2012 08:48:07 GMT
Date: Tue, 15 May 2012 11:47:47 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [patch] hvc_xen: NULL dereference on allocation failure
Message-ID: <20120515084746.GC30265@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Alan Cox <alan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If kzalloc() returns a NULL here, we pass a NULL to
xencons_disconnect_backend() which will cause an Oops.

Also I removed the __GFP_ZERO while I was at it since kzalloc() implies
__GFP_ZERO.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index 83d5c88..d3d91da 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -430,9 +430,9 @@ static int __devinit xencons_probe(struct xenbus_device *dev,
 	if (devid == 0)
 		return -ENODEV;
 
-	info = kzalloc(sizeof(struct xencons_info), GFP_KERNEL | __GFP_ZERO);
+	info = kzalloc(sizeof(struct xencons_info), GFP_KERNEL);
 	if (!info)
-		goto error_nomem;
+		return -ENOMEM;
 	dev_set_drvdata(&dev->dev, info);
 	info->xbdev = dev;
 	info->vtermno = xenbus_devid_to_vtermno(devid);
