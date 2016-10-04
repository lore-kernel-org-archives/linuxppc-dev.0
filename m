Return-Path: <BATV+c3601ec1c81c7bfd3073+4790+infradead.org+acme@merlin.srs.infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp33t43j1zDrFm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 13:37:46 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux Weekly News <lwn@lwn.net>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 18/22] perf tools: Add README for info on parsing JSON/map
 files
Date: Mon,  3 Oct 2016 23:37:17 -0300
Message-Id: <1475548641-12182-19-git-send-email-acme@kernel.org>
In-Reply-To: <1475548641-12182-1-git-send-email-acme@kernel.org>
References: <1475548641-12182-1-git-send-email-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1473978296-20712-16-git-send-email-sukadev@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/README | 147 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100644 tools/perf/pmu-events/README

diff --git a/tools/perf/pmu-events/README b/tools/perf/pmu-events/README
new file mode 100644
index 000000000000..1408ade0d773
--- /dev/null
+++ b/tools/perf/pmu-events/README
@@ -0,0 +1,147 @@
+
+The contents of this directory allow users to specify PMU events in their
+CPUs by their symbolic names rather than raw event codes (see example below).
+
+The main program in this directory, is the 'jevents', which is built and
+executed _BEFORE_ the perf binary itself is built.
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
+The PMU events supported by a CPU model are expected to grouped into topics
+such as Pipelining, Cache, Memory, Floating-point etc. All events for a topic
+should be placed in a separate JSON file - where the file name identifies
+the topic. Eg: "Floating-point.json".
+
+All the topic JSON files for a CPU model/family should be in a separate
+sub directory. Thus for the Silvermont X86 CPU:
+
+	$ ls tools/perf/pmu-events/arch/x86/Silvermont_core
+	Cache.json 	Memory.json 	Virtual-Memory.json
+	Frontend.json 	Pipeline.json
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
+The mapfile enables multiple CPU models to share a single set of PMU events.
+It is required even if such mapping is 1:1.
+
+The mapfile.csv format is expected to be:
+
+	Header line
+	CPUID,Version,Dir/path/name,Type
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
+		always _IGNORED_. It can empty.
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
+	Dir/path/name:
+		is the pathname to the directory containing the CPU's JSON
+		files, relative to the directory containing the mapfile.csv
+
+	Type:
+		indicates whether the events or "core" or "uncore" events.
+
+
+	Eg:
+
+	$ grep Silvermont tools/perf/pmu-events/arch/x86/mapfile.csv
+	GenuineIntel-6-37,V13,Silvermont_core,core
+	GenuineIntel-6-4D,V13,Silvermont_core,core
+	GenuineIntel-6-4C,V13,Silvermont_core,core
+
+	i.e the three CPU models use the JSON files (i.e PMU events) listed
+	in the directory 'tools/perf/pmu-events/arch/x86/Silvermont_core'.
-- 
2.7.4
