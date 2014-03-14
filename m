Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 18/20] powerpc/perf: Add kconfig option for hypervisor
 provided counters
Date: Fri, 14 Mar 2014 16:00:43 +1100
Message-Id: <1394773245-18328-19-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1394773245-18328-1-git-send-email-mpe@ellerman.id.au>
References: <1394773245-18328-1-git-send-email-mpe@ellerman.id.au>
Cc: cody@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Cody P Schafer <cody@linux.vnet.ibm.com>

The commit adds a Kconfig option which allows the hv_gpci and hv_24x7
PMUs, added in the preceeding commits, to be built.

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/perf/Makefile             |  2 ++
 arch/powerpc/platforms/pseries/Kconfig | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
index 60d71ee..f9c083a 100644
--- a/arch/powerpc/perf/Makefile
+++ b/arch/powerpc/perf/Makefile
@@ -11,5 +11,7 @@ obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
 obj-$(CONFIG_FSL_EMB_PERF_EVENT) += core-fsl-emb.o
 obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o e6500-pmu.o
 
+obj-$(CONFIG_HV_PERF_CTRS) += hv-24x7.o hv-gpci.o hv-common.o
+
 obj-$(CONFIG_PPC64)		+= $(obj64-y)
 obj-$(CONFIG_PPC32)		+= $(obj32-y)
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 80b1d57..2cb8b77 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -111,6 +111,18 @@ config CMM
 	  will be reused for other LPARs. The interface allows firmware to
 	  balance memory across many LPARs.
 
+config HV_PERF_CTRS
+       bool "Hypervisor supplied PMU events (24x7 & GPCI)"
+       default y
+       depends on PERF_EVENTS && PPC_PSERIES
+       help
+	  Enable access to hypervisor supplied counters in perf. Currently,
+	  this enables code that uses the hcall GetPerfCounterInfo and 24x7
+	  interfaces to retrieve counters. GPCI exists on Power 6 and later
+	  systems. 24x7 is available on Power 8 systems.
+
+          If unsure, select Y.
+
 config DTL
 	bool "Dispatch Trace Log"
 	depends on PPC_SPLPAR && DEBUG_FS
-- 
1.8.3.2
