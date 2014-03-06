Return-Path: <cody@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7A0942C032A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Mar 2014 11:03:04 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Wed, 5 Mar 2014 17:03:02 -0700
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id E426DC9003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 19:02:56 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s26030mW5636504
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Mar 2014 00:03:00 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2602wBt002640
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 19:02:59 -0500
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Cody P Schafer <cody@linux.vnet.ibm.com>,
 Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 Gavin Shan <shangw@linux.vnet.ibm.com>,
 Lijun Pan <Lijun.Pan@freescale.com>, Li Zhong <zhong@linux.vnet.ibm.com>,
 Michael Ellerman <michael@ellerman.id.au>, Paul Bolle <pebolle@tiscali.nl>,
 Priyanka Jain <Priyanka.Jain@freescale.com>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v4 10/11] powerpc/perf: add kconfig option for hypervisor
 provided counters
Date: Wed,  5 Mar 2014 16:01:09 -0800
Message-Id: <1394064082-6242-11-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1394064082-6242-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1394064082-6242-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
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
1.9.0
