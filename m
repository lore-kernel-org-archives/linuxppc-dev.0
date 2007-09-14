Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 11/25] spufs: Extract the file descriptor search logic in SPU
	coredump code
Message-Id: <1189751574.104936.735882787971.11.gpush@pokey>
In-Reply-To: <1189751574.98527.127994196313.1.gpush@pokey>
To: <linuxppc-dev@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 14 Sep 2007 16:32:54 +1000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>

Extract the logic for searching through the file descriptors for spu contexts
into a separate routine, coredump_next_context(), so we can use it elsewhere
in future. In the process we flatten the for loop, and move the NOSCHED test
into coredump_next_context().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/cell/spufs/coredump.c |   58 +++++++++++++++++----------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/platforms/cell/spufs/coredump.c
index 5e31799..99f8e0b 100644
--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -109,16 +109,11 @@ static int spufs_ctx_note_size(struct spufs_ctx_info *ctx_info)
 	return total;
 }
 
-static int spufs_add_one_context(struct file *file, int dfd)
+static int spufs_add_one_context(struct spu_context *ctx, int dfd)
 {
-	struct spu_context *ctx;
 	struct spufs_ctx_info *ctx_info;
 	int size;
 
-	ctx = SPUFS_I(file->f_dentry->d_inode)->i_ctx;
-	if (ctx->flags & SPU_CREATE_NOSCHED)
-		return 0;
-
 	ctx_info = kzalloc(sizeof(*ctx_info), GFP_KERNEL);
 	if (unlikely(!ctx_info))
 		return -ENOMEM;
@@ -142,22 +137,45 @@ static int spufs_add_one_context(struct file *file, int dfd)
  * internal functionality to dump them without needing to actually
  * open the files.
  */
-static int spufs_arch_notes_size(void)
+static struct spu_context *coredump_next_context(int *fd)
 {
 	struct fdtable *fdt = files_fdtable(current->files);
-	int size = 0, fd;
-
-	for (fd = 0; fd < fdt->max_fds; fd++) {
-		if (FD_ISSET(fd, fdt->open_fds)) {
-			struct file *file = fcheck(fd);
-
-			if (file && file->f_op == &spufs_context_fops) {
-				int rval = spufs_add_one_context(file, fd);
-				if (rval < 0)
-					break;
-				size += rval;
-			}
-		}
+	struct file *file;
+	struct spu_context *ctx = NULL;
+
+	for (; *fd < fdt->max_fds; (*fd)++) {
+		if (!FD_ISSET(*fd, fdt->open_fds))
+			continue;
+
+		file = fcheck(*fd);
+
+		if (!file || file->f_op != &spufs_context_fops)
+			continue;
+
+		ctx = SPUFS_I(file->f_dentry->d_inode)->i_ctx;
+		if (ctx->flags & SPU_CREATE_NOSCHED)
+			continue;
+
+		/* start searching the next fd next time we're called */
+		(*fd)++;
+		break;
+	}
+
+	return ctx;
+}
+
+static int spufs_arch_notes_size(void)
+{
+	struct spu_context *ctx;
+	int size = 0, rc, fd;
+
+	fd = 0;
+	while ((ctx = coredump_next_context(&fd)) != NULL) {
+		rc = spufs_add_one_context(ctx, fd);
+		if (rc < 0)
+			break;
+
+		size += rc;
 	}
 
 	return size;
