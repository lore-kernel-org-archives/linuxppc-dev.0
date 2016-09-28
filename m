Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sknKX4qlDzDrc6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 05:08:15 +1000 (AEST)
Date: Wed, 28 Sep 2016 16:08:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v21 06/19] perf, tools: Support alias descriptions
Message-ID: <20160928190803.GC7467@kernel.org>
References: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1473978296-20712-7-git-send-email-sukadev@linux.vnet.ibm.com>
 <20160927174100.GO5588@kernel.org>
 <20160927181116.GA18012@us.ibm.com>
 <20160928135747.GB7467@kernel.org>
 <20160928182916.GA17343@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160928182916.GA17343@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Sep 28, 2016 at 11:29:16AM -0700, Sukadev Bhattiprolu escreveu:
> Arnaldo Carvalho de Melo [acme@kernel.org] wrote:
> > Em Tue, Sep 27, 2016 at 11:11:16AM -0700, Sukadev Bhattiprolu escreveu:
> > > Arnaldo Carvalho de Melo [acme@kernel.org] wrote:
> > > > Em Thu, Sep 15, 2016 at 03:24:43PM -0700, Sukadev Bhattiprolu escreveu:
> > > > > From: Andi Kleen <ak@linux.intel.com>
> > > > > Add support to print alias descriptions in perf list, which
> > > > > are taken from the generated event files.
> > > > > 
> > > > > The sorting code is changed to put the events with descriptions
> > > > > at the end. The descriptions are printed as possibly multiple word
> > > > > wrapped lines.
> > > > 
> > > > So, now I'm trying to reproduce the results below, but I couldn't find a
> > > > tarball with those .json files for me to use, can you provide me with
> > > > one?
> > > 
> > > The data files are in my github, in the json-code+data-v21 branch
> > > starting with 23bb101. They are individual commits rather than a
> > > tarball though.
> > 
> > Ok, I'll pick one for powerpc and another for x86_64 so that I can test
> > it and Jiri's x-compile support.
> 
> Please pull all files if possible, specially on x86, _before_ building the
> perf binary. If you are going to pull only one, you need to make sure that
> the file you pull matches the CPU model on the system you are testing.(see
> below). For Power, you need to test on Power8.
> 
> > 
> > Refresh my mind, what is the plan on these files? Are we just going to
> > provide pointers to where to get them from vendors, ship it in the
> > kernel, auto-download them as part of the build process?
> 
> They are supposed to be committed into the linux kernel tree as shown
> in the json-code+data-v21 tree and they will be picked up _during build_
> of the perf binary. (We are just not mailing those data files as patches
> since they are large and there is very little value in reviewing them).
> 
> When building perf on on say x86, event tables for all the different
> x86 CPU models will be included in the perf binary. When perf is then
> executed on an x86 box, it will detect the CPU model of that box and
> use the set of events corresponding to that model.
> 
> If the CPU model does not match the models "known" to the perf binary,
> then the symbolic names will not work on that system, but there should
> be no other change in behavior.
> 
> Patch 15/19 tries to explain the process.

I didn't get to that one yet.
 
> > At least examples that allows to build and have a new 'perf test' entry
> > to check them automatically seems to be in order, no?
> 
> Well, the hope was that build/usage will be transparent! but we did not

the 'perf test' entry is to test the whole process of going from a json
file to a the perf binary and then asking for one such event and
checking if the resulting perf_event_attr is what we expect it to be,
see, for instance:

[root@jouet c]# perf test roundtrip
11: roundtrip evsel->name check                              : Ok

tools/perf/tests/evsel-roundtrip-name.c

> test in the cross-compile environment. Will think about a test case.
> Please let me know if we can update the README in Patch 15/19 in any
> way.

I'll let you know when I get to that patch, till then I'll follow the
instructions you gave me here.

I.e. I go on testing patch by patch, trying to use the documentation
that is available up to that point, trying to reproduce the results
described in the patch, to fully validate it.

- Arnaldo
 
> > > 	>       https://github.com/sukadev/linux.git
> > > 	>
> > > 	>       Branch                  Description
> > > 	>       ------------------------------------------------------
> > > 	>       json-code-v21           Source Code only
> > > 	>       json-code+data-v21      Both code and data(for build/test/pull)
> > > 	> 
> > > 
> > > Sukadev
