Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <895526252184eee5548e553d1cfec642b7fc68b8.1189583010.git.michael@ellerman.id.au>
In-Reply-To: <2900ea4dbfd6e98e71ff400cbd25d1283a278972.1189583010.git.michael@ellerman.id.au>
References: <2900ea4dbfd6e98e71ff400cbd25d1283a278972.1189583010.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 06/15] Correctly calculate the size of the local-store to dump
Date: Wed, 12 Sep 2007 17:43:43 +1000 (EST)
Cc: Jeremy Kerr <jk@ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The routine to dump the local store, __spufs_mem_read(), does not take the
spu_lslr_RW value into account - so we shouldn't check it when we're
calculating the size either.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/spufs/coredump.c |   16 ++--------------
 1 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/platforms/cell/spufs/coredump.c
index c65b717..52d6219 100644
--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -66,11 +66,6 @@ static int spufs_dump_seek(struct file *file, loff_t off)
 	return 1;
 }
 
-static u64 ctx_ls_size(struct spu_context *ctx)
-{
-	return ctx->csa.priv2.spu_lslr_RW + 1;
-}
-
 static int spufs_ctx_note_size(struct spu_context *ctx, int dfd)
 {
 	int i, sz, total = 0;
@@ -85,10 +80,7 @@ static int spufs_ctx_note_size(struct spu_context *ctx, int dfd)
 
 		total += sizeof(struct elf_note);
 		total += roundup(strlen(fullname) + 1, 4);
-		if (!strcmp(name, "mem"))
-			total += roundup(ctx_ls_size(ctx), 4);
-		else
-			total += roundup(sz, 4);
+		total += roundup(sz, 4);
 	}
 
 	return total;
@@ -164,11 +156,7 @@ static void spufs_arch_write_note(struct spu_context *ctx, int i,
 		return;
 
 	name = spufs_coredump_read[i].name;
-
-	if (!strcmp(name, "mem"))
-		sz = ctx_ls_size(ctx);
-	else
-		sz = spufs_coredump_read[i].size;
+	sz = spufs_coredump_read[i].size;
 
 	sprintf(fullname, "SPU/%d/%s", dfd, name);
 	en.n_namesz = strlen(fullname) + 1;
-- 
1.5.1.3.g7a33b
