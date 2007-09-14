Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 18/25] spufs: Get rid of spufs_coredump_num_notes,
	it's not needed if we NULL terminate
Message-Id: <1189751574.108845.438873583935.18.gpush@pokey>
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

The spufs_coredump_read array is NULL terminated, and we also store the size.
We only need one or the other, and the other arrays in file.c are NULL
terminated, so do that.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/cell/spufs/coredump.c |    4 ++--
 arch/powerpc/platforms/cell/spufs/file.c     |    4 +---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/platforms/cell/spufs/coredump.c
index 52d6219..fc988fd 100644
--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -72,7 +72,7 @@ static int spufs_ctx_note_size(struct spu_context *ctx, int dfd)
 	char *name;
 	char fullname[80];
 
-	for (i = 0; spufs_coredump_read[i].name; i++) {
+	for (i = 0; spufs_coredump_read[i].name != NULL; i++) {
 		name = spufs_coredump_read[i].name;
 		sz = spufs_coredump_read[i].size;
 
@@ -194,7 +194,7 @@ static void spufs_arch_write_notes(struct file *file)
 	while ((ctx = coredump_next_context(&fd)) != NULL) {
 		spu_acquire_saved(ctx);
 
-		for (j = 0; j < spufs_coredump_num_notes; j++)
+		for (j = 0; spufs_coredump_read[j].name != NULL; j++)
 			spufs_arch_write_note(ctx, j, file, fd);
 
 		spu_release_saved(ctx);
diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 85edbec..6095fb1 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -2250,7 +2250,5 @@ struct spufs_coredump_reader spufs_coredump_read[] = {
 	{ "proxydma_info", __spufs_proxydma_info_read,
 			   NULL, sizeof(struct spu_proxydma_info)},
 	{ "object-id", NULL, __spufs_object_id_get, 19 },
-	{ },
+	{ NULL },
 };
-int spufs_coredump_num_notes = ARRAY_SIZE(spufs_coredump_read) - 1;
-
