Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id BDD051A0CE1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 04:48:23 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 11/26] perf tools: Document parameterized and symbolic events
Date: Mon, 26 Jan 2015 14:47:14 -0300
Message-Id: <1422294449-12735-12-git-send-email-acme@kernel.org>
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

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Cody P Schafer <dev@codyps.com>
Cc: Haren Myneni <hbabu@us.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1420679633-28856-5-git-send-email-sukadev@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-list.txt   | 13 +++++++++++++
 tools/perf/Documentation/perf-record.txt | 12 ++++++++++++
 tools/perf/Documentation/perf-stat.txt   | 20 ++++++++++++++++----
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index cbb4f743d921..3e2aec94f806 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -89,6 +89,19 @@ raw encoding of 0x1A8 can be used:
 You should refer to the processor specific documentation for getting these
 details. Some of them are referenced in the SEE ALSO section below.
 
+PARAMETERIZED EVENTS
+--------------------
+
+Some pmu events listed by 'perf-list' will be displayed with '?' in them. For
+example:
+
+  hv_gpci/dtbp_ptitc,phys_processor_idx=?/
+
+This means that when provided as an event, a value for '?' must
+also be supplied. For example:
+
+  perf stat -C 0 -e 'hv_gpci/dtbp_ptitc,phys_processor_idx=0x2/' ...
+
 OPTIONS
 -------
 
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index af9a54ece024..7d8df2e5edd8 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -33,6 +33,18 @@ OPTIONS
         - a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
 	  hexadecimal event descriptor.
 
+	- a symbolically formed PMU event like 'pmu/param1=0x3,param2/' where
+	  'param1', 'param2', etc are defined as formats for the PMU in
+	  /sys/bus/event_sources/devices/<pmu>/format/*.
+
+	- a symbolically formed event like 'pmu/config=M,config1=N,config3=K/'
+
+          where M, N, K are numbers (in decimal, hex, octal format). Acceptable
+          values for each of 'config', 'config1' and 'config2' are defined by
+          corresponding entries in /sys/bus/event_sources/devices/<pmu>/format/*
+          param1 and param2 are defined as formats for the PMU in:
+          /sys/bus/event_sources/devices/<pmu>/format/*
+
         - a hardware breakpoint event in the form of '\mem:addr[:access]'
           where addr is the address in memory you want to break in.
           Access is the memory access type (read, write, execute) it can
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 29ee857c09c6..04e150d83e7d 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -25,10 +25,22 @@ OPTIONS
 
 -e::
 --event=::
-	Select the PMU event. Selection can be a symbolic event name
-	(use 'perf list' to list all events) or a raw PMU
-	event (eventsel+umask) in the form of rNNN where NNN is a
-	 hexadecimal event descriptor.
+	Select the PMU event. Selection can be:
+
+	- a symbolic event name (use 'perf list' to list all events)
+
+	- a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
+	  hexadecimal event descriptor.
+
+	- a symbolically formed event like 'pmu/param1=0x3,param2/' where
+	  param1 and param2 are defined as formats for the PMU in
+	  /sys/bus/event_sources/devices/<pmu>/format/*
+
+	- a symbolically formed event like 'pmu/config=M,config1=N,config2=K/'
+	  where M, N, K are numbers (in decimal, hex, octal format).
+	  Acceptable values for each of 'config', 'config1' and 'config2'
+	  parameters are defined by corresponding entries in
+	  /sys/bus/event_sources/devices/<pmu>/format/*
 
 -i::
 --no-inherit::
-- 
1.9.3
