Message-ID: <3B7AFB52.9226BEA0@rochcivictheatre.org>
Date: Wed, 15 Aug 2001 17:44:34 -0500
From: Tom Gall <gall@rochcivictheatre.org>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Scott Carroll <scottcar@us.ibm.com>,
	linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@samba.org>
Subject: Re: Power3 problem?
References: <20010815145449.A16297@entropy.crashing.org> <20010815150115.A25310@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:
>
> On Wed, Aug 15, 2001 Scott Carroll wrote:
>
> > While building for Power3 (p640), ChangeSet@1.263, 2001-08-15:
>
> Arg!  I just fixed this, but the problem is this.  I took
> arch/ppc/kernel/l2cr.o out of the always-compiled list, and made it
> compile only for CONFIG_6xx (which is 6xx/7xx/74xx/82xx) since only
> 740/750 and 74xx (more or less) can make use of this.  The problem is
> that Power3 and Power4 pretend to be CONFIG_ALL_PPC, so that they can
> be a chrp machine easily.  The best way to fix this, I think would be to
> make the arch/ppc/kernel/chrp_* files compile without needed pmac_*,
> so that these machines could just work.  Paul, does this sound like
> a sane plan to you?

I agree, this sounds like a good idea. I suspect there's also room for
some of the routines in pmac_* to moved moved into more general files in
the cases they are truely pieces of shared code.

--
Regards,

Tom

--------------------------------------------------------------
Linux Guy             "My heart is human, my blood is boiling,
gall@rochcivictheatre.org    my brain IBM" -- Mr Roboto, Styxx

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
