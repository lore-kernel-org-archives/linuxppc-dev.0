Return-Path: <prvs=685db9857=julien.grall@citrix.com>
Received: from SMTP.CITRIX.COM (smtp.citrix.com [66.165.176.89])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87BD81A2A84
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 01:38:46 +1000 (AEST)
From: Julien Grall <julien.grall@citrix.com>
To: <xen-devel@lists.xenproject.org>
CC: <linux-arm-kernel@lists.infradead.org>, <ian.campbell@citrix.com>,
 <stefano.stabellini@eu.citrix.com>, <linux-kernel@vger.kernel.org>, "Julien
 Grall" <julien.grall@citrix.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, David Vrabel
 <david.vrabel@citrix.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v4 11/20] tty/hvc: xen: Use xen page definition
Date: Mon, 7 Sep 2015 16:33:49 +0100
Message-ID: <1441640038-23615-12-git-send-email-julien.grall@citrix.com>
In-Reply-To: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
References: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
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
Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: linuxppc-dev@lists.ozlabs.org

    Changes in v4:
        - The ring is always 4K (i.e XEN_PAGE_SIZE), so no need to
        map with PAGE_SIZE. This was correctly done in v2 but lost with
        the rebase to the "s/mfn/gfn/" series

    Changes in v3:
        - Some changes has been moved in the series "Use correctly the
        Xen memory terminologies in Linux".
        - Add Stefano's reviewed-by
---
 drivers/tty/hvc/hvc_xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index 10beb15..fa816b7 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -230,7 +230,7 @@ static int xen_hvm_console_init(void)
 	if (r < 0 || v == 0)
 		goto err;
 	gfn = v;
-	info->intf = xen_remap(gfn << PAGE_SHIFT, PAGE_SIZE);
+	info->intf = xen_remap(gfn << XEN_PAGE_SHIFT, XEN_PAGE_SIZE);
 	if (info->intf == NULL)
 		goto err;
 	info->vtermno = HVC_COOKIE;
@@ -472,7 +472,7 @@ static int xencons_resume(struct xenbus_device *dev)
 	struct xencons_info *info = dev_get_drvdata(&dev->dev);
 
 	xencons_disconnect_backend(info);
-	memset(info->intf, 0, PAGE_SIZE);
+	memset(info->intf, 0, XEN_PAGE_SIZE);
 	return xencons_connect_backend(dev, info);
 }
 
-- 
2.1.4
