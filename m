Return-Path: <fgao@ikuai8.com>
Received: from smtpbg342.qq.com (smtpbg342.qq.com [14.17.44.37])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSrZt0pzJzDqRB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:47:01 +1100 (AEDT)
From: fgao@ikuai8.com
To: jk@ozlabs.org, arnd@arndb.de, benh@kernel.crashing.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, cbe-oss-dev@lists.ozlabs.org,
 gfree.wind@gmail.com
Cc: Gao Feng <fgao@ikuai8.com>
Subject: [PATCH kernel 1/1] powerpc/platforms/spufs: Use corresponding
 finish_wait for DEFINE_WAIT in spu_prio_wait
Date: Wed, 22 Feb 2017 16:37:30 +0800
Message-Id: <1487752650-29318-1-git-send-email-fgao@ikuai8.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gao Feng <fgao@ikuai8.com>

It should use finish_wait instead of remove_wait_queue when define
the waitqueue by DEFINE_WAIT.

Signed-off-by: Gao Feng <fgao@ikuai8.com>
---
 arch/powerpc/platforms/cell/spufs/sched.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index 25db92a..76cbcc5 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -564,8 +564,7 @@ static void spu_prio_wait(struct spu_context *ctx)
 		__spu_del_from_rq(ctx);
 	}
 	spin_unlock(&spu_prio->runq_lock);
-	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(&ctx->stop_wq, &wait);
+	finish_wait(&ctx->stop_wq, &wait);
 }
 
 static struct spu *spu_get_idle(struct spu_context *ctx)
-- 
1.9.1
