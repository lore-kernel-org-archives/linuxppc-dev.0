Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id AEDDB1A0C48
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 04:48:19 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 10/26] perf Documentation: Add event parameters
Date: Mon, 26 Jan 2015 14:47:13 -0300
Message-Id: <1422294449-12735-11-git-send-email-acme@kernel.org>
In-Reply-To: <1422294449-12735-1-git-send-email-acme@kernel.org>
References: <1422294449-12735-1-git-send-email-acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Cody P Schafer <cody@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Cody P Schafer <dev@codyps.com>, Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Cody P Schafer <cody@linux.vnet.ibm.com>

Event parameters are a basic way for partial events to be specified in
sysfs with per-event names given to the fields that need to be filled in
when using a particular event.

It is intended for supporting cases where the single 'cpu' parameter is
insufficient. For example, POWER 8 has events for physical
sockets/cores/cpus that are accessible from with virtual machines. To
keep using the single 'cpu' parameter we'd need to perform a mapping
between Linux's cpus and the physical machine's cpus (in this case Linux
is running under a hypervisor). This isn't possible because bindings
between our cpus and physical cpus may not be fixed, and we probably
won't have a "cpu" on each physical cpu.

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Cody P Schafer <dev@codyps.com>
Cc: Haren Myneni <hbabu@us.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1420679633-28856-4-git-send-email-sukadev@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 Documentation/ABI/testing/sysfs-bus-event_source-devices-events | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
index 20979f8b3edb..505f080d20a1 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -52,12 +52,18 @@ Description:	Per-pmu performance monitoring events specific to the running syste
 			event=0x2abc
 			event=0x423,inv,cmask=0x3
 			domain=0x1,offset=0x8,starting_index=0xffff
+			domain=0x1,offset=0x8,core=?
 
 		Each of the assignments indicates a value to be assigned to a
 		particular set of bits (as defined by the format file
 		corresponding to the <term>) in the perf_event structure passed
 		to the perf_open syscall.
 
+		In the case of the last example, a value replacing "?" would
+		need to be provided by the user selecting the particular event.
+		This is referred to as "event parameterization". Event
+		parameters have the format 'param=?'.
+
 What: /sys/bus/event_source/devices/<pmu>/events/<event>.unit
 Date: 2014/02/24
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
-- 
1.9.3
