Subject: RE: Oops on core dumping
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Whitney, John" <John.Whitney@timesys.com>
Cc: Vincent Bernat <bernat@free.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>
In-Reply-To: <3D848382FB72E249812901444C6BDB1D1D189F@exchange.timesys.com>
References: <3D848382FB72E249812901444C6BDB1D1D189F@exchange.timesys.com>
Content-Type: text/plain
Message-Id: <1072840969.730.3.camel@gaston>
Mime-Version: 1.0
Date: Wed, 31 Dec 2003 14:22:50 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-12-31 at 03:05, Whitney, John wrote:
> Vincent,
>
> This looks like the same problem (application core dumps, caused in dump_fpu()) that I posted a patch for last week.  Look in the archives for my solution.  (basically, dump_fpu() is getting a NULL "regs" argument, and then referencing off of it.)

As you may have seen in my comment, this doesn't work on SMP as
last_task_used_math isn't used there.

I suppose we could unconditionally use "current" in this case
though...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
