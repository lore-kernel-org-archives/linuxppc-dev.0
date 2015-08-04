Return-Path: <prvs=651eb886a=julien.grall@citrix.com>
Received: from SMTP.CITRIX.COM (smtp.citrix.com [66.165.176.89])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2713E1A1BE5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 04:13:58 +1000 (AEST)
From: Julien Grall <julien.grall@citrix.com>
To: <xen-devel@lists.xenproject.org>
CC: <ian.campbell@citrix.com>, <stefano.stabellini@eu.citrix.com>,
 <linux-kernel@vger.kernel.org>, Julien Grall <julien.grall@citrix.com>, David
 Vrabel <david.vrabel@citrix.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 7/8] hvc/xen: Further s/MFN/GFN clean-up
Date: Tue, 4 Aug 2015 19:12:51 +0100
Message-ID: <1438711972-18752-8-git-send-email-julien.grall@citrix.com>
In-Reply-To: <1438711972-18752-1-git-send-email-julien.grall@citrix.com>
References: <1438711972-18752-1-git-send-email-julien.grall@citrix.com>
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

HVM_PARAM_CONSOLE_PFN is used to retrieved the console PFN for HVM
guest. It returns a PFN (aka GFN) and not a MFN.

Furthermore, use directly virt_to_gfn for both PV and HVM domain rather
than doing a special case for each of the them.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Reviewed-by: David Vrabel <david.vrabel@citrix.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linuxppc-dev@lists.ozlabs.org

---
    Changes in v2:
        - Add David's reviewed-by
---
 drivers/tty/hvc/hvc_xen.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index efe5124..10beb15 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -200,7 +200,7 @@ static int xen_hvm_console_init(void)
 {
 	int r;
 	uint64_t v = 0;
-	unsigned long mfn;
+	unsigned long gfn;
 	struct xencons_info *info;
 
 	if (!xen_hvm_domain())
@@ -217,7 +217,7 @@ static int xen_hvm_console_init(void)
 	}
 	/*
 	 * If the toolstack (or the hypervisor) hasn't set these values, the
-	 * default value is 0. Even though mfn = 0 and evtchn = 0 are
+	 * default value is 0. Even though gfn = 0 and evtchn = 0 are
 	 * theoretically correct values, in practice they never are and they
 	 * mean that a legacy toolstack hasn't initialized the pv console correctly.
 	 */
@@ -229,8 +229,8 @@ static int xen_hvm_console_init(void)
 	r = hvm_get_parameter(HVM_PARAM_CONSOLE_PFN, &v);
 	if (r < 0 || v == 0)
 		goto err;
-	mfn = v;
-	info->intf = xen_remap(mfn << PAGE_SHIFT, PAGE_SIZE);
+	gfn = v;
+	info->intf = xen_remap(gfn << PAGE_SHIFT, PAGE_SIZE);
 	if (info->intf == NULL)
 		goto err;
 	info->vtermno = HVC_COOKIE;
@@ -375,7 +375,6 @@ static int xencons_connect_backend(struct xenbus_device *dev,
 	int ret, evtchn, devid, ref, irq;
 	struct xenbus_transaction xbt;
 	grant_ref_t gref_head;
-	unsigned long mfn;
 
 	ret = xenbus_alloc_evtchn(dev, &evtchn);
 	if (ret)
@@ -390,10 +389,6 @@ static int xencons_connect_backend(struct xenbus_device *dev,
 			irq, &domU_hvc_ops, 256);
 	if (IS_ERR(info->hvc))
 		return PTR_ERR(info->hvc);
-	if (xen_pv_domain())
-		mfn = virt_to_gfn(info->intf);
-	else
-		mfn = __pa(info->intf) >> PAGE_SHIFT;
 	ret = gnttab_alloc_grant_references(1, &gref_head);
 	if (ret < 0)
 		return ret;
@@ -402,7 +397,7 @@ static int xencons_connect_backend(struct xenbus_device *dev,
 	if (ref < 0)
 		return ref;
 	gnttab_grant_foreign_access_ref(ref, info->xbdev->otherend_id,
-			mfn, 0);
+					virt_to_gfn(info->intf), 0);
 
  again:
 	ret = xenbus_transaction_start(&xbt);
-- 
2.1.4
