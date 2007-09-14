Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 10/25] spusched: fix null pointer dereference in find_victim
Message-Id: <1189751574.104447.719838727251.10.gpush@pokey>
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

From: Christoph Hellwig <hch@lst.de>

find_victim can dereference a NULL pointer when iterating over the list
of victim spus because list_mutex only guarantees spu->ct to be stable,
but of course not to be non-NULL.

Also fix find_victim to not call spu_unbind_context without list_mutex
because that violates the above guarantee.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/cell/spufs/sched.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index 17806e0..4d257b3 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -594,7 +594,7 @@ static struct spu *find_victim(struct spu_context *ctx)
 		list_for_each_entry(spu, &cbe_spu_info[node].spus, cbe_list) {
 			struct spu_context *tmp = spu->ctx;
 
-			if (tmp->prio > ctx->prio &&
+			if (tmp && tmp->prio > ctx->prio &&
 			    (!victim || tmp->prio > victim->prio))
 				victim = spu->ctx;
 		}
@@ -626,9 +626,9 @@ static struct spu *find_victim(struct spu_context *ctx)
 
 			mutex_lock(&cbe_spu_info[node].list_mutex);
 			cbe_spu_info[node].nr_active--;
+			spu_unbind_context(spu, victim);
 			mutex_unlock(&cbe_spu_info[node].list_mutex);
 
-			spu_unbind_context(spu, victim);
 			victim->stats.invol_ctx_switch++;
 			spu->stats.invol_ctx_switch++;
 			mutex_unlock(&victim->state_mutex);
