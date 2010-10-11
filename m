Return-Path: <error27@gmail.com>
Date: Mon, 11 Oct 2010 21:13:35 +0200
From: Dan Carpenter <error27@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [patch] ps3disk: passing wrong variable to bvec_kunmap_irq()
Message-ID: <20101011191335.GH5851@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cbe-oss-dev@lists.ozlabs.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <jaxboe@fusionio.com>, kernel-janitors@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This should pass "buf" to bvec_kunmap_irq() instead of "bv".  The api is
like kmap_atomic() instead of kmap().

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index e9da874..03688c2 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -113,7 +113,7 @@ static void ps3disk_scatter_gather(struct ps3_storage_device *dev,
 			memcpy(buf, dev->bounce_buf+offset, size);
 		offset += size;
 		flush_kernel_dcache_page(bvec->bv_page);
-		bvec_kunmap_irq(bvec, &flags);
+		bvec_kunmap_irq(buf, &flags);
 		i++;
 	}
 }
