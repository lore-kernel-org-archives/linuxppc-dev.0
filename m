Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 187E967E5D
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Oct 2006 09:37:01 +1000 (EST)
Date: Sat, 30 Sep 2006 18:36:56 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 15/15] uint to u32 conversion
Message-Id: <20060930183656.7bb61959.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Convert some uint types to u32 types

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/sysdev/qe_lib/qe_common.c |   22 +++++++++++-----------
 include/asm-powerpc/immap_qe.h         |   14 +++++++-------
 include/asm-powerpc/qe.h               |   16 ++++++++--------
 include/asm-powerpc/ucc_slow.h         |    6 +++---
 4 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe_common.c b/arch/powerpc/sysdev/qe_lib/qe_common.c
index 3780eae..fe6527a 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_common.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_common.c
@@ -100,7 +100,7 @@ void qe_reset(void)
 }
 
 EXPORT_SYMBOL(qe_issue_cmd);
-int qe_issue_cmd(uint cmd, uint device, u8 mcn_protocol, u32 cmd_input)
+int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input)
 {
 	unsigned long flags;
 	u32 cecr;
@@ -172,13 +172,13 @@ unsigned int get_brg_clk(void)
 /* This function is used by UARTS, or anything else that uses a 16x
  * oversampled clock.
  */
-void qe_setbrg(uint brg, uint rate)
+void qe_setbrg(u32 brg, u32 rate)
 {
-	volatile uint *bp;
+	volatile u32 *bp;
 	u32 divisor;
 	int div16 = 0;
 
-	bp = (uint *) & qe_immr->brg.brgc1;
+	bp = (u32 *) & qe_immr->brg.brgc1;
 	bp += brg;
 
 	divisor = (get_brg_clk() / rate);
@@ -271,7 +271,7 @@ EXPORT_SYMBOL(qe_put_snum);
 static int qe_sdma_init(void)
 {
 	struct sdma *sdma = &qe_immr->sdma;
-	uint sdma_buf_offset;
+	u32 sdma_buf_offset;
 
 	if (!sdma)
 		return -ENODEV;
@@ -325,7 +325,7 @@ static void qe_muram_init(void)
 
 /* This function returns an index into the MURAM area.
  */
-uint qe_muram_alloc(uint size, uint align)
+u32 qe_muram_alloc(u32 size, u32 align)
 {
 	void *start;
 	unsigned long flags;
@@ -334,12 +334,12 @@ uint qe_muram_alloc(uint size, uint alig
 	start = rh_alloc_align(&qe_muram_info, size, align, "QE");
 	spin_unlock_irqrestore(&qe_muram_lock, flags);
 
-	return (uint) start;
+	return (u32) start;
 }
 
 EXPORT_SYMBOL(qe_muram_alloc);
 
-int qe_muram_free(uint offset)
+int qe_muram_free(u32 offset)
 {
 	int ret;
 	unsigned long flags;
@@ -354,7 +354,7 @@ int qe_muram_free(uint offset)
 EXPORT_SYMBOL(qe_muram_free);
 
 /* not sure if this is ever needed */
-uint qe_muram_alloc_fixed(uint offset, uint size)
+u32 qe_muram_alloc_fixed(u32 offset, u32 size)
 {
 	void *start;
 	unsigned long flags;
@@ -364,7 +364,7 @@ uint qe_muram_alloc_fixed(uint offset, u
 	    rh_alloc_fixed(&qe_muram_info, (void *)offset, size, "commproc");
 	spin_unlock_irqrestore(&qe_muram_lock, flags);
 
-	return (uint) start;
+	return (u32) start;
 }
 
 EXPORT_SYMBOL(qe_muram_alloc_fixed);
@@ -376,7 +376,7 @@ void qe_muram_dump(void)
 
 EXPORT_SYMBOL(qe_muram_dump);
 
-void *qe_muram_addr(uint offset)
+void *qe_muram_addr(u32 offset)
 {
 	return (void *)&qe_immr->muram[offset];
 }
diff --git a/include/asm-powerpc/immap_qe.h b/include/asm-powerpc/immap_qe.h
index 229ac58..118caa2 100644
--- a/include/asm-powerpc/immap_qe.h
+++ b/include/asm-powerpc/immap_qe.h
@@ -486,18 +486,18 @@ extern phys_addr_t get_qe_base(void);
 
 static inline unsigned long immrbar_virt_to_phys(volatile void * address)
 {
-	if ( ((uint)address >= (uint)qe_immr) &&
-			((uint)address < ((uint)qe_immr + QE_IMMAP_SIZE)) )
-		return (unsigned long)(address - (uint)qe_immr +
-				(uint)get_qe_base());
+	if ( ((u32)address >= (u32)qe_immr) &&
+			((u32)address < ((u32)qe_immr + QE_IMMAP_SIZE)) )
+		return (unsigned long)(address - (u32)qe_immr +
+				(u32)get_qe_base());
 	return (unsigned long)virt_to_phys(address);
 }
 
 static inline void * immrbar_phys_to_virt(unsigned long address)
 {
-	if ( (address >= (uint)get_qe_base()) &&
-			(address < ((uint)get_qe_base() + QE_IMMAP_SIZE)) )
-		return (void *)(address - (uint)get_qe_base() + (uint)qe_immr);
+	if ( (address >= (u32)get_qe_base()) &&
+			(address < ((u32)get_qe_base() + QE_IMMAP_SIZE)) )
+		return (void *)(address - (u32)get_qe_base() + (u32)qe_immr);
 	return (void *)phys_to_virt(address);
 }
 
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index 2e43e45..2f18ff9 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -19,9 +19,9 @@ #define __QE_H__
 
 #include <asm/immap_qe.h>
 
-static inline long IS_MURAM_ERR(const uint offset)
+static inline long IS_MURAM_ERR(const u32 offset)
 {
-	return (uint) offset > (uint) - 1000L;
+	return (u32) offset > (u32) - 1000L;
 }
 
 #define QE_NUM_OF_SNUM  28
@@ -40,15 +40,15 @@ extern int par_io_init(struct device_nod
 extern int par_io_of_config(struct device_node *np);
 
 /* QE internal APIs */
-int qe_issue_cmd(uint cmd, uint device, u8 mcn_protocol, u32 cmd_input);
-void qe_setbrg(uint brg, uint rate);
+int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input);
+void qe_setbrg(u32 brg, u32 rate);
 int qe_get_snum(void);
 void qe_put_snum(u8 snum);
-uint qe_muram_alloc(uint size, uint align);
-int qe_muram_free(uint offset);
-uint qe_muram_alloc_fixed(uint offset, uint size);
+u32 qe_muram_alloc(u32 size, u32 align);
+int qe_muram_free(u32 offset);
+u32 qe_muram_alloc_fixed(u32 offset, u32 size);
 void qe_muram_dump(void);
-void *qe_muram_addr(uint offset);
+void *qe_muram_addr(u32 offset);
 /* Buffer descriptors.
 */
 struct qe_bd {
diff --git a/include/asm-powerpc/ucc_slow.h b/include/asm-powerpc/ucc_slow.h
index 4bca460..0dd96ec 100644
--- a/include/asm-powerpc/ucc_slow.h
+++ b/include/asm-powerpc/ucc_slow.h
@@ -202,7 +202,7 @@ struct ucc_slow_private {
 	struct ucc_slow_info *us_info;
 	struct ucc_slow *us_regs;	/* a pointer to memory map of UCC regs.  */
 	struct ucc_slow_pram *us_pram;	/* a pointer to the parameter RAM.  */
-	uint us_pram_offset;
+	u32 us_pram_offset;
 	int enabled_tx;		/* Whether channel is enabled for Tx (ENT) */
 	int enabled_rx;		/* Whether channel is enabled for Rx (ENR) */
 	int stopped_tx;		/* Whether channel has been stopped for Tx
@@ -211,8 +211,8 @@ struct ucc_slow_private {
 	struct list_head confQ;	/* frames passed to chip waiting for tx */
 	u32 first_tx_bd_mask;	/* mask is used in Tx routine to save status
 				   and length for first BD in a frame.  */
-	uint tx_base_offset;	/* first BD in Tx BD table offset (In MURAM) */
-	uint rx_base_offset;	/* first BD in Rx BD table offset (In MURAM) */
+	u32 tx_base_offset;	/* first BD in Tx BD table offset (In MURAM) */
+	u32 rx_base_offset;	/* first BD in Rx BD table offset (In MURAM) */
 	u8 *confBd;		/* next BD for confirm after Tx */
 	u8 *tx_bd;		/* next BD for new Tx request */
 	u8 *rx_bd;		/* next BD to collect after Rx */
-- 
1.4.2.1
