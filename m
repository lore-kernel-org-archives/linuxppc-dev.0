Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pb0-f53.google.com (mail-pb0-f53.google.com
 [209.85.160.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E4A352C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 00:48:54 +1100 (EST)
Received: by mail-pb0-f53.google.com with SMTP id un1so3740357pbc.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Mar 2013 06:48:52 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: rjw@sisk.pl
Subject: [PATCH 1/2] cpufreq: Notify all policy->cpus in
 cpufreq_notify_transition()
Date: Sun, 24 Mar 2013 19:18:31 +0530
Message-Id: <981c23bd4b2a14c346820685e1203ab7054378f8.1364132845.git.viresh.kumar@linaro.org>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 Liviu.Dudau@arm.com, sparclinux@vger.kernel.org,
 linaro-kernel@lists.linaro.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 arvind.chauhan@arm.com, Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 Jesper Nilsson <jesper.nilsson@axis.com>, robin.randhawa@arm.com,
 Stephen Warren <swarren@wwwdotorg.org>, cpufreq@vger.kernel.org,
 Haavard Skinnemoen <hskinnemoen@gmail.com>, cbe-oss-dev@lists.ozlabs.org,
 Fenghua Yu <fenghua.yu@intel.com>, Steve.Bannister@arm.com,
 Mike Frysinger <vapier@gentoo.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-pm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Mikael Starvik <starvik@axis.com>,
 Kukjin Kim <kgene.kim@samsung.com>, Borislav Petkov <bp@alien8.de>,
 Ben Dooks <ben-linux@fluff.org>, Thomas Renninger <trenn@suse.de>,
 linux-arm-kernel@lists.infradead.org, Tony Luck <tony.luck@intel.com>,
 Eric Miao <eric.y.miao@gmail.com>, linux-cris-kernel@axis.com,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Paul Mundt <lethal@linux-sh.org>, Sascha Hauer <kernel@pengutronix.de>,
 charles.garcia-tobin@arm.com, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

policy->cpus contains all online cpus that have single shared clock line. And
their frequencies are always updated together.

Many SMP system's cpufreq drivers take care of this in individual drivers but
the best place for this code is in cpufreq core.

This patch modifies cpufreq_notify_transition() to notify frequency change for
all cpus in policy->cpus and hence updates all users of this API.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: Mike Frysinger <vapier@gentoo.org>
Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Thomas Renninger <trenn@suse.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-cris-kernel@axis.com
Cc: linux-ia64@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: cbe-oss-dev@lists.ozlabs.org
Cc: linux-mips@linux-mips.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/mach-davinci/cpufreq.c              |  5 +-
 arch/arm/mach-imx/cpufreq.c                  |  5 +-
 arch/arm/mach-integrator/cpu.c               |  6 +--
 arch/arm/mach-pxa/cpufreq-pxa2xx.c           |  5 +-
 arch/arm/mach-pxa/cpufreq-pxa3xx.c           |  5 +-
 arch/arm/mach-s3c24xx/cpufreq.c              |  8 +--
 arch/arm/mach-sa1100/cpu-sa1100.c            |  5 +-
 arch/arm/mach-sa1100/cpu-sa1110.c            |  5 +-
 arch/arm/mach-tegra/cpu-tegra.c              |  6 +--
 arch/avr32/mach-at32ap/cpufreq.c             |  5 +-
 arch/blackfin/mach-common/cpufreq.c          | 79 ++++++++++++----------------
 arch/cris/arch-v32/mach-a3/cpufreq.c         | 20 +++----
 arch/cris/arch-v32/mach-fs/cpufreq.c         | 17 +++---
 arch/ia64/kernel/cpufreq/acpi-cpufreq.c      | 22 ++++----
 arch/mips/kernel/cpufreq/loongson2_cpufreq.c |  5 +-
 arch/powerpc/platforms/cell/cbe_cpufreq.c    |  5 +-
 arch/powerpc/platforms/pasemi/cpufreq.c      |  5 +-
 arch/powerpc/platforms/powermac/cpufreq_32.c | 14 ++---
 arch/powerpc/platforms/powermac/cpufreq_64.c |  5 +-
 arch/sh/kernel/cpufreq.c                     |  5 +-
 arch/sparc/kernel/us2e_cpufreq.c             | 13 ++---
 arch/sparc/kernel/us3_cpufreq.c              | 13 ++---
 arch/unicore32/kernel/cpu-ucv2.c             |  5 +-
 drivers/cpufreq/acpi-cpufreq.c               | 11 +---
 drivers/cpufreq/cpufreq-cpu0.c               | 12 ++---
 drivers/cpufreq/cpufreq-nforce2.c            |  5 +-
 drivers/cpufreq/cpufreq.c                    | 45 +++++++++-------
 drivers/cpufreq/dbx500-cpufreq.c             |  6 +--
 drivers/cpufreq/e_powersaver.c               | 11 ++--
 drivers/cpufreq/elanfreq.c                   | 10 ++--
 drivers/cpufreq/exynos-cpufreq.c             |  7 +--
 drivers/cpufreq/gx-suspmod.c                 | 11 ++--
 drivers/cpufreq/imx6q-cpufreq.c              | 12 ++---
 drivers/cpufreq/kirkwood-cpufreq.c           | 10 ++--
 drivers/cpufreq/longhaul.c                   | 18 ++++---
 drivers/cpufreq/maple-cpufreq.c              |  5 +-
 drivers/cpufreq/omap-cpufreq.c               | 11 +---
 drivers/cpufreq/p4-clockmod.c                | 10 +---
 drivers/cpufreq/pcc-cpufreq.c                |  5 +-
 drivers/cpufreq/powernow-k6.c                | 12 ++---
 drivers/cpufreq/powernow-k7.c                | 10 ++--
 drivers/cpufreq/powernow-k8.c                | 16 +++---
 drivers/cpufreq/s3c2416-cpufreq.c            |  5 +-
 drivers/cpufreq/s3c64xx-cpufreq.c            |  7 ++-
 drivers/cpufreq/s5pv210-cpufreq.c            |  5 +-
 drivers/cpufreq/sc520_freq.c                 | 10 ++--
 drivers/cpufreq/spear-cpufreq.c              |  7 +--
 drivers/cpufreq/speedstep-centrino.c         | 24 ++-------
 drivers/cpufreq/speedstep-ich.c              | 12 +----
 drivers/cpufreq/speedstep-smi.c              |  5 +-
 include/linux/cpufreq.h                      |  4 +-
 51 files changed, 232 insertions(+), 337 deletions(-)

diff --git a/arch/arm/mach-davinci/cpufreq.c b/arch/arm/mach-davinci/cpufreq.c
index 4729eaa..55eb870 100644
--- a/arch/arm/mach-davinci/cpufreq.c
+++ b/arch/arm/mach-davinci/cpufreq.c
@@ -90,7 +90,6 @@ static int davinci_target(struct cpufreq_policy *policy,
 
 	freqs.old = davinci_getspeed(0);
 	freqs.new = clk_round_rate(armclk, target_freq * 1000) / 1000;
-	freqs.cpu = 0;
 
 	if (freqs.old == freqs.new)
 		return ret;
@@ -102,7 +101,7 @@ static int davinci_target(struct cpufreq_policy *policy,
 	if (ret)
 		return -EINVAL;
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	/* if moving to higher frequency, up the voltage beforehand */
 	if (pdata->set_voltage && freqs.new > freqs.old) {
@@ -126,7 +125,7 @@ static int davinci_target(struct cpufreq_policy *policy,
 		pdata->set_voltage(idx);
 
 out:
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	return ret;
 }
diff --git a/arch/arm/mach-imx/cpufreq.c b/arch/arm/mach-imx/cpufreq.c
index d8c75c3..cfce5e3 100644
--- a/arch/arm/mach-imx/cpufreq.c
+++ b/arch/arm/mach-imx/cpufreq.c
@@ -87,13 +87,12 @@ static int mxc_set_target(struct cpufreq_policy *policy,
 
 	freqs.old = clk_get_rate(cpu_clk) / 1000;
 	freqs.new = freq_Hz / 1000;
-	freqs.cpu = 0;
 	freqs.flags = 0;
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	ret = set_cpu_freq(freq_Hz);
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	return ret;
 }
diff --git a/arch/arm/mach-integrator/cpu.c b/arch/arm/mach-integrator/cpu.c
index 590c192..df863c3 100644
--- a/arch/arm/mach-integrator/cpu.c
+++ b/arch/arm/mach-integrator/cpu.c
@@ -123,14 +123,12 @@ static int integrator_set_target(struct cpufreq_policy *policy,
 	vco = icst_hz_to_vco(&cclk_params, target_freq * 1000);
 	freqs.new = icst_hz(&cclk_params, vco) / 1000;
 
-	freqs.cpu = policy->cpu;
-
 	if (freqs.old == freqs.new) {
 		set_cpus_allowed(current, cpus_allowed);
 		return 0;
 	}
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	cm_osc = __raw_readl(CM_OSC);
 
@@ -151,7 +149,7 @@ static int integrator_set_target(struct cpufreq_policy *policy,
 	 */
 	set_cpus_allowed(current, cpus_allowed);
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	return 0;
 }
diff --git a/arch/arm/mach-pxa/cpufreq-pxa2xx.c b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
index 6a7aeab..f1ca4da 100644
--- a/arch/arm/mach-pxa/cpufreq-pxa2xx.c
+++ b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
@@ -311,7 +311,6 @@ static int pxa_set_target(struct cpufreq_policy *policy,
 	new_freq_mem = pxa_freq_settings[idx].membus;
 	freqs.old = policy->cur;
 	freqs.new = new_freq_cpu;
-	freqs.cpu = policy->cpu;
 
 	if (freq_debug)
 		pr_debug("Changing CPU frequency to %d Mhz, (SDRAM %d Mhz)\n",
@@ -327,7 +326,7 @@ static int pxa_set_target(struct cpufreq_policy *policy,
 	 * you should add a notify client with any platform specific
 	 * Vcc changing capability
 	 */
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	/* Calculate the next MDREFR.  If we're slowing down the SDRAM clock
 	 * we need to preset the smaller DRI before the change.	 If we're
@@ -382,7 +381,7 @@ static int pxa_set_target(struct cpufreq_policy *policy,
 	 * you should add a notify client with any platform specific
 	 * SDRAM refresh timer adjustments
 	 */
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	/*
 	 * Even if voltage setting fails, we don't report it, as the frequency
diff --git a/arch/arm/mach-pxa/cpufreq-pxa3xx.c b/arch/arm/mach-pxa/cpufreq-pxa3xx.c
index b85b4ab..8c45b2b 100644
--- a/arch/arm/mach-pxa/cpufreq-pxa3xx.c
+++ b/arch/arm/mach-pxa/cpufreq-pxa3xx.c
@@ -184,7 +184,6 @@ static int pxa3xx_cpufreq_set(struct cpufreq_policy *policy,
 
 	freqs.old = policy->cur;
 	freqs.new = next->cpufreq_mhz * 1000;
-	freqs.cpu = policy->cpu;
 
 	pr_debug("CPU frequency from %d MHz to %d MHz%s\n",
 			freqs.old / 1000, freqs.new / 1000,
@@ -193,14 +192,14 @@ static int pxa3xx_cpufreq_set(struct cpufreq_policy *policy,
 	if (freqs.old == target_freq)
 		return 0;
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	local_irq_save(flags);
 	__update_core_freq(next);
 	__update_bus_freq(next);
 	local_irq_restore(flags);
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	return 0;
 }
diff --git a/arch/arm/mach-s3c24xx/cpufreq.c b/arch/arm/mach-s3c24xx/cpufreq.c
index 5f181e7..3c0e78e 100644
--- a/arch/arm/mach-s3c24xx/cpufreq.c
+++ b/arch/arm/mach-s3c24xx/cpufreq.c
@@ -204,7 +204,6 @@ static int s3c_cpufreq_settarget(struct cpufreq_policy *policy,
 	freqs.old = cpu_cur.freq;
 	freqs.new = cpu_new.freq;
 
-	freqs.freqs.cpu = 0;
 	freqs.freqs.old = cpu_cur.freq.armclk / 1000;
 	freqs.freqs.new = cpu_new.freq.armclk / 1000;
 
@@ -218,9 +217,7 @@ static int s3c_cpufreq_settarget(struct cpufreq_policy *policy,
 	s3c_cpufreq_updateclk(clk_pclk, cpu_new.freq.pclk);
 
 	/* start the frequency change */
-
-	if (policy)
-		cpufreq_notify_transition(&freqs.freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs.freqs, CPUFREQ_PRECHANGE);
 
 	/* If hclk is staying the same, then we do not need to
 	 * re-write the IO or the refresh timings whilst we are changing
@@ -264,8 +261,7 @@ static int s3c_cpufreq_settarget(struct cpufreq_policy *policy,
 	local_irq_restore(flags);
 
 	/* notify everyone we've done this */
-	if (policy)
-		cpufreq_notify_transition(&freqs.freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs.freqs, CPUFREQ_POSTCHANGE);
 
 	s3c_freq_dbg("%s: finished\n", __func__);
 	return 0;
diff --git a/arch/arm/mach-sa1100/cpu-sa1100.c b/arch/arm/mach-sa1100/cpu-sa1100.c
index e8f4d1e..3268761 100644
--- a/arch/arm/mach-sa1100/cpu-sa1100.c
+++ b/arch/arm/mach-sa1100/cpu-sa1100.c
@@ -201,9 +201,8 @@ static int sa1100_target(struct cpufreq_policy *policy,
 
 	freqs.old = cur;
 	freqs.new = sa11x0_ppcr_to_freq(new_ppcr);
-	freqs.cpu = 0;
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	if (freqs.new > cur)
 		sa1100_update_dram_timings(cur, freqs.new);
@@ -213,7 +212,7 @@ static int sa1100_target(struct cpufreq_policy *policy,
 	if (freqs.new < cur)
 		sa1100_update_dram_timings(cur, freqs.new);
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	return 0;
 }
diff --git a/arch/arm/mach-sa1100/cpu-sa1110.c b/arch/arm/mach-sa1100/cpu-sa1110.c
index 48c45b0..38a7733 100644
--- a/arch/arm/mach-sa1100/cpu-sa1110.c
+++ b/arch/arm/mach-sa1100/cpu-sa1110.c
@@ -258,7 +258,6 @@ static int sa1110_target(struct cpufreq_policy *policy,
 
 	freqs.old = sa11x0_getspeed(0);
 	freqs.new = sa11x0_ppcr_to_freq(ppcr);
-	freqs.cpu = 0;
 
 	sdram_calculate_timing(&sd, freqs.new, sdram);
 
@@ -279,7 +278,7 @@ static int sa1110_target(struct cpufreq_policy *policy,
 	sd.mdcas[2] = 0xaaaaaaaa;
 #endif
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	/*
 	 * The clock could be going away for some time.  Set the SDRAMs
@@ -327,7 +326,7 @@ static int sa1110_target(struct cpufreq_policy *policy,
 	 */
 	sdram_update_refresh(freqs.new, sdram);
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	return 0;
 }
diff --git a/arch/arm/mach-tegra/cpu-tegra.c b/arch/arm/mach-tegra/cpu-tegra.c
index e3d6e15..3b441d6 100644
--- a/arch/arm/mach-tegra/cpu-tegra.c
+++ b/arch/arm/mach-tegra/cpu-tegra.c
@@ -128,8 +128,7 @@ static int tegra_update_cpu_speed(unsigned long rate)
 	else
 		clk_set_rate(emc_clk, 100000000);  /* emc 50Mhz */
 
-	for_each_online_cpu(freqs.cpu)
-		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 #ifdef CONFIG_CPU_FREQ_DEBUG
 	printk(KERN_DEBUG "cpufreq-tegra: transition: %u --> %u\n",
@@ -143,8 +142,7 @@ static int tegra_update_cpu_speed(unsigned long rate)
 		return ret;
 	}
 
-	for_each_online_cpu(freqs.cpu)
-		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	return 0;
 }
diff --git a/arch/avr32/mach-at32ap/cpufreq.c b/arch/avr32/mach-at32ap/cpufreq.c
index 18b7656..6544887 100644
--- a/arch/avr32/mach-at32ap/cpufreq.c
+++ b/arch/avr32/mach-at32ap/cpufreq.c
@@ -61,7 +61,6 @@ static int at32_set_target(struct cpufreq_policy *policy,
 
 	freqs.old = at32_get_speed(0);
 	freqs.new = (freq + 500) / 1000;
-	freqs.cpu = 0;
 	freqs.flags = 0;
 
 	if (!ref_freq) {
@@ -69,7 +68,7 @@ static int at32_set_target(struct cpufreq_policy *policy,
 		loops_per_jiffy_ref = boot_cpu_data.loops_per_jiffy;
 	}
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 	if (freqs.old < freqs.new)
 		boot_cpu_data.loops_per_jiffy = cpufreq_scale(
 				loops_per_jiffy_ref, ref_freq, freqs.new);
@@ -77,7 +76,7 @@ static int at32_set_target(struct cpufreq_policy *policy,
 	if (freqs.new < freqs.old)
 		boot_cpu_data.loops_per_jiffy = cpufreq_scale(
 				loops_per_jiffy_ref, ref_freq, freqs.new);
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	pr_debug("cpufreq: set frequency %lu Hz\n", freq);
 
diff --git a/arch/blackfin/mach-common/cpufreq.c b/arch/blackfin/mach-common/cpufreq.c
index d88bd31..4e67368 100644
--- a/arch/blackfin/mach-common/cpufreq.c
+++ b/arch/blackfin/mach-common/cpufreq.c
@@ -127,13 +127,13 @@ unsigned long cpu_set_cclk(int cpu, unsigned long new)
 }
 #endif
 
-static int bfin_target(struct cpufreq_policy *poli,
+static int bfin_target(struct cpufreq_policy *policy,
 			unsigned int target_freq, unsigned int relation)
 {
 #ifndef CONFIG_BF60x
 	unsigned int plldiv;
 #endif
-	unsigned int index, cpu;
+	unsigned int index;
 	unsigned long cclk_hz;
 	struct cpufreq_freqs freqs;
 	static unsigned long lpj_ref;
@@ -144,59 +144,48 @@ static int bfin_target(struct cpufreq_policy *poli,
 	cycles_t cycles;
 #endif
 
-	for_each_online_cpu(cpu) {
-		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	if (cpufreq_frequency_table_target(policy, bfin_freq_table, target_freq,
+				relation, &index))
+		return -EINVAL;
 
-		if (!policy)
-			continue;
+	cclk_hz = bfin_freq_table[index].frequency;
 
-		if (cpufreq_frequency_table_target(policy, bfin_freq_table,
-				 target_freq, relation, &index))
-			return -EINVAL;
+	freqs.old = bfin_getfreq_khz(0);
+	freqs.new = cclk_hz;
 
-		cclk_hz = bfin_freq_table[index].frequency;
+	pr_debug("cpufreq: changing cclk to %lu; target = %u, oldfreq = %u\n",
+			cclk_hz, target_freq, freqs.old);
 
-		freqs.old = bfin_getfreq_khz(0);
-		freqs.new = cclk_hz;
-		freqs.cpu = cpu;
-
-		pr_debug("cpufreq: changing cclk to %lu; target = %u, oldfreq = %u\n",
-			 cclk_hz, target_freq, freqs.old);
-
-		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-		if (cpu == CPUFREQ_CPU) {
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 #ifndef CONFIG_BF60x
-			plldiv = (bfin_read_PLL_DIV() & SSEL) |
-						dpm_state_table[index].csel;
-			bfin_write_PLL_DIV(plldiv);
+	plldiv = (bfin_read_PLL_DIV() & SSEL) | dpm_state_table[index].csel;
+	bfin_write_PLL_DIV(plldiv);
 #else
-			ret = cpu_set_cclk(cpu, freqs.new * 1000);
-			if (ret != 0) {
-				WARN_ONCE(ret, "cpufreq set freq failed %d\n", ret);
-				break;
-			}
+	ret = cpu_set_cclk(policy->cpu, freqs.new * 1000);
+	if (ret != 0) {
+		WARN_ONCE(ret, "cpufreq set freq failed %d\n", ret);
+		break;
+	}
 #endif
-			on_each_cpu(bfin_adjust_core_timer, &index, 1);
+	on_each_cpu(bfin_adjust_core_timer, &index, 1);
 #if defined(CONFIG_CYCLES_CLOCKSOURCE)
-			cycles = get_cycles();
-			SSYNC();
-			cycles += 10; /* ~10 cycles we lose after get_cycles() */
-			__bfin_cycles_off +=
-			    (cycles << __bfin_cycles_mod) - (cycles << index);
-			__bfin_cycles_mod = index;
+	cycles = get_cycles();
+	SSYNC();
+	cycles += 10; /* ~10 cycles we lose after get_cycles() */
+	__bfin_cycles_off += (cycles << __bfin_cycles_mod) - (cycles << index);
+	__bfin_cycles_mod = index;
 #endif
-			if (!lpj_ref_freq) {
-				lpj_ref = loops_per_jiffy;
-				lpj_ref_freq = freqs.old;
-			}
-			if (freqs.new != freqs.old) {
-				loops_per_jiffy = cpufreq_scale(lpj_ref,
-						lpj_ref_freq, freqs.new);
-			}
-		}
-		/* TODO: just test case for cycles clock source, remove later */
-		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	if (!lpj_ref_freq) {
+		lpj_ref = loops_per_jiffy;
+		lpj_ref_freq = freqs.old;
 	}
+	if (freqs.new != freqs.old) {
+		loops_per_jiffy = cpufreq_scale(lpj_ref,
+				lpj_ref_freq, freqs.new);
+	}
+
+	/* TODO: just test case for cycles clock source, remove later */
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	pr_debug("cpufreq: done\n");
 	return ret;
diff --git a/arch/cris/arch-v32/mach-a3/cpufreq.c b/arch/cris/arch-v32/mach-a3/cpufreq.c
index ee391ec..ee142c4 100644
--- a/arch/cris/arch-v32/mach-a3/cpufreq.c
+++ b/arch/cris/arch-v32/mach-a3/cpufreq.c
@@ -27,23 +27,17 @@ static unsigned int cris_freq_get_cpu_frequency(unsigned int cpu)
 	return clk_ctrl.pll ? 200000 : 6000;
 }
 
-static void cris_freq_set_cpu_state(unsigned int state)
+static void cris_freq_set_cpu_state(struct cpufreq_policy *policy,
+		unsigned int state)
 {
-	int i = 0;
 	struct cpufreq_freqs freqs;
 	reg_clkgen_rw_clk_ctrl clk_ctrl;
 	clk_ctrl = REG_RD(clkgen, regi_clkgen, rw_clk_ctrl);
 
-#ifdef CONFIG_SMP
-	for_each_present_cpu(i)
-#endif
-	{
-		freqs.old = cris_freq_get_cpu_frequency(i);
-		freqs.new = cris_freq_table[state].frequency;
-		freqs.cpu = i;
-	}
+	freqs.old = cris_freq_get_cpu_frequency(policy->cpu);
+	freqs.new = cris_freq_table[state].frequency;
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	local_irq_disable();
 
@@ -57,7 +51,7 @@ static void cris_freq_set_cpu_state(unsigned int state)
 
 	local_irq_enable();
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 };
 
 static int cris_freq_verify(struct cpufreq_policy *policy)
@@ -75,7 +69,7 @@ static int cris_freq_target(struct cpufreq_policy *policy,
 			target_freq, relation, &newstate))
 		return -EINVAL;
 
-	cris_freq_set_cpu_state(newstate);
+	cris_freq_set_cpu_state(policy, newstate);
 
 	return 0;
 }
diff --git a/arch/cris/arch-v32/mach-fs/cpufreq.c b/arch/cris/arch-v32/mach-fs/cpufreq.c
index d92cf70..1295223 100644
--- a/arch/cris/arch-v32/mach-fs/cpufreq.c
+++ b/arch/cris/arch-v32/mach-fs/cpufreq.c
@@ -27,20 +27,17 @@ static unsigned int cris_freq_get_cpu_frequency(unsigned int cpu)
 	return clk_ctrl.pll ? 200000 : 6000;
 }
 
-static void cris_freq_set_cpu_state(unsigned int state)
+static void cris_freq_set_cpu_state(struct cpufreq_policy *policy,
+		unsigned int state)
 {
-	int i;
 	struct cpufreq_freqs freqs;
 	reg_config_rw_clk_ctrl clk_ctrl;
 	clk_ctrl = REG_RD(config, regi_config, rw_clk_ctrl);
 
-	for_each_possible_cpu(i) {
-		freqs.old = cris_freq_get_cpu_frequency(i);
-		freqs.new = cris_freq_table[state].frequency;
-		freqs.cpu = i;
-	}
+	freqs.old = cris_freq_get_cpu_frequency(policy->cpu);
+	freqs.new = cris_freq_table[state].frequency;
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	local_irq_disable();
 
@@ -54,7 +51,7 @@ static void cris_freq_set_cpu_state(unsigned int state)
 
 	local_irq_enable();
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 };
 
 static int cris_freq_verify(struct cpufreq_policy *policy)
@@ -71,7 +68,7 @@ static int cris_freq_target(struct cpufreq_policy *policy,
 	    (policy, cris_freq_table, target_freq, relation, &newstate))
 		return -EINVAL;
 
-	cris_freq_set_cpu_state(newstate);
+	cris_freq_set_cpu_state(policy, newstate);
 
 	return 0;
 }
diff --git a/arch/ia64/kernel/cpufreq/acpi-cpufreq.c b/arch/ia64/kernel/cpufreq/acpi-cpufreq.c
index f09b174..4700fef 100644
--- a/arch/ia64/kernel/cpufreq/acpi-cpufreq.c
+++ b/arch/ia64/kernel/cpufreq/acpi-cpufreq.c
@@ -137,7 +137,7 @@ migrate_end:
 static int
 processor_set_freq (
 	struct cpufreq_acpi_io	*data,
-	unsigned int		cpu,
+	struct cpufreq_policy   *policy,
 	int			state)
 {
 	int			ret = 0;
@@ -149,8 +149,8 @@ processor_set_freq (
 	pr_debug("processor_set_freq\n");
 
 	saved_mask = current->cpus_allowed;
-	set_cpus_allowed_ptr(current, cpumask_of(cpu));
-	if (smp_processor_id() != cpu) {
+	set_cpus_allowed_ptr(current, cpumask_of(policy->cpu));
+	if (smp_processor_id() != policy->cpu) {
 		retval = -EAGAIN;
 		goto migrate_end;
 	}
@@ -170,12 +170,11 @@ processor_set_freq (
 		data->acpi_data.state, state);
 
 	/* cpufreq frequency struct */
-	cpufreq_freqs.cpu = cpu;
 	cpufreq_freqs.old = data->freq_table[data->acpi_data.state].frequency;
 	cpufreq_freqs.new = data->freq_table[state].frequency;
 
 	/* notify cpufreq */
-	cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &cpufreq_freqs, CPUFREQ_PRECHANGE);
 
 	/*
 	 * First we write the target state's 'control' value to the
@@ -189,17 +188,20 @@ processor_set_freq (
 	ret = processor_set_pstate(value);
 	if (ret) {
 		unsigned int tmp = cpufreq_freqs.new;
-		cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_POSTCHANGE);
+		cpufreq_notify_transition(policy, &cpufreq_freqs,
+				CPUFREQ_POSTCHANGE);
 		cpufreq_freqs.new = cpufreq_freqs.old;
 		cpufreq_freqs.old = tmp;
-		cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_PRECHANGE);
-		cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_POSTCHANGE);
+		cpufreq_notify_transition(policy, &cpufreq_freqs,
+				CPUFREQ_PRECHANGE);
+		cpufreq_notify_transition(policy, &cpufreq_freqs,
+				CPUFREQ_POSTCHANGE);
 		printk(KERN_WARNING "Transition failed with error %d\n", ret);
 		retval = -ENODEV;
 		goto migrate_end;
 	}
 
-	cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &cpufreq_freqs, CPUFREQ_POSTCHANGE);
 
 	data->acpi_data.state = state;
 
@@ -240,7 +242,7 @@ acpi_cpufreq_target (
 	if (result)
 		return (result);
 
-	result = processor_set_freq(data, policy->cpu, next_state);
+	result = processor_set_freq(data, policy, next_state);
 
 	return (result);
 }
diff --git a/arch/mips/kernel/cpufreq/loongson2_cpufreq.c b/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
index 3237c52..bafda70 100644
--- a/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
+++ b/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
@@ -80,7 +80,6 @@ static int loongson2_cpufreq_target(struct cpufreq_policy *policy,
 
 	pr_debug("cpufreq: requested frequency %u Hz\n", target_freq * 1000);
 
-	freqs.cpu = cpu;
 	freqs.old = loongson2_cpufreq_get(cpu);
 	freqs.new = freq;
 	freqs.flags = 0;
@@ -89,7 +88,7 @@ static int loongson2_cpufreq_target(struct cpufreq_policy *policy,
 		return 0;
 
 	/* notifiers */
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	set_cpus_allowed_ptr(current, &cpus_allowed);
 
@@ -97,7 +96,7 @@ static int loongson2_cpufreq_target(struct cpufreq_policy *policy,
 	clk_set_rate(cpuclk, freq);
 
 	/* notifiers */
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	pr_debug("cpufreq: set frequency %u kHz\n", freq);
 
diff --git a/arch/powerpc/platforms/cell/cbe_cpufreq.c b/arch/powerpc/platforms/cell/cbe_cpufreq.c
index d4c39e3..718c6a3 100644
--- a/arch/powerpc/platforms/cell/cbe_cpufreq.c
+++ b/arch/powerpc/platforms/cell/cbe_cpufreq.c
@@ -156,10 +156,9 @@ static int cbe_cpufreq_target(struct cpufreq_policy *policy,
 
 	freqs.old = policy->cur;
 	freqs.new = cbe_freqs[cbe_pmode_new].frequency;
-	freqs.cpu = policy->cpu;
 
 	mutex_lock(&cbe_switch_mutex);
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	pr_debug("setting frequency for cpu %d to %d kHz, " \
 		 "1/%d of max frequency\n",
@@ -169,7 +168,7 @@ static int cbe_cpufreq_target(struct cpufreq_policy *policy,
 
 	rc = set_pmode(policy->cpu, cbe_pmode_new);
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 	mutex_unlock(&cbe_switch_mutex);
 
 	return rc;
diff --git a/arch/powerpc/platforms/pasemi/cpufreq.c b/arch/powerpc/platforms/pasemi/cpufreq.c
index 890f30e..be1e795 100644
--- a/arch/powerpc/platforms/pasemi/cpufreq.c
+++ b/arch/powerpc/platforms/pasemi/cpufreq.c
@@ -273,10 +273,9 @@ static int pas_cpufreq_target(struct cpufreq_policy *policy,
 
 	freqs.old = policy->cur;
 	freqs.new = pas_freqs[pas_astate_new].frequency;
-	freqs.cpu = policy->cpu;
 
 	mutex_lock(&pas_switch_mutex);
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	pr_debug("setting frequency for cpu %d to %d kHz, 1/%d of max frequency\n",
 		 policy->cpu,
@@ -288,7 +287,7 @@ static int pas_cpufreq_target(struct cpufreq_policy *policy,
 	for_each_online_cpu(i)
 		set_astate(i, pas_astate_new);
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 	mutex_unlock(&pas_switch_mutex);
 
 	ppc_proc_freq = freqs.new * 1000ul;
diff --git a/arch/powerpc/platforms/powermac/cpufreq_32.c b/arch/powerpc/platforms/powermac/cpufreq_32.c
index 311b804..3104fad 100644
--- a/arch/powerpc/platforms/powermac/cpufreq_32.c
+++ b/arch/powerpc/platforms/powermac/cpufreq_32.c
@@ -335,7 +335,8 @@ static int pmu_set_cpu_speed(int low_speed)
 	return 0;
 }
 
-static int do_set_cpu_speed(int speed_mode, int notify)
+static int do_set_cpu_speed(struct cpufreq_policy *policy, int speed_mode,
+		int notify)
 {
 	struct cpufreq_freqs freqs;
 	unsigned long l3cr;
@@ -343,13 +344,12 @@ static int do_set_cpu_speed(int speed_mode, int notify)
 
 	freqs.old = cur_freq;
 	freqs.new = (speed_mode == CPUFREQ_HIGH) ? hi_freq : low_freq;
-	freqs.cpu = smp_processor_id();
 
 	if (freqs.old == freqs.new)
 		return 0;
 
 	if (notify)
-		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+		cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 	if (speed_mode == CPUFREQ_LOW &&
 	    cpu_has_feature(CPU_FTR_L3CR)) {
 		l3cr = _get_L3CR();
@@ -366,7 +366,7 @@ static int do_set_cpu_speed(int speed_mode, int notify)
 			_set_L3CR(prev_l3cr);
 	}
 	if (notify)
-		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+		cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 	cur_freq = (speed_mode == CPUFREQ_HIGH) ? hi_freq : low_freq;
 
 	return 0;
@@ -393,7 +393,7 @@ static int pmac_cpufreq_target(	struct cpufreq_policy *policy,
 			target_freq, relation, &newstate))
 		return -EINVAL;
 
-	rc = do_set_cpu_speed(newstate, 1);
+	rc = do_set_cpu_speed(policy, newstate, 1);
 
 	ppc_proc_freq = cur_freq * 1000ul;
 	return rc;
@@ -442,7 +442,7 @@ static int pmac_cpufreq_suspend(struct cpufreq_policy *policy)
 	no_schedule = 1;
 	sleep_freq = cur_freq;
 	if (cur_freq == low_freq && !is_pmu_based)
-		do_set_cpu_speed(CPUFREQ_HIGH, 0);
+		do_set_cpu_speed(policy, CPUFREQ_HIGH, 0);
 	return 0;
 }
 
@@ -458,7 +458,7 @@ static int pmac_cpufreq_resume(struct cpufreq_policy *policy)
 	 * is that we force a switch to whatever it was, which is
 	 * probably high speed due to our suspend() routine
 	 */
-	do_set_cpu_speed(sleep_freq == low_freq ?
+	do_set_cpu_speed(policy, sleep_freq == low_freq ?
 			 CPUFREQ_LOW : CPUFREQ_HIGH, 0);
 
 	ppc_proc_freq = cur_freq * 1000ul;
diff --git a/arch/powerpc/platforms/powermac/cpufreq_64.c b/arch/powerpc/platforms/powermac/cpufreq_64.c
index 9650c60..7ba4234 100644
--- a/arch/powerpc/platforms/powermac/cpufreq_64.c
+++ b/arch/powerpc/platforms/powermac/cpufreq_64.c
@@ -339,11 +339,10 @@ static int g5_cpufreq_target(struct cpufreq_policy *policy,
 
 	freqs.old = g5_cpu_freqs[g5_pmode_cur].frequency;
 	freqs.new = g5_cpu_freqs[newstate].frequency;
-	freqs.cpu = 0;
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 	rc = g5_switch_freq(newstate);
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	mutex_unlock(&g5_switch_mutex);
 
diff --git a/arch/sh/kernel/cpufreq.c b/arch/sh/kernel/cpufreq.c
index e68b45b..2c7bd94 100644
--- a/arch/sh/kernel/cpufreq.c
+++ b/arch/sh/kernel/cpufreq.c
@@ -69,15 +69,14 @@ static int sh_cpufreq_target(struct cpufreq_policy *policy,
 
 	dev_dbg(dev, "requested frequency %u Hz\n", target_freq * 1000);
 
-	freqs.cpu	= cpu;
 	freqs.old	= sh_cpufreq_get(cpu);
 	freqs.new	= (freq + 500) / 1000;
 	freqs.flags	= 0;
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 	set_cpus_allowed_ptr(current, &cpus_allowed);
 	clk_set_rate(cpuclk, freq);
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	dev_dbg(dev, "set frequency %lu Hz\n", freq);
 
diff --git a/arch/sparc/kernel/us2e_cpufreq.c b/arch/sparc/kernel/us2e_cpufreq.c
index 489fc15..abe963d 100644
--- a/arch/sparc/kernel/us2e_cpufreq.c
+++ b/arch/sparc/kernel/us2e_cpufreq.c
@@ -248,8 +248,10 @@ static unsigned int us2e_freq_get(unsigned int cpu)
 	return clock_tick / estar_to_divisor(estar);
 }
 
-static void us2e_set_cpu_divider_index(unsigned int cpu, unsigned int index)
+static void us2e_set_cpu_divider_index(struct cpufreq_policy *policy,
+		unsigned int index)
 {
+	unsigned int cpu = policy->cpu;
 	unsigned long new_bits, new_freq;
 	unsigned long clock_tick, divisor, old_divisor, estar;
 	cpumask_t cpus_allowed;
@@ -272,14 +274,13 @@ static void us2e_set_cpu_divider_index(unsigned int cpu, unsigned int index)
 
 	freqs.old = clock_tick / old_divisor;
 	freqs.new = new_freq;
-	freqs.cpu = cpu;
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	if (old_divisor != divisor)
 		us2e_transition(estar, new_bits, clock_tick * 1000,
 				old_divisor, divisor);
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	set_cpus_allowed_ptr(current, &cpus_allowed);
 }
@@ -295,7 +296,7 @@ static int us2e_freq_target(struct cpufreq_policy *policy,
 					   target_freq, relation, &new_index))
 		return -EINVAL;
 
-	us2e_set_cpu_divider_index(policy->cpu, new_index);
+	us2e_set_cpu_divider_index(policy, new_index);
 
 	return 0;
 }
@@ -335,7 +336,7 @@ static int __init us2e_freq_cpu_init(struct cpufreq_policy *policy)
 static int us2e_freq_cpu_exit(struct cpufreq_policy *policy)
 {
 	if (cpufreq_us2e_driver)
-		us2e_set_cpu_divider_index(policy->cpu, 0);
+		us2e_set_cpu_divider_index(policy, 0);
 
 	return 0;
 }
diff --git a/arch/sparc/kernel/us3_cpufreq.c b/arch/sparc/kernel/us3_cpufreq.c
index eb1624b..7ceb9c8 100644
--- a/arch/sparc/kernel/us3_cpufreq.c
+++ b/arch/sparc/kernel/us3_cpufreq.c
@@ -96,8 +96,10 @@ static unsigned int us3_freq_get(unsigned int cpu)
 	return ret;
 }
 
-static void us3_set_cpu_divider_index(unsigned int cpu, unsigned int index)
+static void us3_set_cpu_divider_index(struct cpufreq_policy *policy,
+		unsigned int index)
 {
+	unsigned int cpu = policy->cpu;
 	unsigned long new_bits, new_freq, reg;
 	cpumask_t cpus_allowed;
 	struct cpufreq_freqs freqs;
@@ -131,14 +133,13 @@ static void us3_set_cpu_divider_index(unsigned int cpu, unsigned int index)
 
 	freqs.old = get_current_freq(cpu, reg);
 	freqs.new = new_freq;
-	freqs.cpu = cpu;
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	reg &= ~SAFARI_CFG_DIV_MASK;
 	reg |= new_bits;
 	write_safari_cfg(reg);
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	set_cpus_allowed_ptr(current, &cpus_allowed);
 }
@@ -156,7 +157,7 @@ static int us3_freq_target(struct cpufreq_policy *policy,
 					   &new_index))
 		return -EINVAL;
 
-	us3_set_cpu_divider_index(policy->cpu, new_index);
+	us3_set_cpu_divider_index(policy, new_index);
 
 	return 0;
 }
@@ -192,7 +193,7 @@ static int __init us3_freq_cpu_init(struct cpufreq_policy *policy)
 static int us3_freq_cpu_exit(struct cpufreq_policy *policy)
 {
 	if (cpufreq_us3_driver)
-		us3_set_cpu_divider_index(policy->cpu, 0);
+		us3_set_cpu_divider_index(policy, 0);
 
 	return 0;
 }
diff --git a/arch/unicore32/kernel/cpu-ucv2.c b/arch/unicore32/kernel/cpu-ucv2.c
index 4a99f62..ba5a71c 100644
--- a/arch/unicore32/kernel/cpu-ucv2.c
+++ b/arch/unicore32/kernel/cpu-ucv2.c
@@ -52,15 +52,14 @@ static int ucv2_target(struct cpufreq_policy *policy,
 	struct cpufreq_freqs freqs;
 	struct clk *mclk = clk_get(NULL, "MAIN_CLK");
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	if (!clk_set_rate(mclk, target_freq * 1000)) {
 		freqs.old = cur;
 		freqs.new = target_freq;
-		freqs.cpu = 0;
 	}
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	return 0;
 }
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 937bc28..afbef9c 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -423,7 +423,6 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
 	struct drv_cmd cmd;
 	unsigned int next_state = 0; /* Index into freq_table */
 	unsigned int next_perf_state = 0; /* Index into perf table */
-	unsigned int i;
 	int result = 0;
 
 	pr_debug("acpi_cpufreq_target %d (%d)\n", target_freq, policy->cpu);
@@ -486,10 +485,7 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
 
 	freqs.old = perf->states[perf->state].core_frequency * 1000;
 	freqs.new = data->freq_table[next_state].frequency;
-	for_each_cpu(i, policy->cpus) {
-		freqs.cpu = i;
-		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-	}
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	drv_write(&cmd);
 
@@ -502,10 +498,7 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
 		}
 	}
 
-	for_each_cpu(i, policy->cpus) {
-		freqs.cpu = i;
-		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	}
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 	perf->state = next_perf_state;
 
 out:
diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index 4e5b7fb..dff4dbc 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -45,7 +45,7 @@ static int cpu0_set_target(struct cpufreq_policy *policy,
 	struct cpufreq_freqs freqs;
 	struct opp *opp;
 	unsigned long freq_Hz, volt = 0, volt_old = 0, tol = 0;
-	unsigned int index, cpu;
+	unsigned int index;
 	int ret;
 
 	ret = cpufreq_frequency_table_target(policy, freq_table, target_freq,
@@ -65,10 +65,7 @@ static int cpu0_set_target(struct cpufreq_policy *policy,
 	if (freqs.old == freqs.new)
 		return 0;
 
-	for_each_online_cpu(cpu) {
-		freqs.cpu = cpu;
-		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-	}
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	if (cpu_reg) {
 		rcu_read_lock();
@@ -117,10 +114,7 @@ static int cpu0_set_target(struct cpufreq_policy *policy,
 		}
 	}
 
-	for_each_online_cpu(cpu) {
-		freqs.cpu = cpu;
-		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	}
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	return 0;
 }
diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index 13d311e..224a478 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -263,7 +263,6 @@ static int nforce2_target(struct cpufreq_policy *policy,
 
 	freqs.old = nforce2_get(policy->cpu);
 	freqs.new = target_fsb * fid * 100;
-	freqs.cpu = 0;		/* Only one CPU on nForce2 platforms */
 
 	if (freqs.old == freqs.new)
 		return 0;
@@ -271,7 +270,7 @@ static int nforce2_target(struct cpufreq_policy *policy,
 	pr_debug("Old CPU frequency %d kHz, new %d kHz\n",
 	       freqs.old, freqs.new);
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	/* Disable IRQs */
 	/* local_irq_save(flags); */
@@ -286,7 +285,7 @@ static int nforce2_target(struct cpufreq_policy *policy,
 	/* Enable IRQs */
 	/* local_irq_restore(flags); */
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	return 0;
 }
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b02824d..2cc6bc4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -244,19 +244,9 @@ static inline void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
 #endif
 
 
-/**
- * cpufreq_notify_transition - call notifier chain and adjust_jiffies
- * on frequency transition.
- *
- * This function calls the transition notifiers and the "adjust_jiffies"
- * function. It is called twice on all CPU frequency changes that have
- * external effects.
- */
-void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int state)
+void __cpufreq_notify_transition(struct cpufreq_policy *policy,
+		struct cpufreq_freqs *freqs, unsigned int state)
 {
-	struct cpufreq_policy *policy;
-	unsigned long flags;
-
 	BUG_ON(irqs_disabled());
 
 	if (cpufreq_disabled())
@@ -266,10 +256,6 @@ void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int state)
 	pr_debug("notification %u of frequency transition to %u kHz\n",
 		state, freqs->new);
 
-	spin_lock_irqsave(&cpufreq_driver_lock, flags);
-	policy = per_cpu(cpufreq_cpu_data, freqs->cpu);
-	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
-
 	switch (state) {
 
 	case CPUFREQ_PRECHANGE:
@@ -303,6 +289,20 @@ void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int state)
 		break;
 	}
 }
+/**
+ * cpufreq_notify_transition - call notifier chain and adjust_jiffies
+ * on frequency transition.
+ *
+ * This function calls the transition notifiers and the "adjust_jiffies"
+ * function. It is called twice on all CPU frequency changes that have
+ * external effects.
+ */
+void cpufreq_notify_transition(struct cpufreq_policy *policy,
+		struct cpufreq_freqs *freqs, unsigned int state)
+{
+	for_each_cpu(freqs->cpu, policy->cpus)
+		__cpufreq_notify_transition(policy, freqs, state);
+}
 EXPORT_SYMBOL_GPL(cpufreq_notify_transition);
 
 
@@ -1134,16 +1134,23 @@ static void handle_update(struct work_struct *work)
 static void cpufreq_out_of_sync(unsigned int cpu, unsigned int old_freq,
 				unsigned int new_freq)
 {
+	struct cpufreq_policy *policy;
 	struct cpufreq_freqs freqs;
+	unsigned long flags;
+
 
 	pr_debug("Warning: CPU frequency out of sync: cpufreq and timing "
 	       "core thinks of %u, is %u kHz.\n", old_freq, new_freq);
 
-	freqs.cpu = cpu;
 	freqs.old = old_freq;
 	freqs.new = new_freq;
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	spin_lock_irqsave(&cpufreq_driver_lock, flags);
+	policy = per_cpu(cpufreq_cpu_data, cpu);
+	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
+
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 }
 
 
diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index 72f0c3e..7192a6d 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -55,8 +55,7 @@ static int dbx500_cpufreq_target(struct cpufreq_policy *policy,
 		return 0;
 
 	/* pre-change notification */
-	for_each_cpu(freqs.cpu, policy->cpus)
-		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	/* update armss clk frequency */
 	ret = clk_set_rate(armss_clk, freqs.new * 1000);
@@ -68,8 +67,7 @@ static int dbx500_cpufreq_target(struct cpufreq_policy *policy,
 	}
 
 	/* post change notification */
-	for_each_cpu(freqs.cpu, policy->cpus)
-		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	return 0;
 }
diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index 3fffbe6..37380fb 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -104,7 +104,7 @@ static unsigned int eps_get(unsigned int cpu)
 }
 
 static int eps_set_state(struct eps_cpu_data *centaur,
-			 unsigned int cpu,
+			 struct cpufreq_policy *policy,
 			 u32 dest_state)
 {
 	struct cpufreq_freqs freqs;
@@ -112,10 +112,9 @@ static int eps_set_state(struct eps_cpu_data *centaur,
 	int err = 0;
 	int i;
 
-	freqs.old = eps_get(cpu);
+	freqs.old = eps_get(policy->cpu);
 	freqs.new = centaur->fsb * ((dest_state >> 8) & 0xff);
-	freqs.cpu = cpu;
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	/* Wait while CPU is busy */
 	rdmsr(MSR_IA32_PERF_STATUS, lo, hi);
@@ -162,7 +161,7 @@ postchange:
 		current_multiplier);
 	}
 #endif
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 	return err;
 }
 
@@ -190,7 +189,7 @@ static int eps_target(struct cpufreq_policy *policy,
 
 	/* Make frequency transition */
 	dest_state = centaur->freq_table[newstate].index & 0xffff;
-	ret = eps_set_state(centaur, cpu, dest_state);
+	ret = eps_set_state(centaur, policy, dest_state);
 	if (ret)
 		printk(KERN_ERR "eps: Timeout!\n");
 	return ret;
diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index 960671f..658d860 100644
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -117,15 +117,15 @@ static unsigned int elanfreq_get_cpu_frequency(unsigned int cpu)
  *	There is no return value.
  */
 
-static void elanfreq_set_cpu_state(unsigned int state)
+static void elanfreq_set_cpu_state(struct cpufreq_policy *policy,
+		unsigned int state)
 {
 	struct cpufreq_freqs    freqs;
 
 	freqs.old = elanfreq_get_cpu_frequency(0);
 	freqs.new = elan_multiplier[state].clock;
-	freqs.cpu = 0; /* elanfreq.c is UP only driver */
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	printk(KERN_INFO "elanfreq: attempting to set frequency to %i kHz\n",
 			elan_multiplier[state].clock);
@@ -161,7 +161,7 @@ static void elanfreq_set_cpu_state(unsigned int state)
 	udelay(10000);
 	local_irq_enable();
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 };
 
 
@@ -188,7 +188,7 @@ static int elanfreq_target(struct cpufreq_policy *policy,
 				target_freq, relation, &newstate))
 		return -EINVAL;
 
-	elanfreq_set_cpu_state(newstate);
+	elanfreq_set_cpu_state(policy, newstate);
 
 	return 0;
 }
diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 78057a3..c0c4ce5 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -70,7 +70,6 @@ static int exynos_cpufreq_scale(unsigned int target_freq)
 
 	freqs.old = policy->cur;
 	freqs.new = target_freq;
-	freqs.cpu = policy->cpu;
 
 	if (freqs.new == freqs.old)
 		goto out;
@@ -105,8 +104,7 @@ static int exynos_cpufreq_scale(unsigned int target_freq)
 	}
 	arm_volt = volt_table[index];
 
-	for_each_cpu(freqs.cpu, policy->cpus)
-		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	/* When the new frequency is higher than current frequency */
 	if ((freqs.new > freqs.old) && !safe_arm_volt) {
@@ -131,8 +129,7 @@ static int exynos_cpufreq_scale(unsigned int target_freq)
 
 	exynos_info->set_freq(old_index, index);
 
-	for_each_cpu(freqs.cpu, policy->cpus)
-		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	/* When the new frequency is lower than current frequency */
 	if ((freqs.new < freqs.old) ||
diff --git a/drivers/cpufreq/gx-suspmod.c b/drivers/cpufreq/gx-suspmod.c
index 456bee0..3dfc99b 100644
--- a/drivers/cpufreq/gx-suspmod.c
+++ b/drivers/cpufreq/gx-suspmod.c
@@ -251,14 +251,13 @@ static unsigned int gx_validate_speed(unsigned int khz, u8 *on_duration,
  * set cpu speed in khz.
  **/
 
-static void gx_set_cpuspeed(unsigned int khz)
+static void gx_set_cpuspeed(struct cpufreq_policy *policy, unsigned int khz)
 {
 	u8 suscfg, pmer1;
 	unsigned int new_khz;
 	unsigned long flags;
 	struct cpufreq_freqs freqs;
 
-	freqs.cpu = 0;
 	freqs.old = gx_get_cpuspeed(0);
 
 	new_khz = gx_validate_speed(khz, &gx_params->on_duration,
@@ -266,11 +265,9 @@ static void gx_set_cpuspeed(unsigned int khz)
 
 	freqs.new = new_khz;
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 	local_irq_save(flags);
 
-
-
 	if (new_khz != stock_freq) {
 		/* if new khz == 100% of CPU speed, it is special case */
 		switch (gx_params->cs55x0->device) {
@@ -317,7 +314,7 @@ static void gx_set_cpuspeed(unsigned int khz)
 
 	gx_params->pci_suscfg = suscfg;
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	pr_debug("suspend modulation w/ duration of ON:%d us, OFF:%d us\n",
 		gx_params->on_duration * 32, gx_params->off_duration * 32);
@@ -397,7 +394,7 @@ static int cpufreq_gx_target(struct cpufreq_policy *policy,
 		tmp_freq = gx_validate_speed(tmp_freq, &tmp1, &tmp2);
 	}
 
-	gx_set_cpuspeed(tmp_freq);
+	gx_set_cpuspeed(policy, tmp_freq);
 
 	return 0;
 }
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 54e336d..b78bc35 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -50,7 +50,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy,
 	struct cpufreq_freqs freqs;
 	struct opp *opp;
 	unsigned long freq_hz, volt, volt_old;
-	unsigned int index, cpu;
+	unsigned int index;
 	int ret;
 
 	ret = cpufreq_frequency_table_target(policy, freq_table, target_freq,
@@ -68,10 +68,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy,
 	if (freqs.old == freqs.new)
 		return 0;
 
-	for_each_online_cpu(cpu) {
-		freqs.cpu = cpu;
-		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-	}
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	rcu_read_lock();
 	opp = opp_find_freq_ceil(cpu_dev, &freq_hz);
@@ -166,10 +163,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy,
 		}
 	}
 
-	for_each_online_cpu(cpu) {
-		freqs.cpu = cpu;
-		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	}
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	return 0;
 }
diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index 0e83e3c..c6e14fb 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -55,7 +55,8 @@ static unsigned int kirkwood_cpufreq_get_cpu_frequency(unsigned int cpu)
 	return kirkwood_freq_table[0].frequency;
 }
 
-static void kirkwood_cpufreq_set_cpu_state(unsigned int index)
+static void kirkwood_cpufreq_set_cpu_state(struct cpufreq_policy *policy,
+		unsigned int index)
 {
 	struct cpufreq_freqs freqs;
 	unsigned int state = kirkwood_freq_table[index].index;
@@ -63,9 +64,8 @@ static void kirkwood_cpufreq_set_cpu_state(unsigned int index)
 
 	freqs.old = kirkwood_cpufreq_get_cpu_frequency(0);
 	freqs.new = kirkwood_freq_table[index].frequency;
-	freqs.cpu = 0; /* Kirkwood is UP */
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	dev_dbg(priv.dev, "Attempting to set frequency to %i KHz\n",
 		kirkwood_freq_table[index].frequency);
@@ -99,7 +99,7 @@ static void kirkwood_cpufreq_set_cpu_state(unsigned int index)
 
 		local_irq_enable();
 	}
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 };
 
 static int kirkwood_cpufreq_verify(struct cpufreq_policy *policy)
@@ -117,7 +117,7 @@ static int kirkwood_cpufreq_target(struct cpufreq_policy *policy,
 				target_freq, relation, &index))
 		return -EINVAL;
 
-	kirkwood_cpufreq_set_cpu_state(index);
+	kirkwood_cpufreq_set_cpu_state(policy, index);
 
 	return 0;
 }
diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index 1180d53..b448638 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -242,7 +242,8 @@ static void do_powersaver(int cx_address, unsigned int mults_index,
  * Sets a new clock ratio.
  */
 
-static void longhaul_setstate(unsigned int table_index)
+static void longhaul_setstate(struct cpufreq_policy *policy,
+		unsigned int table_index)
 {
 	unsigned int mults_index;
 	int speed, mult;
@@ -267,9 +268,8 @@ static void longhaul_setstate(unsigned int table_index)
 
 	freqs.old = calc_speed(longhaul_get_cpu_mult());
 	freqs.new = speed;
-	freqs.cpu = 0; /* longhaul.c is UP only driver */
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	pr_debug("Setting to FSB:%dMHz Mult:%d.%dx (%s)\n",
 			fsb, mult/10, mult%10, print_speed(speed/1000));
@@ -386,7 +386,7 @@ retry_loop:
 		}
 	}
 	/* Report true CPU frequency */
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	if (!bm_timeout)
 		printk(KERN_INFO PFX "Warning: Timeout while waiting for "
@@ -648,7 +648,7 @@ static int longhaul_target(struct cpufreq_policy *policy,
 		return 0;
 
 	if (!can_scale_voltage)
-		longhaul_setstate(table_index);
+		longhaul_setstate(policy, table_index);
 	else {
 		/* On test system voltage transitions exceeding single
 		 * step up or down were turning motherboard off. Both
@@ -663,7 +663,7 @@ static int longhaul_target(struct cpufreq_policy *policy,
 		while (i != table_index) {
 			vid = (longhaul_table[i].index >> 8) & 0x1f;
 			if (vid != current_vid) {
-				longhaul_setstate(i);
+				longhaul_setstate(policy, i);
 				current_vid = vid;
 				msleep(200);
 			}
@@ -672,7 +672,7 @@ static int longhaul_target(struct cpufreq_policy *policy,
 			else
 				i--;
 		}
-		longhaul_setstate(table_index);
+		longhaul_setstate(policy, table_index);
 	}
 	longhaul_index = table_index;
 	return 0;
@@ -998,15 +998,17 @@ static int __init longhaul_init(void)
 
 static void __exit longhaul_exit(void)
 {
+	struct cpufreq_policy *policy = cpufreq_cpu_get(0);
 	int i;
 
 	for (i = 0; i < numscales; i++) {
 		if (mults[i] == maxmult) {
-			longhaul_setstate(i);
+			longhaul_setstate(policy, i);
 			break;
 		}
 	}
 
+	cpufreq_cpu_put(policy);
 	cpufreq_unregister_driver(&longhaul_driver);
 	kfree(longhaul_table);
 }
diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
index d4c4989..cdd6291 100644
--- a/drivers/cpufreq/maple-cpufreq.c
+++ b/drivers/cpufreq/maple-cpufreq.c
@@ -158,11 +158,10 @@ static int maple_cpufreq_target(struct cpufreq_policy *policy,
 
 	freqs.old = maple_cpu_freqs[maple_pmode_cur].frequency;
 	freqs.new = maple_cpu_freqs[newstate].frequency;
-	freqs.cpu = 0;
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 	rc = maple_scom_switch_freq(newstate);
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	mutex_unlock(&maple_switch_mutex);
 
diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 9128c07..b610edd 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -88,16 +88,12 @@ static int omap_target(struct cpufreq_policy *policy,
 	}
 
 	freqs.old = omap_getspeed(policy->cpu);
-	freqs.cpu = policy->cpu;
 
 	if (freqs.old == freqs.new && policy->cur == freqs.new)
 		return ret;
 
 	/* notifiers */
-	for_each_cpu(i, policy->cpus) {
-		freqs.cpu = i;
-		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-	}
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	freq = freqs.new * 1000;
 	ret = clk_round_rate(mpu_clk, freq);
@@ -157,10 +153,7 @@ static int omap_target(struct cpufreq_policy *policy,
 
 done:
 	/* notifiers */
-	for_each_cpu(i, policy->cpus) {
-		freqs.cpu = i;
-		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	}
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	return ret;
 }
diff --git a/drivers/cpufreq/p4-clockmod.c b/drivers/cpufreq/p4-clockmod.c
index 827629c9..4b2e773 100644
--- a/drivers/cpufreq/p4-clockmod.c
+++ b/drivers/cpufreq/p4-clockmod.c
@@ -125,10 +125,7 @@ static int cpufreq_p4_target(struct cpufreq_policy *policy,
 		return 0;
 
 	/* notifiers */
-	for_each_cpu(i, policy->cpus) {
-		freqs.cpu = i;
-		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-	}
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	/* run on each logical CPU,
 	 * see section 13.15.3 of IA32 Intel Architecture Software
@@ -138,10 +135,7 @@ static int cpufreq_p4_target(struct cpufreq_policy *policy,
 		cpufreq_p4_setdc(i, p4clockmod_table[newstate].index);
 
 	/* notifiers */
-	for_each_cpu(i, policy->cpus) {
-		freqs.cpu = i;
-		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	}
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	return 0;
 }
diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 503996a..0de0008 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -215,8 +215,7 @@ static int pcc_cpufreq_target(struct cpufreq_policy *policy,
 		(pcch_virt_addr + pcc_cpu_data->input_offset));
 
 	freqs.new = target_freq;
-	freqs.cpu = cpu;
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	input_buffer = 0x1 | (((target_freq * 100)
 			       / (ioread32(&pcch_hdr->nominal) * 1000)) << 8);
@@ -237,7 +236,7 @@ static int pcc_cpufreq_target(struct cpufreq_policy *policy,
 	}
 	iowrite16(0, &pcch_hdr->status);
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 	pr_debug("target: was SUCCESSFUL for cpu %d\n", cpu);
 	spin_unlock(&pcc_lock);
 
diff --git a/drivers/cpufreq/powernow-k6.c b/drivers/cpufreq/powernow-k6.c
index af23e0b..ea0222a 100644
--- a/drivers/cpufreq/powernow-k6.c
+++ b/drivers/cpufreq/powernow-k6.c
@@ -68,7 +68,8 @@ static int powernow_k6_get_cpu_multiplier(void)
  *
  *   Tries to change the PowerNow! multiplier
  */
-static void powernow_k6_set_state(unsigned int best_i)
+static void powernow_k6_set_state(struct cpufreq_policy *policy,
+		unsigned int best_i)
 {
 	unsigned long outvalue = 0, invalue = 0;
 	unsigned long msrval;
@@ -81,9 +82,8 @@ static void powernow_k6_set_state(unsigned int best_i)
 
 	freqs.old = busfreq * powernow_k6_get_cpu_multiplier();
 	freqs.new = busfreq * clock_ratio[best_i].index;
-	freqs.cpu = 0; /* powernow-k6.c is UP only driver */
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	/* we now need to transform best_i to the BVC format, see AMD#23446 */
 
@@ -98,7 +98,7 @@ static void powernow_k6_set_state(unsigned int best_i)
 	msrval = POWERNOW_IOPORT + 0x0;
 	wrmsr(MSR_K6_EPMR, msrval, 0); /* disable it again */
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	return;
 }
@@ -136,7 +136,7 @@ static int powernow_k6_target(struct cpufreq_policy *policy,
 				target_freq, relation, &newstate))
 		return -EINVAL;
 
-	powernow_k6_set_state(newstate);
+	powernow_k6_set_state(policy, newstate);
 
 	return 0;
 }
@@ -182,7 +182,7 @@ static int powernow_k6_cpu_exit(struct cpufreq_policy *policy)
 	unsigned int i;
 	for (i = 0; i < 8; i++) {
 		if (i == max_multiplier)
-			powernow_k6_set_state(i);
+			powernow_k6_set_state(policy, i);
 	}
 	cpufreq_frequency_table_put_attr(policy->cpu);
 	return 0;
diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index 334cc2f..53888da 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -248,7 +248,7 @@ static void change_VID(int vid)
 }
 
 
-static void change_speed(unsigned int index)
+static void change_speed(struct cpufreq_policy *policy, unsigned int index)
 {
 	u8 fid, vid;
 	struct cpufreq_freqs freqs;
@@ -263,15 +263,13 @@ static void change_speed(unsigned int index)
 	fid = powernow_table[index].index & 0xFF;
 	vid = (powernow_table[index].index & 0xFF00) >> 8;
 
-	freqs.cpu = 0;
-
 	rdmsrl(MSR_K7_FID_VID_STATUS, fidvidstatus.val);
 	cfid = fidvidstatus.bits.CFID;
 	freqs.old = fsb * fid_codes[cfid] / 10;
 
 	freqs.new = powernow_table[index].frequency;
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	/* Now do the magic poking into the MSRs.  */
 
@@ -292,7 +290,7 @@ static void change_speed(unsigned int index)
 	if (have_a0 == 1)
 		local_irq_enable();
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 }
 
 
@@ -546,7 +544,7 @@ static int powernow_target(struct cpufreq_policy *policy,
 				relation, &newstate))
 		return -EINVAL;
 
-	change_speed(newstate);
+	change_speed(policy, newstate);
 
 	return 0;
 }
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index d13a136..52137a3 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -928,9 +928,10 @@ static int get_transition_latency(struct powernow_k8_data *data)
 static int transition_frequency_fidvid(struct powernow_k8_data *data,
 		unsigned int index)
 {
+	struct cpufreq_policy *policy;
 	u32 fid = 0;
 	u32 vid = 0;
-	int res, i;
+	int res;
 	struct cpufreq_freqs freqs;
 
 	pr_debug("cpu %d transition to index %u\n", smp_processor_id(), index);
@@ -959,10 +960,10 @@ static int transition_frequency_fidvid(struct powernow_k8_data *data,
 	freqs.old = find_khz_freq_from_fid(data->currfid);
 	freqs.new = find_khz_freq_from_fid(fid);
 
-	for_each_cpu(i, data->available_cores) {
-		freqs.cpu = i;
-		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-	}
+	policy = cpufreq_cpu_get(smp_processor_id());
+	cpufreq_cpu_put(policy);
+
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	res = transition_fid_vid(data, fid, vid);
 	if (res)
@@ -970,10 +971,7 @@ static int transition_frequency_fidvid(struct powernow_k8_data *data,
 
 	freqs.new = find_khz_freq_from_fid(data->currfid);
 
-	for_each_cpu(i, data->available_cores) {
-		freqs.cpu = i;
-		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	}
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 	return res;
 }
 
diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
index bcc053b..4f1881e 100644
--- a/drivers/cpufreq/s3c2416-cpufreq.c
+++ b/drivers/cpufreq/s3c2416-cpufreq.c
@@ -256,7 +256,6 @@ static int s3c2416_cpufreq_set_target(struct cpufreq_policy *policy,
 		goto out;
 	}
 
-	freqs.cpu = 0;
 	freqs.flags = 0;
 	freqs.old = s3c_freq->is_dvs ? FREQ_DVS
 				     : clk_get_rate(s3c_freq->armclk) / 1000;
@@ -274,7 +273,7 @@ static int s3c2416_cpufreq_set_target(struct cpufreq_policy *policy,
 	if (!to_dvs && freqs.old == freqs.new)
 		goto out;
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	if (to_dvs) {
 		pr_debug("cpufreq: enter dvs\n");
@@ -287,7 +286,7 @@ static int s3c2416_cpufreq_set_target(struct cpufreq_policy *policy,
 		ret = s3c2416_cpufreq_set_armdiv(s3c_freq, freqs.new);
 	}
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 out:
 	mutex_unlock(&cpufreq_lock);
diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
index 6f9490b..27cacb5 100644
--- a/drivers/cpufreq/s3c64xx-cpufreq.c
+++ b/drivers/cpufreq/s3c64xx-cpufreq.c
@@ -84,7 +84,6 @@ static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
 	if (ret != 0)
 		return ret;
 
-	freqs.cpu = 0;
 	freqs.old = clk_get_rate(armclk) / 1000;
 	freqs.new = s3c64xx_freq_table[i].frequency;
 	freqs.flags = 0;
@@ -95,7 +94,7 @@ static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
 
 	pr_debug("Transition %d-%dkHz\n", freqs.old, freqs.new);
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 #ifdef CONFIG_REGULATOR
 	if (vddarm && freqs.new > freqs.old) {
@@ -117,7 +116,7 @@ static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
 		goto err;
 	}
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 #ifdef CONFIG_REGULATOR
 	if (vddarm && freqs.new < freqs.old) {
@@ -141,7 +140,7 @@ err_clk:
 	if (clk_set_rate(armclk, freqs.old * 1000) < 0)
 		pr_err("Failed to restore original clock rate\n");
 err:
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	return ret;
 }
diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index a484aae..5c77570 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -229,7 +229,6 @@ static int s5pv210_target(struct cpufreq_policy *policy,
 	}
 
 	freqs.new = s5pv210_freq_table[index].frequency;
-	freqs.cpu = 0;
 
 	if (freqs.new == freqs.old)
 		goto exit;
@@ -256,7 +255,7 @@ static int s5pv210_target(struct cpufreq_policy *policy,
 			goto exit;
 	}
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	/* Check if there need to change PLL */
 	if ((index == L0) || (priv_index == L0))
@@ -468,7 +467,7 @@ static int s5pv210_target(struct cpufreq_policy *policy,
 		}
 	}
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	if (freqs.new < freqs.old) {
 		regulator_set_voltage(int_regulator,
diff --git a/drivers/cpufreq/sc520_freq.c b/drivers/cpufreq/sc520_freq.c
index e42e073..f740b13 100644
--- a/drivers/cpufreq/sc520_freq.c
+++ b/drivers/cpufreq/sc520_freq.c
@@ -53,7 +53,8 @@ static unsigned int sc520_freq_get_cpu_frequency(unsigned int cpu)
 	}
 }
 
-static void sc520_freq_set_cpu_state(unsigned int state)
+static void sc520_freq_set_cpu_state(struct cpufreq_policy *policy,
+		unsigned int state)
 {
 
 	struct cpufreq_freqs	freqs;
@@ -61,9 +62,8 @@ static void sc520_freq_set_cpu_state(unsigned int state)
 
 	freqs.old = sc520_freq_get_cpu_frequency(0);
 	freqs.new = sc520_freq_table[state].frequency;
-	freqs.cpu = 0; /* AMD Elan is UP */
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	pr_debug("attempting to set frequency to %i kHz\n",
 			sc520_freq_table[state].frequency);
@@ -75,7 +75,7 @@ static void sc520_freq_set_cpu_state(unsigned int state)
 
 	local_irq_enable();
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 };
 
 static int sc520_freq_verify(struct cpufreq_policy *policy)
@@ -93,7 +93,7 @@ static int sc520_freq_target(struct cpufreq_policy *policy,
 				target_freq, relation, &newstate))
 		return -EINVAL;
 
-	sc520_freq_set_cpu_state(newstate);
+	sc520_freq_set_cpu_state(policy, newstate);
 
 	return 0;
 }
diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 7e4d773..156829f 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -121,7 +121,6 @@ static int spear_cpufreq_target(struct cpufreq_policy *policy,
 				target_freq, relation, &index))
 		return -EINVAL;
 
-	freqs.cpu = policy->cpu;
 	freqs.old = spear_cpufreq_get(0);
 
 	newfreq = spear_cpufreq.freq_tbl[index].frequency * 1000;
@@ -158,8 +157,7 @@ static int spear_cpufreq_target(struct cpufreq_policy *policy,
 	freqs.new = newfreq / 1000;
 	freqs.new /= mult;
 
-	for_each_cpu(freqs.cpu, policy->cpus)
-		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	if (mult == 2)
 		ret = spear1340_set_cpu_rate(srcclk, newfreq);
@@ -172,8 +170,7 @@ static int spear_cpufreq_target(struct cpufreq_policy *policy,
 		freqs.new = clk_get_rate(spear_cpufreq.clk) / 1000;
 	}
 
-	for_each_cpu(freqs.cpu, policy->cpus)
-		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 	return ret;
 }
 
diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
index 3a953d5..3dbbcc3 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -457,7 +457,7 @@ static int centrino_target (struct cpufreq_policy *policy,
 	unsigned int	msr, oldmsr = 0, h = 0, cpu = policy->cpu;
 	struct cpufreq_freqs	freqs;
 	int			retval = 0;
-	unsigned int		j, k, first_cpu, tmp;
+	unsigned int		j, first_cpu, tmp;
 	cpumask_var_t covered_cpus;
 
 	if (unlikely(!zalloc_cpumask_var(&covered_cpus, GFP_KERNEL)))
@@ -522,13 +522,8 @@ static int centrino_target (struct cpufreq_policy *policy,
 			pr_debug("target=%dkHz old=%d new=%d msr=%04x\n",
 				target_freq, freqs.old, freqs.new, msr);
 
-			for_each_cpu(k, policy->cpus) {
-				if (!cpu_online(k))
-					continue;
-				freqs.cpu = k;
-				cpufreq_notify_transition(&freqs,
+			cpufreq_notify_transition(policy, &freqs,
 					CPUFREQ_PRECHANGE);
-			}
 
 			first_cpu = 0;
 			/* all but 16 LSB are reserved, treat them with care */
@@ -544,12 +539,7 @@ static int centrino_target (struct cpufreq_policy *policy,
 		cpumask_set_cpu(j, covered_cpus);
 	}
 
-	for_each_cpu(k, policy->cpus) {
-		if (!cpu_online(k))
-			continue;
-		freqs.cpu = k;
-		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	}
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	if (unlikely(retval)) {
 		/*
@@ -565,12 +555,8 @@ static int centrino_target (struct cpufreq_policy *policy,
 		tmp = freqs.new;
 		freqs.new = freqs.old;
 		freqs.old = tmp;
-		for_each_cpu(j, policy->cpus) {
-			if (!cpu_online(j))
-				continue;
-			cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-			cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-		}
+		cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
+		cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 	}
 	retval = 0;
 
diff --git a/drivers/cpufreq/speedstep-ich.c b/drivers/cpufreq/speedstep-ich.c
index e29b59a..e2e5aa9 100644
--- a/drivers/cpufreq/speedstep-ich.c
+++ b/drivers/cpufreq/speedstep-ich.c
@@ -263,7 +263,6 @@ static int speedstep_target(struct cpufreq_policy *policy,
 {
 	unsigned int newstate = 0, policy_cpu;
 	struct cpufreq_freqs freqs;
-	int i;
 
 	if (cpufreq_frequency_table_target(policy, &speedstep_freqs[0],
 				target_freq, relation, &newstate))
@@ -272,7 +271,6 @@ static int speedstep_target(struct cpufreq_policy *policy,
 	policy_cpu = cpumask_any_and(policy->cpus, cpu_online_mask);
 	freqs.old = speedstep_get(policy_cpu);
 	freqs.new = speedstep_freqs[newstate].frequency;
-	freqs.cpu = policy->cpu;
 
 	pr_debug("transiting from %u to %u kHz\n", freqs.old, freqs.new);
 
@@ -280,18 +278,12 @@ static int speedstep_target(struct cpufreq_policy *policy,
 	if (freqs.old == freqs.new)
 		return 0;
 
-	for_each_cpu(i, policy->cpus) {
-		freqs.cpu = i;
-		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-	}
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	smp_call_function_single(policy_cpu, _speedstep_set_state, &newstate,
 				 true);
 
-	for_each_cpu(i, policy->cpus) {
-		freqs.cpu = i;
-		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	}
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	return 0;
 }
diff --git a/drivers/cpufreq/speedstep-smi.c b/drivers/cpufreq/speedstep-smi.c
index 6a457fc..f5a6b70 100644
--- a/drivers/cpufreq/speedstep-smi.c
+++ b/drivers/cpufreq/speedstep-smi.c
@@ -252,14 +252,13 @@ static int speedstep_target(struct cpufreq_policy *policy,
 
 	freqs.old = speedstep_freqs[speedstep_get_state()].frequency;
 	freqs.new = speedstep_freqs[newstate].frequency;
-	freqs.cpu = 0; /* speedstep.c is UP only driver */
 
 	if (freqs.old == freqs.new)
 		return 0;
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 	speedstep_set_state(newstate);
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	return 0;
 }
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index a22944c..47be364 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -268,8 +268,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
 
-void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int state);
-
+void cpufreq_notify_transition(struct cpufreq_policy *policy,
+		struct cpufreq_freqs *freqs, unsigned int state);
 
 static inline void cpufreq_verify_within_limits(struct cpufreq_policy *policy, unsigned int min, unsigned int max)
 {
-- 
1.7.12.rc2.18.g61b472e
