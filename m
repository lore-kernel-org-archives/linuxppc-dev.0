Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3320D2C02BC
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2013 11:06:26 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 9 Jan 2013 19:06:25 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id CCF8B38C803B
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2013 19:06:20 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0A06KgO324936
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2013 19:06:20 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0A06H57016868
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2013 19:06:20 -0500
From: sukadev@linux.vnet.ibm.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 6/6][v3] perf: Document the ABI of perf sysfs entries
Date: Wed,  9 Jan 2013 16:06:20 -0800
Message-Id: <1357776380-31712-6-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1357776380-31712-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1357776380-31712-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: robert.richter@amd.com, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@au1.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset addes two new sets of files to sysfs:

	- generic and POWER-specific perf events in /sys/devices/cpu/events/
	- perf event config format in /sys/devices/cpu/format/event

Document the format of these files which would become part of the ABI.

Changelog[v3]:
	[Greg KH] Include ABI documentation.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 Documentation/ABI/stable/sysfs-devices-cpu-events |   54 +++++++++++++++++++++
 Documentation/ABI/stable/sysfs-devices-cpu-format |   27 ++++++++++
 2 files changed, 81 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-devices-cpu-format

diff --git a/Documentation/ABI/stable/sysfs-devices-cpu-events b/Documentation/ABI/stable/sysfs-devices-cpu-events
index e69de29..f37d542 100644
--- a/Documentation/ABI/stable/sysfs-devices-cpu-events
+++ b/Documentation/ABI/stable/sysfs-devices-cpu-events
@@ -0,0 +1,54 @@
+What:		/sys/devices/cpu/events/
+		/sys/devices/cpu/events/branch-misses
+		/sys/devices/cpu/events/cache-references
+		/sys/devices/cpu/events/cache-misses
+		/sys/devices/cpu/events/stalled-cycles-frontend
+		/sys/devices/cpu/events/branch-instructions
+		/sys/devices/cpu/events/stalled-cycles-backend
+		/sys/devices/cpu/events/instructions
+		/sys/devices/cpu/events/cpu-cycles
+
+Date:		2013/01/08
+
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+
+Description:	Generic performance monitoring events
+
+		A collection of performance monitoring events that may be
+		supported by many/most CPUs. These events can be monitored
+		using the 'perf(1)' tool.
+
+		The contents of each file would look like:
+
+			event=0xNNNN
+
+		where 'N' is a hex digit.
+
+
+What: 		/sys/devices/cpu/events/PM_LD_MISS_L1
+		/sys/devices/cpu/events/PM_LD_REF_L1
+		/sys/devices/cpu/events/PM_CYC
+		/sys/devices/cpu/events/PM_BRU_FIN
+		/sys/devices/cpu/events/PM_GCT_NOSLOT_CYC
+		/sys/devices/cpu/events/PM_BRU_MPRED
+		/sys/devices/cpu/events/PM_INST_CMPL
+		/sys/devices/cpu/events/PM_CMPLU_STALL
+
+Date:		2013/01/08
+
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+		Linux Powerpc mailing list <linuxppc-dev@ozlabs.org>
+
+Description:	POWER specific performance monitoring events
+
+		A collection of performance monitoring events that may be
+		supported by the POWER CPU. These events can be monitored
+		using the 'perf(1)' tool.
+
+		These events may not be supported by other CPUs.
+
+		The contents of each file would look like:
+
+			event=0xNNNN
+
+		where 'N' is a hex digit.
diff --git a/Documentation/ABI/stable/sysfs-devices-cpu-format b/Documentation/ABI/stable/sysfs-devices-cpu-format
new file mode 100644
index 0000000..b15cfb2
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-devices-cpu-format
@@ -0,0 +1,27 @@
+What:		/sys/devices/cpu/format/
+		/sys/devices/cpu/format/event
+
+Date:		2013/01/08
+
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+
+Description:	Format of performance monitoring events
+
+		Each CPU/architecture may use different format to represent
+		the perf event.  The 'event' file describes the configuration
+		format of the performance monitoring event on the CPU/system.
+
+		The contents of each file would look like:
+
+			config:m-n
+
+		where m and n are the starting and ending bits that are
+		used to represent the event.
+
+		For example, on POWER,
+
+			$ cat /sys/devices/cpu/format/event
+			config:0-20
+
+		meaning that POWER uses the first 20-bits to represent a perf
+		event.
-- 
1.7.1
