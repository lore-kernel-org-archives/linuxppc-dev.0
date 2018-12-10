Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24682C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 22:08:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76BDF20821
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 22:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BDF20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DHJt5RWvzDqT9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 09:08:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.75; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
X-Greylist: delayed 500 seconds by postgrey-1.36 at bilbo;
 Tue, 11 Dec 2018 09:06:30 AEDT
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DHGZ2L2gzDqcY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 09:06:29 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mcp7M-1h4zH82xZi-00a072; Mon, 10 Dec 2018 22:52:08 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Russell Currey <ruscur@russell.cc>, Sam Bobroff <sbobroff@linux.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: eeh_event: convert semaphore to completion
Date: Mon, 10 Dec 2018 22:51:57 +0100
Message-Id: <20181210215203.1936171-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CJMjen7qL/4911//J/0sv7G7S8E+q/SSejut+uCpjBv4zydQ5RO
 FGJZm0JISlxHEUJ3un5ZM6d/lblujQ0cc7mfpk5qgnF0o1fVKrQ6bKiua+G1KQBdKMoe5fL
 G7+OFz6V1A+U42btvS9HMuIWxgxGCsiq8Pmki2B8KEocuNXTUalCXi3cUWE8c/7Kodg8d80
 5vkkfNGWhQ33oLkjd0Qbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iFWaVb80BII=:nJWJWUB6TcbK3Q9zMlpH/I
 SrHr2s7FnKztMp4ldf9d3FrIxaY36mxmEONwAGJv+GZBb664XoVFqSLKGl5o4vKlv07lG+zrs
 bGBH40BVgyErhU1Ejim3EBKq3fo5gaXNS/3cFgR1p46SSrlHAB4lSweBUvf/wvKk+mJspLXyp
 R+siqak5OLmc5sZN45Eew6kd59lTQC9BRt7CGDkTVdwZrZtoRXz/qVc9ferh9INDO3Rz6TKSM
 FdG5v98Dx/qzs3WCie/XK/oZDVHSlY00WeryPUw6Q/T4dkoxZyn5reNH7sNCe/WeDa8lg/zuN
 JkZd27tvud6QWFLfb0qqIADMoRcqaK7QZnsKx3oSgmOuITdwYPnjyWZhKdbHFB9H5WOcYLNY0
 axTBhvoGeVhsYNV7WkBy243FjL3oXdWv+xV0rbyb0uo/3yQm2fyW4fMJNsx1Gy1vWqAy54TJ3
 Ezudu2LW2BLVcFRj68cVCZV3L4g8n+ug831pFzn7Zb/Ft5hD4DRIyHmnESNf4CThQRK7VFrUc
 xr0Zflj7y0w+u8BG4MHeWeE1uiYxch0fHJNZi0xlR0NhZhk1P92NoVnAUMmY4gJfxutZTYxkM
 eksKhuZ/fq3cKCn4+9KTjRkwsY4Wia7mQhaeEjBcNKC05MqNZgiR2xIBdzGlY7pJJvSpffsFG
 PB6JS6kfVGGwAw+e2NKKkuQXwaGK3K/ytclbGeApKDDBfSdSzGBW/SpZosiDFtntEL7RgE9Jk
 EFq75bZCLIDrPL6+NJJxtq8eCIrFotdAfcdEpQ==
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

For this use case, completions and semaphores are equivalent,
but semaphores are an awkward interface that should generally
be avoided, so use the completion instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/eeh_event.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
index 61c9356bf9c9..227e57f980df 100644
--- a/arch/powerpc/kernel/eeh_event.c
+++ b/arch/powerpc/kernel/eeh_event.c
@@ -35,7 +35,7 @@
  */
 
 static DEFINE_SPINLOCK(eeh_eventlist_lock);
-static struct semaphore eeh_eventlist_sem;
+static DECLARE_COMPLETION(eeh_eventlist_event);
 static LIST_HEAD(eeh_eventlist);
 
 /**
@@ -55,7 +55,7 @@ static int eeh_event_handler(void * dummy)
 	struct eeh_pe *pe;
 
 	while (!kthread_should_stop()) {
-		if (down_interruptible(&eeh_eventlist_sem))
+		if (wait_for_completion_interruptible(&eeh_eventlist_event))
 			break;
 
 		/* Fetch EEH event from the queue */
@@ -102,9 +102,6 @@ int eeh_event_init(void)
 	struct task_struct *t;
 	int ret = 0;
 
-	/* Initialize semaphore */
-	sema_init(&eeh_eventlist_sem, 0);
-
 	t = kthread_run(eeh_event_handler, NULL, "eehd");
 	if (IS_ERR(t)) {
 		ret = PTR_ERR(t);
@@ -142,7 +139,7 @@ int eeh_send_failure_event(struct eeh_pe *pe)
 	spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
 
 	/* For EEH deamon to knick in */
-	up(&eeh_eventlist_sem);
+	complete(&eeh_eventlist_event);
 
 	return 0;
 }
-- 
2.20.0

