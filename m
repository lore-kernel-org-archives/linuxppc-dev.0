Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yNT4l6Q0wzDrbl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 13:55:03 +1100 (AEDT)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Message-Id: <6c0df1bef980d1577a830db2f563a3fb20bc431f.1509071937.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1509071937.git.fthain@telegraphics.com.au>
References: <cover.1509071937.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 4/4] m68k/mac: Add mutual exclusion for IOP interrupt polling
Date: Thu, 26 Oct 2017 22:45:24 -0400 (EDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The IOP interrupt handler iop_ism_irq() is used by the adb-iop
driver to poll for ADB request completion. Unfortunately, it is not
re-entrant. Fix the race condition by adding an iop_ism_irq_poll()
function with suitable mutual exclusion.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/m68k/include/asm/mac_iop.h | 1 +
 arch/m68k/mac/iop.c             | 9 +++++++++
 drivers/macintosh/adb-iop.c     | 4 +---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/include/asm/mac_iop.h b/arch/m68k/include/asm/mac_iop.h
index 42566fd052bc..d2a08e004e2c 100644
--- a/arch/m68k/include/asm/mac_iop.h
+++ b/arch/m68k/include/asm/mac_iop.h
@@ -158,6 +158,7 @@ extern void iop_complete_message(struct iop_msg *);
 extern void iop_upload_code(uint, __u8 *, uint, __u16);
 extern void iop_download_code(uint, __u8 *, uint, __u16);
 extern __u8 *iop_compare_code(uint, __u8 *, uint, __u16);
+extern void iop_ism_irq_poll(uint);
 
 extern void iop_register_interrupts(void);
 
diff --git a/arch/m68k/mac/iop.c b/arch/m68k/mac/iop.c
index a2ea52db7d18..9bfa17015768 100644
--- a/arch/m68k/mac/iop.c
+++ b/arch/m68k/mac/iop.c
@@ -598,3 +598,12 @@ irqreturn_t iop_ism_irq(int irq, void *dev_id)
 	}
 	return IRQ_HANDLED;
 }
+
+void iop_ism_irq_poll(uint iop_num)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	iop_ism_irq(0, (void *)iop_num);
+	local_irq_restore(flags);
+}
diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index f5f4da3d0b67..4b0ad3995497 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -29,8 +29,6 @@
 
 /*#define DEBUG_ADB_IOP*/
 
-extern void iop_ism_irq(int, void *);
-
 static struct adb_request *current_req;
 static struct adb_request *last_req;
 #if 0
@@ -265,7 +263,7 @@ int adb_iop_autopoll(int devs)
 void adb_iop_poll(void)
 {
 	if (adb_iop_state == idle) adb_iop_start();
-	iop_ism_irq(0, (void *) ADB_IOP);
+	iop_ism_irq_poll(ADB_IOP);
 }
 
 int adb_iop_reset_bus(void)
-- 
2.13.6
