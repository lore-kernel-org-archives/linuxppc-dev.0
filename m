Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/perf: Fix finding overflowed PMC in interrupt
In-reply-to: <5098B28B.2070703@linux.vnet.ibm.com>
References: <20121106122559.38ea906f@kryten>
 <1352166835-27980-1-git-send-email-mikey@neuling.org>
 <5098B28B.2070703@linux.vnet.ibm.com>
Date: Tue, 06 Nov 2012 21:19:42 +1100
Message-ID: <21513.1352197182@neuling.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:

> On 11/06/2012 07:23 AM, Michael Neuling wrote:
> 
> > +	if (!found && pvr_version_is(PVR_POWER7)) {
> > +		/* check active counters for special buggy p7 overflow */
> > +		for (i = 0; i < cpuhw->n_events; ++i) {
> > +			event = cpuhw->event[i];
> > +			if (!event->hw.idx || is_limited_pmc(event->hw.idx))
> >  				continue;
> > -			val = read_pmc(i + 1);
> > -			if (pmc_overflow(val))
> > -				write_pmc(i + 1, 0);
> > +			if (pmc_overflow_power7(val[event->hw.idx - 1])) {
> 
> 
> I have couple of questions. 
> 
> Can the buggy overflow happen on any of the available counters PMC1-PMC4 ?

No.  It's limited to certain events and I believe it can only happen on
PMC2 and 4.  This code doesn't bother trying to make this distinction
though.

> Will this approach never reset an actual user defined event (with
> sample period < 256) ? Is this related to the counter or the event
> which it is counting ? Just wondering if we have to do something more
> than checking for the count < 256. Just a thought.


I don't understand what you mean by these questions.  Can you explain a
bit more?

Mikey
