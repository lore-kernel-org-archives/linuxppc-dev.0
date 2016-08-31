Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPNmg6QKJzDrhc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 21:42:59 +1000 (AEST)
Date: Wed, 31 Aug 2016 13:42:54 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, ak@linux.intel.com
Cc: mingo@redhat.com, Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, peterz@infradead.org,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 00/20] perf, tools: Add support for PMU events in
 JSON format
Message-ID: <20160831114254.GA9001@krava>
References: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 20, 2016 at 09:02:30PM -0700, Sukadev Bhattiprolu wrote:
> CPUs support a large number of performance monitoring events (PMU events)
> and often these events are very specific to an architecture/model of the
> CPU. To use most of these PMU events with perf, we currently have to identify
> them by their raw codes:
> 
> 	perf stat -e r100f2 sleep 1
> 
> This patchset allows architectures to specify these PMU events in JSON
> files located in 'tools/perf/pmu-events/arch/' of the mainline tree.
> The events from the JSON files for the architecture are then built into
> the perf binary.
> 
> At run time, perf identifies the specific set of events for the CPU and
> creates "event aliases". These aliases allow users to specify events by
> "name" as:
> 
> 	perf stat -e pm_1plus_ppc_cmpl sleep 1
> 
> The file, 'tools/perf/pmu-events/README' in [PATCH 16/16] gives more
> details.
> 
> Note:
> 	- All known events tables for the architecture are included in the
> 	  perf binary.
> 
> 	- For architectures that don't have any JSON files, an empty mapping
> 	  table is created and they should continue to build.
> 
> Thanks to input from Andi Kleen, Jiri Olsa, Namhyung Kim and Ingo Molnar.
> 
> These patches are available from:
> 
> 	https://github.com/sukadev/linux.git 
> 	
> 	Branch			Description
> 	------------------------------------------------------
> 	json-code-v20		Source Code only 
> 	json-data-v20		x86 and Powerpc datafiles only
> 	json-code+data-v20	Both code and data (for build/test)
> 	
> NOTE: 	Only "source code" patches (i.e those in json-code-v20) are being
> 	emailed.  Please pull the "data files" from the json-data-v20 branch.
> 
> Changelog[v20]
> 	- Rebase to recent perf/core
> 	- Add Patch 20/20 to allow perf-stat to work with the period= field

hi,
I had discussion with Ingo about the state of this patchset
and there's one more requirement from his side - to split
event files into per topic files

I made some initial changes over latest Sukadev's branch
and came up with something like this:

	$ find pmu-events/arch/x86/
	pmu-events/arch/x86/
	pmu-events/arch/x86/NehalemEX_core
	pmu-events/arch/x86/NehalemEX_core/Memory.json
	pmu-events/arch/x86/NehalemEX_core/Virtual-Memory.json
	pmu-events/arch/x86/NehalemEX_core/Cache.json
	pmu-events/arch/x86/NehalemEX_core/Pipeline.json
	pmu-events/arch/x86/NehalemEX_core/Floating-point.json
	pmu-events/arch/x86/NehalemEX_core/Other.json
	pmu-events/arch/x86/mapfile.csv
	pmu-events/arch/x86/Broadwell_core
	pmu-events/arch/x86/Broadwell_core/Memory.json
	pmu-events/arch/x86/Broadwell_core/Virtual-Memory.json
	pmu-events/arch/x86/Broadwell_core/Cache.json
	pmu-events/arch/x86/Broadwell_core/Pipeline.json
	pmu-events/arch/x86/Broadwell_core/Floating-point.json
	pmu-events/arch/x86/Broadwell_core/Other.json
	pmu-events/arch/x86/Broadwell_core/Frontend.json

so let's have a discussion if this is acceptable for you guys

I've already made some changes in pmu-events/* to support
this hierarchy to see how bad the change would be.. and
it's not that bad ;-)

you can check followin patches (only 2 Intel files transformed):

	1d5ffa8bb969 perf, tools: Change jevents
	65919f8901e3 perf, tools: Split Broadwell_core.json
	7cd309a85465 perf, tools: Add Broadwell V14 event file
	e316aff2dd4e perf, tools: Split NehalemEX_core.json
	e19e8de49408 perf, tools: Add NehalemEX V1 event file

It's available in:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/json

thanks,
jirka
