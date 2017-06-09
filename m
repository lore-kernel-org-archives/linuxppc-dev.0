Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkbtm69cTzDqSC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 19:03:44 +1000 (AEST)
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/11] TTY: hvc: convert to use DRIVER_ATTR_RW
Date: Fri,  9 Jun 2017 11:03:07 +0200
Message-Id: <20170609090314.13991-4-gregkh@linuxfoundation.org>
In-Reply-To: <20170609090314.13991-1-gregkh@linuxfoundation.org>
References: <20170609090314.13991-1-gregkh@linuxfoundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are trying to get rid of DRIVER_ATTR(), and the hvc driver's
attribute can be trivially changed to use DRIVER_ATTR_RW().

Cc: Jiri Slaby <jslaby@suse.com>
Cc: <linuxppc-dev@lists.ozlabs.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/hvc/hvcs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 99bb875178d7..096ea5f511bd 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -484,13 +484,13 @@ static struct attribute_group hvcs_attr_group = {
 	.attrs = hvcs_attrs,
 };
 
-static ssize_t hvcs_rescan_show(struct device_driver *ddp, char *buf)
+static ssize_t rescan_show(struct device_driver *ddp, char *buf)
 {
 	/* A 1 means it is updating, a 0 means it is done updating */
 	return snprintf(buf, PAGE_SIZE, "%d\n", hvcs_rescan_status);
 }
 
-static ssize_t hvcs_rescan_store(struct device_driver *ddp, const char * buf,
+static ssize_t rescan_store(struct device_driver *ddp, const char * buf,
 		size_t count)
 {
 	if ((simple_strtol(buf, NULL, 0) != 1)
@@ -505,8 +505,7 @@ static ssize_t hvcs_rescan_store(struct device_driver *ddp, const char * buf,
 	return count;
 }
 
-static DRIVER_ATTR(rescan,
-	S_IRUGO | S_IWUSR, hvcs_rescan_show, hvcs_rescan_store);
+static DRIVER_ATTR_RW(rescan);
 
 static void hvcs_kick(void)
 {
-- 
2.13.1
