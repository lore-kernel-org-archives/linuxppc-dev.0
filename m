Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A53702C00A7
 for <linuxppc-dev@ozlabs.org>; Fri, 17 May 2013 21:41:12 +1000 (EST)
Date: Fri, 17 May 2013 13:39:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 3/3] perf, x86, lbr: Demand proper privileges for
 PERF_SAMPLE_BRANCH_KERNEL
Message-ID: <20130517113922.GF5162@dyad.programming.kicks-ass.net>
References: <20130503121122.931661809@chello.nl>
 <20130503121256.230745028@chello.nl>
 <CABPqkBTvcQAyXfeiJwpPsNtbs4ffsVguXE631dK_rbzHpwBdOg@mail.gmail.com>
 <20130516090916.GF19669@dyad.programming.kicks-ass.net>
 <8578.1368699317@ale.ozlabs.ibm.com>
 <20130516111634.GA15314@twins.programming.kicks-ass.net>
 <CABPqkBSCXJN7gLK_e_Q3YVVVFVGS78fo4j2z0+MmriqoXszH+w@mail.gmail.com>
 <20130517111232.GE5162@dyad.programming.kicks-ass.net>
 <29969.1368790328@ale.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <29969.1368790328@ale.ozlabs.ibm.com>
Cc: "ak@linux.intel.com" <ak@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 17, 2013 at 09:32:08PM +1000, Michael Neuling wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:

> > Wouldn't it be mostly conditional branches that are the primary control flow
> > and can get predicted wrong? I mean, I'm sure someone will miss-predict an
> > unconditional branch but its not like we care about people with such
> > afflictions do we?
> 
> You could mispredict the target address of a computed goto.  You'd know
> it was taken but not know target address until later in the pipeline.

Oh right, computed targets could indeed be mis predicted. I was more thinking
about jumps with immediate values.

> On this, the POWER8 branch history buffer tells us two things about the
> prediction status.  
>   1) if the branch was predicted taken/not taken correctly
>   2) if the target address was predicted correctly or not (for computed
>      gotos only)
> So we'd actually like more prediction bits too :-D

So if I understand this right, 1) maps to the predicted flags we have; 2)
would be new stuff?

We don't really have anything like that on x86, but I suppose if you make the
thing optional and present a 'useful' use-case implemented in userspace code
we could take it :-)

> > Anyway, since PPC people thought it worth baking into hardware,
> > presumably they have a compelling use case. Mikey could you see if you
> > can retrieve that from someone in the know? It might be interesting.
> 
> I don't think we can mispredict a non-conditional non-computed but I'll
> have to check with the HW folks.

I was mostly wondering about the use-case for the conditional filter. Stephane
didn't think it useful, clearly your hardware guys thought different :-)
