Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 19/20] powerpc/perf/hv_{gpci,
 24x7}: Add documentation of device attributes
Date: Fri, 14 Mar 2014 16:00:44 +1100
Message-Id: <1394773245-18328-20-git-send-email-mpe@ellerman.id.au>
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

gpci and 24x7 expose some device specific attributes. Add some
documentation for them.

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 .../testing/sysfs-bus-event_source-devices-hv_24x7 | 23 ++++++++++++
 .../testing/sysfs-bus-event_source-devices-hv_gpci | 43 ++++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7 b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
new file mode 100644
index 0000000..e78ee79
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
@@ -0,0 +1,23 @@
+What:		/sys/bus/event_source/devices/hv_24x7/interface/catalog
+Date:		February 2014
+Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Description:
+		Provides access to the binary "24x7 catalog" provided by the
+		hypervisor on POWER7 and 8 systems. This catalog lists events
+		avaliable from the powerpc "hv_24x7" pmu. Its format is
+		documented here:
+		https://raw.githubusercontent.com/jmesmon/catalog-24x7/master/hv-24x7-catalog.h
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
1.8.3.2
