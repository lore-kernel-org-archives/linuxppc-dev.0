Return-Path: <ak@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPSzt2Wm1zDrhc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 00:52:57 +1000 (AEST)
Date: Wed, 31 Aug 2016 07:42:47 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, mingo@redhat.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, peterz@infradead.org,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 00/20] perf, tools: Add support for PMU events in
 JSON format
Message-ID: <20160831144247.GV3078@tassilo.jf.intel.com>
References: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20160831114254.GA9001@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160831114254.GA9001@krava>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> hi,
> I had discussion with Ingo about the state of this patchset
> and there's one more requirement from his side - to split
> event files into per topic files

Thanks Jiri.
> 
> I made some initial changes over latest Sukadev's branch
> and came up with something like this:

Did you just split it by the "Topic" fields?

> 
> 	$ find pmu-events/arch/x86/
> 	pmu-events/arch/x86/
> 	pmu-events/arch/x86/NehalemEX_core
> 	pmu-events/arch/x86/NehalemEX_core/Memory.json
> 	pmu-events/arch/x86/NehalemEX_core/Virtual-Memory.json
> 	pmu-events/arch/x86/NehalemEX_core/Cache.json
> 	pmu-events/arch/x86/NehalemEX_core/Pipeline.json
> 	pmu-events/arch/x86/NehalemEX_core/Floating-point.json
> 	pmu-events/arch/x86/NehalemEX_core/Other.json
> 	pmu-events/arch/x86/mapfile.csv
> 	pmu-events/arch/x86/Broadwell_core
> 	pmu-events/arch/x86/Broadwell_core/Memory.json
> 	pmu-events/arch/x86/Broadwell_core/Virtual-Memory.json
> 	pmu-events/arch/x86/Broadwell_core/Cache.json
> 	pmu-events/arch/x86/Broadwell_core/Pipeline.json
> 	pmu-events/arch/x86/Broadwell_core/Floating-point.json
> 	pmu-events/arch/x86/Broadwell_core/Other.json
> 	pmu-events/arch/x86/Broadwell_core/Frontend.json
> 
> so let's have a discussion if this is acceptable for you guys

Splitting is fine for me, as long as it's scriptable.

I already have some scripts to generate the perf json files,
can update them to split.

> 
> I've already made some changes in pmu-events/* to support
> this hierarchy to see how bad the change would be.. and
> it's not that bad ;-)

Everything has to be automated, please no manual changes.

-Andi
