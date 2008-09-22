Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id ACAAADE125
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 02:11:49 +1000 (EST)
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m8MGBlri008478
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 12:11:47 -0400
Received: from pobox.devel.redhat.com (pobox.devel.redhat.com [10.11.255.8])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m8MGBkrW026762
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 12:11:46 -0400
Received: from warthog.cambridge.redhat.com
	(IDENT:U2FsdGVkX19XSa8FqAEsxNX0OoqR9Xs0nR+Z43XwGvw@xen4-1.farm.hsv.redhat.com
	[10.15.4.90])
	by pobox.devel.redhat.com (8.13.1/8.13.1) with ESMTP id m8MGBjj1008321
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 12:11:46 -0400
Received: from [127.0.0.1] (helo=warthog.procyon.org.uk)
	by warthog.cambridge.redhat.com with esmtp (Exim 4.68 #1 (Red Hat
	Linux)) id 1Kho0m-0003jp-LQ
	for linuxppc-dev@ozlabs.org; Mon, 22 Sep 2008 17:11:44 +0100
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] PPC: Fix rtas_log_read()
To: linuxppc-dev@ozlabs.org
Date: Mon, 22 Sep 2008 17:11:44 +0100
Message-ID: <20080922161144.14343.44612.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix rtas_log_read() to correctly check its buffer after sleeping.  A competing
process may have swiped the error we're attempting to retrieve between us being
woken up and retaking the lock, but we return an event and account for it
anyway without checking.

Any positive result from checking rtas_log_size is invalidated when
rtasd_log_lock is dropped or if it is not held.

It is not correct to rely on userspace doing the right thing by assuming only
one userspace process (rtasd) will be attempting read at any one time.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/powerpc/platforms/pseries/rtasd.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)


diff --git a/arch/powerpc/platforms/pseries/rtasd.c b/arch/powerpc/platforms/pseries/rtasd.c
index c9ffd8c..1ce132f 100644
--- a/arch/powerpc/platforms/pseries/rtasd.c
+++ b/arch/powerpc/platforms/pseries/rtasd.c
@@ -298,16 +298,16 @@ static ssize_t rtas_log_read(struct file * file, char __user * buf,
 
 	spin_lock_irqsave(&rtasd_log_lock, s);
 	/* if it's 0, then we know we got the last one (the one in NVRAM) */
-	if (rtas_log_size == 0 && logging_enabled)
+	while (rtas_log_size == 0 && logging_enabled) {
 		nvram_clear_error_log();
-	spin_unlock_irqrestore(&rtasd_log_lock, s);
-
 
-	error = wait_event_interruptible(rtas_log_wait, rtas_log_size);
-	if (error)
-		goto out;
+		spin_unlock_irqrestore(&rtasd_log_lock, s);
+		error = wait_event_interruptible(rtas_log_wait, rtas_log_size);
+		if (error)
+			goto out;
+		spin_lock_irqsave(&rtasd_log_lock, s);
+	}
 
-	spin_lock_irqsave(&rtasd_log_lock, s);
 	offset = rtas_error_log_buffer_max * (rtas_log_start & LOG_NUMBER_MASK);
 	memcpy(tmp, &rtas_log_buf[offset], count);
 
