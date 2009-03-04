Return-Path: <jk@bilbo.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] powerpc/spufs: Check file offset before calculating write
	size in fixed-sized files
Message-Id: <1236145087.222046.948861432711.1.gpush@pingu>
In-Reply-To: <<49AD7A06.2090401@gmail.com>>
To: Roel Kluin <roel.kluin@gmail.com>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 04 Mar 2009 16:38:07 +1100
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Based on an original patch from Roel Kluin <roel.kluin@gmail.com>.

The write size calculated during regs and fpcr writes may currently
go negative. Because size is unsigned, this will wrap, and our
check for EFBIG will fail.

Instead, do the check for EFBIG before subtracting from size.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
Roel - How about this? clear up the logic a little rather than casting

---
 arch/powerpc/platforms/cell/spufs/file.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 0da7f2b..83ef889 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -568,9 +568,10 @@ spufs_regs_write(struct file *file, const char __user *buffer,
 	struct spu_lscsa *lscsa = ctx->csa.lscsa;
 	int ret;
 
-	size = min_t(ssize_t, sizeof lscsa->gprs - *pos, size);
-	if (size <= 0)
+	if (*pos >= sizeof(lscsa->gprs))
 		return -EFBIG;
+
+	size = min_t(ssize_t, sizeof(lscsa->gprs) - *pos, size);
 	*pos += size;
 
 	ret = spu_acquire_saved(ctx);
@@ -623,10 +624,11 @@ spufs_fpcr_write(struct file *file, const char __user * buffer,
 	struct spu_lscsa *lscsa = ctx->csa.lscsa;
 	int ret;
 
-	size = min_t(ssize_t, sizeof(lscsa->fpcr) - *pos, size);
-	if (size <= 0)
+	if (*pos >= sizeof(lscsa->fpcr))
 		return -EFBIG;
 
+	size = min_t(ssize_t, sizeof(lscsa->fpcr) - *pos, size);
+
 	ret = spu_acquire_saved(ctx);
 	if (ret)
 		return ret;
