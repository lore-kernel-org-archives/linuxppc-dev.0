Date: Thu, 8 Nov 2001 12:38:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Cc: linuxppc-commit@source.mvista.com
Subject: Re: Incoming to hostme.bitkeeper.com:/ua/repos/p/ppc/linuxppc_2_4_devel
Message-ID: <20011108123809.C1700@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011108193006.26A0010028@hostme.bitkeeper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011108193006.26A0010028@hostme.bitkeeper.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 08, 2001 at 11:30:06AM -0800, ppc@bitkeeper.com wrote:

> ChangeSet@1.612, 2001-11-08 12:29:36-07:00, trini@opus.bloom.county
>   Make serial_init (in wrapper) take two args.

I was thinking about this a bit.  The problem is that we have multiple
types of serial controllers we need to 'init' some how.  We have the
ns1655x style ones in most 6xx/7xx/74xx and 4xx boards, and the
integrated controllers in 8xx and 8260 CPUs which have their own way of
being init'ed.  We can either a) have a 'serial_init' function which
will do the right thing, even in the case of one file which can work on
both.  b) We kill the idea of one serial_init which always does the
right thing.  That lead to something like:
#ifdef CONFIG_4xx
	ns1655x_init(0); /* Use channel 0 from the table */
#else
	mpc_serial_init(bp); /* Use the bd_t struct to init this */
#endif

Comments?  Does the current (first) way rub anyone horribly wrong?  Is
there an even better idea out there?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
