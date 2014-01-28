Return-Path: <stewartb2@gmail.com>
Received: from mail-ig0-x22a.google.com (mail-ig0-x22a.google.com
 [IPv6:2607:f8b0:4001:c05::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4417D2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 14:07:45 +1100 (EST)
Received: by mail-ig0-f170.google.com with SMTP id m12so13190349iga.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 19:07:41 -0800 (PST)
From: Brandon Stewart <stewartb2@gmail.com>
To: benh@kernel.crashing.org
Subject: [PATCH 2/2] Fix coding style errors
Date: Mon, 27 Jan 2014 21:07:34 -0600
Message-Id: <1390878454-4329-1-git-send-email-stewartb2@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I corrected several coding errors.

Signed-off-by: Brandon Stewart <stewartb2@gmail.com>
---
 drivers/macintosh/adb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index 53611de..dd3f49a 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -623,7 +623,7 @@ do_adb_query(struct adb_request *req)
 {
 	int	ret = -EINVAL;
 
-	switch(req->data[1]) {
+	switch (req->data[1]) {
 	case ADB_QUERY_GETDEVINFO:
 		if (req->nbytes < 3)
 			break;
@@ -792,8 +792,9 @@ static ssize_t adb_write(struct file *file, const char __user *buf,
 	}
 	/* Special case for ADB_BUSRESET request, all others are sent to
 	   the controller */
-	else if ((req->data[0] == ADB_PACKET) && (count > 1)
-		&& (req->data[1] == ADB_BUSRESET)) {
+	else if (req->data[0] == ADB_PACKET &&
+		req->data[1] == ADB_BUSRESET &&
+		count > 1) {
 		ret = do_adb_reset_bus();
 		up(&adb_probe_mutex);
 		atomic_dec(&state->n_pending);
-- 
1.8.5.3
