Return-Path: <geert@linux-m68k.org>
Received: from wilson.telenet-ops.be (wilson.telenet-ops.be [195.130.132.42])
 by lists.ozlabs.org (Postfix) with ESMTP id A00F11A01BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 23:08:27 +1100 (AEDT)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
 by wilson.telenet-ops.be (Postfix) with ESMTP id E7E3E35A11
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 12:56:23 +0100 (CET)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v2] cpufreq: ppc: Add missing #include <asm/smp.h>
Date: Wed,  4 Mar 2015 12:56:20 +0100
Message-Id: <1425470180-4650-1-git-send-email-geert+renesas@glider.be>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If CONFIG_SMP=n, <linux/smp.h> does not include <asm/smp.h>, causing:

drivers/cpufreq/ppc-corenet-cpufreq.c: In function 'corenet_cpufreq_cpu_init':
drivers/cpufreq/ppc-corenet-cpufreq.c:173:3: error: implicit declaration of function 'get_hard_smp_processor_id' [-Werror=implicit-function-declaration]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Seen with e.g. corenet64_smp_defconfig + CONFIG_CPU_FREQ=y,
CONFIG_PPC_CORENET_CPUFREQ=y, CONFIG_SMP=n

v2:
  - Add comment for #include directive, as requested by Viresh
---
 drivers/cpufreq/ppc-corenet-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
index bee5df7794d33d10..7cb4b766cf948d3f 100644
--- a/drivers/cpufreq/ppc-corenet-cpufreq.c
+++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
@@ -22,6 +22,8 @@
 #include <linux/smp.h>
 #include <sysdev/fsl_soc.h>
 
+#include <asm/smp.h>	/* for get_hard_smp_processor_id() in UP configs */
+
 /**
  * struct cpu_data - per CPU data struct
  * @parent: the parent node of cpu clock
-- 
1.9.1
