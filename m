Return-Path: <roel.kluin@gmail.com>
Message-ID: <4AD32B3F.9060804@gmail.com>
Date: Mon, 12 Oct 2009 15:12:31 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: Jeremy Kerr <jk@ozlabs.org>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] spufs: Fix test in spufs_switch_log_read()
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

size_t len cannot be less than 0.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Or can this test be removed?

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 884e8bc..d4f304f 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -2494,7 +2494,7 @@ static ssize_t spufs_switch_log_read(struct file *file, char __user *buf,
 	struct spu_context *ctx = SPUFS_I(inode)->i_ctx;
 	int error = 0, cnt = 0;
 
-	if (!buf || len < 0)
+	if (!buf || (ssize_t)len < 0)
 		return -EINVAL;
 
 	error = spu_acquire(ctx);
