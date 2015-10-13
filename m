Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8FE7D1A0200
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 16:26:18 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Mon, 12 Oct 2015 23:26:16 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id C037C3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 23:26:14 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9D5QEsh10420504
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 22:26:14 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9D5QELl015219
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 23:26:14 -0600
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
To: <axboe@kernel.dk>
Cc: <linuxppc-dev@lists.ozlabs.org>, <ming.lei@canonical.com>,
 <keith.busch@intel.com>, <snitzer@redhat.com>,
 <linux-kernel@vger.kernel.org>, <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH] block-mq:Fix the null memory access while setting tags cpumask
Date: Tue, 13 Oct 2015 10:55:27 +0530
Message-Id: <1444713927-16261-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In nr_hw_queues >1 cases when certain number of cpus are onlined/or
offlined, that results change in request_queue map in block-mq layer,
we see the kernel dumping like:

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000080
 IP: [<ffffffff8128e2f2>] cpumask_set_cpu+0x6/0xd
 PGD 6d957067 PUD 7604c067 PMD 0
 Oops: 0002 [#1] SMP
 Modules linked in: null_blk
 CPU: 2 PID: 1926 Comm: bash Not tainted 4.3.0-rc2+ #24
 Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
 task: ffff8800724cd1c0 ti: ffff880070a2c000 task.ti: ffff880070a2c000
 RIP: 0010:[<ffffffff8128e2f2>]  [<ffffffff8128e2f2>] cpumask_set_cpu+0x6/0xd
 RSP: 0018:ffff880070a2fbc8  EFLAGS: 00010203
 RAX: ffff880073eedc00 RBX: ffff88006cc88000 RCX: ffff88006c06b000
 RDX: 0000000000000007 RSI: 0000000000000080 RDI: 0000000000000008
 RBP: ffff880070a2fbc8 R08: ffff88006c06ac00 R09: ffff88006c06ad48
 R10: ffff880000004ea8 R11: ffff88006c069650 R12: ffff88007378fe28
 R13: 0000000000000008 R14: ffffe8ffff500200 R15: ffffffff81d2a630
 FS:  00007fa34803b700(0000) GS:ffff88007cc40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
 CR2: 0000000000000080 CR3: 00000000761d2000 CR4: 00000000000006e0
 Stack:
  ffff880070a2fc18 ffffffff8128edec 0000000000000000 ffff880073eedc00
  0000000000000039 ffff88006cc88000 0000000000000007 00000000ffffffe3
  ffffffff81cef2c0 0000000000000000 ffff880070a2fc38 ffffffff8129049a
 Call Trace:
  [<ffffffff8128edec>] blk_mq_map_swqueue+0x9d/0x206
  [<ffffffff8129049a>] blk_mq_queue_reinit_notify+0xe3/0x144
  [<ffffffff8108b403>] notifier_call_chain+0x37/0x63
  [<ffffffff8108b48b>] __raw_notifier_call_chain+0xe/0x10
  [<ffffffff810729ea>] __cpu_notify+0x20/0x32
  [<ffffffff81072c24>] cpu_notify_nofail+0x13/0x1b
  [<ffffffff81073111>] _cpu_down+0x18a/0x264
  [<ffffffff811884ce>] ? path_put+0x1f/0x23
  [<ffffffff81073218>] cpu_down+0x2d/0x3a
  [<ffffffff813a9ad8>] cpu_subsys_offline+0x14/0x16
  [<ffffffff813a55c6>] device_offline+0x65/0x94
  [<ffffffff813a56b3>] online_store+0x48/0x68
  [<ffffffff811e0880>] ? kernfs_fop_write+0x6f/0x143
  [<ffffffff813a3046>] dev_attr_store+0x20/0x22
  [<ffffffff811e1037>] sysfs_kf_write+0x3c/0x3e
  [<ffffffff811e08fe>] kernfs_fop_write+0xed/0x143
  [<ffffffff8117fe0c>] __vfs_write+0x28/0xa6
  [<ffffffff8124b998>] ? security_file_permission+0x3c/0x44
  [<ffffffff810a5a1e>] ? percpu_down_read+0x21/0x42
  [<ffffffff81181ee5>] ? __sb_start_write+0x24/0x41
  [<ffffffff81180956>] vfs_write+0x8d/0xd1
  [<ffffffff81180b37>] SyS_write+0x59/0x83
  [<ffffffff816df46e>] entry_SYSCALL_64_fastpath+0x12/0x71
 Code: 03 75 06 65 48 ff 0a eb 1a f0 48 83 af 68 07 00 00 01 74 02 eb 0d 48 8d bf 68 07 00 00 ff 90 78 07 00 00 5d c3 55 89 ff 48 89 e5 <f0> 48 0f ab 3e 5d c3 0f 1f 44 00 00 55 8b 4e 44 31 d2 8b b7 94
 RIP  [<ffffffff8128e2f2>] cpumask_set_cpu+0x6/0xd
  RSP <ffff880070a2fbc8>
 CR2: 0000000000000080

How to reproduce:
1. create 80 vcpu guest with 10 core 8 threads
2. modprobe null_blk submit_queues=64
3. for i in 72 73 74 75 76 77 78 79 ; do
 echo 0 > /sys/devices/system/cpu/cpu$i/online;
done

Reason:
We try to set freed hwctx->tag->cpumask in blk_mq_map_swqueue().
Introduced during commit f26cdc8536ad ("blk-mq: Shared tag enhancements").

What is happening:
When certain number of cpus are onlined/offlined, that results in
blk_mq_update_queue_map, we could potentially end up in new mapping to
hwctx.

Subsequent blk_mq_map_swqueue of request_queue, tries to set the
hwctx->tags->cpumask which is already freed by blk_mq_free_rq_map in
earlier itearation when it was not mapped.

Fix:
Set the hwctx->tags->cpumask only after blk_mq_init_rq_map() is done

hwctx->tags->cpumask does not follow the hwctx->cpumask after new
mapping even in the cases where new mapping does not cause problem.
That is also fixed with this change.

This problem is originally found in powervm which had 160 cpus (SMT8),
128 nr_hw_queues. The dump was easily reproduced with offlining last core
and it has been a blocker issue because cpu hotplug is a common case for
DLPAR.

Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f2d67b4..39a7834 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1811,7 +1811,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 
 		hctx = q->mq_ops->map_queue(q, i);
 		cpumask_set_cpu(i, hctx->cpumask);
-		cpumask_set_cpu(i, hctx->tags->cpumask);
 		ctx->index_hw = hctx->nr_ctx;
 		hctx->ctxs[hctx->nr_ctx++] = ctx;
 	}
@@ -1836,6 +1835,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		if (!set->tags[i])
 			set->tags[i] = blk_mq_init_rq_map(set, i);
 		hctx->tags = set->tags[i];
+		cpumask_copy(hctx->tags->cpumask, hctx->cpumask);
 		WARN_ON(!hctx->tags);
 
 		/*
-- 
1.7.11.7
