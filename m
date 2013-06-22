Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
 [64.235.106.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AF38C2C040D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jun 2013 19:03:42 +1000 (EST)
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com
 ([174.115.5.73]:46271 helo=crashcourse.ca)
 by astoria.ccjclearline.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
 id 1UqJCi-00027F-Fa
 for linuxppc-dev@lists.ozlabs.org; Sat, 22 Jun 2013 04:29:52 -0400
Date: Sat, 22 Jun 2013 04:29:48 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ADB: Replace __WAITQUEUE_INITIALIZER with more standard
 DECLARE_WAITQUEUE.
Message-ID: <alpine.DEB.2.02.1306220426370.25883@oneiric>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  just FYI, that invocation of __WAITQUEUE_INITIALIER() is the only
one in the entire current source tree so it seems a bit out of place.
not tested, but there *should* be no functional change.

diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index b026896..04a5049 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -697,7 +697,7 @@ static ssize_t adb_read(struct file *file, char __user *buf,
 	int ret = 0;
 	struct adbdev_state *state = file->private_data;
 	struct adb_request *req;
-	wait_queue_t wait = __WAITQUEUE_INITIALIZER(wait,current);
+	DECLARE_WAITQUEUE(wait,current);
 	unsigned long flags;

 	if (count < 2)

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
