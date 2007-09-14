Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 1/2] cell: don't cast the result of of_get_property()
Message-Id: <1189748800.165136.731062325870.1.gpush@pokey>
To: <linuxppc-dev@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 14 Sep 2007 15:46:40 +1000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The cast to u32 * isn't required, of_get_property returns a void *.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/cell/spu_manage.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spu_manage.c b/arch/powerpc/platforms/cell/spu_manage.c
index 0e14f53..1b01070 100644
--- a/arch/powerpc/platforms/cell/spu_manage.c
+++ b/arch/powerpc/platforms/cell/spu_manage.c
@@ -377,10 +377,10 @@ static int qs20_reg_memory[QS20_SPES_PER_BE] = { 1, 1, 0, 0, 0, 0, 0, 0 };
 static struct spu *spu_lookup_reg(int node, u32 reg)
 {
 	struct spu *spu;
-	u32 *spu_reg;
+	const u32 *spu_reg;
 
 	list_for_each_entry(spu, &cbe_spu_info[node].spus, cbe_list) {
-		spu_reg = (u32*)of_get_property(spu_devnode(spu), "reg", NULL);
+		spu_reg = of_get_property(spu_devnode(spu), "reg", NULL);
 		if (*spu_reg == reg)
 			return spu;
 	}
