Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B99A1A0D27
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 03:13:10 +1000 (AEST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 2 Jun 2015 11:13:08 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 25E653E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 11:13:06 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t52HD64L33292488
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 10:13:06 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t52HD5Gh026837
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 11:13:05 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 14/14] perf,
 tools: Add README for the JSON/map files parsing
Date: Tue,  2 Jun 2015 10:12:14 -0700
Message-Id: <1433265135-20426-15-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
 tools/perf/pmu-events/README |  115 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 tools/perf/pmu-events/README

diff --git a/tools/perf/pmu-events/README b/tools/perf/pmu-events/README
new file mode 100644
index 0000000..00fd2e1
--- /dev/null
+++ b/tools/perf/pmu-events/README
@@ -0,0 +1,115 @@
+The contents of this directory allows users to specify PMU events in
+their CPUs by their symbolic names rather than raw event codes (see
+example below).
+
+The main program in this directory, is the 'jevents', which is built and
+executed _before_ the perf binary itself is built.
+
+The 'jevents' program tries to locate and process JSON files in the directory
+tree tools/perf/pmu-events/arch/xxx.
+
+	- Regular files with '.json' extension in the name are assumed to be
+	  JSON files.
+
+	- Regular files with base name starting with 'mapfile.csv' are assumed
+	  to be a CSV file that - maps a specific CPU to its set of PMU events.
+
+Directories are traversed, but all other files are ignored.
+
+Using the JSON files and the mapfile, 'jevents' generates a C source file,
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
+		{
+			...
+		},
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
+directory, 'jevents' tries to create an empty mapping file to allow perf
+build to succeed even if the PMU event aliases cannot be used.
+
+However some errors in processing may cause the perf build to fail.
+
+The mapfile format is expected to be:
+
+	Header line
+	CPUID,Version,JSON/file/path/name,Type
+
+where:
+
+	Lines in which the first character is either '\n' or '#' are ignored.
+
+	Header line
+		is the first line in the file and is ignored. Even if
+		first line is empty or is a comment, subsequent non-comment/
+		blank lines are expected to adhere to the format of the second
+		line above.
+
+	Comma:
+		is the required field delimiter (i.e other fields cannot
+		have commas within them)
+
+	CPUID:
+		represents is an arch-specific CPUID for the set of CPUs
+		that use the PMU events specified in JSON/file/path/name.
+		(Multiple CPU ids can point to the same JSON/file/path/name)
+
+	Version:
+		is the Version of the mapfile.
+
+	JSON/file/path/name:
+		is the pathname for the JSON file, relative to the directory
+		containing the mapfile.csv
+
+	Type:
+		indicates whether the events or "core" or "uncore" events.
-- 
1.7.9.5
