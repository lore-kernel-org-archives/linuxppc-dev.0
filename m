Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5BBDC1A0CCD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 18:50:07 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 22 Dec 2014 02:50:05 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 0E37838C8046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 02:50:02 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBM7o2pF22282300
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 07:50:02 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBM7o0xA024258
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 02:50:01 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH v6 4/4] tools/perf: Document parameterized and symbolic events
Date: Sun, 21 Dec 2014 23:49:27 -0800
Message-Id: <1419234567-22784-5-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1419234567-22784-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1419234567-22784-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, linuxppc-dev@lists.ozlabs.org, dev@codyps.com,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Cody P Schafer <cody@linux.vnet.ibm.com>

Changelog[v6]:
	- [Sukadev Bhattiprolu]: Update documentation of perf-list and
	  perf-record; Added documentation for perf-stat.

CC: Haren Myneni <hbabu@us.ibm.com>
CC: Cody P Schafer <dev@codyps.com>
Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/Documentation/perf-list.txt   | 13 +++++++++++++
 tools/perf/Documentation/perf-record.txt | 12 ++++++++++++
 tools/perf/Documentation/perf-stat.txt   | 20 ++++++++++++++++----
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index cbb4f74..d8be6fa 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -89,6 +89,19 @@ raw encoding of 0x1A8 can be used:
 You should refer to the processor specific documentation for getting these
 details. Some of them are referenced in the SEE ALSO section below.
 
+PARAMETERIZED EVENTS
+--------------------
+
+Some pmu events listed by 'perf-list' will be displayed with '$x' in them. For
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
index af9a54e..acdcf3b 100644
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
+	  /sys/bus/event_sources/devices/<pmu>/format/*
+
         - a hardware breakpoint event in the form of '\mem:addr[:access]'
           where addr is the address in memory you want to break in.
           Access is the memory access type (read, write, execute) it can
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 29ee857..04e150d 100644
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
1.8.3.1
