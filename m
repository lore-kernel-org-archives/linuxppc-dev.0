Return-Path: <jk@bilbo.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] powerpc/spufs: Fix incorrect buffer offset in regs write
Message-Id: <1236145172.189228.314429009881.1.gpush@pingu>
To: <cbe-oss-dev@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 04 Mar 2009 16:39:32 +1100
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We need to offset by *pos bytes, not *pos words.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/cell/spufs/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 83ef889..6b10877 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -578,7 +578,7 @@ spufs_regs_write(struct file *file, const char __user *buffer,
 	if (ret)
 		return ret;
 
-	ret = copy_from_user(lscsa->gprs + *pos - size,
+	ret = copy_from_user((char *)lscsa->gprs + *pos - size,
 			     buffer, size) ? -EFAULT : size;
 
 	spu_release_saved(ctx);
