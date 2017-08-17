Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY6dR3RdTzDqfw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 23:34:35 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id y129so9938050pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 06:34:35 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: gregkh@linuxfoundation.org,
	jslaby@suse.com
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] tty: hvc_vio: constify vio_device_id
Date: Thu, 17 Aug 2017 19:04:22 +0530
Message-Id: <2ca130c97cf001e9f7936cd88091817698ae355a.1502976494.git.arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

vio_device_id are not supposed to change at runtime. All functions
working with vio_device_id provided by <asm/vio.h> work with
const vio_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/tty/hvc/hvc_vio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_vio.c b/drivers/tty/hvc/hvc_vio.c
index b05dc50..39002a1 100644
--- a/drivers/tty/hvc/hvc_vio.c
+++ b/drivers/tty/hvc/hvc_vio.c
@@ -53,7 +53,7 @@
 
 static const char hvc_driver_name[] = "hvc_console";
 
-static struct vio_device_id hvc_driver_table[] = {
+static const struct vio_device_id hvc_driver_table[] = {
 	{"serial", "hvterm1"},
 #ifndef HVC_OLD_HVSI
 	{"serial", "hvterm-protocol"},
-- 
2.7.4
