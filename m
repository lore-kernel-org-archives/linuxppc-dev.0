Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BBC281A001D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 08:56:39 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
 Jiri Slaby <jslaby@suse.com>, David Vrabel <david.vrabel@citrix.com>,
 Julien Grall <julien.grall@citrix.com>,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
 Wei Liu <wei.liu2@citrix.com>, Jan Beulich <JBeulich@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] tty: hvc_xen: hide xen_console_remove when unused
Date: Mon, 25 Jan 2016 22:54:58 +0100
Message-Id: <1453758918-3577213-3-git-send-email-arnd@arndb.de>
In-Reply-To: <1453758918-3577213-1-git-send-email-arnd@arndb.de>
References: <1453758918-3577213-1-git-send-email-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

xencons_disconnect_backend() is only called from xen_console_remove(),
which is conditionally compiled, so we get a harmless warning when
CONFIG_HVC_XEN_FRONTEND is unset:

hvc/hvc_xen.c:350:12: error: 'xen_console_remove' defined but not used [-Werror=unused-function]

This moves the function down into the same #ifdef section to silence
the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/hvc/hvc_xen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index fa816b7193b6..11725422dacb 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -323,6 +323,7 @@ void xen_console_resume(void)
 	}
 }
 
+#ifdef CONFIG_HVC_XEN_FRONTEND
 static void xencons_disconnect_backend(struct xencons_info *info)
 {
 	if (info->irq > 0)
@@ -363,7 +364,6 @@ static int xen_console_remove(struct xencons_info *info)
 	return 0;
 }
 
-#ifdef CONFIG_HVC_XEN_FRONTEND
 static int xencons_remove(struct xenbus_device *dev)
 {
 	return xen_console_remove(dev_get_drvdata(&dev->dev));
-- 
2.7.0
