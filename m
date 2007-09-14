Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 08/25] Fix restore_decr_wrapped() to match CBE Handbook
Message-Id: <1189751574.103493.873307761185.8.gpush@pokey>
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

Based on an original patch from Masato Noguchi
<Masato.Noguchi@jp.sony.com>.

We're currently not restoring the SPE decrementer as specified by the
CBE handbook. This change fixes our implementation to match, and makes
the function read more like the docs.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/cell/spufs/switch.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/switch.c b/arch/powerpc/platforms/cell/spufs/switch.c
index 2506619..de7e5ee 100644
--- a/arch/powerpc/platforms/cell/spufs/switch.c
+++ b/arch/powerpc/platforms/cell/spufs/switch.c
@@ -1559,15 +1559,15 @@ static inline void restore_decr_wrapped(struct spu_state *csa, struct spu *spu)
 	 *     "wrapped" flag is set, OR in a '1' to
 	 *     CSA.SPU_Event_Status[Tm].
 	 */
-	if (csa->lscsa->decr_status.slot[0] & SPU_DECR_STATUS_WRAPPED) {
-		csa->spu_chnldata_RW[0] |= 0x20;
-	}
-	if ((csa->lscsa->decr_status.slot[0] & SPU_DECR_STATUS_WRAPPED) &&
-	    (csa->spu_chnlcnt_RW[0] == 0 &&
-	     ((csa->spu_chnldata_RW[2] & 0x20) == 0x0) &&
-	     ((csa->spu_chnldata_RW[0] & 0x20) != 0x1))) {
+	if (!(csa->lscsa->decr_status.slot[0] & SPU_DECR_STATUS_WRAPPED))
+		return;
+
+	if ((csa->spu_chnlcnt_RW[0] == 0) &&
+	    (csa->spu_chnldata_RW[1] & 0x20) &&
+	    !(csa->spu_chnldata_RW[0] & 0x20))
 		csa->spu_chnlcnt_RW[0] = 1;
-	}
+
+	csa->spu_chnldata_RW[0] |= 0x20;
 }
 
 static inline void restore_ch_part1(struct spu_state *csa, struct spu *spu)
