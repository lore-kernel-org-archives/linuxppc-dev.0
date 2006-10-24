Return-Path: <arnd@arndb.de>
Message-Id: <20061024163813.437824000@arndb.de>
References: <20061024163113.694643000@arndb.de>
Date: Tue, 24 Oct 2006 18:31:17 +0200
From: arnd@arndb.de
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH 04/16] spufs: "stataus" isnt a word.
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/switch.c
@@ -102,7 +102,7 @@ static inline int check_spu_isolate(stru
 	 *     saved at this time.
 	 */
 	isolate_state = SPU_STATUS_ISOLATED_STATE |
-	    SPU_STATUS_ISOLATED_LOAD_STAUTUS | SPU_STATUS_ISOLATED_EXIT_STAUTUS;
+	    SPU_STATUS_ISOLATED_LOAD_STATUS | SPU_STATUS_ISOLATED_EXIT_STATUS;
 	return (in_be32(&prob->spu_status_R) & isolate_state) ? 1 : 0;
 }
 
@@ -1046,12 +1046,12 @@ static inline int suspend_spe(struct spu
 	 */
 	if (in_be32(&prob->spu_status_R) & SPU_STATUS_RUNNING) {
 		if (in_be32(&prob->spu_status_R) &
-		    SPU_STATUS_ISOLATED_EXIT_STAUTUS) {
+		    SPU_STATUS_ISOLATED_EXIT_STATUS) {
 			POLL_WHILE_TRUE(in_be32(&prob->spu_status_R) &
 					SPU_STATUS_RUNNING);
 		}
 		if ((in_be32(&prob->spu_status_R) &
-		     SPU_STATUS_ISOLATED_LOAD_STAUTUS)
+		     SPU_STATUS_ISOLATED_LOAD_STATUS)
 		    || (in_be32(&prob->spu_status_R) &
 			SPU_STATUS_ISOLATED_STATE)) {
 			out_be32(&prob->spu_runcntl_RW, SPU_RUNCNTL_STOP);
@@ -1085,7 +1085,7 @@ static inline void clear_spu_status(stru
 	 */
 	if (!(in_be32(&prob->spu_status_R) & SPU_STATUS_RUNNING)) {
 		if (in_be32(&prob->spu_status_R) &
-		    SPU_STATUS_ISOLATED_EXIT_STAUTUS) {
+		    SPU_STATUS_ISOLATED_EXIT_STATUS) {
 			spu_mfc_sr1_set(spu,
 					MFC_STATE1_MASTER_RUN_CONTROL_MASK);
 			eieio();
@@ -1095,7 +1095,7 @@ static inline void clear_spu_status(stru
 					SPU_STATUS_RUNNING);
 		}
 		if ((in_be32(&prob->spu_status_R) &
-		     SPU_STATUS_ISOLATED_LOAD_STAUTUS)
+		     SPU_STATUS_ISOLATED_LOAD_STATUS)
 		    || (in_be32(&prob->spu_status_R) &
 			SPU_STATUS_ISOLATED_STATE)) {
 			spu_mfc_sr1_set(spu,
Index: linux-2.6/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/spu.h
+++ linux-2.6/include/asm-powerpc/spu.h
@@ -291,8 +291,8 @@ struct spu_problem {
 #define SPU_STATUS_INVALID_INSTR        0x20
 #define SPU_STATUS_INVALID_CH           0x40
 #define SPU_STATUS_ISOLATED_STATE       0x80
-#define SPU_STATUS_ISOLATED_LOAD_STAUTUS 0x200
-#define SPU_STATUS_ISOLATED_EXIT_STAUTUS 0x400
+#define SPU_STATUS_ISOLATED_LOAD_STATUS 0x200
+#define SPU_STATUS_ISOLATED_EXIT_STATUS 0x400
 	u8  pad_0x4028_0x402c[0x4];				/* 0x4028 */
 	u32 spu_spe_R;						/* 0x402c */
 	u8  pad_0x4030_0x4034[0x4];				/* 0x4030 */

--
