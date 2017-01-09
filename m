Return-Path: <jmoyer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ty7tZ05kpzDqMB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 08:43:01 +1100 (AEDT)
From: Jeff Moyer <jmoyer@redhat.com>
To: axboe@kernel.dk, Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc: jack@suse.cz, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] direct-io: don't introduce another read of inode->i_blkbits
References: <1483886830-23878-1-git-send-email-chandan@linux.vnet.ibm.com>
Date: Mon, 09 Jan 2017 16:42:58 -0500
In-Reply-To: <1483886830-23878-1-git-send-email-chandan@linux.vnet.ibm.com>
 (Chandan Rajendra's message of "Sun, 8 Jan 2017 20:17:10 +0530")
Message-ID: <x49r34bgba5.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 20ce44d545844 ("do_direct_IO: Use inode->i_blkbits to compute
block count to be cleaned") introduced a regression: if the block size
of the block device is changed while a direct I/O request is being
setup, it can result in a panic.  See commit ab73857e354ab ("direct-io:
don't read inode->i_blkbits multiple times") for the reasoning, and
commit b87570f5d3496 ("Fix a crash when block device is read and block
size is changed at the same time") for a more detailed problem
description and reproducer.

Fixes: 20ce44d545844
Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

---
Chandan, can you please test this to ensure this still fixes your problem?

diff --git a/fs/direct-io.c b/fs/direct-io.c
index b20adf9..c87bae4 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -905,8 +905,8 @@ static inline void dio_zero_block(struct dio *dio, struct dio_submit *sdio,
 static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 			struct buffer_head *map_bh)
 {
-	const unsigned i_blkbits = dio->inode->i_blkbits;
 	const unsigned blkbits = sdio->blkbits;
+	const unsigned i_blkbits = blkbits + sdio->blkfactor;
 	int ret = 0;
 
 	while (sdio->block_in_file < sdio->final_block_in_request) {
