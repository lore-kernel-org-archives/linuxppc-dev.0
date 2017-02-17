Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0033.hostedemail.com
 [216.40.44.33])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPktg4JbbzDqK8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 18:19:55 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 6C8D44C45
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 07:13:13 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 31/35] drivers/tty: Convert remaining uses of pr_warning to
 pr_warn
Date: Thu, 16 Feb 2017 23:11:44 -0800
Message-Id: <ad251bb376e0256ea8d936fb805d1a2f933e27a8.1487314667.git.joe@perches.com>
In-Reply-To: <cover.1487314666.git.joe@perches.com>
References: <cover.1487314666.git.joe@perches.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To enable eventual removal of pr_warning

This makes pr_warn use consistent for drivers/tty

Prior to this patch, there were 2 uses of pr_warning and
23 uses of pr_warn in drivers/tty

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/tty/hvc/hvcs.c | 2 +-
 drivers/tty/tty_io.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 7823d6d998cf..99bb875178d7 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -1575,7 +1575,7 @@ static int __init hvcs_module_init(void)
 	 */
 	rc = driver_create_file(&(hvcs_vio_driver.driver), &driver_attr_rescan);
 	if (rc)
-		pr_warning("HVCS: Failed to create rescan file (err %d)\n", rc);
+		pr_warn("HVCS: Failed to create rescan file (err %d)\n", rc);
 
 	return 0;
 }
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index a1fd3f7d487a..e9ba3d06d8e1 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2842,8 +2842,8 @@ static void tty_warn_deprecated_flags(struct serial_struct __user *ss)
 	flags &= ASYNC_DEPRECATED;
 
 	if (flags && __ratelimit(&depr_flags))
-		pr_warning("%s: '%s' is using deprecated serial flags (with no effect): %.8x\n",
-				__func__, get_task_comm(comm, current), flags);
+		pr_warn("%s: '%s' is using deprecated serial flags (with no effect): %.8x\n",
+			__func__, get_task_comm(comm, current), flags);
 }
 
 /*
-- 
2.10.0.rc2.1.g053435c
