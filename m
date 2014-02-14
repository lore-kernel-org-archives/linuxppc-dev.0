Return-Path: <cody@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 602E82C044D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Feb 2014 09:03:57 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Fri, 14 Feb 2014 17:03:54 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id C16056E803A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 17:03:48 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1EM3rWe5177618
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 22:03:53 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1EM3qt4032530
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 17:03:52 -0500
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 Cody P Schafer <cody@linux.vnet.ibm.com>
Subject: [PATCH v2 11/11] powerpc/perf/hv_{gpci,
 24x7}: add documentation of device attributes
Date: Fri, 14 Feb 2014 14:02:15 -0800
Message-Id: <1392415338-16288-12-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1392415338-16288-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1392415338-16288-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Rob Landley <rob@landley.net>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Michael Ellerman <michael@ellerman.id.au>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

gpci and 24x7 expose some device specific attributes. Add some
documentation for them.

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 .../testing/sysfs-bus-event_source-devices-hv_24x7 | 22 +++++++++++
 .../testing/sysfs-bus-event_source-devices-hv_gpci | 43 ++++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7 b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
new file mode 100644
index 0000000..13474d3
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
@@ -0,0 +1,22 @@
+What:		/sys/bus/event_source/devices/hv_24x7/interface/catalog
+Date:		February 2014
+Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Description:
+		Provides access to the binary "24x7 catalog" provided by the
+		hypervisor on POWER7 and 8 systems. This catalog lists events
+		avaliable from the powerpc "hv_24x7" pmu. Its format is
+		documented in arch/powerpc/perf/hv_24x7.h.
+
+What:		/sys/bus/event_source/devices/hv_24x7/interface/catalog_length
+Date:		February 2014
+Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Description:
+		A number equal to the length in bytes of the catalog. This is
+		also extractable from the provided binary "catalog" sysfs entry.
+
+What:		/sys/bus/event_source/devices/hv_24x7/interface/catalog_version
+Date:		February 2014
+Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Description:
+		Exposes the "version" field of the 24x7 catalog. This is also
+		extractable from the provided binary "catalog" sysfs entry.
diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci
new file mode 100644
index 0000000..3fa58c2
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci
@@ -0,0 +1,43 @@
+What:		/sys/bus/event_source/devices/hv_gpci/interface/collect_privileged
+Date:		February 2014
+Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Description:
+		'0' if the hypervisor is configured to forbid access to event
+		counters being accumulated by other guests and to physical
+		domain event counters.
+		'1' if that access is allowed.
+
+What:		/sys/bus/event_source/devices/hv_gpci/interface/ga
+Date:		February 2014
+Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Description:
+		0 or 1. Indicates whether we have access to "GA" events (listed
+		in arch/powerpc/perf/hv-gpci.h).
+
+What:		/sys/bus/event_source/devices/hv_gpci/interface/expanded
+Date:		February 2014
+Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Description:
+		0 or 1. Indicates whether we have access to "EXPANDED" events (listed
+		in arch/powerpc/perf/hv-gpci.h).
+
+What:		/sys/bus/event_source/devices/hv_gpci/interface/lab
+Date:		February 2014
+Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Description:
+		0 or 1. Indicates whether we have access to "LAB" events (listed
+		in arch/powerpc/perf/hv-gpci.h).
+
+What:		/sys/bus/event_source/devices/hv_gpci/interface/version
+Date:		February 2014
+Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Description:
+		A number indicating the version of the gpci interface that the
+		hypervisor reports supporting.
+
+What:		/sys/bus/event_source/devices/hv_gpci/interface/kernel_version
+Date:		February 2014
+Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Description:
+		A number indicating the latest version of the gpci interface
+		that the kernel is aware of.
-- 
1.8.5.4
