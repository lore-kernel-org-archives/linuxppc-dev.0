Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x77NL2JlBzDqhk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 04:52:00 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6CGclWN036133
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 12:40:15 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bncjb3rgg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 12:40:15 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 12 Jul 2017 10:40:14 -0600
Date: Wed, 12 Jul 2017 09:40:08 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Andi Kleen <andi@firstfloor.org>, ak@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mikey@neuling.org, mpetlan@redhat.com
Subject: Re: [GIT PULL] Please pull JSON files for Power9 PMU events
References: <20170712020827.GB31223@us.ibm.com>
 <87a849luvr.fsf@concordia.ellerman.id.au>
 <20170712144611.GN27350@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170712144611.GN27350@kernel.org>
Message-Id: <20170712164008.GC31223@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnaldo Carvalho de Melo [acme@kernel.org] wrote:
> Em Wed, Jul 12, 2017 at 10:09:12PM +1000, Michael Ellerman escreveu:
> > Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> > > Please pull the JSON files for POWER9 PMU events.
> 
> > >       perf vendor events: Add POWER9 PMU events
> > >       perf vendor events: Add POWER9 PVRs to mapfile
> 
> > I think the PVRs need work.
> 
> > You have:
> 
> > +004e0100,1,power9.json,core
> > +004e0000,1,power9.json,core
> 
> > The first is P9 DD1, but the second doesn't exist. We have it in the
> > kernel, but with a mask of 0xffff0000. From memory the perf code doesn't
> > do any masking or anything fancy, it looks for an exact match.
> 
> > So for starters you should probably drop that one and add 0x004e1200 and
> > 0x004e0200.

Yes, thanks.

> 
> Could this check be somehow done automatically? Using whatever is in the
> kernel sources or some IBM released document?

Yes, had a recent discussion offline with Michael Petlan and Jiri about
generalizing/simplifying this. For now, I have added the above PVRs and
will look into the broader fix.

The following changes since commit 07d306c838c5c30196619baae36107d0615e459b:

  Merge git://www.linux-watchdog.org/linux-watchdog (2017-07-11 09:59:37 -0700)

are available in the git repository at:

  https://github.com/sukadev/linux/ p9-json

for you to fetch changes up to 8870b54739866c6eea23c36a0125af8045fbd572:

  perf vendor events: Add POWER9 PVRs to mapfile (2017-07-12 11:11:00 -0500)

----------------------------------------------------------------
Sukadev Bhattiprolu (2):
      perf vendor events: Add POWER9 PMU events
      perf vendor events: Add POWER9 PVRs to mapfile

 tools/perf/pmu-events/arch/powerpc/mapfile.csv     |   3 +
 .../perf/pmu-events/arch/powerpc/power9/cache.json | 176 +++++
 .../arch/powerpc/power9/floating-point.json        |  44 ++
 .../pmu-events/arch/powerpc/power9/frontend.json   | 446 +++++++++++
 .../pmu-events/arch/powerpc/power9/marked.json     | 782 +++++++++++++++++++
 .../pmu-events/arch/powerpc/power9/memory.json     | 158 ++++
 .../perf/pmu-events/arch/powerpc/power9/other.json | 836 +++++++++++++++++++++
 .../pmu-events/arch/powerpc/power9/pipeline.json   | 680 +++++++++++++++++
 tools/perf/pmu-events/arch/powerpc/power9/pmc.json | 146 ++++
 .../arch/powerpc/power9/translation.json           | 272 +++++++
 10 files changed, 3543 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/cache.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/marked.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/memory.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/other.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/pmc.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/translation.json
