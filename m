Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18277.49950.354034.86146@cargo.ozlabs.ibm.com>
Date: Mon, 17 Dec 2007 11:30:22 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix sleep on powerbook 3400
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sleep on the powerbook 3400 has been broken since the change that made
powerbook_sleep_3400 call pmac_suspend_devices(), which disables
interrupts.  There are a couple of loops in powerbook_sleep_3400 that
depend on interrupts being enabled, and in fact it has to have
interrupts enabled at the point of going to sleep since it is an
interrupt from the PMU that wakes it up.

This fixes it by using pmu_wait_complete() instead of a spinloop, and
by explicitly enabling interrupts before putting the CPU into sleep
mode (which is OK since all interrupts except the PMU interrupt have
been disabled at the interrupt controller by this stage).

This also changes the logic to keep putting the CPU into sleep mode
until the completion of the interrupt transaction from the PMU that
signals the end of sleep.  Also, we now call pmu_unlock() before sleep
so that the via_pmu_interrupt() code can process the interrupt event
from the PMU properly.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 35e1f22..6f91723 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -2276,7 +2276,7 @@ powerbook_sleep_3400(void)
 {
 	int ret, i, x;
 	unsigned int hid0;
-	unsigned long p;
+	unsigned long p, msr;
 	struct adb_request sleep_req;
 	void __iomem *mem_ctrl;
 	unsigned int __iomem *mem_ctrl_sleep;
@@ -2315,10 +2315,10 @@ powerbook_sleep_3400(void)
 
 	/* Ask the PMU to put us to sleep */
 	pmu_request(&sleep_req, NULL, 5, PMU_SLEEP, 'M', 'A', 'T', 'T');
-	while (!sleep_req.complete)
-		mb();
+	pmu_wait_complete(&sleep_req);
+	pmu_unlock();
 
-	pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,1);
+	pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, 1);
 
 	/* displacement-flush the L2 cache - necessary? */
 	for (p = KERNELBASE; p < KERNELBASE + 0x100000; p += 0x1000)
@@ -2329,18 +2329,19 @@ powerbook_sleep_3400(void)
 	hid0 = mfspr(SPRN_HID0);
 	hid0 = (hid0 & ~(HID0_NAP | HID0_DOZE)) | HID0_SLEEP;
 	mtspr(SPRN_HID0, hid0);
-	mtmsr(mfmsr() | MSR_POW | MSR_EE);
-	udelay(10);
+	local_irq_enable();
+	msr = mfmsr() | MSR_POW;
+	while (asleep) {
+		mb();
+		mtmsr(msr);
+		isync();
+	}
+	local_irq_disable();
 
 	/* OK, we're awake again, start restoring things */
 	out_be32(mem_ctrl_sleep, 0x3f);
-	pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,0);
+	pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, 0);
 	pbook_pci_restore();
-	pmu_unlock();
-
-	/* wait for the PMU interrupt sequence to complete */
-	while (asleep)
-		mb();
 
 	pmac_wakeup_devices();
 	pbook_free_pci_save();
