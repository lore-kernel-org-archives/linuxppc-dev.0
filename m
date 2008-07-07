Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: powerpc/cell/cpufreq: add spu aware cpufreq governor
Date: Mon, 7 Jul 2008 17:02:30 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200807071702.31240.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, cpufreq@lists.linux.org.uk,
	linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46rom: Christian Krafft <krafft@de.ibm.com>

This patch adds a cpufreq governor that takes the number of running spus
into account. It's very similar to the ondemand governor, but not as comple=
x.
Instead of hacking spu load into the ondemand governor it might be easier to
have cpufreq accepting multiple governors per cpu in future.
Don't know if this is the right way, but it would keep the governors simple.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
=2D--

Dave or other cpufreq people, can you take a look at this
and add an Acked-by when you're happy?

We have one prerequisite patch in the powerpc code (in spufs),
so should it get merged through powerpc.git?

 arch/powerpc/platforms/cell/Kconfig            |   10 ++
 arch/powerpc/platforms/cell/Makefile           |    1 +
 arch/powerpc/platforms/cell/cbe_spu_governor.c |  183 ++++++++++++++++++++=
++++
 3 files changed, 194 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/cell/cbe_spu_governor.c

Index: linux-2.6/arch/powerpc/platforms/cell/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.orig/arch/powerpc/platforms/cell/Kconfig
+++ linux-2.6/arch/powerpc/platforms/cell/Kconfig
@@ -107,6 +107,16 @@ config CBE_CPUFREQ_PMI
 	  processor will not only be able to run at lower speed,
 	  but also at lower core voltage.
=20
+config CBE_CPUFREQ_SPU_GOVERNOR
+	tristate "CBE frequency scaling based on SPU usage"
+	depends on SPU_FS
+	select CBE_CPUFREQ
+	default m
+	help
+	  This governor checks for spu usage to adjust the cpu frequency.
+	  If no spu is running on a given cpu, that cpu will be throttled to
+	  the minimal possible frequency.
+
 endmenu
=20
 config OPROFILE_CELL
Index: linux-2.6/arch/powerpc/platforms/cell/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.orig/arch/powerpc/platforms/cell/Makefile
+++ linux-2.6/arch/powerpc/platforms/cell/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_CBE_THERM)			+=3D cbe_thermal
 obj-$(CONFIG_CBE_CPUFREQ_PMI)		+=3D cbe_cpufreq_pmi.o
 obj-$(CONFIG_CBE_CPUFREQ)		+=3D cbe-cpufreq.o
 cbe-cpufreq-y				+=3D cbe_cpufreq_pervasive.o cbe_cpufreq.o
+obj-$(CONFIG_CBE_CPUFREQ_SPU_GOVERNOR)	+=3D cbe_spu_governor.o
=20
 ifeq ($(CONFIG_SMP),y)
 obj-$(CONFIG_PPC_CELL_NATIVE)		+=3D smp.o
Index: linux-2.6/arch/powerpc/platforms/cell/cbe_spu_governor.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- /dev/null
+++ linux-2.6/arch/powerpc/platforms/cell/cbe_spu_governor.c
@@ -0,0 +1,184 @@
+/*
+ * spu aware cpufreq governor for the cell processor
+ *
+ * =C2=A9 Copyright IBM Corporation 2006-2008
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
+#define POLL_TIME	100000		/* in =C2=B5s */
+#define EXP		753		/* exp(-1) in fixed-point */
+
+struct spu_gov_info_struct {
+	unsigned long busy_spus;	/* fixed-point */
+	struct cpufreq_policy *policy;
+	struct delayed_work work;
+	unsigned int poll_int;		/* =C2=B5s */
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
+	cpu =3D info->policy->cpu;
+	busy_spus =3D atomic_read(&cbe_spu_info[cpu_to_node(cpu)].busy_spus);
+
+	CALC_LOAD(info->busy_spus, EXP, busy_spus * FIXED_1);
+	pr_debug("cpu %d: busy_spus=3D%d, info->busy_spus=3D%ld\n",
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
+	info =3D container_of(work, struct spu_gov_info_struct, work.work);
+
+	/* after cancel_delayed_work_sync we unset info->policy */
+	BUG_ON(info->policy =3D=3D NULL);
+
+	target_freq =3D calc_freq(info);
+	__cpufreq_driver_target(info->policy, target_freq, CPUFREQ_RELATION_H);
+
+	delay =3D usecs_to_jiffies(info->poll_int);
+	queue_delayed_work_on(info->policy->cpu, kspugov_wq, &info->work, delay);
+}
+
+static void spu_gov_init_work(struct spu_gov_info_struct *info)
+{
+	int delay =3D usecs_to_jiffies(info->poll_int);
+	INIT_DELAYED_WORK_DEFERRABLE(&info->work, spu_gov_work);
+	queue_delayed_work_on(info->policy->cpu, kspugov_wq, &info->work, delay);
+}
+
+static void spu_gov_cancel_work(struct spu_gov_info_struct *info)
+{
+	cancel_delayed_work_sync(&info->work);
+}
+
+static int spu_gov_govern(struct cpufreq_policy *policy, unsigned int even=
t)
+{
+	unsigned int cpu =3D policy->cpu;
+	struct spu_gov_info_struct *info, *affected_info;
+	int i;
+	int ret =3D 0;
+
+	info =3D &per_cpu(spu_gov_info, cpu);
+
+	switch (event) {
+	case CPUFREQ_GOV_START:
+		if (!cpu_online(cpu)) {
+			printk(KERN_ERR "cpu %d is not online\n", cpu);
+			ret =3D -EINVAL;
+			break;
+		}
+
+		if (!policy->cur) {
+			printk(KERN_ERR "no cpu specified in policy\n");
+			ret =3D -EINVAL;
+			break;
+		}
+
+		/* initialize spu_gov_info for all affected cpus */
+		for_each_cpu_mask(i, policy->cpus) {
+			affected_info =3D &per_cpu(spu_gov_info, i);
+			affected_info->policy =3D policy;
+		}
+
+		info->poll_int =3D POLL_TIME;
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
+			info =3D &per_cpu(spu_gov_info, i);
+			info->policy =3D NULL;
+		}
+
+		break;
+	}
+
+	return ret;
+}
+
+static struct cpufreq_governor spu_governor =3D {
+	.name =3D "spu_governor",
+	.governor =3D spu_gov_govern,
+	.owner =3D THIS_MODULE,
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
+	kspugov_wq =3D create_workqueue("kspugov");
+	if (!kspugov_wq) {
+		printk(KERN_ERR "creation of kspugov failed\n");
+		ret =3D -EFAULT;
+		goto out;
+	}
+
+	ret =3D cpufreq_register_governor(&spu_governor);
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
