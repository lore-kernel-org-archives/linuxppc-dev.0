Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E4F4C1A1D82
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 06:08:57 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 11 Aug 2015 14:08:55 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 810813E4004E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 14:08:52 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7BK8EJb34603236
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 13:08:14 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7BK8pGP027128
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 14:08:52 -0600
Date: Tue, 11 Aug 2015 13:07:24 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V15 00/19] perf, tools: Add support for PMU events in
 JSON format
Message-ID: <20150811200724.GA10078@us.ibm.com>
References: <1433921123-25327-1-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433921123-25327-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
| The file, 'tools/perf/pmu-events/README' in [PATCH 19/19] gives more
| details.
| 
| Note:
| 	- All known events tables for the architecture are included in the
| 	  perf binary.
| 
| 	- For architectures that don't have any JSON files, an empty mapping
| 	  table is created and they should continue to build)
| 
| Thanks to input from Andi Kleen, Jiri Olsa, Namhyung Kim and Ingo Molnar.
| 
| These patches are available from:
| 
| 	https://github.com:sukadev/linux.git 
| 	
| 	Branch			Description
| 	------------------------------------------------------
| 	json-v15		Source Code only 
| 	json-files-5		x86 and Powerpc datafiles only
| 	json-v15-with-data	Both code and data (build/test)
| 	
| NOTE: 	Only "source code" patches (i.e those in json-v15) are being emailed.
| 	Please pull the "data files" from the json-files-5 branch.

Ingo, Arnaldo,

Any updates on this patchset? They have been reviewed/acked by Jiri
and we have not received any comments since then.

Is there a chance this can make it into 4.3?

Sukadev
