Return-Path: <anton.vorontsov@linaro.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4C7ECB6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 21:32:19 +1100 (EST)
Received: by mail-bk0-f51.google.com with SMTP id j10so3226820bkw.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 03:32:19 -0700 (PDT)
Date: Sat, 24 Mar 2012 14:31:10 +0400
From: Anton Vorontsov <anton.vorontsov@linaro.org>
To: Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 09/10] um: Properly check all process' threads for a live mm
Message-ID: <20120324103110.GI29067@lizard>
References: <20120324102609.GA28356@lizard>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20120324102609.GA28356@lizard>
Cc: Mike Frysinger <vapier@gentoo.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 uclinux-dist-devel@blackfin.uclinux.org, linux-mm@kvack.org,
 Paul Mundt <lethal@linux-sh.org>, John Stultz <john.stultz@linaro.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Russell King <linux@arm.linux.org.uk>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kill_off_processes() might miss a valid process, this is because
checking for process->mm is not enough. Process' main thread may
exit or detach its mm via use_mm(), but other threads may still
have a valid mm.

To catch this we use find_lock_task_mm(), which walks up all
threads and returns an appropriate task (with task lock held).

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 arch/um/kernel/reboot.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index 1411f4e..3d15243 100644
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -6,6 +6,7 @@
 #include "linux/sched.h"
 #include "linux/spinlock.h"
 #include "linux/slab.h"
+#include "linux/oom.h"
 #include "kern_util.h"
 #include "os.h"
 #include "skas.h"
@@ -25,13 +26,13 @@ static void kill_off_processes(void)
 
 		read_lock(&tasklist_lock);
 		for_each_process(p) {
-			task_lock(p);
-			if (!p->mm) {
-				task_unlock(p);
+			struct task_struct *t;
+
+			t = find_lock_task_mm(p);
+			if (!t)
 				continue;
-			}
-			pid = p->mm->context.id.u.pid;
-			task_unlock(p);
+			pid = t->mm->context.id.u.pid;
+			task_unlock(t);
 			os_kill_ptraced_process(pid, 1);
 		}
 		read_unlock(&tasklist_lock);
-- 
1.7.9.2
