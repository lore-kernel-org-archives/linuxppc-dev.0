Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.19.201])
 by lists.ozlabs.org (Postfix) with ESMTP id C9FA41A02C3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 07:53:11 +1100 (EST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 02/15] perf Documentation: sysfs events/ interfaces
Date: Wed, 15 Oct 2014 17:52:35 -0300
Message-Id: <1413406368-26245-3-git-send-email-acme@kernel.org>
In-Reply-To: <1413406368-26245-1-git-send-email-acme@kernel.org>
References: <1413406368-26245-1-git-send-email-acme@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, Michael Ellerman <michaele@au1.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Cody P Schafer <dev@codyps.com>,
 Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Cody P Schafer <dev@codyps.com>

Add documentation for the <event>, <event>.scale, and <event>.unit
files in sysfs.

	<event>.scale and <event>.unit were undocumented.
	<event> was previously documented only for specific powerpc pmu events.

Signed-off-by: Cody P Schafer <dev@codyps.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Cody P Schafer <dev@codyps.com>
Cc: Haren Myneni <hbabu@us.ibm.com>
Cc: Haren Myneni <hbabu@us.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1412143402-26061-4-git-send-email-sukadev@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../testing/sysfs-bus-event_source-devices-events  | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
index 7b40a3cbc26a..a5226f094159 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -599,3 +599,63 @@ Description:	POWER-systems specific performance monitoring events
 		Further, multiple terms like 'event=0xNNNN' can be specified
 		and separated with comma. All available terms are defined in
 		the /sys/bus/event_source/devices/<dev>/format file.
+
+What: /sys/bus/event_source/devices/<pmu>/events/<event>
+Date: 2014/02/24
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Per-pmu performance monitoring events specific to the running system
+
+		Each file (except for some of those with a '.' in them, '.unit'
+		and '.scale') in the 'events' directory describes a single
+		performance monitoring event supported by the <pmu>. The name
+		of the file is the name of the event.
+
+		File contents:
+
+			<term>[=<value>][,<term>[=<value>]]...
+
+		Where <term> is one of the terms listed under
+		/sys/bus/event_source/devices/<pmu>/format/ and <value> is
+		a number is base-16 format with a '0x' prefix (lowercase only).
+		If a <term> is specified alone (without an assigned value), it
+		is implied that 0x1 is assigned to that <term>.
+
+		Examples (each of these lines would be in a seperate file):
+
+			event=0x2abc
+			event=0x423,inv,cmask=0x3
+			domain=0x1,offset=0x8,starting_index=0xffff
+
+		Each of the assignments indicates a value to be assigned to a
+		particular set of bits (as defined by the format file
+		corresponding to the <term>) in the perf_event structure passed
+		to the perf_open syscall.
+
+What: /sys/bus/event_source/devices/<pmu>/events/<event>.unit
+Date: 2014/02/24
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Perf event units
+
+		A string specifying the English plural numerical unit that <event>
+		(once multiplied by <event>.scale) represents.
+
+		Example:
+
+			Joules
+
+What: /sys/bus/event_source/devices/<pmu>/events/<event>.scale
+Date: 2014/02/24
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Perf event scaling factors
+
+		A string representing a floating point value expressed in
+		scientific notation to be multiplied by the event count
+		recieved from the kernel to match the unit specified in the
+		<event>.unit file.
+
+		Example:
+
+			2.3283064365386962890625e-10
+
+		This is provided to avoid performing floating point arithmetic
+		in the kernel.
-- 
1.9.3
