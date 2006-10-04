Return-Path: <arnd@arndb.de>
Message-Id: <20061004161458.745590000@arndb.de>
References: <20061004152610.151599000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Date: Wed, 04 Oct 2006 17:26:13 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 03/14] spufs: fix context switch during page fault
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	HyeonSeung Jang <hs8848.jang@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: HyeonSeung Jang <hs8848.jang@samsung.com>

For better explanation, I break down the page fault handling into steps:

1) There is a page fault caused by DMA operation initiated by SPU and
DMA is suspended.

2) The interrupt handler 'spu_irq_class_1()/__spu_trap_data_map()' is
called and it just wakes up the sleeping spe-manager thread.

3) by PPE scheduler, the corresponding bottom half,
spu_irq_class_1_bottom() is called in process context and DMA is
restarted.

There can be a quite large time gap between 2) and 3) and I found
the following problem:

Between 2) and 3) If the context becomes unbound, 3) is not executed
because when the spe-manager thread is awaken, the context is already
saved. (This situation can happen, for example, when a high priority spe
thread newly started in that time gap)

But the actual problem is that the corresponding SPU context does not
work even if it is bound again to a SPU.

Besides I can see the following warning in mambo simulator when the
context becomes
unbound(in save_mfc_cmd()), i.e. when unbind() is called for the
context after step 2) before 3) :

'WARNING: 61392752237: SPE2: MFC_CMD_QUEUE channel count of 15 is
inconsistent with number of available DMA queue entries of 16'

After I go through available documents, I found that the problem is
because the suspended DMA is not restarted when it is bound again.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/switch.c
@@ -1779,6 +1779,15 @@ static inline void restore_mfc_cntl(stru
 	 */
 	out_be64(&priv2->mfc_control_RW, csa->priv2.mfc_control_RW);
 	eieio();
+	/*
+	 * FIXME: this is to restart a DMA that we were processing
+	 *        before the save. better remember the fault information
+	 *        in the csa instead.
+	 */
+	if ((csa->priv2.mfc_control_RW & MFC_CNTL_SUSPEND_DMA_QUEUE_MASK)) {
+		out_be64(&priv2->mfc_control_RW, MFC_CNTL_RESTART_DMA_COMMAND);
+		eieio();
+	}
 }
 
 static inline void enable_user_access(struct spu_state *csa, struct spu *spu)

--
