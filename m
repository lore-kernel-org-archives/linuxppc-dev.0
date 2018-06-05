Return-Path: <weiyongjun1@huawei.com>
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410RHR10bvzF1kV
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 19:25:38 +1000 (AEST)
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, Andrew Donnellan
 <andrew.donnellan@au1.ibm.com>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Alastair D'Silva
 <alastair@d-silva.org>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ocxl: Fix missing unlock on error in
 afu_ioctl_enable_p9_wait()
Date: Tue, 5 Jun 2018 09:16:21 +0000
Message-ID: <1528190181-15745-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add the missing unlock before return from function
afu_ioctl_enable_p9_wait() in the error handling case.

Fixes: e948e06fc63a ("ocxl: Expose the thread_id needed for wait on POWER9")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/misc/ocxl/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index 33ae46c..e6a6074 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -139,8 +139,10 @@ static long afu_ioctl_enable_p9_wait(struct ocxl_context *ctx,
 		// Locks both status & tidr
 		mutex_lock(&ctx->status_mutex);
 		if (!ctx->tidr) {
-			if (set_thread_tidr(current))
+			if (set_thread_tidr(current)) {
+				mutex_unlock(&ctx->status_mutex);
 				return -ENOENT;
+			}
 
 			ctx->tidr = current->thread.tidr;
 		}
