Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Stephane Eranian <eranian@google.com>
Subject: Re: Invalid perf_branch_entry.to entries question
In-reply-to: <CABPqkBRSMxQK8LJWhD39yo8EQZBd3-dRkeMqvwhWwLiHa6m66g@mail.gmail.com>
References: <25394.1367890528@ale.ozlabs.ibm.com>
 <20130508155929.GA8459@dyad.programming.kicks-ass.net>
 <CABPqkBRSMxQK8LJWhD39yo8EQZBd3-dRkeMqvwhWwLiHa6m66g@mail.gmail.com>
Date: Thu, 09 May 2013 08:45:51 +1000
Message-ID: <15099.1368053151@ale.ozlabs.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
 Anshuman Khandual <anshuman.khandual@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephane Eranian <eranian@google.com> wrote:

> On Wed, May 8, 2013 at 5:59 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, May 07, 2013 at 11:35:28AM +1000, Michael Neuling wrote:
> >> Peter & Stephane,
> >>
> >> We are plumbing the POWER8 Branch History Rolling Buffer (BHRB) into
> >> struct perf_branch_entry.
> >>
> >> Sometimes on POWER8 we may not be able to fill out the "to" address.
> >
> > Just because I'm curious.. however does that happen? Surely the CPU knows where
> > next to fetch instructions?
> >
> >> We
> >> initially thought of just making this 0, but it's feasible that this
> >> could be a valid address to branch to.
> >
> > Right, while highly unlikely, x86 actually has some cases where 0 address is
> > valid *shudder*..
> >
> >> The other logical value to indicate an invalid entry would be all 1s
> >> which is not possible (on POWER at least).
> >>
> >> Do you guys have a preference as to what we should use as an invalid
> >> entry?  This would have some consequences for the userspace tool also.
> >>
> >> The alternative would be to add a flag alongside mispred/predicted to
> >> indicate the validity of the "to" address.
> >
> > Either would work with me I suppose.. Stephane do you have any preference?
> 
> But if the 'to' is bogus, why not just drop the sample?
> That happens on x86 if the HW captured branches which do not correspond to
> user filter settings (due to bug).

We can I guess but it seems useful to log the from address when
possible.  

Can we log it and userspace tools can ignore it if it's not useful?

Mikey
