Return-Path: <fabf@skynet.be>
Received: from mailrelay107.isp.belgacom.be (mailrelay107.isp.belgacom.be
 [195.238.20.134])
 by lists.ozlabs.org (Postfix) with ESMTP id 1E49F1A0DC3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 05:13:10 +1100 (AEDT)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/7 linux-next] powerpc/pmac: replace current->state by
 set_current_state()
Date: Fri, 20 Feb 2015 19:12:53 +0100
Message-Id: <1424455977-21903-3-git-send-email-fabf@skynet.be>
In-Reply-To: <1424455977-21903-1-git-send-email-fabf@skynet.be>
References: <1424455977-21903-1-git-send-email-fabf@skynet.be>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Fabian Frederick <fabf@skynet.be>, Ingo Molnar <mingo@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use helper functions to access current->state.
Direct assignments are prone to races and therefore buggy.

current->state = TASK_RUNNING can be replaced by __set_current_state()

Thanks to Peter Zijlstra for the exact definition of the problem.

Suggested-By: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/macintosh/via-pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index dee88e5..3c608d4 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -2109,7 +2109,7 @@ pmu_read(struct file *file, char __user *buf,
 
 	spin_lock_irqsave(&pp->lock, flags);
 	add_wait_queue(&pp->wait, &wait);
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 
 	for (;;) {
 		ret = -EAGAIN;
@@ -2138,7 +2138,7 @@ pmu_read(struct file *file, char __user *buf,
 		schedule();
 		spin_lock_irqsave(&pp->lock, flags);
 	}
-	current->state = TASK_RUNNING;
+	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&pp->wait, &wait);
 	spin_unlock_irqrestore(&pp->lock, flags);
 	
-- 
2.1.0
