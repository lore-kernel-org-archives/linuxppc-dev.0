Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 20/25] spufs: Add contents of npc file to SPU coredumps
Message-Id: <1189751574.110113.426063259127.20.gpush@pokey>
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

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
 arch/powerpc/platforms/cell/spufs/file.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 4cd34e5..985c86b 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -1606,12 +1606,17 @@ static void spufs_npc_set(void *data, u64 val)
 	spu_release(ctx);
 }
 
+static u64 __spufs_npc_get(struct spu_context *ctx)
+{
+	return ctx->ops->npc_read(ctx);
+}
+
 static u64 spufs_npc_get(void *data)
 {
 	struct spu_context *ctx = data;
 	u64 ret;
 	spu_acquire(ctx);
-	ret = ctx->ops->npc_read(ctx);
+	ret = __spufs_npc_get(ctx);
 	spu_release(ctx);
 	return ret;
 }
@@ -2242,5 +2247,6 @@ struct spufs_coredump_reader spufs_coredump_read[] = {
 	{ "proxydma_info", __spufs_proxydma_info_read,
 			   NULL, sizeof(struct spu_proxydma_info)},
 	{ "object-id", NULL, __spufs_object_id_get, 19 },
+	{ "npc", NULL, __spufs_npc_get, 19 },
 	{ NULL },
 };
