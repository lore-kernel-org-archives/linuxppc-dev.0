Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id 919D2DDE1A
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Sep 2007 21:54:46 +1000 (EST)
Received: from mail5.sony.co.jp (localhost [127.0.0.1])
	by mail5.sony.co.jp (R8/Sony) with ESMTP id l84BshBs026860
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Sep 2007 20:54:43 +0900 (JST)
Received: from mailgw02.scei.sony.co.jp (mailgw02.scei.sony.co.jp [43.27.73.8])
	by mail5.sony.co.jp (R8/Sony) with SMTP id l84Bshbd026849
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Sep 2007 20:54:43 +0900 (JST)
Message-ID: <46DD4777.8050402@am.sony.com>
Date: Tue, 04 Sep 2007 04:54:31 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: [patch 1/2] PS3: Clear SPU Class 0 interrupts in handler
Content-Type: text/plain; charset=UTF-8
Cc: "Noguchi, Masato" <Masato.Noguchi@jp.sony.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Masato Noguchi <Masato.Noguchi@jp.sony.com>

Fix a bug that causes the PS3 to hang on the SPU Class 0 interrupt.

The Cell BE Architecture spec states that the SPU MFC Class 0 interrupt
is delivered as a pulse.  The current spu interrupt handler assumes this
behavior and does not clear the interrupt status.

The PS3 hypervisor visualizes all SPU interrupts as level, and on return
from the interrupt handler the hypervisor will deliver a new virtual
interrupt for any unmasked interrupts which for which the status has not
been cleared.  This fix clears the interrupt status in the interrupt
handler.

Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---

Arnd, please consider for 2.6.24.
Tested on QS20, and seems OK.

 arch/powerpc/platforms/cell/spu_base.c |   23 +++++++++++++++--------
 include/asm-powerpc/spu.h              |    2 +-
 2 files changed, 16 insertions(+), 9 deletions(-)

--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -236,27 +236,34 @@ static irqreturn_t
 spu_irq_class_0(int irq, void *data)
 {
 	struct spu *spu;
+	unsigned long stat, mask;
 
 	spu = data;
-	spu->class_0_pending = 1;
+
+	mask = spu_int_mask_get(spu, 0);
+	stat = spu_int_stat_get(spu, 0);
+	stat &= mask;
+
+	spin_lock(&spu->register_lock);
+	spu->class_0_pending |= stat;
+	spin_unlock(&spu->register_lock);
+
 	spu->stop_callback(spu);
 
+	spu_int_stat_clear(spu, 0, stat);
+
 	return IRQ_HANDLED;
 }
 
 int
 spu_irq_class_0_bottom(struct spu *spu)
 {
-	unsigned long stat, mask;
 	unsigned long flags;
-
-	spu->class_0_pending = 0;
+	unsigned long stat;
 
 	spin_lock_irqsave(&spu->register_lock, flags);
-	mask = spu_int_mask_get(spu, 0);
-	stat = spu_int_stat_get(spu, 0);
-
-	stat &= mask;
+	stat = spu->class_0_pending;
+	spu->class_0_pending = 0;
 
 	if (stat & 1) /* invalid DMA alignment */
 		__spu_trap_dma_align(spu);
--- a/include/asm-powerpc/spu.h
+++ b/include/asm-powerpc/spu.h
@@ -130,6 +130,7 @@ struct spu {
 	u64 flags;
 	u64 dar;
 	u64 dsisr;
+	u64 class_0_pending;
 	size_t ls_size;
 	unsigned int slb_replace;
 	struct mm_struct *mm;
@@ -138,7 +139,6 @@ struct spu {
 	unsigned long long timestamp;
 	pid_t pid;
 	pid_t tgid;
-	int class_0_pending;
 	spinlock_t register_lock;
 
 	void (* wbox_callback)(struct spu *spu);
