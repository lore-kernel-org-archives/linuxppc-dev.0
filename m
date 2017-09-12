Return-Path: <npiggin@gmail.com>
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	skiboot@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alistair Popple <alistair@popple.id.au>
Subject: [RFC PATCH 1/2] core: implement OPAL_SIGNAL_SYSTEM_RESET with POWER9
 scoms
Date: Wed, 13 Sep 2017 02:05:52 +1000
Message-Id: <20170912160553.13422-2-npiggin@gmail.com>
In-Reply-To: <20170912160553.13422-1-npiggin@gmail.com>
References: <20170912160553.13422-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This implements a way to raise system reset interrupts on other
cores. This has not yet been tested on DD2 or with deeper sleep
states.
---
 core/Makefile.inc       |   1 +
 core/sreset.c           | 237 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/xscom.c              |   2 +
 include/skiboot.h       |   3 +
 platforms/mambo/mambo.c |   3 +-
 5 files changed, 245 insertions(+), 1 deletion(-)
 create mode 100644 core/sreset.c

diff --git a/core/Makefile.inc b/core/Makefile.inc
index f2de2f64..16204978 100644
--- a/core/Makefile.inc
+++ b/core/Makefile.inc
@@ -9,6 +9,7 @@ CORE_OBJS += vpd.o hostservices.o platform.o nvram.o nvram-format.o hmi.o
 CORE_OBJS += console-log.o ipmi.o time-utils.o pel.o pool.o errorlog.o
 CORE_OBJS += timer.o i2c.o rtc.o flash.o sensor.o ipmi-opal.o
 CORE_OBJS += flash-subpartition.o bitmap.o buddy.o pci-quirk.o powercap.o psr.o
+CORE_OBJS += sreset.o
 
 ifeq ($(SKIBOOT_GCOV),1)
 CORE_OBJS += gcov-profiling.o
diff --git a/core/sreset.c b/core/sreset.c
new file mode 100644
index 00000000..ff20fe71
--- /dev/null
+++ b/core/sreset.c
@@ -0,0 +1,237 @@
+/* Copyright 2017 IBM Corp.
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ * 	http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
+ * implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+
+#include <skiboot.h>
+#include <cpu.h>
+#include <fsp.h>
+#include <psi.h>
+#include <opal.h>
+#include <xscom.h>
+#include <interrupts.h>
+#include <cec.h>
+#include <timebase.h>
+#include <pci.h>
+#include <chip.h>
+#include <chiptod.h>
+#include <ipmi.h>
+
+#define P9_RAS_STATUS			0x10a02
+#define P9_RSTAT_QUIESCED(t)		PPC_BITMASK(0 + 8*(t), 3 + 8*(t))
+#define P9_RAS_MODEREG			0x10a9d
+#define P9_DIRECT_CONTROLS		0x10a9c
+#define P9_DCTL_STOP(t)			PPC_BIT(7 + 8*(t))
+#define P9_DCTL_CONT(t)			PPC_BIT(6 + 8*(t))
+#define P9_DCTL_SRESET(t)		PPC_BIT(4 + 8*(t))
+#define P9_DCTL_PWR(t)			PPC_BIT(32 + 8*(t))
+
+#define P9_CORE_THREAD_STATE		0x10ab3
+#define P9_CTS_STOP(t)			PPC_BIT(56 + (t))
+
+#define PPM_GPMMR			0xf0100
+#define PPM_SPWKUP_OTR			0xf010a
+#define SPECIAL_WKUP_DONE		PPC_BIT(1)
+
+
+static int core_set_special_wakeup(struct cpu_thread *cpu)
+{
+	uint32_t chip_id = pir_to_chip_id(cpu->pir);
+	uint32_t core_id = pir_to_core_id(cpu->pir);
+	uint32_t swake_addr;
+	uint32_t gpmmr_addr;
+	uint64_t val;
+	int i;
+
+	swake_addr = XSCOM_ADDR_P9_EC(core_id, PPM_SPWKUP_OTR);
+	gpmmr_addr = XSCOM_ADDR_P9_EC(core_id, PPM_GPMMR);
+
+	xscom_read(chip_id, swake_addr, &val);
+	if (xscom_write(chip_id, swake_addr, PPC_BIT(0))) {
+		prlog(PR_WARNING, "SRESET: Unable to write SPWKUP_OTR register\n");
+		return OPAL_HARDWARE;
+	}
+	xscom_read(chip_id, swake_addr, &val);
+
+	for (i = 0; i < 100; i++) {
+		if (xscom_read(chip_id, gpmmr_addr, &val)) {
+			prlog(PR_WARNING, "SRESET: Unable to read GPMMR register\n");
+			return OPAL_HARDWARE;
+		}
+		if (val & SPECIAL_WKUP_DONE)
+			return 0;
+
+		time_wait_us(1);
+	}
+
+	xscom_read(chip_id, swake_addr, &val);
+	xscom_write(chip_id, swake_addr, 0);
+	xscom_read(chip_id, swake_addr, &val);
+
+	prlog(PR_WARNING, "SRESET: Special wakeup mode could not be set.\n");
+	return OPAL_HARDWARE;
+}
+
+static void core_clear_special_wakeup(struct cpu_thread *cpu)
+{
+	uint32_t chip_id = pir_to_chip_id(cpu->pir);
+	uint32_t core_id = pir_to_core_id(cpu->pir);
+	uint32_t swake_addr;
+	uint64_t val;
+
+	swake_addr = XSCOM_ADDR_P9_EC(core_id, PPM_SPWKUP_OTR);
+
+	/* De-assert special wakeup bit */
+	xscom_read(chip_id, swake_addr, &val);
+	xscom_write(chip_id, swake_addr, 0);
+	xscom_read(chip_id, swake_addr, &val);
+}
+
+static int thread_quiesced(struct cpu_thread *cpu)
+{
+	uint32_t chip_id = pir_to_chip_id(cpu->pir);
+	uint32_t core_id = pir_to_core_id(cpu->pir);
+	uint32_t thread_id = pir_to_thread_id(cpu->pir);
+	uint32_t ras_addr;
+	uint64_t ras_status;
+
+	ras_addr = XSCOM_ADDR_P9_EC(core_id, P9_RAS_STATUS);
+	if (xscom_read(chip_id, ras_addr, &ras_status)) {
+		prlog(PR_WARNING, "SRESET: Unable to read status register\n");
+		return OPAL_HARDWARE;
+	}
+
+	if ((ras_status & P9_RSTAT_QUIESCED(thread_id))
+		   	== P9_RSTAT_QUIESCED(thread_id))
+		return 1;
+
+	return 0;
+}
+
+static int stop_thread(struct cpu_thread *cpu)
+{
+	uint32_t chip_id = pir_to_chip_id(cpu->pir);
+	uint32_t core_id = pir_to_core_id(cpu->pir);
+	uint32_t thread_id = pir_to_thread_id(cpu->pir);
+	uint32_t dctl_addr;
+	int i;
+
+	dctl_addr = XSCOM_ADDR_P9_EC(core_id, P9_DIRECT_CONTROLS);
+
+	xscom_write(chip_id, dctl_addr, P9_DCTL_STOP(thread_id));
+
+	for (i = 0; i < 100; i++) {
+		int rc = thread_quiesced(cpu);
+		if (rc < 0)
+			break;
+		if (rc)
+			return 0;
+	}
+
+	xscom_write(chip_id, dctl_addr, P9_DCTL_CONT(thread_id));
+	prlog(PR_WARNING, "SRESET: Could not quiesce thread\n");
+	return OPAL_HARDWARE;
+}
+
+static int sreset_thread(struct cpu_thread *cpu)
+{
+	uint32_t chip_id = pir_to_chip_id(cpu->pir);
+	uint32_t core_id = pir_to_core_id(cpu->pir);
+	uint32_t thread_id = pir_to_thread_id(cpu->pir);
+	uint32_t dctl_addr;
+	uint32_t cts_addr;
+	uint64_t cts_val;
+
+	dctl_addr = XSCOM_ADDR_P9_EC(core_id, P9_DIRECT_CONTROLS);
+	cts_addr = XSCOM_ADDR_P9_EC(core_id, P9_CORE_THREAD_STATE);
+
+	if (xscom_read(chip_id, cts_addr, &cts_val)) {
+		prlog(PR_WARNING, "SRESET: Unable to read CORE_THREAD_STATE register\n");
+		return OPAL_HARDWARE;
+	}
+	if (!(cts_val & P9_CTS_STOP(thread_id))) {
+		/* Clear SRR1[46:47] */
+		if (xscom_write(chip_id, dctl_addr, P9_DCTL_PWR(thread_id))) {
+			prlog(PR_WARNING, "SRESET: Unable to set power saving mode\n");
+			return OPAL_HARDWARE;
+		}
+	}
+
+	if (xscom_write(chip_id, dctl_addr, P9_DCTL_SRESET(thread_id))) {
+		prlog(PR_WARNING, "SRESET: Unable to write DIRECT_CONTROLS register\n");
+		return OPAL_HARDWARE;
+	}
+
+	return 0;
+}
+
+// static struct lock sreset_lock = LOCK_UNLOCKED;
+
+static int64_t sreset_cpu(struct cpu_thread *cpu)
+{
+	int rc;
+
+	if (this_cpu() == cpu) {
+		prlog(PR_WARNING, "SRESET: Unable to reset self\n");
+		return OPAL_UNSUPPORTED;
+	}
+	if (this_cpu()->primary == cpu->primary) {
+		prlog(PR_WARNING, "SRESET: Unable to reset threads on same core\n");
+		return OPAL_PARTIAL;
+	}
+
+	rc = thread_quiesced(cpu);
+	if (rc < 0)
+		return rc;
+	if (rc) {
+		prlog(PR_WARNING, "SRESET: Thread is quiesced already\n");
+		return OPAL_WRONG_STATE;
+	}
+
+	rc = core_set_special_wakeup(cpu);
+	if (rc)
+		return rc;
+
+	rc = stop_thread(cpu);
+	if (rc) {
+		core_clear_special_wakeup(cpu);
+		return rc;
+	}
+
+	rc = sreset_thread(cpu);
+
+	core_clear_special_wakeup(cpu);
+
+	return 0;
+}
+
+int64_t signal_system_reset(int cpu_nr)
+{
+	struct cpu_thread *cpu;
+
+	if (proc_gen != proc_gen_p9)
+		return OPAL_UNSUPPORTED;
+
+	/* Reset a single CPU */
+	if (cpu_nr >= 0) {
+		cpu = find_cpu_by_server(cpu_nr);
+		if (!cpu) {
+			printf("SRESET: could not find cpu by server %d\n", cpu_nr);
+			return OPAL_PARAMETER;
+		}
+		return sreset_cpu(cpu);
+	}
+	printf("SRESET: unsupported %d\n", cpu_nr);
+	return OPAL_PARTIAL;
+}
diff --git a/hw/xscom.c b/hw/xscom.c
index 7bd78bf9..f3e04291 100644
--- a/hw/xscom.c
+++ b/hw/xscom.c
@@ -705,6 +705,8 @@ static void xscom_init_chip_info(struct proc_chip *chip)
 		printf("P9 DD%i.%i%d detected\n", 0xf & (chip->ec_level >> 4),
 		       chip->ec_level & 0xf, rev);
 		chip->ec_rev = rev;
+
+		opal_register(OPAL_SIGNAL_SYSTEM_RESET, signal_system_reset, 1);
 	}
 }
 
diff --git a/include/skiboot.h b/include/skiboot.h
index 4b7d5197..37fd774f 100644
--- a/include/skiboot.h
+++ b/include/skiboot.h
@@ -198,6 +198,9 @@ extern char __sym_map_end[];
 extern unsigned long get_symbol(unsigned long addr,
 				char **sym, char **sym_end);
 
+/* System reset */
+extern int64_t signal_system_reset(int cpu_nr);
+
 /* Fast reboot support */
 extern void disable_fast_reboot(const char *reason);
 extern void fast_reboot(void);
diff --git a/platforms/mambo/mambo.c b/platforms/mambo/mambo.c
index cb6e103c..e306ba5c 100644
--- a/platforms/mambo/mambo.c
+++ b/platforms/mambo/mambo.c
@@ -259,7 +259,8 @@ static int64_t mambo_signal_system_reset(int32_t cpu_nr)
 
 static void mambo_sreset_init(void)
 {
-	opal_register(OPAL_SIGNAL_SYSTEM_RESET, mambo_signal_system_reset, 1);
+	if (0)
+		opal_register(OPAL_SIGNAL_SYSTEM_RESET, mambo_signal_system_reset, 1);
 }
 
 static void mambo_platform_init(void)
-- 
2.13.3
