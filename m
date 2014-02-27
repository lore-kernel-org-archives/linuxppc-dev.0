Return-Path: <cody@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D57A72C0341
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2014 08:33:05 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Thu, 27 Feb 2014 16:33:03 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B3430C90041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 16:32:56 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1RLWxdQ10027428
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 21:32:59 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1RLWvJq004265
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 16:32:59 -0500
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 Cody P Schafer <cody@linux.vnet.ibm.com>
Subject: [PATCH v3 11/11] powerpc/perf/hv_{gpci,
 24x7}: add documentation of device attributes
Date: Thu, 27 Feb 2014 13:05:04 -0800
Message-Id: <1393535105-7528-12-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1393535105-7528-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1393535105-7528-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Michael Ellerman <michael@ellerman.id.au>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, scottwood@freescale.com
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
1.9.0
