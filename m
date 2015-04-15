Return-Path: <ak@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id C39E51A0BBE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 05:17:37 +1000 (AEST)
Date: Wed, 15 Apr 2015 12:17:34 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: 'perf upgrade' (was: Re: [PATCH v9 00/11] Add support for JSON
 event files.)
Message-ID: <20150415191734.GC15335@tassilo.jf.intel.com>
References: <1428993665-2133-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150414085541.GA30202@gmail.com>
 <1429010508.27414.1.camel@ellerman.id.au>
 <20150414125822.GA32761@gmail.com>
 <1429052004.10000.1.camel@ellerman.id.au>
 <20150415092557.GA14942@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150415092557.GA14942@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, peterz@infradead.org,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 mingo@redhat.com, Borislav Petkov <bp@alien8.de>, namhyung@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
 Pekka Enberg <penberg@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> My suggestion to resolve the technical objections and lift the NAK 
> would be:
> 
>  - to add the tables to the source code, in a more human readable 
>    format and (optionally) structure the event names better into a 
>    higher level hierarchy, than the humungous linear dumps with no 
>    explanations that you propose - while still supporting the 'raw' 
>    vendor event names you want to use, for those people who are used 
>    to them.

Trying to understand what you mean with high level hierarchy:

Do you mean something like the oprofile event / unit mask split,
with events having a default unit mask?

This one actually works poorly for modern Intel systems, as
unit masks can completely change the behavior, so there is 
not necessarily a direct relation between the name before the dot and the one
after, or a concept of a "default" unit mask.

Or do you mean someone creating a tree hierarchy of events to systematically
debug some particular problem?

I implemented this in my toplev tool here:
https://github.com/andikleen/pmu-tools/wiki/toplev-manual
http://github.com/andikleen/pmu-tools

But it's quite complicated and cannot really be done portable in
a full way without completely turning perf into an architecture specific
tool (which I assume you're opposed to)

Or just some sections grouping events into different topics?
"branches", "caches", "execution" or somesuch.

I think this could be done with the JSON format. Just add a new header.
Print them as sections in perf list.

Or do you mean something like the perf cache events tables?
We already have those. But they cannot replace direct micro architectural
specific events, as the cache event tables do not necessarily express
everything a given micro architecture supports. And also there is a lot
of documentation using the vendor event names, which the users
then want to use.

If it's something else please explain.

> 
>  - to pre-parse the event descriptions at build time - beyond the 
>    speedup 

FWIW I just measured it and the overhead parse time for the haswell JSON file on
my laptop is about 33ms. 

# with event map
% time ./obj-perf/perf list > /dev/null
real    0m0.045s
user    0m0.041s
sys     0m0.003s

% export EVENTMAP=/dev/zero
% time perf list > /dev/null

real    0m0.011s
user    0m0.004s
sys     0m0.006s


>  - to upgrade perf as a whole unit: this helps not just your usecase
>    but many other usecases as well.

With the downloader it actually automatically downloads any missing
files, so the upgrading just works.

-Andi
