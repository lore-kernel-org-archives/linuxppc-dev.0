Return-Path: <dev@codyps.com>
Received: from mail-yk0-x22d.google.com (mail-yk0-x22d.google.com
 [IPv6:2607:f8b0:4002:c07::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E27AF1A0591
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 10:27:37 +1000 (EST)
Received: by mail-yk0-f173.google.com with SMTP id 142so7772266ykq.32
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 17:27:34 -0700 (PDT)
From: Cody P Schafer <dev@codyps.com>
To: LKML <linux-kernel@vger.kernel.org>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Cody P Schafer <dev@codyps.com>, Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@redhat.com>, Michael Ellerman <michael@ellerman.id.au>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 09/16] tools/perf: document parameterized events and note
 symbolically formed events
Date: Tue, 27 May 2014 17:22:04 -0700
Message-Id: <1401236684-10579-10-git-send-email-dev@codyps.com>
In-Reply-To: <1401236684-10579-1-git-send-email-dev@codyps.com>
References: <1401236684-10579-1-git-send-email-dev@codyps.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CC: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Cody P Schafer <dev@codyps.com>
---
 tools/perf/Documentation/perf-list.txt   | 13 +++++++++++++
 tools/perf/Documentation/perf-record.txt |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 6fce6a6..626818b 100644
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
+This means that when provided as an event, a value for phys_processor_idx must
+also be supplied. For example:
+
+  perf stat -e 'hv_gpci/dtbp_ptitc,phys_processor_idx=0x2/' ...
+
 OPTIONS
 -------
 
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index c71b0f3..c005180 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -33,6 +33,11 @@ OPTIONS
         - a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
 	  hexadecimal event descriptor.
 
+	- a symbolicly formed PMU event like 'pmu/value1=0x3,value2/' where
+	  'value1' and 'value2' are defined as formats in
+	  /sys/bus/event_sources/devices/pmu/format/* OR are one of 'config',
+	  'config1', 'config2'.
+
         - a hardware breakpoint event in the form of '\mem:addr[:access]'
           where addr is the address in memory you want to break in.
           Access is the memory access type (read, write, execute) it can
-- 
1.9.3
