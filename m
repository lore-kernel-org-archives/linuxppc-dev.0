Return-Path: <viresh.kumar@linaro.org>
Received: from mail-oa0-f50.google.com (mail-oa0-f50.google.com
 [209.85.219.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C1B412C009F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 16:19:08 +1100 (EST)
Received: by mail-oa0-f50.google.com with SMTP id n1so3254668oag.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Mar 2013 22:19:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <981c23bd4b2a14c346820685e1203ab7054378f8.1364132845.git.viresh.kumar@linaro.org>
References: <981c23bd4b2a14c346820685e1203ab7054378f8.1364132845.git.viresh.kumar@linaro.org>
Date: Mon, 25 Mar 2013 10:49:05 +0530
Message-ID: <CAKohpo=JuyVmSRFs1wpqvvmouRpL+d8ms-o4UC74OJqAgFv7Vw@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: Notify all policy->cpus in
 cpufreq_notify_transition()
From: Viresh Kumar <viresh.kumar@linaro.org>
To: rjw@sisk.pl
Content-Type: text/plain; charset=ISO-8859-1
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

On 24 March 2013 19:18, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> policy->cpus contains all online cpus that have single shared clock line. And
> their frequencies are always updated together.
>
> Many SMP system's cpufreq drivers take care of this in individual drivers but
> the best place for this code is in cpufreq core.
>
> This patch modifies cpufreq_notify_transition() to notify frequency change for
> all cpus in policy->cpus and hence updates all users of this API.

Another fixup for tegra:

diff --git a/arch/arm/mach-tegra/cpu-tegra.c b/arch/arm/mach-tegra/cpu-tegra.c
index 3b441d6..11ca730 100644
--- a/arch/arm/mach-tegra/cpu-tegra.c
+++ b/arch/arm/mach-tegra/cpu-tegra.c
@@ -106,7 +106,8 @@ out:
        return ret;
 }

-static int tegra_update_cpu_speed(unsigned long rate)
+static int tegra_update_cpu_speed(struct cpufreq_policy *policy,
+               unsigned long rate)
 {
        int ret = 0;
        struct cpufreq_freqs freqs;
@@ -179,7 +180,7 @@ static int tegra_target(struct cpufreq_policy *policy,

        target_cpu_speed[policy->cpu] = freq;

-       ret = tegra_update_cpu_speed(tegra_cpu_highest_speed());
+       ret = tegra_update_cpu_speed(policy, tegra_cpu_highest_speed());

 out:
        mutex_unlock(&tegra_cpu_lock);
@@ -191,10 +192,12 @@ static int tegra_pm_notify(struct notifier_block
*nb, unsigned long event,
 {
        mutex_lock(&tegra_cpu_lock);
        if (event == PM_SUSPEND_PREPARE) {
+               struct cpufreq_policy *policy = cpufreq_cpu_get(0);
                is_suspended = true;
                pr_info("Tegra cpufreq suspend: setting frequency to %d kHz\n",
                        freq_table[0].frequency);
-               tegra_update_cpu_speed(freq_table[0].frequency);
+               tegra_update_cpu_speed(policy, freq_table[0].frequency);
+               cpufreq_cpu_put(policy);
        } else if (event == PM_POST_SUSPEND) {
                is_suspended = false;
        }
