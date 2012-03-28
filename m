Return-Path: <akpm@linux-foundation.org>
Received: from mail-we0-f202.google.com (mail-we0-f202.google.com
 [74.125.82.202])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A2439B6EF3
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2012 09:21:02 +1100 (EST)
Received: by wejx9 with SMTP id x9so73462wej.3
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2012 15:20:58 -0700 (PDT)
Subject: [patch 1/2] powerpc/eeh: remove eeh_event_handler()->daemonize()
To: benh@kernel.crashing.org
From: akpm@linux-foundation.org
Date: Wed, 28 Mar 2012 15:20:57 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=ASCII
Message-Id: <20120328222057.B749EA0363@akpm.mtv.corp.google.com>
Cc: matt.fleming@intel.com, oleg@redhat.com, linuxppc-dev@ozlabs.org,
 tj@kernel.org, akpm@linux-foundation.org, linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Oleg Nesterov <oleg@redhat.com>
Subject: powerpc/eeh: remove eeh_event_handler()->daemonize()

daemonize() is only needed when a user-space task does kernel_thread().

eeh_event_handler() thread is created by the worker kthread, and thus it
doesn't need the soon-to-be-deprecated daemonize().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Linas Vepstas <linasvepstas@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Matt Fleming <matt.fleming@intel.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/platforms/pseries/eeh_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/powerpc/platforms/pseries/eeh_event.c~powerpc-eeh-remove-eeh_event_handler-daemonize arch/powerpc/platforms/pseries/eeh_event.c
--- a/arch/powerpc/platforms/pseries/eeh_event.c~powerpc-eeh-remove-eeh_event_handler-daemonize
+++ a/arch/powerpc/platforms/pseries/eeh_event.c
@@ -59,7 +59,7 @@ static int eeh_event_handler(void * dumm
 	struct eeh_event *event;
 	struct eeh_dev *edev;
 
-	daemonize("eehd");
+	set_task_comm(current, "eehd");
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	spin_lock_irqsave(&eeh_eventlist_lock, flags);
_
