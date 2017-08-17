Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYCyn6k9HzDrJQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 03:34:57 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id y192so10900337pgd.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 10:34:57 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: ashleydlai@gmail.com, peterhuewe@gmx.de, tpmdd@selhorst.net,
 jarkko.sakkinen@linux.intel.com, jgunthorpe@obsidianresearch.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 tpmdd-devel@lists.sourceforge.net
Subject: [PATCH] tpm: vtpm: constify vio_device_id
Date: Thu, 17 Aug 2017 23:04:21 +0530
Message-Id: <a9ebcd668f5a7293c3805d0b6b21245f15c80212.1502989694.git.arvind.yadav.cs@gmail.com>
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
 drivers/char/tpm/tpm_ibmvtpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index f01d083..d2ce46b 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -32,7 +32,7 @@
 
 static const char tpm_ibmvtpm_driver_name[] = "tpm_ibmvtpm";
 
-static struct vio_device_id tpm_ibmvtpm_device_table[] = {
+static const struct vio_device_id tpm_ibmvtpm_device_table[] = {
 	{ "IBM,vtpm", "IBM,vtpm"},
 	{ "", "" }
 };
-- 
2.7.4
