Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C8F71A099B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Oct 2014 11:19:10 +1100 (EST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E1F9D1400D5
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2014 11:19:09 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 9 Oct 2014 10:19:07 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Subject: [PATCH] CXL: Fix afu_read() not doing finish_wait() on signal or
 non-blocking
Date: Thu,  9 Oct 2014 11:17:46 +1100
Message-Id: <1412813866-22717-1-git-send-email-imunsie@au.ibm.com>
In-Reply-To: <1412764803-sup-6790@delenn.ozlabs.ibm.com>
References: <1412764803-sup-6790@delenn.ozlabs.ibm.com>
Cc: cbe-oss-dev <cbe-oss-dev@lists.ozlabs.org>, mikey <mikey@neuling.org>,
 arnd <arnd@arndb.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 greg <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, anton <anton@samba.org>,
 imunsie <imunsie@au1.ibm.com>, jk <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

If afu_read() returned due to a signal or the AFU file descriptor being
opened non-blocking it would not call finish_wait() before returning,
which could lead to a crash later when something else wakes up the wait
queue.

This patch restructures the wait logic to ensure that the cleanup is
done correctly.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---

Resending with correct whitespace as my mailer decided to replace tabs with
spaces on the last try.

 drivers/misc/cxl/file.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 847b7e6..378b099 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -273,6 +273,7 @@ static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 	struct cxl_context *ctx = file->private_data;
 	struct cxl_event event;
 	unsigned long flags;
+	int rc;
 	DEFINE_WAIT(wait);
 
 	if (count < CXL_READ_MIN_SIZE)
@@ -285,13 +286,17 @@ static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 		if (ctx_event_pending(ctx))
 			break;
 
-		spin_unlock_irqrestore(&ctx->lock, flags);
-		if (file->f_flags & O_NONBLOCK)
-			return -EAGAIN;
+		if (file->f_flags & O_NONBLOCK) {
+			rc = -EAGAIN;
+			goto out;
+		}
 
-		if (signal_pending(current))
-			return -ERESTARTSYS;
+		if (signal_pending(current)) {
+			rc = -ERESTARTSYS;
+			goto out;
+		}
 
+		spin_unlock_irqrestore(&ctx->lock, flags);
 		pr_devel("afu_read going to sleep...\n");
 		schedule();
 		pr_devel("afu_read woken up\n");
@@ -336,6 +341,11 @@ static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 	if (copy_to_user(buf, &event, event.header.size))
 		return -EFAULT;
 	return event.header.size;
+
+out:
+	finish_wait(&ctx->wq, &wait);
+	spin_unlock_irqrestore(&ctx->lock, flags);
+	return rc;
 }
 
 static const struct file_operations afu_fops = {
-- 
2.1.0
