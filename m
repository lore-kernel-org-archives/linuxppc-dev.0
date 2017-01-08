Return-Path: <chandan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3txLjh53CGzDqWR
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2017 01:47:36 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v08EiVYS079900
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 8 Jan 2017 09:47:33 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27tvgyqq11-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Jan 2017 09:47:33 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <chandan@linux.vnet.ibm.com>;
 Sun, 8 Jan 2017 07:47:32 -0700
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
To: axboe@kernel.dk, jack@suse.cz
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 anton@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] do_direct_IO: Use inode->i_blkbits to compute block count to
 be cleaned
Date: Sun,  8 Jan 2017 20:17:10 +0530
Message-Id: <1483886830-23878-1-git-send-email-chandan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The code currently uses sdio->blkbits to compute the number of blocks to
be cleaned. However sdio->blkbits is derived from the logical block size
of the underlying block device (Refer to the definition of
do_blockdev_direct_IO()). Due to this, generic/299 test would rarely
fail when executed on an ext4 filesystem with 64k as the block size and
when using a virtio based disk (having 512 byte as the logical block
size) inside a kvm guest.

This commit fixes the bug by using inode->i_blkbits to compute the
number of blocks to be cleaned.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 fs/direct-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index aeae8c0..b20adf9 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -905,6 +905,7 @@ static inline void dio_zero_block(struct dio *dio, struct dio_submit *sdio,
 static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 			struct buffer_head *map_bh)
 {
+	const unsigned i_blkbits = dio->inode->i_blkbits;
 	const unsigned blkbits = sdio->blkbits;
 	int ret = 0;
 
@@ -949,7 +950,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 					clean_bdev_aliases(
 						map_bh->b_bdev,
 						map_bh->b_blocknr,
-						map_bh->b_size >> blkbits);
+						map_bh->b_size >> i_blkbits);
 				}
 
 				if (!sdio->blkfactor)
-- 
2.5.5
