Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPT2J1kYFzDrhc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 00:55:04 +1000 (AEST)
Date: Wed, 31 Aug 2016 16:54:59 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, mingo@redhat.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, peterz@infradead.org,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 00/20] perf, tools: Add support for PMU events in
 JSON format
Message-ID: <20160831145459.GA32396@krava>
References: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20160831114254.GA9001@krava>
 <20160831144247.GV3078@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160831144247.GV3078@tassilo.jf.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 31, 2016 at 07:42:47AM -0700, Andi Kleen wrote:
> > hi,
> > I had discussion with Ingo about the state of this patchset
> > and there's one more requirement from his side - to split
> > event files into per topic files
> 
> Thanks Jiri.
> > 
> > I made some initial changes over latest Sukadev's branch
> > and came up with something like this:
> 
> Did you just split it by the "Topic" fields?

yep

> 
> > 
> > 	$ find pmu-events/arch/x86/
> > 	pmu-events/arch/x86/
> > 	pmu-events/arch/x86/NehalemEX_core
> > 	pmu-events/arch/x86/NehalemEX_core/Memory.json
> > 	pmu-events/arch/x86/NehalemEX_core/Virtual-Memory.json
> > 	pmu-events/arch/x86/NehalemEX_core/Cache.json
> > 	pmu-events/arch/x86/NehalemEX_core/Pipeline.json
> > 	pmu-events/arch/x86/NehalemEX_core/Floating-point.json
> > 	pmu-events/arch/x86/NehalemEX_core/Other.json
> > 	pmu-events/arch/x86/mapfile.csv
> > 	pmu-events/arch/x86/Broadwell_core
> > 	pmu-events/arch/x86/Broadwell_core/Memory.json
> > 	pmu-events/arch/x86/Broadwell_core/Virtual-Memory.json
> > 	pmu-events/arch/x86/Broadwell_core/Cache.json
> > 	pmu-events/arch/x86/Broadwell_core/Pipeline.json
> > 	pmu-events/arch/x86/Broadwell_core/Floating-point.json
> > 	pmu-events/arch/x86/Broadwell_core/Other.json
> > 	pmu-events/arch/x86/Broadwell_core/Frontend.json
> > 
> > so let's have a discussion if this is acceptable for you guys
> 
> Splitting is fine for me, as long as it's scriptable.
> 
> I already have some scripts to generate the perf json files,
> can update them to split.

yep, there's split-json.py script earlier in the perf/json branch

> 
> > 
> > I've already made some changes in pmu-events/* to support
> > this hierarchy to see how bad the change would be.. and
> > it's not that bad ;-)
> 
> Everything has to be automated, please no manual changes.

sure

so, if you're ok with the layout, how do you want to proceed further?

thanks,
jirka
