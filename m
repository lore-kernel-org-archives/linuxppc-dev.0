Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03FF41A0C58
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 06:46:01 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 22 Dec 2014 12:45:59 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 179941FF001B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 12:34:42 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBMJjvcX50200610
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 12:45:57 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBMJjvJL015470
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 12:45:57 -0700
Date: Mon, 22 Dec 2014 11:45:27 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v6 4/4] tools/perf: Document parameterized and symbolic
 events
Message-ID: <20141222194527.GA23294@us.ibm.com>
References: <1419234567-22784-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1419234567-22784-5-git-send-email-sukadev@linux.vnet.ibm.com>
 <20141222144315.GC29096@krava.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141222144315.GC29096@krava.brq.redhat.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, dev@codyps.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jiri Olsa [jolsa@redhat.com] wrote:

| > +          values for each of 'config', 'config1' and 'config2' are defined by
| > +          corresponding entries in /sys/bus/event_sources/devices/<pmu>/format/*
| > +          param1 and param2 are defined as formats for the PMU in:
| > +	  /sys/bus/event_sources/devices/<pmu>/format/*
| 
|    ^^^^ misaligned tab

Thanks, Fixed the typos and alignment below.
---
>From 1fdb5012081903172c11a41f9edb0d51525ba500 Mon Sep 17 00:00:00 2001
From: Cody P Schafer <cody@linux.vnet.ibm.com>
Date: Wed, 24 Sep 2014 12:27:23 -0700
Subject: [PATCH v6 4/4] tools/perf: Document parameterized and symbolic events

Changelog[v6]:
	- [Sukadev Bhattiprolu]: Update documentation of perf-list and
	  perf-record; Added documentation for perf-stat.
	- [Jiri Olsa] Fix some typos/formatting

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
index cbb4f74..3e2aec9 100644
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
index af9a54e..7d8df2e 100644
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
