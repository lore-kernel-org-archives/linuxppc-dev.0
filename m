Return-Path: <yury.norov@gmail.com>
From: Yury Norov <yury.norov@gmail.com>
To: arnd@arndb.de,
	benh@kernel.crashing.org,
	paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org, cbe-oss-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, klimov.linux@gmail.com,
 Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] powerpc: remove unneeded check in spu_gang_remove_ctx
Date: Mon, 22 Jun 2015 21:49:11 +0300
Message-Id: <1434998951-26285-1-git-send-email-yury.norov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In discussion to patch "selinux: reduce locking overhead in
inode_free_security()" it was figured out that list_del_init()
is safe to be called multiple times on the same entry. In that
case, it was useful to move a check out of spinlock to decrease
lock contention. Here we can remove '!list_empty()' check completely
and decrease 'spu_gang_remove_ctx()' function size, and (sometimes)
avoid branch predictor misses.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/powerpc/platforms/cell/spufs/gang.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/gang.c b/arch/powerpc/platforms/cell/spufs/gang.c
index 71a4432..67e3fc3 100644
--- a/arch/powerpc/platforms/cell/spufs/gang.c
+++ b/arch/powerpc/platforms/cell/spufs/gang.c
@@ -75,10 +75,10 @@ void spu_gang_remove_ctx(struct spu_gang *gang, struct spu_context *ctx)
 {
 	mutex_lock(&gang->mutex);
 	WARN_ON(ctx->gang != gang);
-	if (!list_empty(&ctx->aff_list)) {
-		list_del_init(&ctx->aff_list);
-		gang->aff_flags &= ~AFF_OFFSETS_SET;
-	}
+
+	list_del_init(&ctx->aff_list);
+	gang->aff_flags &= ~AFF_OFFSETS_SET;
+
 	list_del_init(&ctx->gang_list);
 	gang->contexts--;
 	mutex_unlock(&gang->mutex);
-- 
2.1.4
