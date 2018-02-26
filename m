Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqVHb3SwFzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 16:09:30 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id v3so8666135plg.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 21:09:30 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>, bcm-kernel-feedback-list@broadcom.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 Markus Mayer <mmayer@broadcom.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
 linux-tegra@vger.kernel.org
Subject: [PATCH 00/27] cpufreq: Stop validating cpufreq table in drivers
Date: Mon, 26 Feb 2018 10:38:43 +0530
Message-Id: <cover.1519620578.git.viresh.kumar@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

A patchset [1] sent last week already updated the cpufreq core to start
validating cpufreq table if the policy contains a valid
"policy->freq_table" pointer.

This series updates all such drivers to stop validating the cpufreq
table directly and let only the core handle it.

It depends on the previous series [1] and two cleanup patches [2][3] and
is rebased over 4.16-rc3.

It is already tested by the 0-day testing infrastructure and no issues
were reported.

--
viresh

[1] https://lkml.kernel.org/r/bd8c6133ad0bdd56c936802bcf26878d7cbdb679.1519279148.git.viresh.kumar@linaro.org
[2] https://lkml.kernel.org/r/77d470741dab32c2076a35253b9c0c2f0136583b.1519293292.git.viresh.kumar@linaro.org
[3] https://lkml.kernel.org/r/6b737a9c285840b4b2036fa51b692ee835664ec8.1519358505.git.viresh.kumar@linaro.org

Viresh Kumar (27):
  cpufreq: imx6q: Find max freq from frequency table itself
  cpufreq: Don't validate cpufreq table from cpufreq_generic_init()
  cpufreq: acpi: Don't validate the frequency table twice
  cpufreq: arm_big_little: Don't validate the frequency table twice
  cpufreq: blackfin: Don't validate the frequency table twice
  cpufreq: brcmstb: Don't validate the frequency table twice
  cpufreq: cpufreq-dt: Don't validate the frequency table twice
  cpufreq: e_powersaver: Don't validate the frequency table twice
  cpufreq: elanfreq: Don't validate the frequency table twice
  cpufreq: ia64-acpi: Don't validate the frequency table twice
  cpufreq: longhaul: Don't validate the frequency table twice
  cpufreq: mediatek: Don't validate the frequency table twice
  cpufreq: p4-clockmod: Don't validate the frequency table twice
  cpufreq: powernow: Don't validate the frequency table twice
  cpufreq: powerenv: Don't validate the frequency table twice
  cpufreq: ppc_cbe: Don't validate the frequency table twice
  cpufreq: pxa: Don't validate the frequency table twice
  cpufreq: qoirq: Don't validate the frequency table twice
  cpufreq: s3c24xx: Don't validate the frequency table twice
  cpufreq: sc520: Don't validate the frequency table twice
  cpufreq: scpi: Don't validate the frequency table twice
  cpufreq: sfi: Don't validate the frequency table twice
  cpufreq: sh: Don't validate the frequency table twice
  cpufreq: sparc: Don't validate the frequency table twice
  cpufreq: speedstep: Don't validate the frequency table twice
  cpufreq: tegra186: Don't validate the frequency table twice
  cpufreq: Drop cpufreq_table_validate_and_show()

 Documentation/cpu-freq/core.txt        | 12 +++++-------
 Documentation/cpu-freq/cpu-drivers.txt |  6 ++----
 drivers/cpufreq/acpi-cpufreq.c         | 20 +++++++++++---------
 drivers/cpufreq/arm_big_little.c       |  9 +--------
 drivers/cpufreq/blackfin-cpufreq.c     |  3 ++-
 drivers/cpufreq/brcmstb-avs-cpufreq.c  |  6 +-----
 drivers/cpufreq/cpufreq-dt.c           |  8 +-------
 drivers/cpufreq/cpufreq.c              |  9 +--------
 drivers/cpufreq/e_powersaver.c         |  8 +-------
 drivers/cpufreq/elanfreq.c             |  3 ++-
 drivers/cpufreq/freq_table.c           | 14 --------------
 drivers/cpufreq/ia64-acpi-cpufreq.c    |  7 +------
 drivers/cpufreq/imx6q-cpufreq.c        |  7 ++++---
 drivers/cpufreq/longhaul.c             |  3 ++-
 drivers/cpufreq/mediatek-cpufreq.c     | 11 +----------
 drivers/cpufreq/p4-clockmod.c          |  3 ++-
 drivers/cpufreq/powernow-k6.c          |  3 ++-
 drivers/cpufreq/powernow-k7.c          |  3 ++-
 drivers/cpufreq/powernow-k8.c          | 10 +---------
 drivers/cpufreq/powernv-cpufreq.c      | 11 +++--------
 drivers/cpufreq/ppc_cbe_cpufreq.c      |  5 ++---
 drivers/cpufreq/pxa2xx-cpufreq.c       |  4 ++--
 drivers/cpufreq/pxa3xx-cpufreq.c       |  4 +++-
 drivers/cpufreq/qoriq-cpufreq.c        | 13 ++-----------
 drivers/cpufreq/s3c24xx-cpufreq.c      |  5 +----
 drivers/cpufreq/sc520_freq.c           |  3 ++-
 drivers/cpufreq/scpi-cpufreq.c         | 10 +---------
 drivers/cpufreq/sfi-cpufreq.c          |  3 ++-
 drivers/cpufreq/sh-cpufreq.c           | 22 ++++++++++++----------
 drivers/cpufreq/sparc-us2e-cpufreq.c   |  3 ++-
 drivers/cpufreq/sparc-us3-cpufreq.c    |  3 ++-
 drivers/cpufreq/speedstep-centrino.c   |  4 ++--
 drivers/cpufreq/speedstep-ich.c        |  4 +++-
 drivers/cpufreq/speedstep-smi.c        |  4 +++-
 drivers/cpufreq/tegra186-cpufreq.c     |  2 +-
 include/linux/cpufreq.h                |  2 --
 36 files changed, 85 insertions(+), 162 deletions(-)

-- 
2.15.0.194.g9af6a3dea062
