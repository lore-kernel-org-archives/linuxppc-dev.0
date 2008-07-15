Return-Path: <arnd@arndb.de>
Message-Id: <20080715195739.408579544@arndb.de>
References: <20080715195139.316677337@arndb.de>
Date: Tue, 15 Jul 2008 21:51:43 +0200
From: arnd@arndb.de
To: benh@kernel.crashing.org, cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: [patch 4/9] powerpc/cell/cpufreq: add spu aware cpufreq governor
Cc: Christian Krafft <krafft@de.ibm.com>, Jeremy Kerr <jk@ozlabs.org>,
	Dave Jones <davej@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christian Krafft <krafft@de.ibm.com>

This patch adds a cpufreq governor that takes the number of running spus
into account. It's very similar to the ondemand governor, but not as complex.
Instead of hacking spu load into the ondemand governor it might be easier to
have cpufreq accepting multiple governors per cpu in future.
Don't know if this is the right way, but it would keep the governors simple.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Dave Jones <davej@redhat.com>
Cc: Jeremy Kerr <jk@ozlabs.org>
---
 arch/powerpc/platforms/cell/Kconfig             |    9 +
 arch/powerpc/platforms/cell/Makefile            |    1 +
 arch/powerpc/platforms/cell/cpufreq_spudemand.c |  184 +++++++++++++++++++++++
 3 files changed, 194 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/cell/cpufreq_spudemand.c

diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index 3959fcf..6ee571f 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -107,6 +107,15 @@ config CBE_CPUFREQ_PMI
 	  processor will not only be able to run at lower speed,
 	  but also at lower core voltage.
 
+config CBE_CPUFREQ_SPU_GOVERNOR
+	tristate "CBE frequency scaling based on SPU usage"
+	depends on SPU_FS && CPU_FREQ
+	default m
+	help
+	  This governor checks for spu usage to adjust the cpu frequency.
+	  If no spu is running on a given cpu, that cpu will be throttled to
+	  the minimal possible frequency.
+
 endmenu
 
 config OPROFILE_CELL
diff --git a/arch/powerpc/platforms/cell/Makefile b/arch/powerpc/platforms/cell/Makefile
index c2a7e4e..7fcf09b 100644
--- a/arch/powerpc/platforms/cell/Makefile
+++ b/arch/powerpc/platforms/cell/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_CBE_THERM)			+= cbe_thermal.o
 obj-$(CONFIG_CBE_CPUFREQ_PMI)		+= cbe_cpufreq_pmi.o
 obj-$(CONFIG_CBE_CPUFREQ)		+= cbe-cpufreq.o
 cbe-cpufreq-y				+= cbe_cpufreq_pervasive.o cbe_cpufreq.o
+obj-$(CONFIG_CBE_CPUFREQ_SPU_GOVERNOR)	+= cpufreq_spudemand.o
 
 ifeq ($(CONFIG_SMP),y)
 obj-$(CONFIG_PPC_CELL_NATIVE)		+= smp.o
diff --git a/arch/powerpc/platforms/cell/cpufreq_spudemand.c b/arch/powerpc/platforms/cell/cpufreq_spudemand.c
new file mode 100644
index 0000000..a3c6c01
--- /dev/null
+++ b/arch/powerpc/platforms/cell/cpufreq_spudemand.c
@@ -0,0 +1,184 @@
+/*
+ * spu aware cpufreq governor for the cell processor
+ *
+ * © Copyright IBM Corporation 2006-2008
+ *
+ * Author: Christian Krafft <krafft@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/cpufreq.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+#include <linux/workqueue.h>
+#include <asm/atomic.h>
+#include <asm/machdep.h>
+#include <asm/spu.h>
+
+#define POLL_TIME	100000		/* in µs */
+#define EXP		753		/* exp(-1) in fixed-point */
+
+struct spu_gov_info_struct {
+	unsigned long busy_spus;	/* fixed-point */
+	struct cpufreq_policy *policy;
+	struct delayed_work work;
+	unsigned int poll_int;		/* µs */
+};
+static DEFINE_PER_CPU(struct spu_gov_info_struct, spu_gov_info);
+
+static struct workqueue_struct *kspugov_wq;
+
+static int calc_freq(struct spu_gov_info_struct *info)
+{
+	int cpu;
+	int busy_spus;
+
+	cpu = info->policy->cpu;
+	busy_spus = atomic_read(&cbe_spu_info[cpu_to_node(cpu)].busy_spus);
+
+	CALC_LOAD(info->busy_spus, EXP, busy_spus * FIXED_1);
+	pr_debug("cpu %d: busy_spus=%d, info->busy_spus=%ld\n",
+			cpu, busy_spus, info->busy_spus);
+
+	return info->policy->max * info->busy_spus / FIXED_1;
+}
+
+static void spu_gov_work(struct work_struct *work)
+{
+	struct spu_gov_info_struct *info;
+	int delay;
+	unsigned long target_freq;
+
+	info = container_of(work, struct spu_gov_info_struct, work.work);
+
+	/* after cancel_delayed_work_sync we unset info->policy */
+	BUG_ON(info->policy == NULL);
+
+	target_freq = calc_freq(info);
+	__cpufreq_driver_target(info->policy, target_freq, CPUFREQ_RELATION_H);
+
+	delay = usecs_to_jiffies(info->poll_int);
+	queue_delayed_work_on(info->policy->cpu, kspugov_wq, &info->work, delay);
+}
+
+static void spu_gov_init_work(struct spu_gov_info_struct *info)
+{
+	int delay = usecs_to_jiffies(info->poll_int);
+	INIT_DELAYED_WORK_DEFERRABLE(&info->work, spu_gov_work);
+	queue_delayed_work_on(info->policy->cpu, kspugov_wq, &info->work, delay);
+}
+
+static void spu_gov_cancel_work(struct spu_gov_info_struct *info)
+{
+	cancel_delayed_work_sync(&info->work);
+}
+
+static int spu_gov_govern(struct cpufreq_policy *policy, unsigned int event)
+{
+	unsigned int cpu = policy->cpu;
+	struct spu_gov_info_struct *info, *affected_info;
+	int i;
+	int ret = 0;
+
+	info = &per_cpu(spu_gov_info, cpu);
+
+	switch (event) {
+	case CPUFREQ_GOV_START:
+		if (!cpu_online(cpu)) {
+			printk(KERN_ERR "cpu %d is not online\n", cpu);
+			ret = -EINVAL;
+			break;
+		}
+
+		if (!policy->cur) {
+			printk(KERN_ERR "no cpu specified in policy\n");
+			ret = -EINVAL;
+			break;
+		}
+
+		/* initialize spu_gov_info for all affected cpus */
+		for_each_cpu_mask(i, policy->cpus) {
+			affected_info = &per_cpu(spu_gov_info, i);
+			affected_info->policy = policy;
+		}
+
+		info->poll_int = POLL_TIME;
+
+		/* setup timer */
+		spu_gov_init_work(info);
+
+		break;
+
+	case CPUFREQ_GOV_STOP:
+		/* cancel timer */
+		spu_gov_cancel_work(info);
+
+		/* clean spu_gov_info for all affected cpus */
+		for_each_cpu_mask (i, policy->cpus) {
+			info = &per_cpu(spu_gov_info, i);
+			info->policy = NULL;
+		}
+
+		break;
+	}
+
+	return ret;
+}
+
+static struct cpufreq_governor spu_governor = {
+	.name = "spudemand",
+	.governor = spu_gov_govern,
+	.owner = THIS_MODULE,
+};
+
+/*
+ * module init and destoy
+ */
+
+static int __init spu_gov_init(void)
+{
+	int ret;
+
+	kspugov_wq = create_workqueue("kspugov");
+	if (!kspugov_wq) {
+		printk(KERN_ERR "creation of kspugov failed\n");
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret = cpufreq_register_governor(&spu_governor);
+	if (ret) {
+		printk(KERN_ERR "registration of governor failed\n");
+		destroy_workqueue(kspugov_wq);
+		goto out;
+	}
+out:
+	return ret;
+}
+
+static void __exit spu_gov_exit(void)
+{
+	cpufreq_unregister_governor(&spu_governor);
+	destroy_workqueue(kspugov_wq);
+}
+
+
+module_init(spu_gov_init);
+module_exit(spu_gov_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Christian Krafft <krafft@de.ibm.com>");
+
-- 
1.5.4.3

-- 
