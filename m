Message-ID: <001701c384ce$7a5c3ae0$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Tom Rini" <trini@kernel.crashing.org>,
	"Jean-Denis Boyer" <jdboyer@m5t.com>,
	"Steffen Rumler" <Steffen.Rumler@siemens.com>,
	"linuxppc" <linuxppc-embedded@lists.linuxppc.org>
References: <IGEFJKJNHJDCBKALBJLLEEGCFPAA.joakim.tjernlund@lumentis.se> <IGEFJKJNHJDCBKALBJLLGEGDFPAA.joakim.tjernlund@lumentis.se> <20030926212410.GB8927@ip68-0-152-218.tc.ph.cox.net> <3F74BBC5.3010302@embeddededge.com> <006f01c3847f$17943dd0$020120b0@jockeXP> <3F74C7D4.4020000@embeddededge.com>
Subject: Re: Problem of concurrency in arch/ppc/8260_io/uart.c
Date: Sat, 27 Sep 2003 10:07:54 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > Yes, thats correct. I did try different ways around that but the only thing that
> > would work is to make copy_from_user() copy to i tmp buf and then copy the
> > tmp buf into the BD. Would that be better?
>
> I wonder what happens if we mark a buffer ready with a count of zero?
> Since the typical case is no page fault, I would just update the BD ptr
> early, use the buffer, mark it ready.  If you get a fault, put a zero
> for the count and mark it ready.

I tried that and it broke the CPM.

> If that freaks out the CPM, put one
> byte of zero into the buffer and give it a count of 1.  Then you just have
> to hold the lock across the update of the BD ptr, just like everywhere else.

That will work, but wont the zero show up on the console? hmm, since
the zero count will be very unlikely case anyhow,  I can live with that.

 Jocke

>
> -- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
