Return-Path: <bhaktipriya96@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sNwB96xyKzDr6Q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 03:14:57 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id hh10so1382390pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 10:14:57 -0700 (PDT)
Date: Tue, 30 Aug 2016 22:44:51 +0530
From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
To: Geoff Levand <geoff@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Tejun Heo <tj@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] ps3: Remove deprecated create_singlethread_workqueue
Message-ID: <20160830171450.GA1890@Karyakshetra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The workqueue "ps3av->wq" queues a single work item &ps3av->work and hence
doesn't require ordering. It is involved in waking up ps3avd to do the
video mode setting and hence it's not being used on a memory reclaim
path. Hence, it has been converted to use system_wq.

System workqueues have been able to handle high level of concurrency
for a long time now and hence it's not required to have a singlethreaded
workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueue
created with create_singlethread_workqueue(), system_wq allows multiple
work items to overlap executions even on the same CPU; however, a
per-cpu workqueue doesn't have any CPU locality or global ordering
guarantee unless the target CPU is explicitly specified and thus the
increase of local concurrency shouldn't make any difference.

The work item has been flushed in ps3av_remove to ensure that
there are no pending tasks while disconnecting the driver.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/ps3/ps3av.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
index 437fc35..e293606 100644
--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -44,7 +44,6 @@ static struct ps3av {
 	struct mutex mutex;
 	struct work_struct work;
 	struct completion done;
-	struct workqueue_struct *wq;
 	int open_count;
 	struct ps3_system_bus_device *dev;

@@ -485,7 +484,7 @@ static int ps3av_set_videomode(void)
 	ps3av_set_av_video_mute(PS3AV_CMD_MUTE_ON);

 	/* wake up ps3avd to do the actual video mode setting */
-	queue_work(ps3av->wq, &ps3av->work);
+	schedule_work(&ps3av->work);

 	return 0;
 }
@@ -956,11 +955,6 @@ static int ps3av_probe(struct ps3_system_bus_device *dev)
 	INIT_WORK(&ps3av->work, ps3avd);
 	init_completion(&ps3av->done);
 	complete(&ps3av->done);
-	ps3av->wq = create_singlethread_workqueue("ps3avd");
-	if (!ps3av->wq) {
-		res = -ENOMEM;
-		goto fail;
-	}

 	switch (ps3_os_area_get_av_multi_out()) {
 	case PS3_PARAM_AV_MULTI_OUT_NTSC:
@@ -1018,8 +1012,7 @@ static int ps3av_remove(struct ps3_system_bus_device *dev)
 	dev_dbg(&dev->core, " -> %s:%d\n", __func__, __LINE__);
 	if (ps3av) {
 		ps3av_cmd_fin();
-		if (ps3av->wq)
-			destroy_workqueue(ps3av->wq);
+		flush_work(&ps3av->work);
 		kfree(ps3av);
 		ps3av = NULL;
 	}
--
2.1.4
