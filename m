Date: Mon, 5 Nov 2001 08:10:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods
Message-ID: <20011105081004.C32163@cpe-24-221-152-185.az.sprintbbd.net>
References: <200111050626.fA56Qg5444874@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200111050626.fA56Qg5444874@saturn.cs.uml.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 05, 2001 at 01:26:42AM -0500, Albert D. Cahalan wrote:

> I think it is important to allow for fast booting.
> That means both full boot and unsuspend. There should
> be a minimum of overhead on an embedded system.

We should make sure that the system allows for this, but not go and
implement it like this by default.  In the cases where we _need_ to be
up and running to point X in Y seconds, you do need to do things
slightly differently.  You can make sure that things are cleared, MMU is
off, et al.  What I've sort-of been thinking of for PPCBoot applies to
this case as well.  We'd have a 'wrapper' which basically converts a
bd_t if existing (since we will probably want to do this anyhow, PPCBoot
or not), and make up bi_recs for things like CONFIG_CMDLINE, if given.
Then, if needed (compile time) uncompress and jump.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
