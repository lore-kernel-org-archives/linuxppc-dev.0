Return-Path: <famz@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rg2pB2j4GzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 12:01:22 +1000 (AEST)
From: Fam Zheng <famz@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Jens Axboe <axboe@kernel.dk>,
 "Ed L. Cashin" <ed.cashin@acm.org>, Jiri Kosina <jikos@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Shaohua Li <shli@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Keith Busch <keith.busch@intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@infradead.org>, famz@redhat.com
Subject: [PATCH v2 11/12] mtd: Generate uevent after attribute available
Date: Thu, 30 Jun 2016 09:59:52 +0800
Message-Id: <20160630015953.6888-12-famz@redhat.com>
In-Reply-To: <20160630015953.6888-1-famz@redhat.com>
References: <20160630015953.6888-1-famz@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is documented that KOBJ_ADD should be generated after the object's
attributes and children are ready.  We can achieve this with the new
disk_gen_uevents interface.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 drivers/mtd/mtd_blkdevs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index ab3bc22..6848141 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -436,13 +436,14 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	if (new->readonly)
 		set_disk_ro(gd, 1);
 
-	add_disk(gd, true);
+	add_disk(gd, false);
 
 	if (new->disk_attributes) {
 		ret = sysfs_create_group(&disk_to_dev(gd)->kobj,
 					new->disk_attributes);
 		WARN_ON(ret);
 	}
+	disk_gen_uevents(gd);
 	return 0;
 error4:
 	blk_cleanup_queue(new->rq);
-- 
2.9.0
