Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 40yRV52fJ2zF0WH
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 13:27:57 +1000 (AEST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>
Message-Id: <a9d597fceb83952694808849100c2737f28107e1.1527909627.git.fthain@telegraphics.com.au>
In-Reply-To: <af2106d65c6b845c178bb2a0837e8554be2d1e8e.1527909627.git.fthain@telegraphics.com.au>
References: <cover.1527909627.git.fthain@telegraphics.com.au>
 <f32f4e3a0fd736152f768b7a00bfc731daba1629.1527909627.git.fthain@telegraphics.com.au>
 <7ce9a8c3996506ae6f9ab16b3cf73c287e205a89.1527909627.git.fthain@telegraphics.com.au>
 <8597ac466215f573d8bea40e74fdec2bf72fabbb.1527909627.git.fthain@telegraphics.com.au>
 <878b389293851359e53de186bf302ce52d95ad95.1527909627.git.fthain@telegraphics.com.au>
 <adba0545c06cd6c67e26c433990d036b0d7e968c.1527909627.git.fthain@telegraphics.com.au>
 <166b4c3a7347fe27f12bda86d50533cd01ee11b9.1527909627.git.fthain@telegraphics.com.au>
 <73507a3e9444da17c222cf74df41842ce30d15ee.1527909627.git.fthain@telegraphics.com.au>
 <de8edb03dbd2fd25b53d0bdf9c6d65adf9aa0aa3.1527909627.git.fthain@telegraphics.com.au>
 <ddfa9261a77d747e6523dd5cc0df84cc555dc440.1527909627.git.fthain@telegraphics.com.au>
 <af2106d65c6b845c178bb2a0837e8554be2d1e8e.1527909627.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 11/11] macintosh/via-pmu: Disambiguate interrupt statistics
Date: Fri,  1 Jun 2018 23:27:51 -0400 (EDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of the event counters are overloaded which makes it very
difficult to interpret their values.

Counter 0 is supposed to report CB1 interrupts but it can also count
PMU_INT_WAITING_CHARGER events.

Counter 1 is supposed to report GPIO interrupts but it can also count
other events (depending upon the value of the PMU_INT_ADB bit).

Disambiguate these statistics with dedicated counters for GPIO and
CB1 interrupts.

Comments in the MkLinux source code say that the type 0 and type 1
interrupts are model-specific. Label them as "unknown".

This change to the contents of /proc/pmu/interrupts is by necessity
visible in userland. However, packages which interact with the PMU
(that is, pbbuttonsd, pmac-utils and pmud) don't open this file.
AFAIK, user software has no need to poll these counters.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
The file now looks like this,

  0:          0 (Unknown interrupt (type 0))
  1:          0 (Unknown interrupt (type 1))
  2:          0 (PC-Card eject button)
  3:         23 (Sound/Brightness button)
  4:         74 (ADB message)
  5:          0 (Battery state change)
  6:          0 (Environment interrupt)
  7:        121 (Tick timer)
  8:          0 (Ghost interrupt (zero len))
  9:          1 (Empty interrupt (empty mask))
 10:          2 (Max irqs in a row)
 11:        194 (Total CB1 triggered events)
 12:          0 (Total GPIO1 triggered events)

rather than this,

  0:        194 (Total CB1 triggered events)
  1:          0 (Total GPIO1 triggered events)
  2:          0 (PC-Card eject button)
  3:         23 (Sound/Brightness button)
  4:         74 (ADB message)
  5:          0 (Battery state change)
  6:          0 (Environment interrupt)
  7:        121 (Tick timer)
  8:          0 (Ghost interrupt (zero len))
  9:          1 (Empty interrupt (empty mask))
 10:          2 (Max irqs in a row)

If some parser exists for this file, and if this change is problematic,
we could increment the driver version number in /proc/pmu/info, to
correspond with the format change.
---
 drivers/macintosh/via-pmu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 5c5ebad4e6ae..490bbcc42ce0 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -172,7 +172,9 @@ static int drop_interrupts;
 static int option_lid_wakeup = 1;
 #endif /* CONFIG_SUSPEND && CONFIG_PPC32 */
 static unsigned long async_req_locks;
-static unsigned int pmu_irq_stats[11];
+
+#define NUM_IRQ_STATS 13
+static unsigned int pmu_irq_stats[NUM_IRQ_STATS];
 
 static struct proc_dir_entry *proc_pmu_root;
 static struct proc_dir_entry *proc_pmu_info;
@@ -884,9 +886,9 @@ static const struct file_operations pmu_info_proc_fops = {
 static int pmu_irqstats_proc_show(struct seq_file *m, void *v)
 {
 	int i;
-	static const char *irq_names[] = {
-		"Total CB1 triggered events",
-		"Total GPIO1 triggered events",
+	static const char *irq_names[NUM_IRQ_STATS] = {
+		"Unknown interrupt (type 0)",
+		"Unknown interrupt (type 1)",
 		"PC-Card eject button",
 		"Sound/Brightness button",
 		"ADB message",
@@ -895,10 +897,12 @@ static int pmu_irqstats_proc_show(struct seq_file *m, void *v)
 		"Tick timer",
 		"Ghost interrupt (zero len)",
 		"Empty interrupt (empty mask)",
-		"Max irqs in a row"
+		"Max irqs in a row",
+		"Total CB1 triggered events",
+		"Total GPIO1 triggered events",
         };
 
-	for (i=0; i<11; i++) {
+	for (i = 0; i < NUM_IRQ_STATS; i++) {
 		seq_printf(m, " %2u: %10u (%s)\n",
 			     i, pmu_irq_stats[i], irq_names[i]);
 	}
@@ -1655,7 +1659,7 @@ via_pmu_interrupt(int irq, void *arg)
 		}
 		if (intr & CB1_INT) {
 			adb_int_pending = 1;
-			pmu_irq_stats[0]++;
+			pmu_irq_stats[11]++;
 		}
 		if (intr & SR_INT) {
 			req = pmu_sr_intr();
@@ -1742,7 +1746,7 @@ gpio1_interrupt(int irq, void *arg)
 			disable_irq_nosync(gpio_irq);
 			gpio_irq_enabled = 0;
 		}
-		pmu_irq_stats[1]++;
+		pmu_irq_stats[12]++;
 		adb_int_pending = 1;
 		spin_unlock_irqrestore(&pmu_lock, flags);
 		via_pmu_interrupt(0, NULL);
-- 
2.16.1
