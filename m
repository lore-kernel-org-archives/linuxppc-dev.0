Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B6F632C07C8
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2013 17:26:55 +1100 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 22 Jan 2013 23:26:53 -0700
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 135CA3E40039
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2013 23:26:45 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0N6QoKZ215186
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2013 23:26:51 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0N6Qlcp004472
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2013 23:26:50 -0700
Date: Tue, 22 Jan 2013 22:26:45 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>,
 Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 6/6][v4]: perf: Document the ABI of perf sysfs entries
Message-ID: <20130123062645.GG13720@us.ibm.com>
References: <20130123062201.GA13720@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130123062201.GA13720@us.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>, robert.richter@amd.com,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


[PATCH 6/6][v4]: perf: Document the ABI of perf sysfs entries

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
---
 .../testing/sysfs-bus-event_source-devices-events  |   62 ++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)
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
1.7.1
