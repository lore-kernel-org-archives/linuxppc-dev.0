Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zW8x21fGXzDqtT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jan 2018 02:11:50 +1100 (AEDT)
From: Colin King <colin.king@canonical.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ocxl: fix signed comparison with less than zero
Date: Tue, 30 Jan 2018 15:11:44 +0000
Message-Id: <20180130151144.32544-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Colin Ian King <colin.king@canonical.com>

Currently the comparison of used < 0 is always false because
uses is a size_t. Fix this by making used a ssize_t type.

Detected by Coccinelle:
drivers/misc/ocxl/file.c:320:6-10: WARNING: Unsigned expression
compared with zero: used < 0

Fixes: 5ef3166e8a32 ("ocxl: Driver code for 'generic' opencapi devices")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/ocxl/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index c90c1a578d2f..1287e4430e6b 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -277,7 +277,7 @@ static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 	struct ocxl_context *ctx = file->private_data;
 	struct ocxl_kernel_event_header header;
 	ssize_t rc;
-	size_t used = 0;
+	ssize_t used = 0;
 	DEFINE_WAIT(event_wait);
 
 	memset(&header, 0, sizeof(header));
-- 
2.15.1
