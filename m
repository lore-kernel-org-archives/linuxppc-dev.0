Date: Wed, 15 Aug 2001 16:25:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Scott Carroll <scottcar@us.ibm.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Power3 problem?
Message-ID: <20010815162545.C25310@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010815145449.A16297@entropy.crashing.org> <20010815150115.A25310@cpe-24-221-152-185.az.sprintbbd.net> <15227.631.494933.982093@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15227.631.494933.982093@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 16, 2001 at 09:15:03AM +1000, Paul Mackerras wrote:
> Tom Rini writes:
>
> > Arg!  I just fixed this, but the problem is this.  I took
> > arch/ppc/kernel/l2cr.o out of the always-compiled list, and made it
> > compile only for CONFIG_6xx (which is 6xx/7xx/74xx/82xx) since only
> > 740/750 and 74xx (more or less) can make use of this.  The problem is
> > that Power3 and Power4 pretend to be CONFIG_ALL_PPC, so that they can
>
> Well POWER3/4 aren't just pretending to be CONFIG_ALL_PPC, they *are*
> CONFIG_ALL_PPC since they *are* CHRP machines.  Not all CHRPs are 6xx
> (actually POWER3 is a PPC630 or PPC630+ so it *is* 6xx in a sense).

Well, pretending is a bad choice of words.  They are real chrp machines,
but they aren't 'ALL_PPC', since you can't run on a power3 and a 604 :)

> > be a chrp machine easily.  The best way to fix this, I think would be to
> > make the arch/ppc/kernel/chrp_* files compile without needed pmac_*,
> > so that these machines could just work.  Paul, does this sound like
> > a sane plan to you?
>
> Nope. :)  Not unless we want to start having separate configs for
> prep, pmac and chrp again like we used to.  Which is not impossible
> but it would be a fair bit of work.

Well, I don't think it will be as bad as that.  It _should_ be possible
to split them out, and move the functions it uses from pmac_setup.c into
a common file.  If I have time I'll play with it sometime and post patches.
If it can be done cleanly, I don't think it'd be a bad idea, but...

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
