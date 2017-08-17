Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY6dT60KfzDqfw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 23:34:37 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 83so9935522pgb.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 06:34:37 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: gregkh@linuxfoundation.org,
	jslaby@suse.com
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] tty: hvcs: constify vio_device_id
Date: Thu, 17 Aug 2017 19:04:23 +0530
Message-Id: <f0d9e3a3da5aea4a5f133a67390ea7883c353e0f.1502976494.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <2ca130c97cf001e9f7936cd88091817698ae355a.1502976494.git.arvind.yadav.cs@gmail.com>
References: <2ca130c97cf001e9f7936cd88091817698ae355a.1502976494.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <2ca130c97cf001e9f7936cd88091817698ae355a.1502976494.git.arvind.yadav.cs@gmail.com>
References: <2ca130c97cf001e9f7936cd88091817698ae355a.1502976494.git.arvind.yadav.cs@gmail.com>
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
 drivers/tty/hvc/hvcs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 79cc5be..7320190 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -675,7 +675,7 @@ static int khvcsd(void *unused)
 	return 0;
 }
 
-static struct vio_device_id hvcs_driver_table[] = {
+static const struct vio_device_id hvcs_driver_table[] = {
 	{"serial-server", "hvterm2"},
 	{ "", "" }
 };
-- 
2.7.4
