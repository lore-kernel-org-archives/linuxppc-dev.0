Date: Mon, 29 Sep 2003 08:33:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Cc: Dan Malek <dan@embeddededge.com>,
	Jean-Denis Boyer <jdboyer@m5t.com>,
	Steffen Rumler <Steffen.Rumler@siemens.com>,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem of concurrency in arch/ppc/8260_io/uart.c
Message-ID: <20030929153326.GC862@ip68-0-152-218.tc.ph.cox.net>
References: <001701c384ce$7a5c3ae0$020120b0@jockeXP> <IGEFJKJNHJDCBKALBJLLKEJOFPAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <IGEFJKJNHJDCBKALBJLLKEJOFPAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Sep 27, 2003 at 03:43:51PM +0200, Joakim Tjernlund wrote:
> > > If that freaks out the CPM, put one
> > > byte of zero into the buffer and give it a count of 1.  Then you just have
> > > to hold the lock across the update of the BD ptr, just like everywhere else.
> >
> > That will work, but wont the zero show up on the console? hmm, since
> > the zero count will be very unlikely case anyhow,  I can live with that.
>
> OK, this patch does the above. I left my test function(err_copy_from_user)
> to simulate bad copy_from_user() copies every now and then. Just remove
> it and change the call in rs_8xx_write when you have tested it.
> Works great for me, not even jove(emacs like editor) will break it.

KGDB still works for me.  Dan, happy with this?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
