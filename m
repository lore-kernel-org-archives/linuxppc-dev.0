Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 89C361A1A4A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 17:26:40 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 15 Aug 2014 03:26:38 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 194856E801A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 03:26:25 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7F7QZYW10027374
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 07:26:35 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7F7QY6I027368
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 03:26:35 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, ak@linux.intel.com,
 Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org, eranian@google.com
Subject: [PATCH v2 08/14] tools/perf: document parameterized events and note
 symbolically formed events
Date: Fri, 15 Aug 2014 00:26:17 -0700
Message-Id: <1408087583-32239-9-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1408087583-32239-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1408087583-32239-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dev@codyps.com, linux-kernel@vger.kernel.org,
 Michael Ellerman <michaele@au1.ibm.com>,
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

CC: Haren Myneni <hbabu@us.ibm.com>
CC: Cody P Schafer <dev@codyps.com>
Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
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
index d460049..664f852 100644
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
1.8.3.1
