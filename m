Return-Path: <krafft@de.ibm.com>
Date: Thu, 21 Jun 2007 13:41:15 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: Christian Krafft <krafft@de.ibm.com>
Subject: [patch 5/5] cell: cbe_cpufreq: reorganize code
Message-ID: <20070621134115.62225f49@localhost>
In-Reply-To: <20070621130944.083f8fa5@localhost>
References: <20070621130944.083f8fa5@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_+bZhZ1f_sDOE/RqFB6D2KGJ";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_+bZhZ1f_sDOE/RqFB6D2KGJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Subject: cbe_cpufreq: reorganize code and fix some bugs

From: Christian Krafft <krafft@de.ibm.com>

This patch reorganizes the code of the driver into three files.
Two cbe_cpufreq_pmi.c and cbe_cpufreq_pervasive.c care about hardware.
cbe_cpufreq.c contains the logic.
There is no changed behaviour, except that the PMI related function
is now located in a seperate module cbe_cpufreq_pmi. This module
will be required by cbe_cpufreq, if CONFIG_CBE_CPUFREQ_PMI has been set.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>


Index: linux-2.6.22-rc5/arch/powerpc/platforms/cell/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-rc5.orig/arch/powerpc/platforms/cell/Kconfig
+++ linux-2.6.22-rc5/arch/powerpc/platforms/cell/Kconfig
@@ -73,4 +73,14 @@ config CBE_CPUFREQ
 	  For details, take a look at <file:Documentation/cpu-freq/>.
 	  If you don't have such processor, say N
=20
+config CBE_CPUFREQ_PMI
+	tristate "CBE frequency scaling using PMI interface"
+	depends on CBE_CPUFREQ && PPC_PMI && EXPERIMENTAL
+	default n
+	help
+	  Select this, if you want to use the PMI interface
+	  to switch frequencies. Using PMI, the
+	  processor will not only be able to run at lower speed,
+	  but also at lower core voltage.
+
 endmenu
Index: linux-2.6.22-rc5/arch/powerpc/platforms/cell/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-rc5.orig/arch/powerpc/platforms/cell/Makefile
+++ linux-2.6.22-rc5/arch/powerpc/platforms/cell/Makefile
@@ -4,7 +4,9 @@ obj-$(CONFIG_PPC_CELL_NATIVE)		+=3D interr
 obj-$(CONFIG_CBE_RAS)			+=3D ras.o
=20
 obj-$(CONFIG_CBE_THERM)			+=3D cbe_thermal.o
-obj-$(CONFIG_CBE_CPUFREQ)		+=3D cbe_cpufreq.o
+obj-$(CONFIG_CBE_CPUFREQ_PMI)		+=3D cbe_cpufreq_pmi.o
+obj-$(CONFIG_CBE_CPUFREQ)		+=3D cbe-cpufreq.o
+cbe-cpufreq-y				+=3D cbe_cpufreq_pervasive.o cbe_cpufreq.o
=20
 ifeq ($(CONFIG_SMP),y)
 obj-$(CONFIG_PPC_CELL_NATIVE)		+=3D smp.o
Index: linux-2.6.22-rc5/arch/powerpc/platforms/cell/cbe_cpufreq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-rc5.orig/arch/powerpc/platforms/cell/cbe_cpufreq.c
+++ linux-2.6.22-rc5/arch/powerpc/platforms/cell/cbe_cpufreq.c
@@ -1,7 +1,7 @@
 /*
  * cpufreq driver for the cell processor
  *
- * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005-2007
  *
  * Author: Christian Krafft <krafft@de.ibm.com>
  *
@@ -21,18 +21,10 @@
  */
=20
 #include <linux/cpufreq.h>
-#include <linux/timer.h>
-
-#include <asm/hw_irq.h>
-#include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/processor.h>
-#include <asm/prom.h>
-#include <asm/time.h>
-#include <asm/pmi.h>
 #include <asm/of_platform.h>
-
-#include "cbe_regs.h"
+#include <asm/prom.h>
+#include "cbe_cpufreq.h"
=20
 static DEFINE_MUTEX(cbe_switch_mutex);
=20
@@ -50,183 +42,24 @@ static struct cpufreq_frequency_table cb
 	{0,	CPUFREQ_TABLE_END},
 };
=20
-/* to write to MIC register */
-static u64 MIC_Slow_Fast_Timer_table[] =3D {
-	[0 ... 7] =3D 0x007fc00000000000ull,
-};
-
-/* more values for the MIC */
-static u64 MIC_Slow_Next_Timer_table[] =3D {
-	0x0000240000000000ull,
-	0x0000268000000000ull,
-	0x000029C000000000ull,
-	0x00002D0000000000ull,
-	0x0000300000000000ull,
-	0x0000334000000000ull,
-	0x000039C000000000ull,
-	0x00003FC000000000ull,
-};
-
-static u8 pmi_slow_mode_limit[MAX_BE];
-
 /*
  * hardware specific functions
  */
=20
-static bool cbe_cpufreq_has_pmi;
-
-#ifdef CONFIG_PPC_PMI
-static int set_pmode_pmi(int cpu, unsigned int pmode)
-{
-	int ret;
-	pmi_message_t pmi_msg;
-#ifdef DEBUG
-	long time;
-#endif
-
-	pmi_msg.type =3D PMI_TYPE_FREQ_CHANGE;
-	pmi_msg.data1 =3D	cbe_cpu_to_node(cpu);
-	pmi_msg.data2 =3D pmode;
-
-#ifdef DEBUG
-	time =3D jiffies;
-#endif
-
-	pmi_send_message(pmi_msg);
-	ret =3D pmi_msg.data2;
-
-	pr_debug("PMI returned slow mode %d\n", ret);
-
-#ifdef DEBUG
-	time =3D jiffies - time; /* actual cycles (not cpu cycles!) */
-	time =3D jiffies_to_msecs(time);
-	pr_debug("had to wait %lu ms for a transition using PMI.\n", time);
-#endif
-	return ret;
-}
-#endif
-
-static int get_pmode(int cpu)
-{
-	int ret;
-	struct cbe_pmd_regs __iomem *pmd_regs;
-
-	pmd_regs =3D cbe_get_cpu_pmd_regs(cpu);
-	ret =3D in_be64(&pmd_regs->pmsr) & 0x07;
-
-	return ret;
-}
-
-static int set_pmode_reg(int cpu, unsigned int pmode)
-{
-	struct cbe_pmd_regs __iomem *pmd_regs;
-	struct cbe_mic_tm_regs __iomem *mic_tm_regs;
-	u64 flags;
-	u64 value;
-#ifdef DEBUG
-	long time;
-#endif
-
-	local_irq_save(flags);
-
-	mic_tm_regs =3D cbe_get_cpu_mic_tm_regs(cpu);
-	pmd_regs =3D cbe_get_cpu_pmd_regs(cpu);
-
-#ifdef DEBUG
-	time =3D jiffies;
-#endif
-	out_be64(&mic_tm_regs->slow_fast_timer_0, MIC_Slow_Fast_Timer_table[pmode=
]);
-	out_be64(&mic_tm_regs->slow_fast_timer_1, MIC_Slow_Fast_Timer_table[pmode=
]);
-
-	out_be64(&mic_tm_regs->slow_next_timer_0, MIC_Slow_Next_Timer_table[pmode=
]);
-	out_be64(&mic_tm_regs->slow_next_timer_1, MIC_Slow_Next_Timer_table[pmode=
]);
-
-	value =3D in_be64(&pmd_regs->pmcr);
-	/* set bits to zero */
-	value &=3D 0xFFFFFFFFFFFFFFF8ull;
-	/* set bits to next pmode */
-	value |=3D pmode;
-
-	out_be64(&pmd_regs->pmcr, value);
-
-#ifdef DEBUG
-	/* wait until new pmode appears in status register */
-	value =3D in_be64(&pmd_regs->pmsr) & 0x07;
-	while(value !=3D pmode) {
-		cpu_relax();
-		value =3D in_be64(&pmd_regs->pmsr) & 0x07;
-	}
-
-	time =3D jiffies - time;
-	time =3D jiffies_to_msecs(time);
-	pr_debug("had to wait %lu ms for a transition using " \
-		 "the pervasive unit.\n", time);
-#endif
-	local_irq_restore(flags);
-
-	return 0;
-}
-
-static int set_pmode(int cpu, unsigned int slow_mode)
+static int set_pmode(unsigned int cpu, unsigned int slow_mode)
 {
 	int rc;
-#ifdef CONFIG_PPC_PMI
+
 	if (cbe_cpufreq_has_pmi)
-		rc =3D set_pmode_pmi(cpu, slow_mode);
+		rc =3D cbe_cpufreq_set_pmode_pmi(cpu, slow_mode);
 	else
-#endif
-		rc =3D set_pmode_reg(cpu, slow_mode);
+		rc =3D cbe_cpufreq_set_pmode(cpu, slow_mode);
=20
-	pr_debug("register contains slow mode %d\n", get_pmode(cpu));
+	pr_debug("register contains slow mode %d\n", cbe_cpufreq_get_pmode(cpu));
=20
 	return rc;
 }
=20
-static void cbe_cpufreq_handle_pmi(pmi_message_t pmi_msg)
-{
-	u8 node; slow_mode;
-
-	BUG_ON(pmi_msg.type !=3D PMI_TYPE_FREQ_CHANGE);
-
-	node =3D pmi_msg.data1;
-	slow_mode =3D pmi_msg.data2;
-
-	pmi_slow_mode_limit[node] =3D slow_mode;
-
-	pr_debug("cbe_handle_pmi: node: %d, max slow_mode=3D%d\n", slow_mode);
-}
-
-static int pmi_notifier(struct notifier_block *nb,
-				       unsigned long event, void *data)
-{
-	struct cpufreq_policy *policy =3D data;
-	u8 node;
-
-	node =3D cbe_cpu_to_node(policy->cpu);
-
-	pr_debug("got notified, event=3D%lu, node=3D%u\n", event, node);
-
-	if (pmi_slow_mode_limit[node] !=3D 0) {
-		pr_debug("limiting node %d to slow mode %d\n",
-			 node, pmi_slow_mode_limit[node]);
-
-		cpufreq_verify_within_limits(policy, 0,
-			 cbe_freqs[pmi_slow_mode_limit[node]].frequency);
-	}
-
-	return 0;
-}
-
-static struct notifier_block pmi_notifier_block =3D {
-	.notifier_call =3D pmi_notifier,
-};
-
-static struct pmi_handler cbe_pmi_handler =3D {
-	.type			=3D PMI_TYPE_FREQ_CHANGE,
-	.handle_pmi_message	=3D cbe_cpufreq_handle_pmi,
-};
-
-
 /*
  * cpufreq functions
  */
@@ -270,7 +103,7 @@ static int cbe_cpufreq_cpu_init(struct c
 	 * of a transition */
 	policy->cpuinfo.transition_latency =3D 25000;
=20
-	cur_pmode =3D get_pmode(policy->cpu);
+	cur_pmode =3D cbe_cpufreq_get_pmode(policy->cpu);
 	pr_debug("current pmode is at %d\n",cur_pmode);
=20
 	policy->cur =3D cbe_freqs[cur_pmode].frequency;
@@ -297,7 +130,6 @@ static int cbe_cpufreq_verify(struct cpu
 	return cpufreq_frequency_table_verify(policy, cbe_freqs);
 }
=20
-
 static int cbe_cpufreq_target(struct cpufreq_policy *policy,
 			      unsigned int target_freq,
 			      unsigned int relation)
@@ -352,22 +184,12 @@ static int __init cbe_cpufreq_init(void)
 	if (!machine_is(cell))
 		return -ENODEV;
=20
-	cbe_cpufreq_has_pmi =3D pmi_register_handler(&cbe_pmi_handler) =3D=3D 0;
-
-	if (cbe_cpufreq_has_pmi)
-		cpufreq_register_notifier(&pmi_notifier_block, CPUFREQ_POLICY_NOTIFIER);
-
 	return cpufreq_register_driver(&cbe_cpufreq_driver);
 }
=20
 static void __exit cbe_cpufreq_exit(void)
 {
 	cpufreq_unregister_driver(&cbe_cpufreq_driver);
-
-	if (cbe_cpufreq_has_pmi) {
-		cpufreq_unregister_notifier(&pmi_notifier_block, CPUFREQ_POLICY_NOTIFIER=
);
-		pmi_unregister_handler(&cbe_pmi_handler);
-	}
 }
=20
 module_init(cbe_cpufreq_init);
Index: linux-2.6.22-rc5/arch/powerpc/platforms/cell/cbe_cpufreq.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6.22-rc5/arch/powerpc/platforms/cell/cbe_cpufreq.h
@@ -0,0 +1,24 @@
+/*
+ * cbe_cpufreq.h
+ *
+ * This file contains the definitions used by the cbe_cpufreq driver.
+ *
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005-2007
+ *
+ * Author: Christian Krafft <krafft@de.ibm.com>
+ *
+ */
+
+#include <linux/cpufreq.h>
+#include <linux/types.h>
+
+int cbe_cpufreq_set_pmode(int cpu, unsigned int pmode);
+int cbe_cpufreq_get_pmode(int cpu);
+
+int cbe_cpufreq_set_pmode_pmi(int cpu, unsigned int pmode);
+
+#if defined(CONFIG_CBE_CPUFREQ_PMI) || defined(CONFIG_CBE_CPUFREQ_PMI_MODU=
LE)
+extern bool cbe_cpufreq_has_pmi;
+#else
+#define cbe_cpufreq_has_pmi (0)
+#endif
Index: linux-2.6.22-rc5/arch/powerpc/platforms/cell/cbe_cpufreq_pervasive.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6.22-rc5/arch/powerpc/platforms/cell/cbe_cpufreq_pervasive.c
@@ -0,0 +1,118 @@
+/*
+ * pervasive backend for the cbe_cpufreq driver
+ *
+ * This driver makes use of the pervasive unit to
+ * engage the desired frequency.
+ *
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005-2007
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/kernel.h>
+#include <asm/machdep.h>
+#include <asm/hw_irq.h>
+#include <asm/io.h>
+
+#ifdef DEBUG
+#include <asm/time.h>
+#endif
+
+#include "cbe_regs.h"
+#include "cbe_cpufreq.h"
+
+/* to write to MIC register */
+static u64 MIC_Slow_Fast_Timer_table[] =3D {
+	[0 ... 7] =3D 0x007fc00000000000ull,
+};
+
+/* more values for the MIC */
+static u64 MIC_Slow_Next_Timer_table[] =3D {
+	0x0000240000000000ull,
+	0x0000268000000000ull,
+	0x000029C000000000ull,
+	0x00002D0000000000ull,
+	0x0000300000000000ull,
+	0x0000334000000000ull,
+	0x000039C000000000ull,
+	0x00003FC000000000ull,
+};
+
+
+int cbe_cpufreq_set_pmode(int cpu, unsigned int pmode)
+{
+	struct cbe_pmd_regs __iomem *pmd_regs;
+	struct cbe_mic_tm_regs __iomem *mic_tm_regs;
+	u64 flags;
+	u64 value;
+#ifdef DEBUG
+	long time;
+#endif
+
+	local_irq_save(flags);
+
+	mic_tm_regs =3D cbe_get_cpu_mic_tm_regs(cpu);
+	pmd_regs =3D cbe_get_cpu_pmd_regs(cpu);
+
+#ifdef DEBUG
+	time =3D jiffies;
+#endif
+
+	out_be64(&mic_tm_regs->slow_fast_timer_0, MIC_Slow_Fast_Timer_table[pmode=
]);
+	out_be64(&mic_tm_regs->slow_fast_timer_1, MIC_Slow_Fast_Timer_table[pmode=
]);
+
+	out_be64(&mic_tm_regs->slow_next_timer_0, MIC_Slow_Next_Timer_table[pmode=
]);
+	out_be64(&mic_tm_regs->slow_next_timer_1, MIC_Slow_Next_Timer_table[pmode=
]);
+
+	value =3D in_be64(&pmd_regs->pmcr);
+	/* set bits to zero */
+	value &=3D 0xFFFFFFFFFFFFFFF8ull;
+	/* set bits to next pmode */
+	value |=3D pmode;
+
+	out_be64(&pmd_regs->pmcr, value);
+
+#ifdef DEBUG
+	/* wait until new pmode appears in status register */
+	value =3D in_be64(&pmd_regs->pmsr) & 0x07;
+	while(value !=3D pmode) {
+		cpu_relax();
+		value =3D in_be64(&pmd_regs->pmsr) & 0x07;
+	}
+
+	time =3D jiffies  - time;
+	time =3D jiffies_to_msecs(time);
+	pr_debug("had to wait %lu ms for a transition using " \
+		 "pervasive unit\n", time);
+#endif
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+
+int cbe_cpufreq_get_pmode(int cpu)
+{
+	int ret;
+	struct cbe_pmd_regs __iomem *pmd_regs;
+
+	pmd_regs =3D cbe_get_cpu_pmd_regs(cpu);
+	ret =3D in_be64(&pmd_regs->pmsr) & 0x07;
+
+	return ret;
+}
+
Index: linux-2.6.22-rc5/arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6.22-rc5/arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c
@@ -0,0 +1,148 @@
+/*
+ * pmi backend for the cbe_cpufreq driver
+ *
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005-2007
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/timer.h>
+#include <asm/of_platform.h>
+#include <asm/processor.h>
+#include <asm/prom.h>
+#include <asm/pmi.h>
+
+#ifdef DEBUG
+#include <asm/time.h>
+#endif
+
+#include "cbe_regs.h"
+#include "cbe_cpufreq.h"
+
+static u8 pmi_slow_mode_limit[MAX_CBE];
+
+bool cbe_cpufreq_has_pmi =3D false;
+EXPORT_SYMBOL_GPL(cbe_cpufreq_has_pmi);
+
+/*
+ * hardware specific functions
+ */
+
+int cbe_cpufreq_set_pmode_pmi(int cpu, unsigned int pmode)
+{
+	int ret;
+	pmi_message_t pmi_msg;
+#ifdef DEBUG
+	long time;
+#endif
+	pmi_msg.type =3D PMI_TYPE_FREQ_CHANGE;
+	pmi_msg.data1 =3D	cbe_cpu_to_node(cpu);
+	pmi_msg.data2 =3D pmode;
+
+#ifdef DEBUG
+	time =3D jiffies;
+#endif
+	pmi_send_message(pmi_msg);
+
+#ifdef DEBUG
+	time =3D jiffies  - time;
+	time =3D jiffies_to_msecs(time);
+	pr_debug("had to wait %lu ms for a transition using " \
+		 "PMI\n", time);
+#endif
+	ret =3D pmi_msg.data2;
+	pr_debug("PMI returned slow mode %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cbe_cpufreq_set_pmode_pmi);
+
+
+static void cbe_cpufreq_handle_pmi(pmi_message_t pmi_msg)
+{
+	u8 node, slow_mode;
+
+	BUG_ON(pmi_msg.type !=3D PMI_TYPE_FREQ_CHANGE);
+
+	node =3D pmi_msg.data1;
+	slow_mode =3D pmi_msg.data2;
+
+	pmi_slow_mode_limit[node] =3D slow_mode;
+
+	pr_debug("cbe_handle_pmi: node: %d max_freq: %d\n", node, slow_mode);
+}
+
+static int pmi_notifier(struct notifier_block *nb,
+				       unsigned long event, void *data)
+{
+	struct cpufreq_policy *policy =3D data;
+	struct cpufreq_frequency_table *cbe_freqs;
+	u8 node;
+
+	cbe_freqs =3D cpufreq_frequency_get_table(policy->cpu);
+	node =3D cbe_cpu_to_node(policy->cpu);
+
+	pr_debug("got notified, event=3D%lu, node=3D%u\n", event, node);
+
+	if (pmi_slow_mode_limit[node] !=3D 0) {
+		pr_debug("limiting node %d to slow mode %d\n",
+			 node, pmi_slow_mode_limit[node]);
+
+		cpufreq_verify_within_limits(policy, 0,
+
+			cbe_freqs[pmi_slow_mode_limit[node]].frequency);
+	}
+
+	return 0;
+}
+
+static struct notifier_block pmi_notifier_block =3D {
+	.notifier_call =3D pmi_notifier,
+};
+
+static struct pmi_handler cbe_pmi_handler =3D {
+	.type			=3D PMI_TYPE_FREQ_CHANGE,
+	.handle_pmi_message	=3D cbe_cpufreq_handle_pmi,
+};
+
+
+
+static int __init cbe_cpufreq_pmi_init(void)
+{
+	cbe_cpufreq_has_pmi =3D pmi_register_handler(&cbe_pmi_handler) =3D=3D 0;
+
+	if (!cbe_cpufreq_has_pmi)
+		return -ENODEV;
+
+	cpufreq_register_notifier(&pmi_notifier_block, CPUFREQ_POLICY_NOTIFIER);
+
+	return 0;
+}
+
+static void __exit cbe_cpufreq_pmi_exit(void)
+{
+	cpufreq_unregister_notifier(&pmi_notifier_block, CPUFREQ_POLICY_NOTIFIER);
+	pmi_unregister_handler(&cbe_pmi_handler);
+}
+
+module_init(cbe_cpufreq_pmi_init);
+module_exit(cbe_cpufreq_pmi_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Christian Krafft <krafft@de.ibm.com>");

--=20
Mit freundlichen Gruessen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,
Linux Kernel Development
IT Specialist


Vorsitzender des Aufsichtsrats:	Martin Jetter
Geschaeftsfuehrung:		Herbert Kircher
Sitz der Gesellschaft:		Boeblingen
Registriergericht:		Amtsgericht Stuttgart, HRB 243294


--Sig_+bZhZ1f_sDOE/RqFB6D2KGJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGemPp6rqK4qDx+dcRAq4aAKCsi8mtAxAdFa7bEYYx2DTTzEZbYwCfdqZ2
m5OXLEeBe1+gl4GOY+0klRk=
=2kgE
-----END PGP SIGNATURE-----

--Sig_+bZhZ1f_sDOE/RqFB6D2KGJ--
