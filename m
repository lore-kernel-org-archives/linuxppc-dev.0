Date: Mon, 27 Aug 2001 15:40:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@mvista.com>
Cc: linuxppc-commit@source.mvista.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc_htab.c again
Message-ID: <20010827154006.C6925@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010827090729.B6925@cpe-24-221-152-185.az.sprintbbd.net> <3B8A8F26.EC447C4@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B8A8F26.EC447C4@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 27, 2001 at 02:19:18PM -0400, Dan Malek wrote:
> Tom Rini wrote:
> >
> > Hey all.  I notice paul made ppc_htab.c compile on all arches again.  I'm
> > not about to undo this or anything, but I still don't agree with it.
>
> Just look at it carefully.

Okay.

> In the past, on processors without HPTE
> the code was almost one big no-op (due to conditional tests, etc.) but
> somewhere there were a few sublte generic operations (like tlbie) that
> were important to (nearly) all processors.  I often took advantage of
> that.  The code would compile, no #ifdef necessary, generic functions
> called, and in the end "the right thing" would happen :-).

Yes, but that doesn't happen now, is what I'm trying to get it.  We -EFAULT
before then.  If I'm reading the current code right, it appears to now all
be HPTE related anyhow.  I think it'd be a great thing to put the generic
stuffs into a 'generic' file.  I think putting more things into
/proc/ppc_htab, when it used to print anything on !6xx, was a laziness
induced idea.   It worked but was ugly. :)  We can't do that anymore,
w/o hacking up the code abit.  It does compile now, w/ less ifdefs than before
since we tossed in more dummy #defines.  I just don't get why we want to
compile it when it doesn't do anything...

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
