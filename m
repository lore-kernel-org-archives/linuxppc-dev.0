Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF4A31A089C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 20:31:14 +1000 (AEST)
Date: Wed, 3 Jun 2015 12:31:07 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 03/14] perf, tools: Use pmu_events_map table to
 create event aliases
Message-ID: <20150603103107.GE1828@krava.redhat.com>
References: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1433265135-20426-4-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433265135-20426-4-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 02, 2015 at 10:12:03AM -0700, Sukadev Bhattiprolu wrote:
> At run time, (i.e when perf is starting up), locate the specific events
> table for the current CPU and create event aliases for each of the events.
> 
> Use these aliases to parse user's specified perf event.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> 
> Changelog[v3]
> 	[Jiri Olsa] Fix a memory leak with cpuid.
> 
> Changelog[v2]
> 	[Andi Kleen] Replace the pmu_events_map->vfm field with a simple
> 		generic "cpuid" string and use that string to find the
> 		matching mapfile entry.
> ---
>  tools/perf/arch/powerpc/util/header.c |   11 ++++
>  tools/perf/util/header.h              |    3 +-
>  tools/perf/util/pmu.c                 |  104 ++++++++++++++++++++++++++++-----
>  3 files changed, 104 insertions(+), 14 deletions(-)

I think this patch is doing too much, it should be split into 3 pieces:

  - introduce get_cpuid_str for powerpc
  - introducing __perf_pmu__new_alias/perf_pmu__new_alias functions split
  - adding pmu_add_cpu_aliases functionality

jirka
