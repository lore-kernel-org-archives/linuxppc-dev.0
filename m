Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E53E1A0CDB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 05:08:04 +1000 (AEST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 31 Aug 2015 13:08:02 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id CE40519D803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 12:58:56 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7VJ78MA49545222
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 12:07:16 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7VJ7Slg000687
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 13:07:28 -0600
Date: Mon, 31 Aug 2015 12:05:21 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 00/16] perf, tools: Add support for PMU events in
 JSON format
Message-ID: <20150831190521.GC31119@us.ibm.com>
References: <1440569166-22169-1-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440569166-22169-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sukadev Bhattiprolu [sukadev@linux.vnet.ibm.com] wrote:
| CPUs support a large number of performance monitoring events (PMU events)
| and often these events are very specific to an architecture/model of the
| CPU. To use most of these PMU events with perf, we currently have to identify
| them by their raw codes:
| 
| 	perf stat -e r100f2 sleep 1
| 
| This patchset allows architectures to specify these PMU events in JSON
| files located in 'tools/perf/pmu-events/arch/' of the mainline tree.
| The events from the JSON files for the architecture are then built into
| the perf binary.
| 
| At run time, perf identifies the specific set of events for the CPU and
| creates "event aliases". These aliases allow users to specify events by
| "name" as:
| 
| 	perf stat -e pm_1plus_ppc_cmpl sleep 1
| 
| The file, 'tools/perf/pmu-events/README' in [PATCH 16/16] gives more
| details.
| 
| Note:
| 	- All known events tables for the architecture are included in the
| 	  perf binary.
| 
| 	- For architectures that don't have any JSON files, an empty mapping
| 	  table is created and they should continue to build.
| 
| Thanks to input from Andi Kleen, Jiri Olsa, Namhyung Kim and Ingo Molnar.
| 
| These patches are available from:
| 
| 	https://github.com:sukadev/linux.git 
| 	
| 	Branch			Description
| 	------------------------------------------------------
| 	json-v16		Source Code only 
| 	json-files-6		x86 and Powerpc datafiles only
| 	json-v16-with-data	Both code and data (for build/test)

Arnaldo, Ingo,

I added Andi's patch https://lkml.org/lkml/2015/8/28/521 to 'json-v16' branch.
and created a new branch, 'json-files-7' with updated to Intel data files.
Here are the three new branches.

 	https://github.com:sukadev/linux.git 
 	
 	Branch			Description
 	------------------------------------------------------
 	json-v16		Source Code only 
 	json-files-7		x86 and Powerpc datafiles only
 	json-v16.1-with-data	Both code and data (for build/test)

Sukadev
