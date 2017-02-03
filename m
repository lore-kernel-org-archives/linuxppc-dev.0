Return-Path: <npiggin@gmail.com>
Date: Fri, 3 Feb 2017 16:21:54 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Popple <alistair@popple.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, <skiboot@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/powernv: implement NMI IPI with
 OPAL_SIGNAL_SYSTEM_RESET
Message-ID: <20170203162154.08b85ff0@roar.ozlabs.ibm.com>
In-Reply-To: <3306162.5sCMYZyWl3@new-mexico>
References: <20170202142511.14158-1-npiggin@gmail.com>
 <20170203152048.2d6bee4a@roar.ozlabs.ibm.com>
 <3306162.5sCMYZyWl3@new-mexico>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 03 Feb 2017 17:00:19 +1100
Alistair Popple <alistair@popple.id.au> wrote:

> On Fri, 3 Feb 2017 03:20:48 PM Nicholas Piggin wrote:
> > On Fri,  3 Feb 2017 00:25:11 +1000
> > Nicholas Piggin <npiggin@gmail.com> wrote:
> >  
> > > This goes with the previous NMI IPI series, and a new version of
> > > Alistair's opal API I posted to the skiboot list.  
> >
> > And here is the incremental bit that is required for Alistair's
> > hardware implementation to work.
> >
> > If the opal broacast call fails with OPAL_PARTIAL, then we designate
> > a bouncer CPU on another core to send NMI IPIs back to our sibling
> > threads.
> >
> > Probably needs more discussion and testing about how to detect and
> > handle failure cases and future compatibility for different types of
> > restrictions, but at least it works in mambo.  
> 
> Looking at the Mambo implementation you recently posted I couldn't see
> where OPAL_PARTIAL was returned. So I guess you have other Skiboot
> patches to test this path using Mambo? I'm wondering because they
> could be useful for testing the skiboot HW side as well...

Oh I just did it all on the Linux side, just forced it to always
do bounce rather than try broadcast first, I was lazy. But we'll
make mambo match the hardware implementation as far as possible
once you've got something.

> > Of course the other option rather than doing this in Linux is call
> > into opal in the system reset handler and have it do the bouncing.
> > Something to consider before we finalise the API.  
> 
> That might not be such a bad idea. OPAL could queue up the threads it
> couldn't reset and then wait until opal_sreset_complete() is called
> from an eligible thread to reset the ones it couldn't do in the
> original call.

Yeah, IIRC we thought it might have been harder to do in firmware,
but that may not be the case.

It may not be a bad idea in general for opal to have a token
available to hook system resets too.

> I might try prototyping something like this when I get some time. One
> issue would be if there is only a single core in the system, but
> that's unlikely and I think that's probably something we can't support
> in any case as cores can't sreset threads on the same core, at least
> on P8.

Yes on powernv it would be unusual, except maybe mambo where we
can make it work.

Thanks,
Nick
