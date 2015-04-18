Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 120811A001D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2015 23:13:35 +1000 (AEST)
Date: Sat, 18 Apr 2015 15:12:20 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: 'perf upgrade' (was: Re: [PATCH v9 00/11] Add support for JSON
 event files.)
Message-ID: <20150418131220.GB1514@krava.brq.redhat.com>
References: <1428993665-2133-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150414085541.GA30202@gmail.com>
 <1429010508.27414.1.camel@ellerman.id.au>
 <20150414125822.GA32761@gmail.com>
 <1429052004.10000.1.camel@ellerman.id.au>
 <20150415092557.GA14942@gmail.com>
 <20150415205042.GA11620@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150415205042.GA11620@us.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>, ak@linux.intel.com,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, peterz@infradead.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Pekka Enberg <penberg@iki.fi>, Linus Torvalds <torvalds@linux-foundation.org>,
 mingo@redhat.com, Borislav Petkov <bp@alien8.de>, namhyung@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 15, 2015 at 01:50:42PM -0700, Sukadev Bhattiprolu wrote:

SNIP

> 
> | 
> |  - to add an ABI to support those vendor files
> | 
> | And those are IMHO five good technical reasons to disagree with your 
> | approach.
> | 
> | My suggestion to resolve the technical objections and lift the NAK 
> | would be:
> | 
> |  - to add the tables to the source code, in a more human readable 
> |    format and (optionally) structure the event names better into a 
> |    higher level hierarchy, than the humungous linear dumps with no 
> |    explanations that you propose - while still supporting the 'raw' 
> |    vendor event names you want to use, for those people who are used 
> |    to them.
> | 
> 
> A bit confused.
> 
> Have the JSON files in the tree and generate the C structure during
> build?
> 
> Or, ditch the JSON files and add something like this in say,
> tools/perf/arch/powerpc/util/power8-events.h?
> 
> static const  struct events power8_events[] = {
>     [ 0 ] = {
>         .name = "PM_1LPAR_CYC",
>         .code = 0x1f05e,
>         .brief_desc = " "Number of cycles in single lpar mode. All threads in the core are assigned to the same lpar,",
>         .public_desc = "Number of cycles in single lpar mode.,",
>       },
> 
> If we have the JSON files, would the 'make install' put the JSON files
> in ~/.cache/pmu-events or in a standard location?

IIUC the intention is not to have external event data files
but have them compiled into perf binary.. like we could have
JSON with events description under perf source and build it
into 'struct perf_pmu_alias' data duting the build..

the pmu.c alias logic would need a little adjustments,
but it seems doable to me

jirka
