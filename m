Return-Path: <jg1.han@samsung.com>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 by ozlabs.org (Postfix) with ESMTP id 514722C0077
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2013 17:17:00 +1000 (EST)
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQ6003019K5VSN0@mailout3.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 19 Jul 2013 16:16:57 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] macintosh: ams: replace strict_strtoul() with kstrtoul()
Date: Fri, 19 Jul 2013 16:16:56 +0900
Message-id: <001501ce844f$f3ddb840$db9928c0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Cc: Jingoo Han <jg1.han@samsung.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The usage of strict_strtoul() is not preferred, because
strict_strtoul() is obsolete. Thus, kstrtoul() should be
used.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/macintosh/ams/ams-input.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/macintosh/ams/ams-input.c b/drivers/macintosh/ams/ams-input.c
index b27e530..2edae7d 100644
--- a/drivers/macintosh/ams/ams-input.c
+++ b/drivers/macintosh/ams/ams-input.c
@@ -118,8 +118,12 @@ static ssize_t ams_input_store_joystick(struct device *dev,
 {
 	unsigned long enable;
 	int error = 0;
+	int ret;
 
-	if (strict_strtoul(buf, 0, &enable) || enable > 1)
+	ret = kstrtoul(buf, 0, &enable);
+	if (ret)
+		return ret;
+	if (enable > 1)
 		return -EINVAL;
 
 	mutex_lock(&ams_input_mutex);
-- 
1.7.10.4
