Return-Path: <b.zolnierkie@samsung.com>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4BB312C0040
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Dec 2013 05:58:00 +1100 (EST)
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MY4000NZC7SAQC0@mailout4.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Sat, 21 Dec 2013 03:47:52 +0900 (KST)
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: rjw@rjwysocki.net
Subject: [PATCH v2 0/9] cpuidle: rework device state count handling
Date: Fri, 20 Dec 2013 19:47:22 +0100
Message-id: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 b.zolnierkie@samsung.com, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
 linuxppc-dev@lists.ozlabs.org, lenb@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Some cpuidle drivers assume that cpuidle core will handle cases where
device->state_count is smaller than driver->state_count, unfortunately
currently this is untrue (device->state_count is used only for handling
cpuidle state sysfs entries and driver->state_count is used for all
other cases) and will not be fixed in the future as device->state_count
is planned to be removed [1].

This patchset fixes such drivers (ARM EXYNOS cpuidle driver and ACPI
cpuidle driver), removes superflous device->state_count initialization
from drivers for which device->state_count equals driver->state_count
(POWERPC pseries cpuidle driver and intel_idle driver) and finally
removes state_count field from struct cpuidle_device.

Additionaly (while at it) this patchset fixes C1E promotion disable
quirk handling (in intel_idle driver) and converts cpuidle drivers code
to use the common cpuidle_[un]register() routines (in POWERPC pseries
cpuidle driver and intel_idle driver).

[1] http://permalink.gmane.org/gmane.linux.power-management.general/36908

Reference to v1:
	http://comments.gmane.org/gmane.linux.power-management.general/37390

Changes since v1:
- synced patch series with next-20131220
- added ACKs from Daniel Lezcano

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (9):
  ARM: EXYNOS: cpuidle: fix AFTR mode check
  POWERPC: pseries: cpuidle: remove superfluous dev->state_count
    initialization
  POWERPC: pseries: cpuidle: use the common cpuidle_[un]register()
    routines
  ACPI / cpuidle: fix max idle state handling with hotplug CPU support
  ACPI / cpuidle: remove dev->state_count setting
  intel_idle: do C1E promotion disable quirk for hotplugged CPUs
  intel_idle: remove superfluous dev->state_count initialization
  intel_idle: use the common cpuidle_[un]register() routines
  cpuidle: remove state_count field from struct cpuidle_device

 arch/arm/mach-exynos/cpuidle.c                  |   8 +-
 arch/powerpc/platforms/pseries/processor_idle.c |  59 +---------
 drivers/acpi/processor_idle.c                   |  29 +++--
 drivers/cpuidle/cpuidle.c                       |   3 -
 drivers/cpuidle/sysfs.c                         |   5 +-
 drivers/idle/intel_idle.c                       | 140 +++++-------------------
 include/linux/cpuidle.h                         |   1 -
 7 files changed, 51 insertions(+), 194 deletions(-)

-- 
1.8.2.3
