Return-Path: <joe@perches.com>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 (using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6C1822C0099
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 07:08:23 +1000 (EST)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] hvc_xen: Remove unnecessary __GFP_ZERO from kzalloc
Date: Thu, 29 Aug 2013 14:08:18 -0700
Message-Id: <3cf4280498661e3099cf53ef408581fb2de9c006.1377810330.git.joe@perches.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jiri Slaby <jslaby@suse.cz>,
 linuxppc-dev@lists.ozlabs.org,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kzalloc already adds this __GFP_ZERO.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/tty/hvc/hvc_xen.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index 682210d..e61c36c 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -208,7 +208,7 @@ static int xen_hvm_console_init(void)
 
 	info = vtermno_to_xencons(HVC_COOKIE);
 	if (!info) {
-		info = kzalloc(sizeof(struct xencons_info), GFP_KERNEL | __GFP_ZERO);
+		info = kzalloc(sizeof(struct xencons_info), GFP_KERNEL);
 		if (!info)
 			return -ENOMEM;
 	} else if (info->intf != NULL) {
@@ -257,7 +257,7 @@ static int xen_pv_console_init(void)
 
 	info = vtermno_to_xencons(HVC_COOKIE);
 	if (!info) {
-		info = kzalloc(sizeof(struct xencons_info), GFP_KERNEL | __GFP_ZERO);
+		info = kzalloc(sizeof(struct xencons_info), GFP_KERNEL);
 		if (!info)
 			return -ENOMEM;
 	} else if (info->intf != NULL) {
@@ -284,7 +284,7 @@ static int xen_initial_domain_console_init(void)
 
 	info = vtermno_to_xencons(HVC_COOKIE);
 	if (!info) {
-		info = kzalloc(sizeof(struct xencons_info), GFP_KERNEL | __GFP_ZERO);
+		info = kzalloc(sizeof(struct xencons_info), GFP_KERNEL);
 		if (!info)
 			return -ENOMEM;
 	}
-- 
1.8.1.2.459.gbcd45b4.dirty
