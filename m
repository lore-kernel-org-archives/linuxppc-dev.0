Date: Wed, 15 Aug 2001 15:01:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Scott Carroll <scottcar@us.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Power3 problem?
Message-ID: <20010815150115.A25310@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010815145449.A16297@entropy.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010815145449.A16297@entropy.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Aug 15, 2001 Scott Carroll wrote:

> While building for Power3 (p640), ChangeSet@1.263, 2001-08-15:

Arg!  I just fixed this, but the problem is this.  I took
arch/ppc/kernel/l2cr.o out of the always-compiled list, and made it
compile only for CONFIG_6xx (which is 6xx/7xx/74xx/82xx) since only
740/750 and 74xx (more or less) can make use of this.  The problem is
that Power3 and Power4 pretend to be CONFIG_ALL_PPC, so that they can
be a chrp machine easily.  The best way to fix this, I think would be to
make the arch/ppc/kernel/chrp_* files compile without needed pmac_*,
so that these machines could just work.  Paul, does this sound like
a sane plan to you?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
