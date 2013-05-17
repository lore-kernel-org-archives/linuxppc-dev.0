Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:4830:2446:ff00:4687:fcff:fea6:5117])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6CCAC2C00A3
 for <linuxppc-dev@ozlabs.org>; Fri, 17 May 2013 21:14:31 +1000 (EST)
Date: Fri, 17 May 2013 13:12:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 3/3] perf, x86, lbr: Demand proper privileges for
 PERF_SAMPLE_BRANCH_KERNEL
Message-ID: <20130517111232.GE5162@dyad.programming.kicks-ass.net>
References: <20130503121122.931661809@chello.nl>
 <20130503121256.230745028@chello.nl>
 <CABPqkBTvcQAyXfeiJwpPsNtbs4ffsVguXE631dK_rbzHpwBdOg@mail.gmail.com>
 <20130516090916.GF19669@dyad.programming.kicks-ass.net>
 <8578.1368699317@ale.ozlabs.ibm.com>
 <20130516111634.GA15314@twins.programming.kicks-ass.net>
 <CABPqkBSCXJN7gLK_e_Q3YVVVFVGS78fo4j2z0+MmriqoXszH+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABPqkBSCXJN7gLK_e_Q3YVVVFVGS78fo4j2z0+MmriqoXszH+w@mail.gmail.com>
Cc: Michael Neuling <mikey@neuling.org>,
 "ak@linux.intel.com" <ak@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 16, 2013 at 05:36:11PM +0200, Stephane Eranian wrote:
> On Thu, May 16, 2013 at 1:16 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Thu, May 16, 2013 at 08:15:17PM +1000, Michael Neuling wrote:
> >> Peter,
> >>
> >> BTW PowerPC also has the ability to filter on conditional branches.  Any
> >> chance we could add something like the follow to perf also?
> >>
> >
> > I don't see an immediate problem with that except that we on x86 need to
> > implement that in the software filter. Stephane do you see any
> > fundamental issue with that?
> >
> On X86, the LBR cannot filter on conditional in HW. Thus as Peter said, it would
> have to be done in SW. I did not add that because I think those branches are
> not necessarily useful for tools.

Wouldn't it be mostly conditional branches that are the primary control flow
and can get predicted wrong? I mean, I'm sure someone will miss-predict an
unconditional branch but its not like we care about people with such
afflictions do we?

Anyway, since PPC people thought it worth baking into hardware, presumably they
have a compelling use case. Mikey could you see if you can retrieve that from
someone in the know? It might be interesting.

Also, it looks like its trivial to add to x86, you seem to have already done
all the hard work by having X86_BR_JCC.

The only missing piece would be:

--- a/arch/x86/kernel/cpu/perf_event_intel_lbr.c
+++ b/arch/x86/kernel/cpu/perf_event_intel_lbr.c
@@ -337,6 +337,10 @@ static int intel_pmu_setup_sw_lbr_filter
 
 	if (br_type & PERF_SAMPLE_BRANCH_IND_CALL)
 		mask |= X86_BR_IND_CALL;
+
+	if (br_type & PERF_SAMPLE_BRANCH_CONDITIONAL)
+		mask |= X86_BR_JCC;
+
 	/*
 	 * stash actual user request into reg, it may
 	 * be used by fixup code for some CPU
