Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZtKj4mMPzDsZJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 08:26:01 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8FMN4Qf103360
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 18:25:59 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25fqtsdb0r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 18:25:59 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 18:25:58 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v21 15/19] perf,
 tools: Add README for info on parsing JSON/map files
Date: Thu, 15 Sep 2016 15:24:52 -0700
In-Reply-To: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1473978296-20712-16-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
---
Changelog[v21]
	- Update README to reflect the Topics.json directory tree layout.
---
 tools/perf/pmu-events/README | 148 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 tools/perf/pmu-events/README

diff --git a/tools/perf/pmu-events/README b/tools/perf/pmu-events/README
new file mode 100644
index 0000000..c5ee208e
--- /dev/null
+++ b/tools/perf/pmu-events/README
@@ -0,0 +1,148 @@
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
+
-- 
1.8.3.1
