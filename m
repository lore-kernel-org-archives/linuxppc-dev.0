Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47F261A08B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 16:28:20 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 5 Jun 2015 00:28:18 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 30FF71FF001E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 00:19:26 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t556Q1928454398
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 23:26:01 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t556SFBF008384
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 00:28:15 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v14 19/19] perf,
 tools: Add README for info on parsing JSON/map files
Date: Thu,  4 Jun 2015 23:27:27 -0700
Message-Id: <1433485647-9314-20-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1433485647-9314-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1433485647-9314-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/pmu-events/README |  122 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 tools/perf/pmu-events/README

diff --git a/tools/perf/pmu-events/README b/tools/perf/pmu-events/README
new file mode 100644
index 0000000..da57cb5
--- /dev/null
+++ b/tools/perf/pmu-events/README
@@ -0,0 +1,122 @@
+
+The contents of this directory allow users to specify PMU events in
+their CPUs by their symbolic names rather than raw event codes (see
+example below).
+
+The main program in this directory, is the 'jevents', which is built and
+executed _before_ the perf binary itself is built.
+
+The 'jevents' program tries to locate and process JSON files in the directory
+tree tools/perf/pmu-events/arch/foo.
+
+	- Regular files with '.json' extension in the name are assumed to be
+	  JSON files, each of which describes a set of PMU events.
+
+	- Regular files with basename starting with 'mapfile.csv' are assumed
+	  to be a CSV file that maps a specific CPU to its set of PMU events.
+	  (see below for mapfile format)
+
+	- Directories are traversed, but all other files are ignored.
+
+Using the JSON files and the mapfile, 'jevents' generates the C source file,
+'pmu-events.c', which encodes the two sets of tables:
+
+	- Set of 'PMU events tables' for all known CPUs in the architecture,
+	  (one table like the following, per JSON file; table name 'pme_power8'
+	  is derived from JSON file name, 'power8.json').
+
+		struct pmu_event pme_power8[] = {
+
+			...
+
+			{
+				.name = "pm_1plus_ppc_cmpl",
+				.event = "event=0x100f2",
+				.desc = "1 or more ppc insts finished,",
+			},
+
+			...
+		}
+
+	- A 'mapping table' that maps each CPU of the architecture, to its
+	  'PMU events table'
+
+		struct pmu_events_map pmu_events_map[] = {
+		{
+			.cpuid = "004b0000",
+			.version = "1",
+			.type = "core",
+			.table = pme_power8
+		},
+			...
+
+		};
+
+After the 'pmu-events.c' is generated, it is compiled and the resulting
+'pmu-events.o' is added to 'libperf.a' which is then used to build perf.
+
+NOTES:
+	1. Several CPUs can support same set of events and hence use a common
+	   JSON file. Hence several entries in the pmu_events_map[] could map
+	   to a single 'PMU events table'.
+
+	2. The 'pmu-events.h' has an extern declaration for the mapping table
+	   and the generated 'pmu-events.c' defines this table.
+
+	3. _All_ known CPU tables for architecture are included in the perf
+	   binary.
+
+At run time, perf determines the actual CPU it is running on, finds the
+matching events table and builds aliases for those events. This allows
+users to specify events by their name:
+
+	$ perf stat -e pm_1plus_ppc_cmpl sleep 1
+
+where 'pm_1plus_ppc_cmpl' is a Power8 PMU event.
+
+In case of errors when processing files in the tools/perf/pmu-events/arch
+directory, 'jevents' tries to create an empty mapping file to allow the perf
+build to succeed even if the PMU event aliases cannot be used.
+
+However some errors in processing may cause the perf build to fail.
+
+Mapfile format
+===============
+
+The mapfile.csv format is expected to be:
+
+	Header line
+	CPUID,Version,File/path/name.json,Type
+
+where:
+
+	Comma:
+		is the required field delimiter (i.e other fields cannot
+		have commas within them).
+
+	Comments:
+		Lines in which the first character is either '\n' or '#'
+		are ignored.
+
+	Header line
+		The header line is the first line in the file, which is
+		_IGNORED_. It can be a comment (begin with '#') or empty.
+
+	CPUID:
+		CPUID is an arch-specific char string, that can be used
+		to identify CPU (and associate it with a set of PMU events
+		it supports). Multiple CPUIDS can point to the same
+		File/path/name.json.
+
+		Example:
+			CPUID == 'GenuineIntel-6-2E' (on x86).
+			CPUID == '004b0100' (PVR value in Powerpc)
+	Version:
+		is the Version of the mapfile.
+
+	File/path/name.json:
+		is the pathname for the JSON file, relative to the directory
+		containing the mapfile.csv
+
+	Type:
+		indicates whether the events or "core" or "uncore" events.
-- 
1.7.9.5
