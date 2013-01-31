Return-Path: <BATV+6a08737156a33091b2c0+3448+infradead.org+acme@merlin.srs.infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 234FF2C02F7
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2013 04:25:47 +1100 (EST)
From: Arnaldo Carvalho de Melo <acme@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 25/25] perf: Document the ABI of perf sysfs entries
Date: Thu, 31 Jan 2013 14:25:28 -0300
Message-Id: <1359653128-10433-26-git-send-email-acme@infradead.org>
In-Reply-To: <1359653128-10433-1-git-send-email-acme@infradead.org>
References: <1359653128-10433-1-git-send-email-acme@infradead.org>
Content-Type: text/plain; charset="utf-8"
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Robert Richter <robert.richter@amd.com>, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linuxppc-dev@ozlabs.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

This patchset addes two new sets of files to sysfs for POWER architecture.

	- perf event config format in /sys/devices/cpu/format/event
	- generic and POWER-specific perf events in /sys/devices/cpu/events/

The format of the first file is already documented in:

	sysfs-bus-event_source-devices-format

Document the format of the second set of files '/sys/devices/cpu/events/*'
which would also become part of the ABI.

Changelog[v4]:
	[Jiri Olsa]: Mention that multiple event= like terms can be specified
	in the 'events' file.
	[Jiri Olsa]: Remove the documentation for the 'config format' file
	as it is already documented in 'Documentation/ABI/testing/'.
	[Jiri Olsa]: Move ABI documentation from 'stable/' to 'testing/'

Changelog[v3]:
	[Greg KH] Include ABI documentation.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Anton Blanchard <anton@au1.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Robert Richter <robert.richter@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: linuxppc-dev@ozlabs.org
Link: http://lkml.kernel.org/r/20130123062645.GG13720@us.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 Documentation/ABI/stable/sysfs-devices-cpu-events  |  0
 .../testing/sysfs-bus-event_source-devices-events  | 62 ++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 delete mode 100644 Documentation/ABI/stable/sysfs-devices-cpu-events
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-events

diff --git a/Documentation/ABI/stable/sysfs-devices-cpu-events b/Documentation/ABI/stable/sysfs-devices-cpu-events
deleted file mode 100644
index e69de29..0000000
diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
new file mode 100644
index 0000000..0adeb52
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -0,0 +1,62 @@
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
+		where 'N' is a hex digit and the number '0xNNNN' shows the
+		"raw code" for the perf event identified by the file's
+		"basename".
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
+Description:	POWER-systems specific performance monitoring events
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
+		where 'N' is a hex digit and the number '0xNNNN' shows the
+		"raw code" for the perf event identified by the file's
+		"basename".
+
+		Further, multiple terms like 'event=0xNNNN' can be specified
+		and separated with comma. All available terms are defined in
+		the /sys/bus/event_source/devices/<dev>/format file.
-- 
1.8.1.1.361.gec3ae6e
