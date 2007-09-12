Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <6566ec53f4b03dbf089291a7335f5370c6a88088.1189583010.git.michael@ellerman.id.au>
In-Reply-To: <2900ea4dbfd6e98e71ff400cbd25d1283a278972.1189583010.git.michael@ellerman.id.au>
References: <2900ea4dbfd6e98e71ff400cbd25d1283a278972.1189583010.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 10/15] Add contents of npc file to SPU coredumps
Date: Wed, 12 Sep 2007 17:43:47 +1000 (EST)
Cc: Jeremy Kerr <jk@ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/spufs/file.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index d19220f..52f020a 100644
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
@@ -2242,6 +2247,7 @@ struct spufs_coredump_reader spufs_coredump_read[] = {
 	{ "proxydma_info", __spufs_proxydma_info_read,
 			   NULL, sizeof(struct spu_proxydma_info)},
 	{ "object-id", NULL, __spufs_object_id_get, 19 },
+	{ "npc", NULL, __spufs_npc_get, 19 },
 };
 
 int spufs_coredump_num_notes = ARRAY_SIZE(spufs_coredump_read);
-- 
1.5.1.3.g7a33b
