Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wi0-x22f.google.com (mail-wi0-x22f.google.com
 [IPv6:2a00:1450:400c:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 64E211A1763
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 23:07:32 +1000 (AEST)
Received: by wicmc15 with SMTP id mc15so123171814wic.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 06:07:29 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 28 May 2015 15:07:25 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] perf: jevents: Program to convert JSON file to C
 style file
Message-ID: <20150528130724.GA8987@gmail.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-3-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150527135402.GA29557@danjae.kornet>
 <20150527144007.GL7484@tassilo.jf.intel.com>
 <CAM9d7cgSPbBgHL8qkmFEfbA3pNct4VPaxDwOcKZD3_5ZNL-oNQ@mail.gmail.com>
 <20150528115223.GD12392@krava.redhat.com>
 <20150528120954.GA8478@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150528120954.GA8478@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > On Wed, May 27, 2015 at 11:59:04PM +0900, Namhyung Kim wrote:
> > > Hi Andi,
> > > 
> > > On Wed, May 27, 2015 at 11:40 PM, Andi Kleen <ak@linux.intel.com> wrote:
> > > >> So we build tables of all models in the architecture, and choose
> > > >> matching one when compiling perf, right?  Can't we do that when
> > > >> building the tables?  IOW, why don't we check the VFM and discard
> > > >> non-matching tables?  Those non-matching tables are also needed?
> > > >
> > > > We build it for all cpus in an architecture, not all architectures.
> > > > So e.g. for an x86 binary power is not included, and vice versa.
> > > 
> > > OK.
> > > 
> > > > It always includes all CPUs for a given architecture, so it's possible
> > > > to use the perf binary on other systems than just the one it was
> > > > build on.
> > > 
> > > So it selects one at run-time not build-time, good.  But I worry about
> > > the size of the intel tables.  How large are they?  Maybe we can make
> > > it dynamic-loadable if needed..
> > 
> > just compiled Sukadev's new version with Andi's events list
> > and stripped binary size is:
> > 
> > [jolsa@krava perf]$ ls -l perf
> > -rwxrwxr-x 1 jolsa jolsa 2772640 May 28 13:49 perf
> > 
> > 
> > while perf on Arnaldo's perf/core is:
> > 
> > [jolsa@krava perf]$ ls -l perf
> > -rwxrwxr-x 1 jolsa jolsa 2334816 May 28 13:49 perf
> > 
> > seems not that bad
> 
> It's not bad at all.
> 
> Do you have a Git tree URI where I could take a look at its current state? A 
> tree would be nice that has as many of these patches integrated as possible.

A couple of observations:

1)

The x86 JSON files are unnecessarily large, and for no good reason, for example:

 triton:~/tip/tools/perf/pmu-events/arch/x86> grep -h EdgeDetect * | sort | uniq -c
   5534         "EdgeDetect": "0",
     57         "EdgeDetect": "1",

it's ridiculous to repeat "EdgeDetect": "0" more than 5 thousand times, just so 
that in 57 cases we can say '1'. Those lines should be omitted, and the default 
value should be 0.

This would reduce the source code line count of the JSON files by 40% already:

 triton:~/tip/tools/perf/pmu-events/arch/x86> grep ': "0",' * | wc -l
 42127
 triton:~/tip/tools/perf/pmu-events/arch/x86> cat * | wc -l
 103702

And no, I don't care if manufacturers release crappy JSON files - they need to be 
fixed/stripped before applied to our source tree.

2)

Also, the JSON files should carry more high levelstructure than they do today. 
Let's take SandyBridge_core.json as an example: it defines 386 events, but they 
are all in a 'flat' hierarchy, which is almost impossible for all but the most 
expert users to overview.

So instead of this flat structure, there should at minimum be broad categorization 
of the various parts of the hardware they relate to: whether they relate to the 
branch predictor, memory caches, TLB caches, memory ops, offcore, decoders, 
execution units, FPU ops, etc., etc. - so that they can be queried via 'perf 
list'.

We don't just want the import the unstructured mess that these event files are - 
we want to turn them into real structure. We can still keep the messy vendor names 
as well, like IDQ.DSB_CYCLES, but we want to impose structure as well.

3)

There should be good 'perf list' visualization for these events: grouping, 
individual names, with a good interface to query details if needed. I.e. it should 
be possible to browse and discover events relevant to the CPU the tool is 
executing on.

Thanks,

	Ingo
