Return-Path: <julien.grall@citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A61781A0015
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 03:29:20 +1000 (AEST)
From: Julien Grall <julien.grall@citrix.com>
To: <xen-devel@lists.xenproject.org>
Subject: [RFC 14/23] tty/hvc: xen: Use xen page definition
Date: Thu, 14 May 2015 18:00:54 +0100
Message-ID: <1431622863-28575-15-git-send-email-julien.grall@citrix.com>
In-Reply-To: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: ian.campbell@citrix.com, stefano.stabellini@eu.citrix.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 tim@xen.org, linux-kernel@vger.kernel.org,
 Julien Grall <julien.grall@citrix.com>, David Vrabel <david.vrabel@citrix.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Jiri Slaby <jslaby@suse.cz>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The console ring is always based on the page granularity of Xen.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/tty/hvc/hvc_xen.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index 5bab1c6..a68d115 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -230,7 +230,7 @@ static int xen_hvm_console_init(void)
 	if (r < 0 || v == 0)
 		goto err;
 	mfn = v;
-	info->intf = xen_remap(mfn << PAGE_SHIFT, PAGE_SIZE);
+	info->intf = xen_remap(mfn << XEN_PAGE_SHIFT, XEN_PAGE_SIZE);
 	if (info->intf == NULL)
 		goto err;
 	info->vtermno = HVC_COOKIE;
@@ -392,7 +392,7 @@ static int xencons_connect_backend(struct xenbus_device *dev,
 	if (xen_pv_domain())
 		mfn = virt_to_mfn(info->intf);
 	else
-		mfn = __pa(info->intf) >> PAGE_SHIFT;
+		mfn = __pa(info->intf) >> XEN_PAGE_SHIFT;
 	ret = gnttab_alloc_grant_references(1, &gref_head);
 	if (ret < 0)
 		return ret;
@@ -476,7 +476,7 @@ static int xencons_resume(struct xenbus_device *dev)
 	struct xencons_info *info = dev_get_drvdata(&dev->dev);
 
 	xencons_disconnect_backend(info);
-	memset(info->intf, 0, PAGE_SIZE);
+	memset(info->intf, 0, XEN_PAGE_SIZE);
 	return xencons_connect_backend(dev, info);
 }
 
-- 
2.1.4
